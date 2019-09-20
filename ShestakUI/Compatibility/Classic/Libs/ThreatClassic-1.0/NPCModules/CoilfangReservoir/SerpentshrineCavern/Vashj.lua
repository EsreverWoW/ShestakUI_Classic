local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local VASHJ_ID = 21212
local BARRIER_ID = 38112

ThreatLib:GetModule("NPCCore"):RegisterModule(VASHJ_ID, function(Vashj)
	function Vashj:Init()
		self.buffGains[BARRIER_ID] = self.Phase
		self.buffFades[BARRIER_ID] = self.Phase
		self:RegisterCombatant(VASHJ_ID, true)
	end

	function Vashj:Phase()
		self:WipeRaidThreatOnMob(VASHJ_ID)
	end
end)
