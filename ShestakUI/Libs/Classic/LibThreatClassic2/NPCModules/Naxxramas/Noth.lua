if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

local NOTH_ID = 15954
local BLINK_ID = 29211

ThreatLib:GetModule("NPCCore-r"..MINOR):RegisterModule(NOTH_ID, function(Noth)
	function Noth:Init()
		self:RegisterCombatant(NOTH_ID, true)
		self:RegisterBuffGainsHandler(NOTH_ID, BLINK_ID, self.Blink)
	end

	function Noth:Blink()
		self:WipeRaidThreatOnMob(NOTH_ID)
	end
end)
