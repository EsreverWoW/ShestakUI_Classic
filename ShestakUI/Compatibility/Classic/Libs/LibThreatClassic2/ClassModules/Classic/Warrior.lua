if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "WARRIOR" then return end

local _G = _G
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo
local GetShapeshiftForm = _G.GetShapeshiftForm
local GetSpellInfo = _G.GetSpellInfo
local pairs, ipairs = _G.pairs, _G.ipairs
local GetTime = _G.GetTime
local UnitDebuff = _G.UnitDebuff

local Warrior = ThreatLib:GetOrCreateModule("Player-r"..MINOR)

-- https://github.com/magey/classic-warrior/wiki/Threat-Mechanics
-- maxRankThreatValue / maxRankLevelAvailability = factor
-- lowerRankThreatValue = factor * rankN

local sunderFactor 			= 261 / 58	-- ok-ish (between 260 - 270)
local shieldBashFactor 		= 187 / 52
local revengeFactor 		= 355 / 60	-- maybe look into r5
local heroicStrikeFactor 	= 220 / 70	-- NEED MORE INFO
local shieldSlamFactor 		= 250 / 60
local cleaveFactor 			= 100 / 60	-- NEED MORE INFO
local hamstringFactor 		= 145 / 54	-- ok-ish (between 142 - 148)
local mockingBlowFactor 	= 250 / 56	-- NEED MORE INFO
local battleShoutFactor 	= 1
local demoShoutFactor 		= 43 / 54
local thunderClapFactor		= 130 / 58

local threatValues = {
	sunder = {
		[7386] = sunderFactor * 10,
		[7405] = sunderFactor * 22,
		[8380] = sunderFactor * 34,
		[11596] = sunderFactor * 46,
		[11597] = 261
	},
	shieldBash = {
		[72] = shieldBashFactor * 12,
		[1671] = shieldBashFactor * 32,
		[1672] = 187
	},
	revenge = {
		[6572] = revengeFactor * 14,
		[6574] = revengeFactor * 24,
		[7379] = revengeFactor * 34,
		[11600] = revengeFactor * 44,
		[11601] = 315,
		[25288] = 355
	},
	heroicStrike = { -- needs work
		[78] = 20,
		[284] = 39,
		[285] = 59,
		[1608] = 78,
		[11564] = 98,
		[11565] = 118,
		[11566] = 137,
		[11567] = 145,
		[25286] = 175
	},
	shieldSlam = {
		[23922] = shieldSlamFactor * 40,
		[23923] = shieldSlamFactor * 48,
		[23924] = shieldSlamFactor * 54,
		[23925] = 250
	},
	cleave = {
		[845] = 10,
		[7369] = 40,
		[11608] = 60,
		[11609] = 70,
		[20569] = 100
	},
	hamstring = {
		[1715] = hamstringFactor * 8,
		[7372] = hamstringFactor * 32,
		[7373] = 145,
	},
	--[[
	mockingBlow = {
		[694] = mockingBlowFactor * 16,
		[7400] = mockingBlowFactor * 26,
		[7402] = mockingBlowFactor * 36,
		[20559] = mockingBlowFactor * 46,
		[20560] = 250
	},
	--]]
	battleShout = {
		[6673] = battleShoutFactor * 1,
		[5242] = battleShoutFactor * 12,
		[6192] = battleShoutFactor * 22,
		[11549] = battleShoutFactor * 32,
		[11550] = battleShoutFactor * 42,
		[11551] = battleShoutFactor * 52,
		[25289] = 60
	},
	demoShout = {
		[1160] = demoShoutFactor * 14,
		[6190] = demoShoutFactor * 24,
		[11554] = demoShoutFactor * 34,
		[11555] = demoShoutFactor * 44,
		[11556] = 43
	},
	thunderclap = {
		[6343] = thunderClapFactor * 6,
		[8198] = thunderClapFactor * 18,
		[8204] = thunderClapFactor * 28,
		[8205] = thunderClapFactor * 38,
		[11580] = thunderClapFactor * 48,
		[11581] = 130
	},
	execute = {
		[5308] = true,
		[20658] = true,
		[20660] = true,
		[20661] = true,
		[20662] = true
	},
	disarm = {
		[676] = 104
	}
}

