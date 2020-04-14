if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "DRUID" then return end

local _G = _G
local pairs = _G.pairs
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo
local GetShapeshiftForm = _G.GetShapeshiftForm
local UnitGUID = _G.UnitGUID

local Druid = ThreatLib:GetOrCreateModule("Player-r"..MINOR)

local faerieFireFactor = 108 / 54	-- NEED MORE INFO

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
}

local SCHOOL_MASK_NATURE = _G.SCHOOL_MASK_NATURE or 0x08
local SCHOOL_MASK_ARCANE = _G.SCHOOL_MASK_ARCANE or 0x40

local itemSets = {}
local swipeIDs = {779, 780, 769, 9754, 9908}
local maulIDs = {6807, 6808, 6809, 8972, 9745, 9880, 9881}
local tranquilityIDs = {740, 8918, 9862, 9863}

function Druid:ClassInit()

	-- Growl. Assumption that all successful taunts apply a debuff to the mob
	self.MobDebuffHandlers[6795] = self.Growl

	for k, v in pairs(threatValues.faerieFire) do
		self.CastLandedHandlers[k] = self.FaerieFire
		self.CastMissHandlers[k] = self.FaerieFireMiss
	end
	for k, v in pairs(threatValues.cower) do
		self.CastLandedHandlers[k] = self.Cower
		self.CastMissHandlers[k] = self.CowerMiss
	end

	for k, v in pairs(threatValues.demoralizingRoar) do
		self.MobDebuffHandlers[k] = self.DemoralizingRoar
	end

	-- Subtlety for all Arcane or Nature Damage, as well as heals.
	self.schoolThreatMods[SCHOOL_MASK_NATURE] = self.Subtlety
	self.schoolThreatMods[SCHOOL_MASK_ARCANE] = self.Subtlety

	for i = 1, #swipeIDs do
		self.AbilityHandlers[swipeIDs[i]] = self.Swipe
	end
	swipeIDs = nil

	for i = 1, #maulIDs do
		self.AbilityHandlers[maulIDs[i]] = self.Maul
	end
	maulIDs = nil

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

function Druid:ClassDisable()
	self:UnregisterEvent("UPDATE_SHAPESHIFT_FORM")
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
	elseif form == 2 or form == 3 then
		-- if aquatic form is not learnt, druid cat form is 2 and travel form 3
		-- else aquatic form is 2 and cat form 3.
		-- should be fine, druids don't dps in travel or aquatic form xD
		self.passiveThreatModifiers = 0.71
	else
		self.passiveThreatModifiers = 1
	end
	self.totalThreatMods = nil -- Needed to recalc total mods
end

function Druid:Growl(spellID, target)
	local targetThreat = ThreatLib:GetThreat(UnitGUID("targettarget"), target)
	local myThreat = ThreatLib:GetThreat(UnitGUID("player"), target)
	if targetThreat > 0 and targetThreat > myThreat then
		self:AddTargetThreat(target, targetThreat-myThreat)
		ThreatLib:PublishThreat()
	elseif targetThreat == 0 then
		local maxThreat = ThreatLib:GetMaxThreatOnTarget(target)
		self:AddTargetThreat(target, maxThreat-myThreat)
		ThreatLib:PublishThreat()
	end
end

function Druid:FaerieFire(spellID, target)
	self:AddTargetThreat(target, threatValues.faerieFire[spellID] * self:threatMods())
end

function Druid:FaerieFireMiss(spellID, target)
	self:AddTargetThreat(target, -(threatValues.faerieFire[spellID] * self:threatMods()))
end

function Druid:Maul(amount)
	return amount * 1.75
end

function Druid:Swipe(amount)
	return amount * 1.75
end

function Druid:Cower(spellID, target)
	self:AddTargetThreat(target, threatValues.cower[spellID] * self:threatMods() * -1)
end

function Druid:CowerMiss(spellID, target)
	self:AddTargetThreat(target, threatValues.cower[spellID] * self:threatMods())
end

function Druid:DemoralizingRoar(spellID, target)
	self:AddTargetThreat(target, threatValues.demoralizingRoar[spellID] * self:threatMods())
end

function Druid:Subtlety(amount)
	return amount * self.subtletyMod
end

function Druid:Tranquility(amount)
	return amount * self.tranqMod
end
