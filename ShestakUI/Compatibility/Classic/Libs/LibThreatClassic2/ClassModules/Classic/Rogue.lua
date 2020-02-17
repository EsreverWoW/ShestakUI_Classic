if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "ROGUE" then return end

local pairs, ipairs = _G.pairs, _G.ipairs

local _G = _G
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo

local Rogue = ThreatLib:GetOrCreateModule("Player-r"..MINOR)

local feintThreatAmounts = {
	[1966] = -150,
	[6768] = -240,
	[8637] = -390,
	[11303] = -600,
	[25302] = -800
}

function Rogue:ClassInit()
	-- CastHandlers should return true if they modified the threat level, false if they don't
	local feint = function(self, spellID, target) self:AddTargetThreat(target, self:Feint(spellID)) end
	for k, v in pairs(feintThreatAmounts) do
		self.CastLandedHandlers[k] = feint
	end

	self.CastHandlers[1856] = self.Vanish
	self.CastHandlers[1857] = self.Vanish

	-- ThreatMods should return the modifications (if any) to the threat passed in
	local abilityIDs = {
		-- Sinister Strike
		1752, 1757, 1758, 1759, 1760, 8621, 11293, 11294,

		-- Backstab
		53, 2589, 2590, 2591, 8721, 11279, 11280, 11281, 25300,

		-- Hemo
		16511, 17347, 17348,

		-- Eviscerate
		2098, 6760, 6761, 6762, 8623, 8624, 11299, 11300, 31016
	}
	for _, id in ipairs(abilityIDs) do
		self.AbilityHandlers[id] = self.BonescytheBonus
	end

	-- Set names don't need to be localized.
	self.itemSets = {
		["Bloodfang"] = { 16908, 16909, 16832, 16906, 16910, 16911, 16905, 16907 },
		["Bonescythe"] = { 22478, 22477, 22479, 22480, 22482, 22483, 22476, 22481, 23060}
	}
end

function Rogue:ClassEnable()
	self.passiveThreatModifiers = 0.71
end

function Rogue:ClassDisable()
end

function Rogue:ScanTalents()
	-- Scan talents
	if ThreatLib.Classic then
		self.feintMod = 1 + (0.1 * select(5, GetTalentInfo(3, 3)))
	else
		self.feintMod = 1 -- for when testing in retail
	end
end

function Rogue:Feint(spellID)
	local bfBonus = 1
	if self:getWornSetPieces("Bloodfang") >= 5 then
		bfBonus = 1.25
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
