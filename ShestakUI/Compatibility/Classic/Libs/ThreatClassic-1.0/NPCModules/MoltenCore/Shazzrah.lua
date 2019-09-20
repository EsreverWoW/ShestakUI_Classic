local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local SHAZZRAH_ID = 12264
local GATE_ID = 23138

ThreatLib:GetModule("NPCCore"):RegisterModule(SHAZZRAH_ID, function(Shazzrah)
	function Shazzrah:Init()
		self:RegisterCombatant(SHAZZRAH_ID, true)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", self.Gate, GATE_ID)
	end

	function Shazzrah:Gate()
		self:WipeRaidThreatOnMob(SHAZZRAH_ID)
	end
end)
