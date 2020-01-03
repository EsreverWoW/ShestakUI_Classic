if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "PALADIN" then return end

local Paladin = ThreatLib:GetOrCreateModule("Player")
local UnitClass = _G.UnitClass
local UnitInRange = _G.UnitInRange
local UnitIsGhost = _G.UnitIsGhost
local UnitIsConnected = _G.UnitIsConnected
local IsInRaid = _G.IsInRaid
local righteousFuryMod = 1

local _G = _G
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo

local irfRanks = {0, 0.16, 0.33, 0.5}

local HolyHealIDs = {
	-- Holy Light
	635, 639, 647, 1026, 1042, 3472, 10328, 10329, 25292,

	-- Holy Shock
	25903, 25913, 25914,

	-- Lay on Hands
	633, 2800, 10310,

	-- Seal of Light
	20167, 20333, 20334, 20340,

	-- Flash of Light
	19750, 19939, 19940, 19941, 19942, 19943,
}

local HolyDamageIDs = {
	-- Blessing of Sanctuary
	20911, 20912, 20913, 20914,

	-- Exorcism
	879, 5614, 5615, 10312, 10313, 10314,

	-- Greater Blessing of Sanctuary
	25899,

	-- Hammer of Wrath
	24275, 24274, 24239,

	-- Holy Wrath
	2812, 10318,

	-- Judgement of Command
	20467, 20963, 20964, 20964, 20966, 

	-- Judgement of Righteousness
	20187, 20280, 20281, 20282, 20283, 20284, 20285, 20286,

	-- Retribution Aura
	7294, 10298, 10299, 10300, 10301,

	-- Seal of Command
	20375, 

	-- Seal of Righteousness
	21084, 20287, 20288, 20289, 20290, 20291, 20292, 20293,
}

--blessing threat values
--including them all even though most of them are not useful for threat
local threatValues = {
	lesserBlessing = {
		--kings
		[20217] = 20,
		--light
		[19977] = 40,
		[19978] = 50,
		[19979] = 60,
		--might
		[19740] = 4,
		[19834] = 12,
		[19835] = 22,
		[19836] = 32,
		[19837] = 42,
		[19838] = 52,
		[25291] = 60,
		--sanctuary
		[20911] = 30,
		[20912] = 40,
		[20913] = 50,
		[20914] = 60,
		--salvation
		[1038] = 26,
		--wisdom
		[19742] = 14,
		[19850] = 24,
		[19852] = 34,
		[19853] = 44,
		[19854] = 54,
		[25290] = 60,
		--freedom
		[1044] = 18,
		--protection
		[1022] = 10,
		[5599] = 24,
		[10278] = 38,
		--sacrifice
		[6940] = 46,
		[20729] = 54
	},
	greaterBlessing ={
		--greater kings
		[25898] = 60,
		--greater light
		[25890] = 60,
		--greater might
		[25782] = 52,
		[25916] = 60,
		--greater sanctuary
		[25899] = 60,
		--greater salvation
		[25895] = 60,
		--greater wisdom
		[25894] = 54,
		[25918] = 60,
	}
}


local rfOn = false
local RIGHTEOUS_FURY_SPELL_ID = 25780
local CLEANSE_SPELL_ID = 4987

function Paladin:ClassInit()
	--adding threat for blessings
	for k, v in pairs(threatValues.greaterBlessing) do
		self.CastLandedHandlers[k] = self.GreaterBlessing
	end
	for k, v in pairs(threatValues.lesserBlessing) do
		self.CastLandedHandlers[k] = self.Blessing
	end

	-- Righteous Fury
	for i = 1, #HolyDamageIDs do
		self.AbilityHandlers[HolyDamageIDs[i]] = self.RighteousFury
	end
	HolyDamageIDs = nil

	self.BuffHandlers[RIGHTEOUS_FURY_SPELL_ID] = self.RighteousFuryBuff

	self.CastHandlers[CLEANSE_SPELL_ID] = self.Cleanse

	local healMod = function(self, amt)
		return 0.5 * amt
	end

	for i = 1, #HolyHealIDs do
		self.AbilityHandlers[HolyHealIDs[i]] = healMod
	end

	-- Judgement
	-- This is a maximum of like 10 TPS, do we really need it?
	-- We'll track first-lands, but not worry about refreshes.
	self.CastLandedHandlers[20271] = function(self, spellID, recipient)
		self:AddTargetThreat(recipient, self:RighteousFury(57))
	end

	local holyShield = function(self, amt)
		return self:RighteousFury(amt) * 1.2
	end
	local holyShieldIDs = {20925, 20927, 20928}
	for i = 1, #holyShieldIDs do
		self.AbilityHandlers[holyShieldIDs[i]] = holyShield
	end

	HolyHealIDs = nil
end

function Paladin:ClassEnable()
	self.passiveThreatModifiers = 1
end

function Paladin:ClassDisable()
end

function Paladin:ScanTalents()
	-- Scan talents	
	if ThreatLib.Classic then
		local rank = select(5, GetTalentInfo(2, 7))
		righteousFuryMod = 1.6
		if rank then
			righteousFuryMod = righteousFuryMod * (1 + irfRanks[rank+1])
		end
		
	else
		righteousFuryMod = 1.6 -- for when testing in retail
	end

	self:calcBuffMods()
end

function Paladin:Blessing(spellID, recipient)
	result = self:RighteousFury(threatValues.lesserBlessing[spellID])
	self:AddThreat(result)
end

function Paladin:GreaterBlessing(spellID, recipient, spellName )
	locClass, engClass, locRace, engRace, gender, name, server = GetPlayerInfoByGUID(recipient)
	className = locClass:upper()
	numberOfClass = self:ClassCounter(className)
	result = self:RighteousFury(threatValues.greaterBlessing[spellID]) * numberOfClass
	self:AddThreat(result)
end

function Paladin:ClassCounter(className)
	local countClass = 0
	if UnitClass("player"):upper() == className then
		countClass = countClass + 1
	end
	local unitString = nil 

	if IsInRaid() then
		unitString = "raid%d"
	else
		unitString = "party%d"
	end

	for i=0,GetNumGroupMembers() do
		unitid=(unitString):format(i)
		if UnitIsConnected(unitid) and UnitInRange(unitid) and not UnitIsGhost(unitid) then
			if UnitClass(unitid):upper() == className then
				countClass = countClass + 1
			end
		end
	end
	return countClass
end

function Paladin:Cleanse(spellID, target)
	self:AddThreat(40 * self:threatMods())
end

function Paladin:RighteousFuryBuff(action, spellID, applications)
	self.isTanking = false
	if action == "gain" or action == "exist" then
		rfOn = true
		self.isTanking = true
		self.passiveThreatModifiers = 1
	elseif action == "lose" then
		rfOn = false
		self.passiveThreatModifiers = 1
	end
	if action == "gain" or action == "lose" then
		self.totalThreatMods = nil
	end
	ThreatLib:Debug("passiveThreatModifiers is %s", self.passiveThreatModifiers)
end

function Paladin:RighteousFury(amt)
	if rfOn then
		return amt * righteousFuryMod
	else
		return amt
	end
end
