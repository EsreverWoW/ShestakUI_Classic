if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local HAKKAR_ID = 14834
local ASPECT_OF_ARLOKK_ID = 24690

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(HAKKAR_ID, function(Hakkar)
	function Hakkar:Init()
        self:RegisterCombatant(HAKKAR_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", HAKKAR_ID, ASPECT_OF_ARLOKK_ID, self.AspectOfArlokk)
	end

    function Hakkar:AspectOfArlokk(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0, 0)
	end
end)
