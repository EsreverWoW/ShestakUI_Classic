local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local NOTH_ID = 15954
local BLINK_ID = 29211

ThreatLib:GetModule("NPCCore"):RegisterModule(NOTH_ID, function(Noth)
	function Noth:Init()
		self:RegisterCombatant(NOTH_ID, true)
		self.buffGains[BLINK_ID] = self.Wipe -- FIXME: May not work in Classic
	end

	function Noth:Wipe()
		self:WipeRaidThreatOnMob(NOTH_ID)
	end
end)
