local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

if select(2, _G.UnitClass("player")) ~= "MAGE" then return end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local _G = _G
	local select = _G.select
	local floor = _G.floor
	local max = _G.max
	local GetTalentInfo = _G.GetTalentInfo
	local GetTime = _G.GetTime

	local ThreatLib = _G.ThreatLib
	local Mage = ThreatLib:GetOrCreateModule("Player")
	
	local timers = {}
	
	local SCHOOL_MASK_FIRE = _G.SCHOOL_MASK_FIRE or 0x04;
	local SCHOOL_MASK_FROST = _G.SCHOOL_MASK_FROST or 0x10;
	local SCHOOL_MASK_ARCANE = _G.SCHOOL_MASK_ARCANE or 0x40;
	
	--[[
		["mage"] = 
		{
			["arcanist"] = false, 		-- 8 piece bonus
			["netherwind"] = false, 	-- 3 piece
			["arcanethreat"] = 0.0,		-- almost a modifier to global threat (spells only) e.g. "-0.4" for 2/2 talent points.
			["frostthreat"] = 0.0, 		-- almost a modifier to global threat (spells only) e.g. "-0.3" for 3/3 talent points.
			["firethreat"] = 0.0, 		-- almost a modifier to global threat (spells only) e.g. "-0.3" for 2/2 talent points.
		},
	]]--

	local frostChanneling = { 0, 0.04, 0.07, 0.10 }
	local NWBonusIDs = {
		-- Scorch
		2948, 8444, 8445, 8446, 10205, 10206, 10207, 27073, 27074,
		
		-- Fireball
		133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692,
		
		-- Frostbolt
		116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697,
	}
	local NWBonus20IDs = {
		-- Arcane Missiles
		5143, 5144, 5145, 8416, 8417, 10211, 10212, 25345, 27075, 38699, 38704,
	}

	function Mage:ClassInit()	
		-- self.BuffHandlers[32612] = self.Invisibility
		self.BuffHandlers[66] = self.Invisibility
		self.BuffHandlers[32612] = function(self, action)
			if action == "gain" then
				if timers.InvisAggroModifier then
					self:CancelTimer(timers.InvisAggroModifier)
					timers.InvisAggroModifier = nil
				end
				self:MultiplyThreat(0)
			end
		end

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

		self.itemSets = {
			["Arcanist"] 	= {16795, 16796, 16797, 16800, 16802, 16799, 16798, 16801},
			["Netherwind"]	= {16914, 16915, 16917, 16912, 16818, 16918, 16916, 16913}
		}	
	end

	function Mage:ClassEnable()
		self.passiveThreatModifiers = 1
	end

	function Mage:ScanTalents()
		self.arcaneThreatMod = 1 - (select(5, GetTalentInfo(1,1)) * 0.2)
		self.frostThreatMod = 1 - frostChanneling[select(5, GetTalentInfo(3,12)) + 1]
		self.fireThreatMod = 1 - (select(5, GetTalentInfo(2,9)) * 0.05)
	end

	function Mage:ItemSetMods()
		local mod = 1
		if self:getWornSetPieces("Arcanist") >= 8 then
			mod = mod * 0.85
		end
		return mod
	end

	local invisModifiers = {90/100, 80/90, 70/80, 60/70}
	function Mage:InvisUpdate()
		self.invisTickCount = self.invisTickCount + 1
		if self.invisTickCount > 4 then
			if timers.InvisAggroModifier then
				self:CancelTimer(timers.InvisAggroModifier)
				timers.InvisAggroModifier = nil
			end
			return
		end	
		self:MultiplyThreat(invisModifiers[self.invisTickCount])
	end

	function Mage:Invisibility(action, spellID)
		if action == "gain" then
			self.invisTickCount = 0
			timers.InvisAggroModifier = self:ScheduleRepeatingTimer("InvisUpdate", 1)
		elseif action == "lose" then
			if timers.InvisAggroModifier then
				self:CancelTimer(timers.InvisAggroModifier)
				timers.InvisAggroModifier = nil
			end
		end
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
end
