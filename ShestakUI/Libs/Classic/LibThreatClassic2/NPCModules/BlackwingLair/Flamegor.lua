if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local FLAMEGOR_ID = 11981
local WING_BUFFET_ID = 23339

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(FLAMEGOR_ID, function(Flamegor)
	function Flamegor:Init()
        self:RegisterCombatant(FLAMEGOR_ID, true)
		self:RegisterSpellDamageHandler(FLAMEGOR_ID, WING_BUFFET_ID, self.WingBuffet)
	end

	function Flamegor:WingBuffet(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0.5, 0)
	end
end)
