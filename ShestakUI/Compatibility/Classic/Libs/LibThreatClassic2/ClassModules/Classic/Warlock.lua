if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "WARLOCK" then return end 

local _G = _G
local tonumber = _G.tonumber
local type = _G.type
local ipairs = _G.ipairs
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo

local Warlock = ThreatLib:GetOrCreateModule("Player")

local destructionSpellIDs = {
	-- Hellfire
	1949, 11683, 11684,
	-- Rain of Fire
	5740, 6219, 11677, 11678,
	-- Soul Fire
	6353, 17924,
	-- Conflagrate
	17962, 18930, 18931, 18932,
	-- Shadow Bolt
	686, 695, 705, 1088, 1106, 7641, 11659, 11660, 11661, 25307,
	-- Shadowburn
	17877, 18867, 18868, 18869, 18870, 18871
}

local plagueheartBonusIDs = {
	-- Corruption
	172, 6222, 6223, 7648, 11671, 11672, 25311,

	-- Immolate
	348, 707, 1094, 2941, 11665, 11667, 11668, 25309,

	-- Curse of Agony
	980, 1014, 6217, 11711, 11712, 11713,

	-- Siphon Life
	18265, 18879, 18880, 18881,
}

local masterDemonologistIDs = {23759, 23826, 23827, 23828, 23829}
local searingPainIDs = {5676, 17919, 17920, 17921, 17922, 17923}

function Warlock:ClassInit()
	for _, id in ipairs(masterDemonologistIDs) do
		self.BuffHandlers[id] = self.MasterDemonologist
	end
	masterDemonologistIDs = nil

	for _, id in ipairs(searingPainIDs) do
		self.AbilityHandlers[id] = self.SearingPain
	end
	searingPainIDs = nil

	for _,v in ipairs(destructionSpellIDs) do
		self.AbilityHandlers[v] = self.Destruction
	end
	destructionSpellIDs = nil

	for _,v in ipairs(plagueheartBonusIDs) do
		self.AbilityHandlers[v] = self.PlagueheartBonus
	end
	plagueheartBonusIDs = nil

	self.itemSets = {
		["Nemesis"] = { 16927, 16928 , 16929, 16930, 16931, 16932, 16933, 16934  },
		["Plagueheart"] = { 22504, 22505, 22506, 22507, 22508, 22509, 22510, 22511, 23063 },
	}

	-- Life Tap
	--[[
	self.ExemptGains[31818] = true
	self.ExemptGains[32553] = true
	--]]
	self.ExemptGains[1454] = true
	self.ExemptGains[1455] = true
	self.ExemptGains[1456] = true
	self.ExemptGains[11687] = true
	self.ExemptGains[11688] = true
	self.ExemptGains[11689] = true

	-- Death Coil Heals
	self.ExemptGains[6789] = true
	self.ExemptGains[17625] = true
	self.ExemptGains[17926] = true

	-- Siphon Life
	self.ExemptGains[18265] = true
	self.ExemptGains[18879] = true
	self.ExemptGains[18880] = true
	self.ExemptGains[18881] = true

	-- Drain Life
	self.ExemptGains[689] = true
	self.ExemptGains[699] = true
	self.ExemptGains[709] = true
	self.ExemptGains[7651] = true
	self.ExemptGains[11699] = true
	self.ExemptGains[11700] = true

	-- Drain Mana
	self.ExemptGains[5138] = true
	self.ExemptGains[6226] = true
	self.ExemptGains[11703] = true
	self.ExemptGains[11704] = true
end

function Warlock:ClassEnable()
	self.passiveThreatModifiers = 1
end

function Warlock:ClassDisable()
end

function Warlock:MasterDemonologist(action)
	-- The imp is MAGE. Succubus/Felguard are PALADIN. Voidwalker is WARRIOR.
	if action == "exist" and UnitExists("pet") and select(2, UnitClass("pet")) == "MAGE" then
		self:AddBuffThreatMultiplier(self.MDMod)
	end
end

function Warlock:ScanTalents()
	-- Scan talents
	if ThreatLib.Classic then
		self.MDMod = 1 - 0.04 * select( 5, GetTalentInfo(2, 15))
	else
		self.MDMod = 1 -- for when testing in retail
	end
end

function Warlock:SearingPain(amt)
	local nemesisBonus = 1

	if self:getWornSetPieces("Nemesis") == 8 then
		nemesisBonus = 0.8
	end

	return amt * 2 * nemesisBonus
end

function Warlock:Destruction(amt, dmg, isCrit)
	local plagueheartBonus = 1

	if isCrit and self:getWornSetPieces("Plagueheart") >= 6 then
		plagueheartBonus = 0.75
	end

	local nemesisBonus = 1

	if self:getWornSetPieces("Nemesis") == 8 then
		nemesisBonus = 0.8
	end

	return amt * nemesisBonus * plagueheartBonus
end

function Warlock:PlagueheartBonus(amt, dmg, isCrit)
	local plagueheartBonus = 1

	if self:getWornSetPieces("Plagueheart") >= 6 then
		if isCrit then
			plagueheartBonus = 0.75 * 0.75
		else
			plagueheartBonus = 0.75
		end
	end

	local nemesisBonus = 1

	if self:getWornSetPieces("Nemesis") == 8 then
		nemesisBonus = 0.8
	end

	return amt * nemesisBonus * plagueheartBonus
end
