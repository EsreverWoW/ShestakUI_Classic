if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local KEL_THUZAD_ID = 15990
local CHAINS_ID = 28410

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(KEL_THUZAD_ID, function(KelThuzad)
	function KelThuzad:Init()
		self:RegisterCombatant(KEL_THUZAD_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", KEL_THUZAD_ID, CHAINS_ID, self.Chains)
	end

	function KelThuzad:Chains()
		self:WipeRaidThreatOnMob(KEL_THUZAD_ID)
	end
end)
