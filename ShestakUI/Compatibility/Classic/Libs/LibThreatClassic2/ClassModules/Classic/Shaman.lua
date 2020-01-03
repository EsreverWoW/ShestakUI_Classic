if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

if select(2, _G.UnitClass("player")) ~= "SHAMAN" then return end

local _G = _G
local ipairs = _G.ipairs
local select = _G.select
local GetTalentInfo = _G.GetTalentInfo

local Shaman = ThreatLib:GetOrCreateModule("Player")

local healingSpellIDs = {
	-- Lesser Healing Wave
	8004, 8008, 8010, 10466, 10467, 10468,

	-- Healing Wave
	331, 332, 547, 913, 939, 959, 8005, 10395, 10396, 25357,

	-- Chain Heal
	1064, 10622, 10623,
}

local clIDs = {
	-- Chain Lightning
	421, 930, 2860, 10605
}

local lbIDs = {
	-- Lightning Bolt
	403, 529, 548, 915, 943, 6041, 10391, 10392, 15207, 15208
}

local earthShockIDs = { 8042, 8044, 8045, 8046, 10412, 10413, 10414 }

function Shaman:ClassInit()
	-- ThreatMods should return the modifications (if any) to the threat passed in
	for _,v in ipairs(healingSpellIDs) do
		self.AbilityHandlers[v] = self.HealingSpells
	end
	healingSpellIDs = nil

	for _, v in ipairs(earthShockIDs) do
		self.AbilityHandlers[v] = self.EarthShock
	end
	earthShockIDs = nil

	for _,v in ipairs(clIDs) do
		self.AbilityHandlers[v] = self.ChainLightning
		self.CastMissHandlers[v] = self.ChainLightningMiss
		self.CastHandlers[v] = self.StartCLCast
	end
	clIDs = nil

	for _,v in ipairs(lbIDs) do
		self.AbilityHandlers[v] = self.LightningBolt
		self.CastMissHandlers[v] = self.LightningBoltMiss
		self.CastHandlers[v] = self.StartLBCast
	end
	lbIDs = nil

	self.lastCLCast = 0
	self.lastCLHitTime = 0
	self.lastLBCast = 0
	self.lastLBHitTime = 0
end

function Shaman:ClassEnable()
	self.passiveThreatModifiers = 1
end

function Shaman:ClassDisable()
end

function Shaman:ScanTalents()
	-- Scan talents
	if ThreatLib.Classic then
		self.HealingGrace = 1 - 0.05 * select(5, GetTalentInfo(3,9))
	else
		self.HealingGrace = 1 -- for when testing in retail
	end
end

function Shaman:HealingSpells(amt)
	return amt * self.HealingGrace
end

function Shaman:EarthShock(amt)
	return amt * 2
end

function Shaman:ChainLightning(amt)
	local t = GetTime()
	if self.lastCLHitTime == 0 then
		self.lastCLHitTime = t
	end
	if t - self.lastCLHitTime <= 0.045 then
		return amt
	else
		return 0
	end
end

function Shaman:LightningBolt(amt)
	ThreatLib:Debug("Lightning bolt damage!")
	if self.lastLBHitTime == 0 then
		self.lastLBHitTime = GetTime()
		return amt
	else
		return 0
	end
end

function Shaman:ChainLightningMiss(spellID)
	local t = GetTime()
	if self.lastCLHitTime == 0 then
		self.lastCLHitTime = t
	end
end

function Shaman:LightningBoltMiss(spellID)
	ThreatLib:Debug("Missed lightning bolt! (%s)", spellID)
	local t = GetTime()
	if self.lastLBHitTime == 0 then
		self.lastLBHitTime = t
	end
end

function Shaman:StartCLCast()
	self.lastCLCast = GetTime()
	self.lastCLHitTime = 0
end

function Shaman:StartLBCast()
	ThreatLib:Debug("Casting Lightning bolt...")
	self.lastLBCast = GetTime()
	self.lastLBHitTime = 0
end