local function init(self, t, f)
	local funcSuccess = function(self, spellID, target)
		self:AddTargetThreat(target, f(self, spellID))
	end
	local funcMiss = function(self, spellID, target)
		self:AddTargetThreat(target, -f(self, spellID))
	end
	for k, v in pairs(t) do
		self.CastLandedHandlers[k] = funcSuccess
		self.CastMissHandlers[k] = funcMiss
	end
end

function Warrior:ClassInit()
	-- Taunt. Assumption that all successful taunts apply a debuff to the mob
	self.MobDebuffHandlers[355] = self.Taunt

	init(self, threatValues.heroicStrike, self.HeroicStrike)
	init(self, threatValues.cleave, self.Cleave)
	init(self, threatValues.shieldBash, self.ShieldBash)
	init(self, threatValues.shieldSlam, self.ShieldSlam)
	init(self, threatValues.revenge, self.Revenge)
	-- init(self, threatValues.mockingBlow, self.MockingBlow)
	init(self, threatValues.hamstring, self.Hamstring)
	init(self, threatValues.thunderclap, self.Thunderclap)
	init(self, threatValues.disarm, self.Disarm)
	init(self, threatValues.sunder, self.SunderArmor)

	-- Ability damage modifiers
	for k, v in pairs(threatValues.execute) do
		self.AbilityHandlers[k] = self.Execute
	end

	-- Shouts
	-- Battle Shout
	local bShout = function(self, spellID, target)
		self:AddThreat(threatValues.battleShout[spellID] * self:threatMods())
	end
	for k, v in pairs(threatValues.battleShout) do
		self.CastHandlers[k] = bShout
	end

	-- Demoralizing Shout
	local demoShoutFunc = function(self, spellID, target)
		self:AddTargetThreat(target, threatValues.demoShout[spellID] * self:threatMods())
	end
	for k, v in pairs(threatValues.demoShout) do
		self.MobDebuffHandlers[k] = demoShoutFunc
	end

	-- Set names don't need to be localized.
	self.itemSets = {
		["Might"] = { 16866, 16867, 16868, 16862, 16864, 16861, 16865, 16863 }
	}
end

function Warrior:ClassEnable()
	self:GetStanceThreatMod()
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "GetStanceThreatMod" )
end

function Warrior:ClassDisable()
	self:UnregisterEvent("UPDATE_SHAPESHIFT_FORM")
end

function Warrior:ScanTalents()
	-- Defiance
	if ThreatLib.Classic then
		local rank = _G.select(5, GetTalentInfo(3, 9))
		self.defianceMod = 1 + (0.03 * rank)
	else
		self.defianceMod = 1 -- for when testing in retail
	end
end

function Warrior:GetStanceThreatMod()
	self.isTanking = false
	if GetShapeshiftForm() == 2 then
		self.passiveThreatModifiers = 1.3 * self.defianceMod
		self.isTanking = true
	elseif GetShapeshiftForm() == 3 then
		self.passiveThreatModifiers = 0.8
	else
		self.passiveThreatModifiers = 0.8
	end
	self.totalThreatMods = nil -- Needed to recalc total mods
end

function Warrior:SunderArmor(spellID)
	local sunderMod = 1
	if self:getWornSetPieces("Might") >= 8 then
		sunderMod = 1.15
	end
	local threat = threatValues.sunder[spellID]
	return threat * sunderMod * self:threatMods()
end

local pendingTauntTarget = nil
local pendingTauntOffset = nil
function Warrior:Taunt(spellID, target)
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

function Warrior:HeroicStrike(spellID)
	return threatValues.heroicStrike[spellID] * self:threatMods()
end

function Warrior:Cleave(spellID)
	return threatValues.cleave[spellID] * self:threatMods()
end

function Warrior:ShieldBash(spellID)
	return threatValues.shieldBash[spellID] * self:threatMods()
end

function Warrior:ShieldSlam(spellID)
	return threatValues.shieldSlam[spellID] * self:threatMods()
end

function Warrior:Revenge(spellID)
	return threatValues.revenge[spellID] * self:threatMods()
end

--[[
function Warrior:MockingBlow(spellID)
	return threatValues.mockingBlow[spellID] * self:threatMods()
end
--]]

function Warrior:Hamstring(spellID)
	return threatValues.hamstring[spellID] * self:threatMods()
end

function Warrior:Thunderclap(spellID)
	return threatValues.thunderclap[spellID] * self:threatMods()
end

function Warrior:Execute(amount)
	return amount * 1.25
end

function Warrior:Disarm(spellID)
	return threatValues.disarm[spellID] * self:threatMods()
end
