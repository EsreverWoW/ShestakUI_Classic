local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local ThreatLib = _G.ThreatLib
local VERAS_ID = 22952

ThreatLib:GetModule("NPCCore"):RegisterModule(VERAS_ID, function(Council)
	function Council:Init()
		self:RegisterCombatant(VERAS_ID, true)

		-- Notes on Veras Darkshadow vanish
		-- He casts spell 41476, gains buff 41476, but loses buff 41479 about 30+ seconds later.
		-- Losing 41479 is not consistent, and sometimes is not reported in the combat log.
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", self.Vanish, 41476)
	end

	function Council:Vanish(srcGUID, dstGUID, spellId)
		self:ScheduleTimer("WipeRaidThreatOnMob", 30, srcGUID)
	end
end)
