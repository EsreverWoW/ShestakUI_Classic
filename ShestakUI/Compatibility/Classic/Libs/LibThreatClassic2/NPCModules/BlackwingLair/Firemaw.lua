if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local FIREMAW_ID = 11983
local WING_BUFFET_ID = 23339

ThreatLib:GetModule("NPCCore"):RegisterModule(FIREMAW_ID, function(Firemaw)
	function Firemaw:Init()
        self:RegisterCombatant(FIREMAW_ID, true)
		self:RegisterSpellDamageHandler(FIREMAW_ID, WING_BUFFET_ID, self.WingBuffet)
	end

	function Firemaw:WingBuffet(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0.5, 0)
	end
end)
