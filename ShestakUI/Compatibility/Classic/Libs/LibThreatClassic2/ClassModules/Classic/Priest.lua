if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "PRIEST" then return end

local Priest = ThreatLib:GetOrCreateModule("Player")

local _G = _G
local ipairs = _G.ipairs
local pairs = _G.pairs
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo

local DiscSpellIDs = {
	-- Consume magic
	32676,

	-- Starshards
	10797, 19296, 19299, 19302, 19303, 19304, 19305,

	-- Dispel Magic
	527, 988,

	-- Divine Spirit
	14752, 14818, 14819,

	-- Elune's Grace
	2561,

	-- Inner Fire
	588, 7128, 602, 1006, 10951, 10952,

	-- Levitate
	1706,

	-- Mass Dispel
	32375,

	-- Power Word: Fortitude
	1243, 1244, 1245, 2791, 10937, 10938,

	-- Prayer of Fort
	21562, 21564,

	-- Prayer of Spirit
	27681,

	-- Shackle Undead
	9484, 9485, 10955,

	-- Feedback
	13896, 19271, 19273, 19274, 19275,

	-- Mana Burn
	8129, 8131, 10874, 10875, 10876
}

local HolySpellIDs = {
	-- Abolish Disease
	552,

	-- Cure Disease
	528,

	-- Fear Ward
	6346,

	-- Holy Fire
	14914, 15262, 15263, 15264, 15265, 15266, 15267, 15261,

	-- Lightwell
	724, 27870,

	-- Resurrection
	2006, 2010, 10880, 10881, 20770,

	-- Smite
	585, 591, 598, 984, 1004, 6060, 10933, 10934
}

local VestmentBonusIDs = {
	-- Desperate Prayer
	13908, 19236, 19238, 19240, 19241, 19242, 19243,

	-- Flash Heal
	2061, 9472, 9473, 9474, 10915, 10916, 10917,

	-- Greater Heal
	2060, 10963, 10964, 10965, 25314,

	-- Heal
	2054, 2055, 6063, 6064,

	-- Lesser Heal
	2050, 2052, 2053,

	-- Prayer of Healing
	596, 996, 10960, 10961, 25316,

	-- Renew
	139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25315
}

local ShadowSpellIDs = {
	-- Prayer of Shadow Protection
	27683,

	-- Devouring Plague
	2944, 19276, 19277, 19278, 19279, 19280,

	-- Fade
	586, 9578, 9579, 9592, 10941, 10942,

	-- Hex of Weakness
	9035, 19281, 19282, 19283, 19284, 19285,

	-- Mind Flay
	15407, 17311, 17312, 17313, 17314, 18807,

	-- Mind Soothe
	453, 8192, 10953,

	-- Mind Vision
	2096, 10909,

	-- Psychic Scream
	8122, 8124, 10888, 10890,

	-- Shadow Protection
	976, 10957, 10958,

	-- Shadow Word: Pain
	589, 594, 970, 992, 2767, 10892, 10893, 10894,

	-- Touch of Weakness
	2652, 19261, 19262, 19264, 19265, 19266
}

local threatAmounts = {
	["fade"] = {
		[586] = 55,
		[9578] = 155,
		[9579] = 285,
		[9592] = 440,
		[10941] = 620,
		[10942] = 820,
	},
	["pws"] = {
		[17] = 22,
		[592] = 44,
		[600] = 79,
		[3747] = 117,
		[6065] = 150.5,
		[6066] = 190.5,
		[10898] = 242,
		[10899] = 302.5,
		[10900] = 381.5,
		[10901] = 471,
	}
}

function Priest:ClassInit()
	-- Set up school modifiers
	for _,v in ipairs(DiscSpellIDs) do
		self.AbilityHandlers[v] = self.Disc
	end
	DiscSpellIDs = nil

	for _,v in ipairs(HolySpellIDs) do
		self.AbilityHandlers[v] = self.Holy
	end
	HolySpellIDs = nil

	for _,v in ipairs(ShadowSpellIDs) do
		self.AbilityHandlers[v] = self.Shadow
	end
	ShadowSpellIDs = nil

	for _,v in ipairs(VestmentBonusIDs) do
		self.AbilityHandlers[v] = self.VestmentBonus
	end
	VestmentBonusIDs = nil

	----------------------------------------------------
	-- Fade
	----------------------------------------------------
	for k, v in pairs(threatAmounts["fade"]) do
		self.BuffHandlers[k] = self.Fade
	end

	----------------------------------------------------
	-- Power Word: Shield
	----------------------------------------------------
	local modPWS = function(self, spellID, target)
		local base = threatAmounts["pws"][spellID] * self.impPWS * self.silentResolveMod * self:threatMods()
		self:AddThreat(base)
	end
	for k, v in pairs(threatAmounts["pws"]) do
		self.CastHandlers[k] = modPWS
	end

	----------------------------------------------------
	-- Holy Nova / Shadowguard / Mind Blast
	----------------------------------------------------
	local holyNovaIDs = {15237, 15430, 15431, 27799, 27800, 27801}
	local shadowguardIDs = {18137, 19308, 19309, 19310, 19311, 19312}
	local mindBlastIDs = {8092, 8102, 8103, 8104, 8105, 8106, 10945, 10946, 10947}
	local zeroThreat = function(self, amt) return 0 end
	local mbThreat = function(self, amt) return amt * 2 * self.shadowAffinityMod end
	for _, v in ipairs(holyNovaIDs) do
		self.AbilityHandlers[v] = zeroThreat
	end

	for _, v in ipairs(shadowguardIDs) do
		self.AbilityHandlers[v] = zeroThreat
	end

	for _, v in ipairs(mindBlastIDs) do
		self.AbilityHandlers[v] = mbThreat
	end

	holyNovaIDs = nil
	shadowguardIDs = nil
	mindBlastIDs = nil

	-- Set names don't need to be localized.
	self.itemSets = {
		["Vestments"] = { 22514, 22513, 22515, 22516, 22518, 22519, 22512, 22517 }
	}
end

function Priest:ClassEnable()
	self.passiveThreatModifiers = 1
end

function Priest:ClassDisable()
end

local shadowAffinityRanks = {0.92, 0.84, 0.75}
function Priest:ScanTalents()
	if ThreatLib.Classic then
		self.silentResolveMod = 1 - (0.04 * select(5, GetTalentInfo(1, 3)))
		self.shadowAffinityMod = shadowAffinityRanks[select(5, GetTalentInfo(3, 3))] or 1
		self.impPWS = 1 + (select(5, GetTalentInfo(1, 5)) * 0.05)
	else
		self.silentResolveMod = 1
		self.shadowAffinityMod = 1
		self.impPWS = 1
	end
end

function Priest:Fade(action, spellID, applications)
	if action == "lose" then
		self:AddThreat(self.fadedAmount)
	elseif action == "gain" then
		self.fadedAmount = threatAmounts["fade"][spellID] * self.shadowAffinityMod * self:threatMods()
		self:AddThreat(self.fadedAmount * -1)
	end
end

function Priest:Disc(amt)
	return amt * self.silentResolveMod
end

function Priest:Holy(amt)
	return amt * self.silentResolveMod
end

function Priest:Shadow(amt)
	return amt * self.shadowAffinityMod
end

function Priest:VestmentBonus(amt)
	local vestmentBonus = 1
	if self:getWornSetPieces("Vestments") >= 6 then
		vestmentBonus = 0.9
	end
	return amt * vestmentBonus * self.silentResolveMod
end
