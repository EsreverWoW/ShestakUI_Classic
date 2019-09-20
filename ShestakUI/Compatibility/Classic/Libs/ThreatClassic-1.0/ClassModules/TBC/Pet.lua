local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then
	_G.ThreatLib_MINOR_VERSION = MINOR_VERSION
end

-- Temp, re-enable when rest of stuff is working

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local _G = _G
	local tonumber = _G.tonumber
	local pairs = _G.pairs

	local UnitName = _G.UnitName
	local UnitAffectingCombat = _G.UnitAffectingCombat
	local GetPetActionInfo = _G.GetPetActionInfo

	local ThreatLib = _G.ThreatLib

	local new, del, newHash, newSet = ThreatLib.new, ThreatLib.del, ThreatLib.newHash, ThreatLib.newSet
	local Pet = ThreatLib:GetOrCreateModule("Pet")

	-- Most of this data come from KTM's pet module
	local spellIDRanks = {}
	local spellLookups = {}

	local skillData = {
		-- Scaling skills
		["Growl"] = {
			spellIDs	 = {2649, 14916, 14917, 14918, 14919, 14920, 14921, 27047},
			rankLevel    = { 1, 10, 20, 30, 40, 50, 60, 70},
			rankThreat   = {50, 65, 110, 170, 240, 320, 415, 664},
			apBaseBonus  = 1235.6,
			apLevelMalus = 28.14,
			apFactor     = 5.7,
		},	
		["Anguish"] = {
			spellIDs	 = {33698, 33699, 33700},
			rankLevel    = { 50,  60,  69},
			rankThreat   = {300, 395, 632},
			apBaseBonus  = 109,
			apLevelMalus = 0,
			apFactor     = 0.698,
		},
		["Torment"] = {
			spellIDs	 = {3716, 7809, 7810, 7811, 11774, 11775, 27270},
			rankLevel    = {10, 20,  30,  40,  50,  60,  70},
			rankThreat   = {45, 75, 125, 215, 300, 395, 632},
			apBaseBonus  = 123,
			apLevelMalus = 0,
			apFactor     = 0.385,
		},
		["Suffering"] = {
			spellIDs	 = {17735, 17750, 17751, 17752, 27271, 33701},
			rankLevel    = { 24,  36,  48,  60,  63,  69},
			rankThreat   = {150, 300, 450, 600, 645, 885},
			apBaseBonus  = 124,
			apLevelMalus = 0,
			apFactor     = 0.547,	
		},
		
		-- I think that Intimidation scales, but I don't have any scaling data on it
		["Intimidation"] = {
			spellIDs 	= {24394},
			rankThreat	= {580}
		},
		
		-- Unscaling skills
		["Cower"] = {
			spellIDs 	= {1742, 1753, 1754, 1755, 1756, 16697, 27048},
			rankThreat 	= {-30, -55,  -85, -125, -175, -225, -360},	
		},
		["Cleave"] = {
			spellIDs 	= {30213, 30219, 30223},
			rankThreat 	= {95, 114, 130},
		},
		["Soothing Kiss"] = {
			spellIDs 	= {6360, 7813, 11784, 11785, 27275},
			rankThreat = {-45, -75, -127, -165, -275}
		},
	}

	local petAPThreshold = 0

	local skillRanks = {}

	function Pet:ClassEnable()
		self:RegisterEvent("LOCALPLAYER_PET_RENAMED")
		self:RegisterEvent("UNIT_NAME_UPDATE")
		
		-- CastHandlers
		self.unitName = UnitName("pet")		
		self.unitType = "pet"
		local playerClass = select(2, UnitClass("player"))
		self.petScaling = (playerClass == "HUNTER") or (playerClass == "WARLOCK")
		
		local function castHandler(self, spellID, target) self:AddSkillThreat(spellID, target) end
		for name, data in pairs(skillData) do
			for i = 1, #data.spellIDs do
				local v = data.spellIDs[i]
				spellIDRanks[v] = i
				spellLookups[v] = name
				self.CastLandedHandlers[v] = castHandler
			end
		end
		
		for k, v in pairs(skillRanks) do
			skillRanks[k] = nil
		end
		self.skillRanks = skillRanks
		
		self:ScanPetSkillRanks()
		self:RegisterEvent("PET_BAR_UPDATE", "ScanPetSkillRanks")
	end

	function Pet:ScanPetSkillRanks()
		for i = 1,10 do
			local name, rank = GetPetActionInfo(i)
			if skillData[name] then
				self.skillRanks[name] = rank
			end
		end
	end

	function Pet:AddSkillThreat(spellID, target)
		local rank = spellIDRanks[spellID]
		local skill = skillData[spellLookups[spellID]]
		local rankLevel = skill.rankLevel
		local rankThreat = skill.rankThreat

		local threat = skill.rankThreat[rank]
		
		if self.petScaling and skill.apFactor then	
			-- This could be optimized pretty heavily
			local petLevel = UnitLevel("pet")
			if skill.apFactor and petLevel then
				for i = 1, #rankLevel do
					if rankLevel[#rankLevel - i + 1] <= petLevel then
						rank = #rankLevel - i + 1
						break
					end
				end
				
				local baseAP, posAPBuff, negAPBuff = UnitAttackPower("pet");	
				local petAP = baseAP + posAPBuff + negAPBuff;
				local threshold = (petLevel * skill.apLevelMalus) - skill.apBaseBonus
				local bonus = max(0, petAP - threshold) * skill.apFactor
				local baseThreat = skill.rankThreat[rank] + bonus
				threat = threat + (max(0, petAP - (baseThreat + petLevel)) * skill.apFactor)
			end
		end
		
		if not threat then return end
		self:AddTargetThreat(target, threat * self:threatMods())	
	end

	function Pet:LOCALPLAYER_PET_RENAMED()
		self.guid = nil
		self.unitName = UnitName("pet")
	end

	function Pet:UNIT_NAME_UPDATE(arg1)
		if arg1 == "pet" then	
			self.guid = nil
			self.unitName = UnitName("pet")
			self:CheckDespawned()
		end
	end
end
