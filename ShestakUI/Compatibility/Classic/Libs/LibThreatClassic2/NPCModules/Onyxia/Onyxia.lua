if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
local ThreatLib = LibStub and LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local ONYXIA_ID = 10184
local FIREBALL_ID = 18392
local KNOCK_AWAY_ID = 19633

ThreatLib:GetModule("NPCCore"):RegisterModule(ONYXIA_ID, function(Onyxia)
	function Onyxia:Init()
        self:RegisterCombatant(ONYXIA_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", ONYXIA_ID, FIREBALL_ID, self.Fireball)
		self:RegisterSpellDamageHandler(ONYXIA_ID, KNOCK_AWAY_ID, self.KnockAway)
	end

    function Onyxia:Fireball(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0, 0)
	end

	function Onyxia:KnockAway(sourceGUID, unitId)
        self:ModifyThreat(sourceGUID, unitId, 0.75, 0)
	end
end)
