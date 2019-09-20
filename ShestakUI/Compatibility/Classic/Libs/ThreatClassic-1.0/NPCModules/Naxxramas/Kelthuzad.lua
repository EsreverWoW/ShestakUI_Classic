local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local KEL_THUZAD_ID = 15990
local CHAINS_ID = 28410

ThreatLib:GetModule("NPCCore"):RegisterModule(KEL_THUZAD_ID, function(KelThuzad)
	function KelThuzad:Init()
		self:RegisterCombatant(KEL_THUZAD_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", self.Chains, CHAINS_ID)
	end

	function KelThuzad:Chains()
		self:WipeRaidThreatOnMob(KEL_THUZAD_ID)
	end
end)
