if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local BROODLORD_LASHLAYER_ID = 12017
local KNOCK_AWAY_ID = 18670

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(BROODLORD_LASHLAYER_ID, function(BroodlordLashlayer)
	function BroodlordLashlayer:Init()
        self:RegisterCombatant(BROODLORD_LASHLAYER_ID, true)
		self:RegisterSpellDamageHandler(BROODLORD_LASHLAYER_ID, KNOCK_AWAY_ID, self.KnockAway)
	end

	function BroodlordLashlayer:KnockAway(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0.5, 0)
	end
end)
