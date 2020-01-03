if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local OURO_ID = 15517
local SAND_BLAST_ID = 26102

ThreatLib:GetModule("NPCCore"):RegisterModule(OURO_ID, function(Ouro)
	function Ouro:Init()
        self:RegisterCombatant(OURO_ID, true)
		self:RegisterSpellDamageHandler(OURO_ID, SAND_BLAST_ID, self.SandBlast)
	end

	function Ouro:SandBlast(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0, 0)
	end
end)
