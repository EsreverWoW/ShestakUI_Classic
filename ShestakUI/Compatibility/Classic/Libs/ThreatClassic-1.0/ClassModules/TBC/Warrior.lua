local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end
if select(2, _G.UnitClass("player")) ~= "WARRIOR" then return end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()
	local _G = _G
	local max = _G.max
	local tonumber = _G.tonumber
	local type = _G.type
	local select = _G.select
	local GetTalentInfo = _G.GetTalentInfo
	local GetShapeshiftForm = _G.GetShapeshiftForm
	local GetSpellInfo = _G.GetSpellInfo
	local pairs, ipairs = _G.pairs, _G.ipairs
	local GetTime = _G.GetTime
	local UnitDebuff = _G.UnitDebuff
	local UnitLevel = _G.UnitLevel

	local ThreatLib = _G.ThreatLib

	local Warrior = ThreatLib:GetOrCreateModule("Player")

	local MSBTTalentMod = 1.0
	local MSBTMod = 1.0
	local zerkerStanceMod = 0

	local sunderFactor 			= 301 / 67
	local shieldBashFactor 		= 230 / 64
	local revengeFactor 		= 201 / 70
	local heroicStrikeFactor 	= 220 / 70
	local shieldSlamFactor 		= 307 / 70
	local cleaveFactor 			= 130 / 68
	local hamstringFactor 		= 181 / 67
	local mockingBlowFactor 	= 290 / 65
	local battleShoutFactor 	= 1
	local demoShoutFactor 		= 56 / 70
	
	local sunderName = GetSpellInfo(7386)
	
	local threatValues = {
		sunder = {
			[7386] = sunderFactor * 10,
			[7405] = sunderFactor * 22, 
			[8380] = sunderFactor * 34,
			[11596] = sunderFactor * 46, 
			[11597] = sunderFactor * 58,
			[25225] = 301
		},
		shieldBash = {
			[72] = shieldBashFactor * 12,
			[1671] = shieldBashFactor * 32,
			[1672] = shieldBashFactor * 52,
			[29704] = 230
		},
		revenge = {
			[6572] = revengeFactor * 14,
			[6574] = revengeFactor * 24,
			[7379] = revengeFactor * 34,
			[11600] = revengeFactor * 44,
			[11601] = revengeFactor * 54,
			[25288] = revengeFactor * 60,
			[25269] = revengeFactor * 63,
			[30357] = 201
		},
		heroicStrike = {
			[78] = heroicStrikeFactor * 1,
			[284] = heroicStrikeFactor * 8,
			[285] = heroicStrikeFactor * 16,
			[1608] = heroicStrikeFactor * 24,
			[11564] = heroicStrikeFactor * 32,
			[11565] = heroicStrikeFactor * 40,
			[11566] = heroicStrikeFactor * 48,
			[11567] = 145,
			[25286] = 173,
			[29707] = 196,
			[30324] = 220
		},
		shieldSlam = {
			[23922] = shieldSlamFactor * 40,
			[23923] = shieldSlamFactor * 48,
			[23924] = shieldSlamFactor * 54,
			[23925] = 250,
			[25258] = 286,
			[30356] = 307
		},
		cleave = {
			[845] = cleaveFactor * 20,
			[7369] = cleaveFactor * 30,
			[11608] = cleaveFactor * 40,
			[11609] = cleaveFactor * 50,
			[20569] = 100,
			[25231] = 130
		},
		hamstring = {
			[1715] = hamstringFactor * 8,
			[7372] = hamstringFactor * 32,
			[7373] = hamstringFactor * 54,
			[25212] = 181
		},
		mockingBlow = {
			[694] = mockingBlowFactor * 16,
			[7400] = mockingBlowFactor * 26,
			[7402] = mockingBlowFactor * 36,
			[20559] = mockingBlowFactor * 46,
			[20560] = mockingBlowFactor * 56,
			[25266] = 290
		},
		battleShout = {
			[6673] = battleShoutFactor * 1,
			[5242] = battleShoutFactor * 12,
			[6192] = battleShoutFactor * 22,
			[11549] = battleShoutFactor * 32,
			[11550] = battleShoutFactor * 42,
			[11551] = battleShoutFactor * 52,
			[25289] = battleShoutFactor * 60,
			[2048] = 69
		},
		demoShout = {
			[1160] = demoShoutFactor * 14,
			[6190] = demoShoutFactor * 24,
			[11554] = demoShoutFactor * 34,
			[11555] = demoShoutFactor * 44,
			[11556] = demoShoutFactor * 54,
			[25202] = demoShoutFactor * 62,
			[25203] = 56
		},
		commandingShout = {
			[469] = 58
		},
		thunderclap = {
			[6343] = true,
			[8198] = true,
			[8204] = true,
			[8205] = true,
			[11580] = true,
			[11581] = true,
			[25264] = true,
		},
		execute = {
			[5308] = true,
			[20658] = true,
			[20660] = true,
			[20661] = true,
			[20662] = true,
			[25234] = true,
			[25236] = true,
		},
		disarm = {
			[676] = 104
		},
		devastate = {
			[20243] = true, 
			[30016] = true, 
			[30022] = true
		}		
	}
	
	local msbtIDs = {
		-- Mortal Strike
		12294, 21551, 21552, 21553, 25248, 30330,
		
		-- Bloodthirst
		23881, 23892, 23893, 23894, 25251, 30335
	}

	local playerLevel = UnitLevel("player")
	
	local function init(self, t, f)
		local func = function(self, spellID, target)
			self:AddTargetThreat(target, f(self, spellID))
		end
		for k, v in pairs(t) do
			self.CastLandedHandlers[k] = func
		end
	end
	
	function Warrior:ClassInit()
		-- Taunt
		self.CastLandedHandlers[355] = self.Taunt
		
		-- Non-transactional abilities		
		init(self, threatValues.heroicStrike, self.HeroicStrike)
		init(self, threatValues.shieldBash, self.ShieldBash)
		init(self, threatValues.shieldSlam, self.ShieldSlam)
		init(self, threatValues.revenge, self.Revenge)
		init(self, threatValues.mockingBlow, self.MockingBlow)
		init(self, threatValues.hamstring, self.Hamstring)
		init(self, threatValues.disarm, self.Disarm)
		init(self, threatValues.devastate, self.Devastate)

		-- Transactional stuff
		-- Sunder Armor
		local func = function(self, spellID, target)
			self:AddTargetThreatTransactional(target, spellID, self:SunderArmor(spellID))
		end
		for k, v in pairs(threatValues.sunder) do
			self.CastHandlers[k] = func
			self.MobDebuffHandlers[k] = self.GetDevastateSunder
		end
		
		-- Ability damage modifiers
		for k, v in pairs(threatValues.thunderclap) do
			self.AbilityHandlers[v] = self.Thunderclap
		end

		for k, v in pairs(threatValues.execute) do
			self.AbilityHandlers[v] = self.Execute
		end

		for _, k in ipairs(msbtIDs) do
			self.AbilityHandlers[k] = self.MSBT
		end
		msbtIDs = nil

		-- Shouts
		-- Commanding Shout		
		--[[
		for _, k in ipairs(threatValues.commandingShout) do
			self.CastHandlers[k] = function(spellID) self:AddThreat(68 * self:threatMods()) end
		end
		]]--

		-- self.CastHandlers[BS["Battle Shout"]]		= function(self, rank) self:AddThreat(self:BattleShout(rank)) end
		-- self.CastHandlers[BS["Demoralizing Shout"]]	= function(self, rank) self:AddTargetThreat(self:DemoShoutThreat(rank)) end
		-- self.CastMissHandlers[BS["Demoralizing Shout"]]	= self.DemoShoutMiss
		
		-- Set names don't need to be localized.
		self.itemSets = {
			["Might"] = { 16866, 16867, 16868, 16862, 16864, 16861, 16865, 16863 }
		}
		
		self.lastDevastateTime = 0
	end
	
	function Warrior:ClassEnable()
		self:GetStanceThreatMod()
		self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "GetStanceThreatMod" )
	end

	function Warrior:ScanTalents()
		local rank = _G.select(5, GetTalentInfo(3, 9))
		self.defianceMod = 1 + (0.05 * rank)

		-- Tactical mastery
		local rank = _G.select(5, GetTalentInfo(3, 2))
		MSBTTalentMod = 1 + (0.21 * rank)
		
		-- Improved berserker stance
		local rank = _G.select(5, GetTalentInfo(2, 20))
		zerkerStanceMod = 0.02 * rank	
		
		-- We need to watch debuffs if we're devastate, unfortunately.
		if _G.select(5, GetTalentInfo(3, 22)) > 0 then
			self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "GetDevastateSunder")
		end
	end
	
	function Warrior:GetStanceThreatMod()
		self.isTanking = false
		if GetShapeshiftForm() == 2 then
			self.passiveThreatModifiers = 1.3 * self.defianceMod
			MSBTMod = MSBTTalentMod
			self.isTanking = true
		elseif GetShapeshiftForm() == 3 then
			-- Currently assuming that the zerker change is multiplicative
			self.passiveThreatModifiers = 0.8 * (1 - zerkerStanceMod)
			-- Change to this if it tests out to additive
			-- self.passiveThreatModifiers = 0.8 - zerkerStanceMod
			MSBTMod = 1.0
		else
			self.passiveThreatModifiers = 0.8
			MSBTMod = 1.0
		end
		self.totalThreatMods = nil		-- Needed to recalc total mods
	end

	function Warrior:SunderArmor(spellID)
		local sunderMod = 1.0
		if self:getWornSetPieces("Might") >= 8 then	
			sunderMod = 1.15;
		end
		local threat = threatValues.sunder[spellID]
		return threat * sunderMod * self:threatMods()
	end

	function Warrior:Taunt(spellID, target)
		local targetThreat = ThreatLib:GetThreat(UnitGUID("targettarget"), target)
		local myThreat = ThreatLib:GetThreat(UnitGUID("player"), target)
		if targetThreat > 0 and targetThreat > myThreat then
			pendingTauntTarget = target
			pendingTauntOffset = targetThreat-myThreat
		elseif targetThreat == 0 then
			local maxThreat = ThreatLib:GetMaxThreatOnTarget(target)
			pendingTauntTarget = target
			pendingTauntOffset = maxThreat-myThreat
		end
		self.nextEventHook = self.TauntNextHook
	end

	function Warrior:TauntNextHook(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID)
		if pendingTauntTarget and (eventtype ~= 'SPELL_MISSED' or spellID ~= 355) then
			self:AddTargetThreat(pendingTauntTarget, pendingTauntOffset)
			ThreatLib:PublishThreat()
		end
		pendingTauntTarget = nil
		pendingTauntOffset = nil
	end

	function Warrior:HeroicStrike(spellID)
		return threatValues.heroicStrike[spellID] * self:threatMods()
	end

	function Warrior:ShieldBash(spellID)
		return threatValues.shieldBash[spellID] * self:threatMods()
	end

	function Warrior:ShieldSlam(spellID)
		return threatValues.shieldSlam[spellID] * self:threatMods()
	end

	function Warrior:Revenge(spellID)
		return threatValues.revenge[spellID] * self:threatMods()
	end

	function Warrior:MockingBlow(spellID)
		return threatValues.mockingBlow[spellID] * self:threatMods()
	end

	function Warrior:Hamstring(spellID)
		return threatValues.hamstring[spellID] * self:threatMods()
	end

	function Warrior:Thunderclap(amount)
		return amount * 1.75
	end
	
	function Warrior:Execute(amount)
		return amount * 1.25
	end

	function Warrior:MSBT(amt)
		return amt * MSBTMod
	end

	function Warrior:Disarm(spellID)
		return threatValues.disarm[spellID] * self:threatMods()
	end

	local devastateThreat = {119, 134, 147, 162, 176, 176}
	function Warrior:Devastate(spellID)
		local threat = devastateThreat[1]
		for i = 1, 40 do
			local name, rank, texture, count, debuffType, duration, timeLeft = UnitDebuff("target", i)
			if not name then break end
			if timeLeft and name == sunderName then
				threat = devastateThreat[count]
				break
			end
		end
		self.lastDevastateTime = GetTime()
		return threat * self:threatMods()
	end

	-- This is an incredibly ugly hack, but will hopefully tide us over until 2.4.
	function Warrior:GetDevastateSunder(spellID, target)
		if GetTime() - self.lastDevastateTime < 2 then
			self:AddTargetThreat(target, self:SunderArmor(spellID))
		end
	end
end
