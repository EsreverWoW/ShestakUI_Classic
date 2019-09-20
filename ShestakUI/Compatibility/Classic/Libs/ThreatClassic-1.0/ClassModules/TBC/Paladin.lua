local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

local _, c = _G.UnitClass("player")
if c ~= "PALADIN" then return end 

local GetTime = _G.GetTime

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local ThreatLib = _G.ThreatLib
	local Paladin = ThreatLib:GetOrCreateModule("Player")

	local _G = _G
	local ipairs = _G.ipairs
	local select = _G.select
	local GetTalentInfo = _G.GetTalentInfo

	local irfRanks = {0, 0.16, 0.33, 0.5}

	local HolyHealIDs = {
		-- Holy Light
		635, 639, 647, 1026, 1042, 3472, 10328, 10329, 25292, 27135, 27136,
		
		-- Holy Shock
		25903, 25913, 25914, 27175, 33074,
		
		-- Lay on Hands
		633, 2800, 10310, 27154,
		
		-- Seal of Light
		20167, 20333, 20334, 20340, 27161,
		
		-- Flash of Light
		19750, 19939, 19940, 19941, 19942, 19943, 27137
	}

	local rfOn = false
	local fanaticismModifier = 0
	local RIGHTEOUS_FURY_SPELL_ID = 25780
	
	function Paladin:ClassInit()
		self.schoolThreatMods[_G.SCHOOL_MASK_HOLY] = self.RighteousFury
		
		-- Righteous Fury
		self.BuffHandlers[RIGHTEOUS_FURY_SPELL_ID] = self.RighteousFuryBuff
		
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
			return amt * 1.35
		end
		local holyShieldIDs = {20925, 20927, 20928, 27179}
		for i = 1, #holyShieldIDs do
			self.AbilityHandlers[holyShieldIDs[i]] = holyShield
		end
		
		-- Righteous Defense
		-- The player spell is 31789
		-- The taunt effect is 31790
		self.CastLandedHandlers[31789] = self.CastRighteousDefense
		self.MobDebuffHandlers[31790] = self.RighteousDefense
		-- Mob debuff handler here!
		
		HolyHealIDs = nil
		self.RighteousDefenseCastTime = 0
	end
	
	function Paladin:ClassEnable()
		self.passiveThreatModifiers = 1 - fanaticismModifier
	end

	function Paladin:ScanTalents()
		-- Scan talents	
		self.righteousFuryMod = 1.6 + (0.6 * irfRanks[select(5, GetTalentInfo(2, 7))+1])
		
		-- Fanaticism
		local rank = select(5, GetTalentInfo(3, 21))
		fanaticismModifier = (0.06 * rank)
		self:calcBuffMods()
	end

	function Paladin:RighteousFuryBuff(action, spellID, applications)
		self.isTanking = false
		if action == "gain" or action == "exist" then
			rfOn = true
			self.isTanking = true
			self.passiveThreatModifiers = 1
		elseif action == "lose" then
			rfOn = false
			self.passiveThreatModifiers = 1 - fanaticismModifier
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

	local tauntOffTarget = nil
	function Paladin:CastRighteousDefense(spellID, target)
		tauntOffTarget = target
		self.RighteousDefenseCastTime = GetTime()
	end
	
	function Paladin:RighteousDefense(spellID, target)
		if GetTime() - self.RighteousDefenseCastTime < 1 then
			local targetThreat = ThreatLib:GetThreat(tauntOffTarget, target)
			local myThreat = ThreatLib:GetThreat(UnitGUID("player"), target)
			if targetThreat > 0 and targetThreat > myThreat then
				self:SetTargetThreat(target, targetThreat)
				self.nextEventHook = self.AfterRighteousDefense
			elseif targetThreat == 0 then
				local maxThreat = ThreatLib:GetMaxThreatOnTarget(target)
				self:SetTargetThreat(target, maxThreat)
				self.nextEventHook = self.AfterRighteousDefense
			end
		end
	end

	function Paladin:AfterRighteousDefense(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID)
		if eventtype ~= "SPELL_AURA_APPLIED" or spellID ~= 31790 then
			ThreatLib:PublishThreat()
		end
	end
end
