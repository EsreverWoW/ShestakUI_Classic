local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local BLACKHEART_ID = 18667
ThreatLib:GetModule("NPCCore"):RegisterModule(BLACKHEART_ID, function(Blackheart)
	Blackheart:RegisterTranslation("enUS", function() return {
		["Time for fun!"] = "Time for fun!",
	} end)

	Blackheart:RegisterTranslation("deDE", function() return {
		["Time for fun!"] = "Zeit für Spass!",
	} end)

	Blackheart:RegisterTranslation("frFR", function() return {
		["Time for fun!"] = "Rions un peu !",
	} end)

	Blackheart:RegisterTranslation("koKR", function() return {
		["Time for fun!"] = "재미를 볼 시간이다!",
	} end)

	Blackheart:RegisterTranslation("zhTW", function() return {
		["Time for fun!"] = "玩樂的時間到了!",
	} end)

	Blackheart:RegisterTranslation("zhCN", function() return {
		["Time for fun!"] = "有好玩的啦！",
	} end)

	local blackheartPhase = Blackheart:GetTranslation("Time for fun!")
	Blackheart:UnregisterTranslations()

	function Blackheart:Init()
		self:RegisterCombatant(BLACKHEART_ID, true)
		self:RegisterChatEvent("yell", blackheartPhase, self.phaseTransition)
	end

	function Blackheart:phaseTransition()
		self:WipeRaidThreatOnMob(BLACKHEART_ID)
	end
	-- Note, War Stomp spellID 33707 is in the ThreatNPCModuleCore already
end)
