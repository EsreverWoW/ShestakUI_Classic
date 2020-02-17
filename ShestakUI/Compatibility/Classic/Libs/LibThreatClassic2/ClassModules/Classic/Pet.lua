if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local _G = _G
local pairs = _G.pairs
local tonumber = _G.tonumber

local GetPetActionInfo = _G.GetPetActionInfo
local GetSpellInfo = _G.GetSpellInfo
local UnitName = _G.UnitName

local Pet = ThreatLib:GetOrCreateModule("Pet-r"..MINOR)

-- Most of this data come from KTM's pet module
local spellIDRanks = {}
local spellLookups = {}

local skillData = not ThreatLib.Classic and {} or { -- for when testing in retail
	-- Scaling skills
	-- Growl
	[GetSpellInfo(2649)] = {
		spellIDs		= {2649, 14916, 14917, 14918, 14919, 14920, 14921},
		rankLevel		= {1, 10, 20, 30, 40, 50, 60},
		rankThreat		= {50, 65, 110, 170, 240, 320, 415},
		apBaseBonus		= 1235.6,
		apLevelMalus	= 28.14,
		apFactor		= 5.7,
	},
	-- Torment
	[GetSpellInfo(3716)] = {
		spellIDs		= {3716, 7809, 7810, 7811, 11774, 11775},
		rankLevel		= {10, 20, 30, 40, 50, 60},
		rankThreat		= {45, 75, 125, 215, 300, 395},
		apBaseBonus		= 123,
		apLevelMalus	= 0,
		apFactor		= 0.385,
	},
	-- Suffering
	[GetSpellInfo(17735)] = {
		spellIDs		= {17735, 17750, 17751, 17752},
		rankLevel		= {24, 36, 48, 60},
		rankThreat		= {150, 300, 450, 600},
		apBaseBonus		= 124,
		apLevelMalus	= 0,
		apFactor		= 0.547,
	},

	-- I think that Intimidation scales, but I don't have any scaling data on it
	-- Intimidation
	[GetSpellInfo(24394)] = {
		spellIDs 	= {24394},
		rankThreat	= {580}
	},

	-- Unscaling skills
	-- Scorpid Poison
	[GetSpellInfo(24640)] = {
		spellIDs	= {24640, 24583, 24586, 24587},
		rankThreat	= {5, 5, 5, 5},
	},
	-- Cower
	[GetSpellInfo(1742)] = {
		spellIDs	= {1742, 1753, 1754, 1755, 1756, 16697},
		rankThreat	= {-30, -55, -85, -125, -175, -225},
	},
	-- Soothing Kiss
	[GetSpellInfo(6360)] = {
		spellIDs	= {6360, 7813, 11784, 11785},
		rankThreat	= {-45, -75, -127, -165}
	},
}

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
	local function castMissHandler(self, spellID, target) self:RollbackSkillThreat(spellID, target) end
	for name, data in pairs(skillData) do
		for i = 1, #data.spellIDs do
			local v = data.spellIDs[i]
			spellIDRanks[v] = i
			spellLookups[v] = name
			self.CastLandedHandlers[v] = castHandler
			self.CastMissHandlers[v] = castMissHandler
		end
	end

	for k, v in pairs(skillRanks) do
		skillRanks[k] = nil
	end
	self.skillRanks = skillRanks

	self:ScanPetSkillRanks()
	self:RegisterEvent("PET_BAR_UPDATE", "ScanPetSkillRanks")
end

function Pet:ClassDisable()
	self:UnregisterEvent("LOCALPLAYER_PET_RENAMED")
	self:UnregisterEvent("UNIT_NAME_UPDATE")
	self:UnregisterEvent("PET_BAR_UPDATE")
end

function Pet:ScanPetSkillRanks()
	for i = 1, 10 do
		local name, _, _, _, _ , _, rank = GetPetActionInfo(i)
		if skillData[name] then
			self.skillRanks[name] = rank
		end
	end
end

function Pet:GetSkillThreat(spellID, target)
	local rank = spellIDRanks[spellID]
	local skill = skillData[spellLookups[spellID]]
	local rankLevel = skill.rankLevel

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

			local baseAP, posAPBuff, negAPBuff = UnitAttackPower("pet")
			local petAP = baseAP + posAPBuff + negAPBuff
			local threshold = (petLevel * skill.apLevelMalus) - skill.apBaseBonus
			local bonus = max(0, petAP - threshold) * skill.apFactor
			local baseThreat = skill.rankThreat[rank] + bonus
			threat = threat + (max(0, petAP - (baseThreat + petLevel)) * skill.apFactor)
		end
	end

	return threat
end

function Pet:AddSkillThreat(spellID, target)
	local threat = self:GetSkillThreat(spellID, target)
	if not threat then return end

	self:AddTargetThreat(target, threat * self:threatMods())
end

function Pet:RollbackSkillThreat(spellID, target)
	local threat = self:GetSkillThreat(spellID, target)
	if not threat then return end

	self:AddTargetThreat(target, -(threat * self:threatMods()))
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
