local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

if select(2, _G.UnitClass("player")) ~= "WARLOCK" then return end 

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local _G = _G
	local tonumber = _G.tonumber
	local type = _G.type
	local ipairs = _G.ipairs
	local select = _G.select
	local GetTalentInfo = _G.GetTalentInfo
	local UnitCreatureFamily = _G.UnitCreatureFamily

	local ThreatLib = _G.ThreatLib

	local Warlock = ThreatLib:GetOrCreateModule("Player")

	--[[
		Health funnel threat = ?
		Unending breath doesn't seem to cause threat
		Drain life debuff = no threat
		Imp shadowbolt proc = no threat
		Drain soul debuff = no threat
		Amplify Curse = no threat
	--]]

	local afflictionSpellIDs = {
		-- Drain Life
		689, 699, 709, 7651, 11699, 11700, 27219, 27220,		
		-- Unstable Affliction
		30108, 30404, 30405,		
		-- Drain Soul
		1120, 8288, 8289, 11675,		
		-- Curse of Doom
		603, 30910,		
		-- Death Coil
		6789, 17625, 17926, 27223, 		
		-- Seed of Corruption
		27243,
	}
	
	local destructionSpellIDs = {
		-- Hellfire
		1949, 11683, 11684, 27213,		
		-- Rain of Fire
		5740, 6219, 11677, 11678, 27212,		
		-- Soul Fire
		6353, 17924, 27211, 30545,		
		-- Conflagrate
		17962, 18930, 18931, 18932, 27266, 30912,		
		-- Incinerate
		29722, 32231,		
		-- Shadowfury
		30283, 30413, 30414,		
		-- Shadow Bolt
		686, 695, 705, 1088, 1106, 7641, 11659, 11660, 11661, 25307, 27209,		
		-- Shadowburn
		17877, 18867, 18868, 18869, 18870, 18871, 27263, 30546		
	}
	
	local masterDemonologistIDs = {23785, 23833, 23823, 23824, 23825}
	local searingPainIDs = {5676, 17919, 17920, 17921, 17922, 17923, 27210, 30459}
	local afflictionSpecialIDs = {
		-- Siphon Life
		18265, 18879, 18880, 18881, 27264, 30911,		
		-- Corruption
		172, 6222, 6223, 7648, 11671, 11672, 25311, 27216,
		-- Curse of Agony
		980, 1014, 6217, 11711, 11712, 11713, 27218
	}
	
	local destructionSpecialIDs = {
		-- Immolate
		348, 707, 1094, 2941, 11665, 11667, 11668, 25309, 27215
	}
	
	function Warlock:ClassInit()	
		for _, id in ipairs(masterDemonologistIDs) do
			self.BuffHandlers[id] = self.MasterDemonologist
		end
		masterDemonologistIDs = nil
		
		-- Soulshatter uses 32835 when it lands, 29858 for "player performed it", and _both_ (apparently at random) for misses. o.0
		self.CastMissHandlers[32835] = self.SoulshatterMissed
		self.CastMissHandlers[29858] = self.SoulshatterMissed
		
		self.CastHandlers[29858] = self.Soulshatter

		for _, id in ipairs(searingPainIDs) do
			self.AbilityHandlers[id] = self.SearingPain
		end
		searingPainIDs = nil
		
		--Affliction
		
		for _,v in ipairs(afflictionSpellIDs) do
			self.AbilityHandlers[v] = self.Affliction
		end
		afflictionSpellIDs = nil
		
		for _, v in ipairs(afflictionSpecialIDs) do
			self.AbilityHandlers[v] = self.AfflictionSpecial
		end
		afflictionSpecialIDs = nil
		
		for _,v in ipairs(destructionSpellIDs) do
			self.AbilityHandlers[v] = self.Destruction
		end
		destructionSpellIDs = nil

		for _,v in ipairs(destructionSpecialIDs) do
			self.AbilityHandlers[v] = self.DestructionSpecial
		end
		destructionSpecialIDs = nil
		
		self.itemSets = {
		 	["Nemesis"] = { 16927, 16928 , 16929, 16930, 16931, 16932, 16933, 16934  },
		 	["Plagueheart"] = { 22504, 22505, 22506, 22507, 22508, 22509, 22510, 22511, 23063 },
		}
		
		-- Life Tap
		self.ExemptGains[31818] = true
		self.ExemptGains[32553] = true
		
		-- Death Coil Heals
		self.ExemptGains[6789] = true
		self.ExemptGains[17625] = true
		self.ExemptGains[17926] = true
		self.ExemptGains[27223] = true
		
		-- Siphon Life
		self.ExemptGains[18265] = true
		self.ExemptGains[18879] = true
		self.ExemptGains[18880] = true
		self.ExemptGains[18881] = true
		self.ExemptGains[27264] = true
		self.ExemptGains[30911] = true
		
		-- Drain Life
		self.ExemptGains[689] = true
		self.ExemptGains[699] = true
		self.ExemptGains[709] = true
		self.ExemptGains[7651] = true
		self.ExemptGains[11699] = true
		self.ExemptGains[11700] = true
		self.ExemptGains[27219] = true
		self.ExemptGains[27220] = true
		
		-- Drain Mana
		self.ExemptGains[5138] = true
		self.ExemptGains[6226] = true
		self.ExemptGains[11703] = true
		self.ExemptGains[11704] = true
		self.ExemptGains[27221] = true
		self.ExemptGains[30908] = true
	end
	
	function Warlock:ClassEnable()
		self.passiveThreatModifiers = 1
	end

	function Warlock:MasterDemonologist(action)
		-- The imp is a mage. Succy/Felguard are paladins, voidwalker is a warrior.
		if action == "exist" and UnitExists("pet") and select(2, UnitClass("pet")) == "MAGE" then
			self:AddBuffThreatMultiplier(self.MDMod)
		end
	end		

	function Warlock:ScanTalents()
		-- Scan talents
		self.MDMod = 1 - 0.04 * select( 5, GetTalentInfo(2, 17))
		self.afflictionModifier = 1 - 0.05 * select( 5, GetTalentInfo(1, 4))
		self.destructionModifier = 1 - 0.05 * select( 5, GetTalentInfo(3, 10))
	end

	function Warlock:Soulshatter(spellID, target)
		for k, v in pairs(self.targetThreat) do
			self:MultiplyTargetThreatTransactional(k, spellID, 0.5)
		end
	end
	
	function Warlock:SoulshatterMissed(spellID, target)
		-- The transactions were queued for SpellID 29858, so we ignore the argument
		self:rollbackTransaction(target, 29858)
	end
	
	function Warlock:SearingPain(amt)
		return amt * 2 * self.destructionModifier
	end

	function Warlock:Affliction(amt)
		return amt * self.afflictionModifier
	end

	function Warlock:AfflictionSpecial(amt)
		local plagueheartBonus = 1
		
		if self:getWornSetPieces("Plagueheart") >= 6 then
			plagueheartBonus = 0.75
		end
		
		return amt * self.afflictionModifier * plagueheartBonus
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

		return amt * self.destructionModifier * nemesisBonus * plagueheartBonus
	end

	function Warlock:DestructionSpecial(amt, dmg, isCrit)
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
		
		return amt * self.destructionModifier * nemesisBonus * plagueheartBonus
	end
end
