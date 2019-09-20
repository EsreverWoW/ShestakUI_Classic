local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

if select(2, _G.UnitClass("player")) ~= "DRUID" then return end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local _G = _G
	local type = _G.type
	local pairs = _G.pairs
	local ipairs = _G.ipairs
	local select = _G.select
	local tonumber = _G.tonumber
	local GetTalentInfo = _G.GetTalentInfo
	local GetShapeshiftForm = _G.GetShapeshiftForm
	local ThreatLib = _G.ThreatLib

	local Druid = ThreatLib:GetOrCreateModule("Player")

	--[[
	-- We don't need these because heals have a school assigned now!
	local HealIDs = {
		-- Healing Touch
		5185, 5186, 5187, 5188, 5189, 6778, 8903, 9758, 9888, 9889, 25297, 26978, 26979,
		
		-- Regrowth
		8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 26980,
		
		-- Rejuvenation
		774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 26981, 26982,
		
		-- Lifebloom
		33763,
		
		-- Swiftmend
		18562
	}
	]]--

	local faerieFireFactor = 127 / 66
	local maulFactor = 322 / 67
	local threatValues = {
		["faerieFire"] = { 
			-- Rank 1, normal and feral
			[770] = faerieFireFactor * 18,			-- Just a guess, need to validate
			[16857] = faerieFireFactor * 30,		-- Just a guess, need to validate
			
			[778] = faerieFireFactor * 30,			-- Just a guess, need to validate
			[17390] = faerieFireFactor * 30,		-- Just a guess, need to validate
			
			[9749] = faerieFireFactor * 42,			-- Just a guess, need to validate
			[17391] = faerieFireFactor * 42,		-- Just a guess, need to validate
			
			[9907] = 108,
			[17392] = 108,
			
			[26993] = 127,
			[27011] = 127
		}, 
		["maul"] = { 
			[6807] = maulFactor * 10,		-- Just a guess
			[6808] = maulFactor * 18,		-- Just a guess
			[6809] = maulFactor * 26,		-- Just a guess
			[8972] = maulFactor * 34,		-- Just a guess
			[9745] = maulFactor * 42,		-- Just a guess
			[9880] = maulFactor * 50,		-- Just a guess
			[9881] = 207,
			[26996] = 322
		}, 
		["lacerate"] = {
			[33745] = 285
		},
		["mangle"] = {
			[33878] = 1.3,
			[33986] = 1.3, 
			[33987] = 1.3
		},
		["cower"] = { 
			[8998] = 240, 
			[9000] = 390,
			[9892] = 600,
			[31709] = 800,
			[27004] = 1170
		},
		mangleModifier = 1.3
	}

	local SCHOOL_MASK_NATURE = _G.SCHOOL_MASK_NATURE or 0x08
	local SCHOOL_MASK_ARCANE = _G.SCHOOL_MASK_ARCANE or 0x40
	
	local itemSets = {
		["Thunderheart"] = { 31042, 31034, 31039, 31044, 31048 }
	}
	local tranquilityIDs = {740, 8918, 9862, 9863, 26983}

	function Druid:ClassInit()

		-- Growl
		self.CastLandedHandlers[6795] = self.Growl
		
		-- Cyclone
		self.CastLandedHandlers[33786] = self.Cyclone
		
		for k, v in pairs(threatValues.faerieFire) do
			self.CastLandedHandlers[k] = self.FaerieFire
		end
		for k, v in pairs(threatValues.maul) do
			self.CastLandedHandlers[k] = self.Maul
		end
		for k, v in pairs(threatValues.cower) do
			self.CastLandedHandlers[k] = self.Cower
		end
		for k, v in pairs(threatValues.lacerate) do
			self.CastLandedHandlers[k] = self.Lacerate
			self.AbilityHandlers[k] = self.LacerateDmg
		end
		
		-- Subtlety for all Arcane or Nature Damage, as well as heals.
		self.schoolThreatMods[SCHOOL_MASK_NATURE] = self.Subtlety
		self.schoolThreatMods[SCHOOL_MASK_ARCANE] = self.Subtlety
		
		for i = 1, #tranquilityIDs do
			self.AbilityHandlers[tranquilityIDs[i]] = self.Tranquility
		end
		tranquilityIDs = nil
		
		for k, v in pairs(threatValues.mangle) do
			self.AbilityHandlers[k] = self.Mangle
		end

		self.AbilityHandlers[33763] = self.LifebloomHOT
		
		self.itemSets = itemSets
	end
	
	function Druid:ClassEnable()
		self:GetStanceThreatMod()
		self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "GetStanceThreatMod")
	end

	function Druid:ScanTalents()
		self.feralinstinctMod = 0.05 * select(5, GetTalentInfo(2, 3))
		self.subtletyMod = 1 - 0.04 * select(5, GetTalentInfo(3, 7))
		self.tranqMod = 1 - 0.5 * select(5, GetTalentInfo(3, 13))
	end

	-- get form passive threat modifier
	-- this function has one issue, if the druid skipped his Aquatic Quest, cat form will have index 2 not 3 - maybe change detection
	function Druid:GetStanceThreatMod()
		local form = GetShapeshiftForm()
		self.isTanking = false
		if form == 1 then
			self.passiveThreatModifiers = 1.3 + self.feralinstinctMod
			self.isTanking = true
		elseif form == 3 then
			self.passiveThreatModifiers = 0.71
		else
			self.passiveThreatModifiers = 1
		end
		self.totalThreatMods = nil		-- Needed to recalc total mods
	end

	local pendingTauntTarget = nil
	local pendingTauntOffset = nil
	function Druid:Growl(spellID, target)
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
		self.nextEventHook = self.GrowlNextHook
	end

	function Druid:GrowlNextHook(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID)
		if pendingTauntTarget and (eventtype ~= 'SPELL_MISSED' or spellID ~= 6795) then
			self:AddTargetThreat(pendingTauntTarget, pendingTauntOffset)
			ThreatLib:PublishThreat()
		end
		pendingTauntTarget = nil
		pendingTauntOffset = nil
	end

	function Druid:FaerieFire(spellID, target)
		self:AddTargetThreat(target, threatValues.faerieFire[spellID] * self:threatMods())
	end

	function Druid:Maul(spellID, target)
		self:AddTargetThreat(target, threatValues.maul[spellID] * self:threatMods())
	end

	function Druid:Lacerate(spellID, target)
		self:AddTargetThreat(target, threatValues.lacerate[spellID] * self:threatMods())
	end

	function Druid:Cower(spellID, target)
		self:AddTargetThreat(target, threatValues.cower[spellID] * self:threatMods() * -1)
	end

	function Druid:Subtlety(amount)
		return amount * self.subtletyMod
	end

	function Druid:Tranquility(amount)
		return amount * self.tranqMod
	end

	function Druid:LacerateDmg(amount)
		return amount * 0.2
	end

	function Druid:Mangle(amount)
		local mangleMod = 1
		if self:getWornSetPieces("Thunderheart") >= 2 then	
			mangleMod = 1.15
		end
		
		return amount * threatValues.mangleModifier * mangleMod
	end

	function Druid:Cyclone(spellID, target)
		self:AddTargetThreat(target, 180 * self:threatMods())
	end

	function Druid:LifebloomHOT(amount)
		-- Lifebloom healing gets only half as much threat as other heals
		return amount * 0.5
	end
end
