local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

if select(2, _G.UnitClass("player")) ~= "SHAMAN" then return end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local _G = _G
	local tonumber = _G.tonumber
	local ipairs = _G.ipairs
	local select = _G.select
	local GetTalentInfo = _G.GetTalentInfo

	local ThreatLib = _G.ThreatLib

	local Shaman = ThreatLib:GetOrCreateModule("Player")

	local healingSpellIDs = {
		-- Lesser Healing Wave
		8004, 8008, 8010, 10466, 10467, 10468, 25420,
		
		-- Healing Wave
		331, 332, 547, 913, 939, 959, 8005, 10395, 10396, 25357, 25391, 25396,
		
		-- Chain Heal
		1064, 10622, 10623, 25422, 25423,
		
		-- Earth Shield
		-- Does this get Healing Grace's threat redcution? To test!
		974, 32593, 32594,
		
		-- Healing Stream Totem
		-- Will this ever fire?
		5394, 6375, 6377, 10462, 10463, 25567,
		
		-- Lifebloom (Since it counts as the shaman casting the heal)
		33763,
		
		-- Prayer of Mending (Since it counts as the shaman casting the heal)
		33076
	}
	
	local clIDs = {
		-- Chain Lightning
		-- I think these are the old CL spell IDs?
		421, 930, 2860, 10605, 25439, 25442,		
		-- New IDs
		45297, 45298, 45299, 45300, 45301, 45302
	}
	
	local lbIDs = {		
		-- Lightning Bolt
		-- Old IDs
		403, 529, 548, 915, 943, 6041, 10391, 10392, 15207, 15208, 25448, 25449,		
		-- New IDs
		45284, 45286, 45287, 45288, 45289, 45290, 45291, 45292, 45293, 45294, 45295, 45296
	}

	local frostShockIDs = { 8056, 8058, 10472, 10473, 25464 }
	
	local SCHOOL_MASK_PHYSICAL = SCHOOL_MASK_PHYSICAL or 0x01
	local SCHOOL_MASK_FIRE = _G.SCHOOL_MASK_FIRE or 0x04
	local SCHOOL_MASK_NATURE = _G.SCHOOL_MASK_NATURE or 0x08
	local SCHOOL_MASK_FROST = _G.SCHOOL_MASK_FROST or 0x10

	function Shaman:ClassInit()	
		-- ThreatMods should return the modifications (if any) to the threat passed in
		for _,v in ipairs(healingSpellIDs) do
			self.AbilityHandlers[v] = self.HealingSpells
		end
		healingSpellIDs = nil

		for _, v in ipairs(frostShockIDs) do
			self.AbilityHandlers[v] = self.FrostShock
		end
		frostShockIDs = nil
		
		self.schoolThreatMods[SCHOOL_MASK_PHYSICAL] = self.Melee
		self.schoolThreatMods[SCHOOL_MASK_FIRE] = self.ElementalPrecisionFunc
		self.schoolThreatMods[SCHOOL_MASK_NATURE] = self.ElementalPrecisionFunc
		self.schoolThreatMods[SCHOOL_MASK_FROST] = self.ElementalPrecisionFunc
		
		for _,v in ipairs(clIDs) do
			self.AbilityHandlers[v] = self.ChainLightning
			self.CastMissHandlers[v] = self.ChainLightningMiss
			self.CastHandlers[v] = self.StartCLCast
		end
		clIDs = nil
		
		for _,v in ipairs(lbIDs) do
			self.AbilityHandlers[v] = self.LightningBolt
			self.CastMissHandlers[v] = self.LightningBoltMiss
			local n, r = GetSpellInfo(v)
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

	local precisionReduction = {1, 0.96, 0.93, 0.9}
	function Shaman:ScanTalents()
		-- Scan talents
		self.HealingGrace = 1 - 0.05 * select(5, GetTalentInfo(3,9))
		self.ElementalPrecision = precisionReduction[select(5, GetTalentInfo(1,15))+1]
		
		local SpiritWeaponsModifier = 0.3
		self.SpiritWeapons = 1 - SpiritWeaponsModifier * select(5, GetTalentInfo(2,13))
	end

	function Shaman:HealingSpells(amt)
		return amt * self.HealingGrace
	end

	function Shaman:ElementalPrecisionFunc(amt)
		return amt * self.ElementalPrecision
	end

	function Shaman:FrostShock(amt)
		return amt * 2
	end

	function Shaman:Melee(amt)
		return amt * self.SpiritWeapons
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
end
