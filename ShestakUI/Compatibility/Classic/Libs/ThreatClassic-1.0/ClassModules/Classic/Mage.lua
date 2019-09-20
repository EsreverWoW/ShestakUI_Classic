local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "MAGE" then return end

local _G = _G
local select = _G.select
local max = _G.max
local GetTalentInfo = _G.GetTalentInfo

local Mage = ThreatLib:GetOrCreateModule("Player")

local SCHOOL_MASK_FIRE = _G.SCHOOL_MASK_FIRE or 0x04;
local SCHOOL_MASK_FROST = _G.SCHOOL_MASK_FROST or 0x10;
local SCHOOL_MASK_ARCANE = _G.SCHOOL_MASK_ARCANE or 0x40;

local NWBonusIDs = {
	-- Scorch
	2948, 8444, 8445, 8446, 10205, 10206, 10207,

	-- Fireball
	133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306,

	-- Frostbolt
	116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304,
}
local NWBonus20IDs = {
	-- Arcane Missiles
	5143, 5144, 5145, 8416, 8417, 10211, 10212, 25345,
}

function Mage:ClassInit()
	-- School names come through in english thanks to Parser-3.0
	self.schoolThreatMods[SCHOOL_MASK_FIRE] = function(self, amt) return amt * self.fireThreatMod * self:ItemSetMods() end
	self.schoolThreatMods[SCHOOL_MASK_FROST] = function(self, amt) return amt * self.frostThreatMod * self:ItemSetMods() end
	self.schoolThreatMods[SCHOOL_MASK_ARCANE] = function(self, amt) return amt * self.arcaneThreatMod * self:ItemSetMods() end

	for i = 1, #NWBonusIDs do
		self.AbilityHandlers[NWBonusIDs[i]] = self.NWBonus100
	end
	for i = 1, #NWBonus20IDs do
		self.AbilityHandlers[NWBonus20IDs[i]] = self.NWBonus20
	end
	NWBonusIDs, NWBonus20IDs = nil, nil

	-- I tested Counterspell with a level 32 mage. I would like mages of other levels
	-- to test its threat value as well.
	-- Counterspell
	self.CastLandedHandlers[2139] = function(self, spellID, target) self:AddTargetThreat(target, 300 * self:threatMods()) end

	-- Remove Lesser Curse
	self.CastHandlers[475] = function(self, spellID, target) self:AddThreat(14 * self:threatMods()) end

	self.itemSets = {
		["Arcanist"] 	= {16795, 16796, 16797, 16800, 16802, 16799, 16798, 16801},
		["Netherwind"]	= {16914, 16915, 16917, 16912, 16818, 16918, 16916, 16913}
	}
end

function Mage:ClassEnable()
	self.passiveThreatModifiers = 1
end

function Mage:ScanTalents()
	if ThreatLib.Classic then
		self.arcaneThreatMod = 1 - 0.2 * select(5, GetTalentInfo(1, 1))
		self.frostThreatMod = 1 - 0.1 * select(5, GetTalentInfo(3, 12))
		self.fireThreatMod = 1 - 0.15 * select(5, GetTalentInfo(2, 9))
	else
		self.arcaneThreatMod = 1 -- for when testing in retail
		self.frostThreatMod = 1 -- for when testing in retail
		self.fireThreatMod = 1 -- for when testing in retail
	end
end

function Mage:ItemSetMods()
	local mod = 1
	if self:getWornSetPieces("Arcanist") >= 8 then
		mod = mod * 0.85
	end
	return mod
end

function Mage:NWBonus100(amt)
	if self:getWornSetPieces("Netherwind") >= 3 then
		amt = max(0, amt - 100)
	end
	return amt
end

function Mage:NWBonus20(amt)
	if self:getWornSetPieces("Netherwind") >= 3 then
		amt = max(0, amt - 20)
	end
	return amt
end
