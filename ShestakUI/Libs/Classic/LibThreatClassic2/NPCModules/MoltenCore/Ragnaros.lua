if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local RAGNAROS_ID = 11502
local WRATH_ID = 20566

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(RAGNAROS_ID, function(Ragnaros)
	function Ragnaros:Init()
		self:RegisterCombatant(RAGNAROS_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", RAGNAROS_ID, WRATH_ID, self.Wrath)
	end

	function Ragnaros:Wrath()
		self:WipeRaidThreatOnMob(RAGNAROS_ID)
	end
end)
