local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "PALADIN" then return end

local Paladin = ThreatLib:GetOrCreateModule("Player")

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

local rfOn = false
local RIGHTEOUS_FURY_SPELL_ID = 25780
local CLEANSE_SPELL_ID = 4987

function Paladin:ClassInit()
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

function Paladin:ScanTalents()
	-- Scan talents	
	if ThreatLib.Classic then
		self.righteousFuryMod = 1.6 + (0.6 * irfRanks[select(5, GetTalentInfo(2, 7)) + 1])
	else
		self.righteousFuryMod = 1.6 -- for when testing in retail
	end

	self:calcBuffMods()
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
		return amt * self.righteousFuryMod
	else
		return amt
	end
end
