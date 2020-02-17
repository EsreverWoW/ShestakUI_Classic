if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local SHAZZRAH_ID = 12264
local GATE_ID = 23138

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(SHAZZRAH_ID, function(Shazzrah)
	function Shazzrah:Init()
		self:RegisterCombatant(SHAZZRAH_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", SHAZZRAH_ID, GATE_ID, self.Gate)
	end

	function Shazzrah:Gate()
		self:WipeRaidThreatOnMob(SHAZZRAH_ID)
	end
end)
