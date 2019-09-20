local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 7 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end


local pairs = _G.pairs
local GetSpellInfo = _G.GetSpellInfo
local GetTime = _G.GetTime
local ERR_FEIGN_DEATH_RESISTED = _G.ERR_FEIGN_DEATH_RESISTED

if select(2, UnitClass("player")) ~= "HUNTER" then return end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local _G = _G
	local tonumber = _G.tonumber
	local getmetatable = _G.getmetatable
	local ThreatLib = _G.ThreatLib

	local Hunter = ThreatLib:GetOrCreateModule("Player")

	local threatTable = {
		["DistractingShot"] = {
			[20736] = 110,
			[14274] = 160,
			[15629] = 250,
			[15630] = 350,
			[15631] = 465,
			[15632] = 600,
			[27020] = 900,
		},
		["Disengage"] = {
			[781] = -140,
			[14272] = -280,
			[14273] = -405,
			[27015] = -545
		}
	}
	
	local FDString
	function Hunter:ClassInit()
		for k, v in pairs(threatTable["DistractingShot"]) do
			self.CastLandedHandlers[k] = self.DistractingShot
		end
		for k, v in pairs(threatTable["Disengage"]) do
			self.CastLandedHandlers[k] = self.Disengage
		end
		
		FDString = GetSpellInfo(5384)
		self.CastHandlers[5384] = self.FeignDeath

		self.CastLandedHandlers[34477] = self.MisdirectionCast
		self.BuffHandlers[34477] = self.MisdirectionBuff
		-- self.CastHandlers[34477] = self.MisdirectionBuff
	end

	function Hunter:ClassEnable()
		-- Needed for FD. Ugly as hell, but it works.
		self:RegisterEvent("UNIT_SPELLCAST_SENT")
		self:RegisterEvent("UI_ERROR_MESSAGE")
		-- ERR_FEIGN_DEATH_RESISTED
	end

	function Hunter:DistractingShot(spellID, target)
		local amt = threatTable["DistractingShot"][spellID]
		self:AddTargetThreat(target, amt * self:threatMods())
	end

	function Hunter:Disengage(spellID, target)
		ThreatLib:Debug("Disengage caught, %s", spellID)
		local amt = threatTable["Disengage"][spellID]
		self:AddTargetThreat(target, amt * self:threatMods())
	end
	
	function Hunter:MisdirectionCast(spellID, recipient)
		self.redirectingThreat = true
		self.redirectTarget = recipient
	end
	
	function Hunter:MisdirectionBuff(action, rank, apps)
		if action == "lose" then
			self.redirectingThreat = false
			self.redirectTarget = nil
		end
	end
	
	-- Feign is a rather unique case. It's cast on all targets, but may be resisted by any one target. There is no combat log message - only an error event with ERR_FEIGN_DEATH_RESISTED from GlobalStrings
	-- ERR_FEIGN_DEATH_RESISTED always happens before SPELLCAST_SUCCESSFUL, so we "prime" FD when we get SENT, then invalidate it if we get a resist, let it through otherwise.
	-- The net effect is that a resist on any one target invalidates the threat reset on all targets, but we can't help that since we don't have target data on who resisted
	local FeignDeathPrimed = 0
	function Hunter:FeignDeath()
		if GetTime() - FeignDeathPrimed < 5 then
			FeignDeathPrimed = 0
			self:MultiplyThreat(0)
			ThreatLib:Debug("Running FD, clearing threat!")
		end	
	end

	function Hunter:UNIT_SPELLCAST_SENT(evt, arg1, arg2, arg3, arg4)
		ThreatLib:Debug("Hunter:UNIT_SPELLCAST_SENT: %s, %s, %s, %s", arg1, arg2, arg3, arg4)
		if arg1 == "player" and arg2 == FDString then
			ThreatLib:Debug("FD is primed!")
			FeignDeathPrimed = GetTime()
		end
	end

	function Hunter:UI_ERROR_MESSAGE(evt, arg1)
		if arg1 == ERR_FEIGN_DEATH_RESISTED then
			ThreatLib:Debug("Canceling FD!")
			FeignDeathPrimed = 0
		end
	end
end
