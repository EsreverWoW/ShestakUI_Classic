local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "DRUID" then return end

local _G = _G
local pairs = _G.pairs
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo
local GetShapeshiftForm = _G.GetShapeshiftForm
local UnitGUID = _G.UnitGUID

local Druid = ThreatLib:GetOrCreateModule("Player")

local faerieFireFactor = 108 / 54	-- NEED MORE INFO
local maulFactor = 322 / 67			-- NEED MORE INFO

local threatValues = {
	["cower"] = {
		[8998] = 240,
		[9000] = 390,
		[9892] = 600
	},
	["demoralizingRoar"] = {
		[99] = 9,
		[1735] = 15,
		[9490] = 20,
		[9747] = 30,
		[9898] = 39
	},
	["faerieFire"] = {
		-- normal
		[770] = faerieFireFactor * 18,
		[778] = faerieFireFactor * 30,
		[9749] = faerieFireFactor * 42,
		[9907] = 108,
		-- feral
		[16857] = faerieFireFactor * 18,
		[17390] = faerieFireFactor * 30,
		[17391] = faerieFireFactor * 42,
		[17392] = 108,
	},
	["maul"] = {
		[6807] = 18,
		[6808] = 27,
		[6809] = 37,
		[8972] = 49,
		[9745] = 71,
		[9880] = 101,
		[9881] = 128
	},
}

local SCHOOL_MASK_NATURE = _G.SCHOOL_MASK_NATURE or 0x08
local SCHOOL_MASK_ARCANE = _G.SCHOOL_MASK_ARCANE or 0x40

local itemSets = {}
local swipeIDs = {779, 780, 769, 9754, 9908}
local tranquilityIDs = {740, 8918, 9862, 9863}

function Druid:ClassInit()

	-- Growl
	self.CastLandedHandlers[6795] = self.Growl

	for k, v in pairs(threatValues.faerieFire) do
		self.CastLandedHandlers[k] = self.FaerieFire
	end
	for k, v in pairs(threatValues.maul) do
		self.CastLandedHandlers[k] = self.Maul
	end
	for k, v in pairs(threatValues.cower) do
		self.CastLandedHandlers[k] = self.Cower
	end
	for k, v in pairs(threatValues.demoralizingRoar) do
		self.CastHandlers[k] = self.DemoralizingRoar
	end
	for k, v in pairs(threatValues.demoralizingRoar) do
		self.CastMissHandlers[k] = self.DemoralizingRoarMiss
	end

	-- Subtlety for all Arcane or Nature Damage, as well as heals.
	self.schoolThreatMods[SCHOOL_MASK_NATURE] = self.Subtlety
	self.schoolThreatMods[SCHOOL_MASK_ARCANE] = self.Subtlety

	for i = 1, #swipeIDs do
		self.AbilityHandlers[swipeIDs[i]] = self.Swipe
	end
	swipeIDs = nil

	for i = 1, #tranquilityIDs do
		self.AbilityHandlers[tranquilityIDs[i]] = self.Tranquility
	end
	tranquilityIDs = nil

	self.itemSets = itemSets
end

function Druid:ClassEnable()
	self:GetStanceThreatMod()
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "GetStanceThreatMod")
end

function Druid:ScanTalents()
	if ThreatLib.Classic then
		self.feralinstinctMod = 0.03 * select(5, GetTalentInfo(2, 3))
		self.subtletyMod = 1 - 0.04 * select(5, GetTalentInfo(3, 8))
		self.tranqMod = 1 - 0.5 * select(5, GetTalentInfo(3, 13))
	else
		self.feralinstinctMod = 0 -- for when testing in retail
		self.subtletyMod = 1 -- for when testing in retail
		self.tranqMod = 1 -- for when testing in retail
	end
end

-- get form passive threat modifier
function Druid:GetStanceThreatMod()
	local form = GetShapeshiftForm()
	self.isTanking = false
	if form == 1 then
		self.passiveThreatModifiers = 1.3 + self.feralinstinctMod
		self.isTanking = true
	elseif form == 2 then
		self.passiveThreatModifiers = 0.71
	else
		self.passiveThreatModifiers = 1
	end
	self.totalThreatMods = nil -- Needed to recalc total mods
end

local pendingTauntTarget = nil
local pendingTauntOffset = nil
function Druid:Growl(spellID, target)
	local targetThreat = ThreatLib:GetThreat(UnitGUID("targettarget"), target)
	local myThreat = ThreatLib:GetThreat(UnitGUID("player"), target)
	if targetThreat > 0 and targetThreat > myThreat then
		pendingTauntTarget = target
		pendingTauntOffset = targetThreat-myThreat
	elseif targetThreat == 0 then
		local maxThreat = ThreatLib:GetMaxThreatOnTarget(target)
		pendingTauntTarget = target
		pendingTauntOffset = maxThreat-myThreat
	end
	self.nextEventHook = self.GrowlNextHook
end

function Druid:GrowlNextHook(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID)
	if pendingTauntTarget and (subEvent ~= "SPELL_MISSED" or spellID ~= 6795) then
		self:AddTargetThreat(pendingTauntTarget, pendingTauntOffset)
		ThreatLib:PublishThreat()
	end
	pendingTauntTarget = nil
	pendingTauntOffset = nil
end

function Druid:FaerieFire(spellID, target)
	self:AddTargetThreat(target, threatValues.faerieFire[spellID] * self:threatMods())
end

function Druid:Maul(spellID, target)
	self:AddTargetThreat(target, threatValues.maul[spellID] * 1.75 * self:threatMods())
end

function Druid:Swipe(amount)
	return amount * 1.75
end

function Druid:Cower(spellID, target)
	self:AddTargetThreat(target, threatValues.cower[spellID] * self:threatMods() * -1)
end

function Druid:DemoralizingRoar(spellID, target)
	self:AddThreat(threatValues.demoralizingRoar[spellID] * self:threatMods())
end

function Druid:DemoralizingRoarMiss(spellID, target)
	self:rollbackTransaction(target, spellID)
end

function Druid:Subtlety(amount)
	return amount * self.subtletyMod
end

function Druid:Tranquility(amount)
	return amount * self.tranqMod
end
