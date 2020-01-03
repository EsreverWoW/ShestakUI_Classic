if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local EBONROC_ID = 14601
local WING_BUFFET_ID = 23339

ThreatLib:GetModule("NPCCore"):RegisterModule(EBONROC_ID, function(Ebonroc)
	function Ebonroc:Init()
        self:RegisterCombatant(EBONROC_ID, true)
		self:RegisterSpellDamageHandler(EBONROC_ID, WING_BUFFET_ID, self.WingBuffet)
	end

	function Ebonroc:WingBuffet(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0.5, 0)
	end
end)
