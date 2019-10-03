local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return en

local SUPREMUS_ID = 22898
ThreatLib:GetModule("NPCCore"):RegisterModule(SUPREMUS_ID, function(Supremus)
	Supremus:RegisterTranslation("enUS", function() return {
		["Supremus punches the ground in anger!"] = "Supremus punches the ground in anger!"
	} end)
	Supremus:RegisterTranslation("deDE", function() return {
		["Supremus punches the ground in anger!"] = "Supremus schlägt wütend auf den Boden!",
	} end)
	Supremus:RegisterTranslation("koKR", function() return {
		["Supremus punches the ground in anger!"] = "궁극의 심연이 분노하여 땅을 내리찍습니다!",
	} end)
	Supremus:RegisterTranslation("frFR", function() return {
		["Supremus punches the ground in anger!"] = "De rage, Supremus frappe le sol !"
	} end)
	Supremus:RegisterTranslation("zhTW", function() return {
		["Supremus punches the ground in anger!"] = "瑟普莫斯憤怒的捶擊地面!"
	} end)
	Supremus:RegisterTranslation("zhCN", function() return {
		["Supremus punches the ground in anger!"] = "苏普雷姆斯愤怒地击打着地面！"
	} end)
	Supremus:RegisterTranslation("ruRU", function() return {
		["Supremus punches the ground in anger!"] = "Супремус в гневе ударяет по земле!"
	} end)

	local phaseTransition = Supremus:GetTranslation("Supremus punches the ground in anger!")
	Supremus:UnregisterTranslations()

	function Supremus:Init()
		self:RegisterCombatant(SUPREMUS_ID, true)
	end

	function Supremus:OnEnable()
		ThreatLib:GetModule("NPCCore").modulePrototype.OnEnable(self)
		self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	end

	function Supremus:CHAT_MSG_RAID_BOSS_EMOTE(evt, msg)
		if msg == phaseTransition then
			self:WipeAllRaidThreat()
		end
	end
end)
