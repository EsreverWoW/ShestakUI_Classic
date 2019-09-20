local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

if select(2, UnitClass("player")) ~= "ROGUE" then return end

local pairs, ipairs = _G.pairs, _G.ipairs

ThreatLib_funcs[#ThreatLib_funcs+1] = function()
	local _G = _G
	local tonumber = _G.tonumber
	local select = _G.select
	local GetTalentInfo = _G.GetTalentInfo

	local ThreatLib = _G.ThreatLib
	local Rogue = ThreatLib:GetOrCreateModule("Player")

	local feintThreatAmounts = {
		[1966] = -150,
		[6768] = -240,
		[8637] = -390,
		[11303] = -600,
		[25302] = -800,
		[27448] = -1050
	}

	function Rogue:ClassInit()	
		-- CastHandlers should return true if they modified the threat level, false if they don't
		local feint = function(self, spellID, target) self:AddTargetThreat(target, self:Feint(spellID)) end
		for k, v in pairs(feintThreatAmounts) do
			self.CastLandedHandlers[k] = feint
		end
		
		self.CastHandlers[1856] = self.Vanish
		self.CastHandlers[1857] = self.Vanish
		self.CastHandlers[26889] = self.Vanish
		
		-- ThreatMods should return the modifications (if any) to the threat passed in
		local abilityIDs = {
			-- Sinister Strike
			1752, 1757, 1758, 1759, 1760, 8621, 11293, 11294, 26861, 26862,
			
			-- Backstab
			53, 2589, 2590, 2591, 8721, 11279, 11280, 11281, 25300, 26863,
			
			-- Hemo
			16511, 17347, 17348, 26864,
			
			-- Eviscerate
			2098, 6760, 6761, 6762, 8623, 8624, 11299, 11300, 31016, 26865
		}
		for _, id in ipairs(abilityIDs) do
			self.AbilityHandlers[id] = self.BonescytheBonus
		end
		
		-- Anesthetic Poison
		self.AbilityHandlers[26786]		= function() return 0 end
		
		-- Set names don't need to be localized.
		self.itemSets = {
			["Bloodfang"] = { 16908, 16909, 16832, 16906, 16910, 16911, 16905, 16907 },
			["Bonescythe"] = { 22478, 22477, 22479, 22480, 22482, 22483, 22476, 22481, 23060}
		}
	end
	
	function Rogue:ClassEnable()
		self.passiveThreatModifiers = 0.71
	end

	function Rogue:ScanTalents()
		-- Scan talents
		local rank = select(5, GetTalentInfo(3, 3))
		self.feintMod = 1 + (0.1 * rank)
	end

	function Rogue:Feint(spellID)
		local bfBonus = 1
		if self:getWornSetPieces("Bloodfang") >= 5 then
			bfBonus = 1.2
		end		
		return feintThreatAmounts[spellID] * self.feintMod * self:threatMods() * bfBonus
	end

	function Rogue:Vanish()
		self:MultiplyThreat(0)
	end

	function Rogue:BonescytheBonus(amt)
		if self:getWornSetPieces("Bonescythe") >= 6 then
			return amt * 0.92
		end
		return amt
	end

end
