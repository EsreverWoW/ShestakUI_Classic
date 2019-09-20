local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local DOOMWALKER_NPC_ID = 17711
ThreatLib:GetModule("NPCCore"):RegisterModule(DOOMWALKER_NPC_ID, function(Doomwalker)

	function Doomwalker:Init()
		self:RegisterCombatant(DOOMWALKER_NPC_ID, true)
		self:RegisterSpellHandler("SPELL_DAMAGE", self.Overrun, 32636, 32637)
	end

	function Doomwalker:Overrun()
		self:WipeRaidThreatOnMob(DOOMWALKER_NPC_ID)
	end
end)
