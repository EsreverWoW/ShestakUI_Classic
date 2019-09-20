local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then
	_G.ThreatLib_MINOR_VERSION = MINOR_VERSION
end

if select(2, UnitClass("player")) ~= "PRIEST" then return end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()
	local ThreatLib = _G.ThreatLib
	local Priest = ThreatLib:GetOrCreateModule("Player")

	local _G = _G
	local tonumber = _G.tonumber
	local ipairs = _G.ipairs
	local pairs = _G.pairs
	local select = _G.select
	local GetTalentInfo = _G.GetTalentInfo
	local max = _G.math.max

	local DiscSpellIDs = {
		-- Consume magic
		32676,
		
		-- Starshards
		10797, 19296, 19299, 19302, 19303, 19304, 19305, 25446,
		
		-- Dispel Magic
		527, 988,
		
		-- Divine Spirit
		14752, 14818, 14819, 27841, 25312,
		
		-- Elune's Grace
		2561,
		
		-- Inner Fire
		588, 7128, 602, 1006, 10951, 10952, 25431,
		
		-- Levitate
		1706,
		
		-- Mass Dispel
		32375,
		
		-- Power Word: Fortitude
		1243, 1244, 1245, 2791, 10937, 10938, 25389,
		
		-- Prayer of Fort
		21562, 21564, 25392,
		
		-- Prayer of Spirit
		27681, 32999,
		
		-- Shackle Undead
		9484, 9485, 10955,
		
		-- Symbol of Hope
		32548,
		
		-- Feedback
		13896, 19271, 19273, 19274, 19275, 25441,
		
		-- Mana Burn
		8129, 8131, 10874, 10875, 10876, 25379, 25380
	}
	
	local HolySpellIDs = {
		-- Abolish Disease
		552,
		
		-- Circle of Healing
		34861, 34863, 34864, 34865, 34866,
		
		-- Cure Disease
		528,
		
		-- Desperate Prayer
		13908, 19236, 19238, 19240, 19241, 19242, 19243, 25437,
		
		-- Fear Ward
		6346,
		
		-- Flash Heal
		2061, 9472, 9473, 9474, 10915, 10916, 10917, 25233, 25235,
		
		-- Greater Heal
		2060, 10963, 10964, 10965, 25314, 25210, 25213,
		
		-- Heal
		2054, 2055, 6063, 6064,
		
		-- Holy Fire
		14914, 15262, 15263, 15264, 15265, 15266, 15267, 15261, 25384,
		
		-- Lesser Heal
		2050, 2052, 2053, 
		
		-- Lightwell
		724, 27870, 27871, 28275,
		
		-- Prayer of Healing
		596, 996, 10960, 10961, 25316, 25308,
		
		-- Prayer of Mending
		33076,
		
		-- Renew
		139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25315, 25221, 25222,
		
		-- Resurrection
		2006, 2010, 10880, 10881, 20770, 25435,
		
		-- Smite
		585, 591, 598, 984, 1004, 6060, 10933, 10934, 25363, 25364
	}
	
	local ShadowSpellIDs = {
		-- Prayer of Shadow Protection
		27683, 39374,
		
		-- Devouring Plague
		2944, 19276, 19277, 19278, 19279, 19280, 25467,
		
		-- Fade
		586, 9578, 9579, 9592, 10941, 10942, 25429,
		
		-- Hex of Weakness
		9035, 19281, 19282, 19283, 19284, 19285, 25470,
		
		-- Mind Blast
		8092, 8102, 8103, 8104, 8105, 8106, 10945, 10946, 10947, 25372, 25375,
		
		-- Mind Control
		--605, 10911, 10912,
		-- No known testing is done to conclude Mind Control threat values
		-- Closest is http://elitistjerks.com/f31/t23307-priest_mind_control_threat_testing/
		-- which is highly inconclusive. Wowwiki says "To this date it is not clear
		-- precisely how much threat Mind Control causes, but it is very substantial"
		-- MC threat is not a flat 5500 threat as Satrina's guide says.
		
		-- Mind Flay
		15407, 17311, 17312, 17313, 17314, 18807, 25387,
		
		-- Mind Soothe
		453, 8192, 10953, 25596,
		
		-- Mind Vision
		2096, 10909,
		
		-- Psychic Scream
		8122, 8124, 10888, 10890,
		
		-- Shadow Protection
		976, 10957, 10958, 25433,
		
		-- Shadow Word: Death
		32379, 32996,
		
		-- Shadow Word: Pain
		589, 594, 970, 992, 2767, 10892, 10893, 10894, 25367, 25368,
		
		-- Shadowfiend
		34433,
		
		-- Shadowguard - special handling
		-- 18137, 19308, 19309, 19310, 19311, 19312, 25477,
		
		-- Touch of Weakness
		2652, 19261, 19262, 19264, 19265, 19266, 25461
	}

	--local MindControlThreat = {nil, nil, 5500}
	
	local threatAmounts = {
		["reflectiveshield"] = 0,
		["fade"] = {
			[586] = 55,
			[9578] = 155,
			[9579] = 285,
			[9592] = 440,
			[10941] = 620,
			[10942] = 820,
			[25429] = 1500
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
			[25217] = 573.5,
			[25218] = 657.5
		}
	}

	function Priest:ClassInit()
		local function modForSilentResolve(self, amt) return amt * self.silentResolveMod end
		local function modForShadowAffinity(self, amt) return amt * self.shadowAffinityMod end

		-- Set up school modifiers
		for _,v in ipairs(DiscSpellIDs) do
			self.AbilityHandlers[v] = modForSilentResolve
		end
		DiscSpellIDs = nil

		for _,v in ipairs(HolySpellIDs) do
			self.AbilityHandlers[v] = modForSilentResolve
		end
		HolySpellIDs = nil

		for _,v in ipairs(ShadowSpellIDs) do
			self.AbilityHandlers[v] = modForShadowAffinity
		end
		ShadowSpellIDs = nil

		----------------------------------------------------
		-- Vampiric Embrace heal modifiers
		-- TODO: Verify that this is the right spell ID!
		----------------------------------------------------
		-- self.AbilityHandlers[15286] = modForSilentResolve

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
		-- Holy Nova, Shadowguard, Binding Heal
		----------------------------------------------------
		local holyNovaIDs = {15237, 15430, 15431, 27799, 27800, 27801, 25331}
		local shadowguardIDs = {18137, 19308, 19309, 19310, 19311, 19312, 25477}
		local bindingHealIDs = {32546}
		local zeroThreat = function(self, amt) return 0 end
		local halfThreat = function(self, amt) return amt * 0.5 * self.silentResolveMod end
		for _, v in ipairs(holyNovaIDs) do
			self.AbilityHandlers[v] = zeroThreat
		end

		for _, v in ipairs(shadowguardIDs) do
			self.AbilityHandlers[v] = zeroThreat
		end

		for _, v in ipairs(bindingHealIDs) do
			self.AbilityHandlers[v] = halfThreat
		end
		holyNovaIDs = nil
		shadowguardIDs = nil
		bindingHealIDs = nil
	end
	
	function Priest:ClassEnable()
		self.passiveThreatModifiers = 1
	end

	local shadowAffinityRanks = {0.92, 0.84, 0.75}
	function Priest:ScanTalents()
		self.silentResolveMod = 1 - (0.04 * select(5, GetTalentInfo(1, 3)))
		self.shadowAffinityMod = shadowAffinityRanks[select(5, GetTalentInfo(3, 3))] or 1
		self.impPWS = 1 + (select(5, GetTalentInfo(1, 5)) * 0.05)
	end

	function Priest:Fade(action, spellID, applications)
		if action == "lose" then
			self:AddThreat(self.fadedAmount)
		elseif action == "gain" then
			self.fadedAmount = threatAmounts["fade"][spellID] * self.shadowAffinityMod * self:threatMods()
			self:AddThreat(self.fadedAmount * -1)
		end
	end
end
