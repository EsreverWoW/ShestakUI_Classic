local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local NIGHTBANE_ID = 17225

ThreatLib:GetModule("NPCCore"):RegisterModule(NIGHTBANE_ID, function(Nightbane)
	Nightbane:RegisterTranslation("enUS", function() return {
		["Enough! I shall land and crush you myself!"] = "Enough! I shall land and crush you myself!",
		["Insects! Let me show you my strength up close!"] = "Insects! Let me show you my strength up close!",
		["Miserable vermin. I shall exterminate you from the air!"] = "Miserable vermin. I shall exterminate you from the air!"
	} end)

	Nightbane:RegisterTranslation("deDE", function() return {
		["Enough! I shall land and crush you myself!"] = "Genug! Ich werde landen und mich h\195\182chst pers\195\182nlich um Euch k\195\188mmern!",
		["Insects! Let me show you my strength up close!"] = "Insekten! Lasst mich Euch meine Kraft aus n\195\164chster N\195\164he demonstrieren!",
		["Miserable vermin. I shall exterminate you from the air!"] = "Abscheuliches Gew\195\188rm! Ich werde euch aus der Luft vernichten!"
	} end)

	Nightbane:RegisterTranslation("frFR", function() return {
		["Enough! I shall land and crush you myself!"] = "Assez ! Je vais atterrir et vous écraser moi-même !",
		["Insects! Let me show you my strength up close!"] = "Insectes ! Je vais vous montrer de quel bois je me chauffe !",
		["Miserable vermin. I shall exterminate you from the air!"] = "Misérable vermine. Je vais vous exterminer des airs !"
	} end)

	Nightbane:RegisterTranslation("koKR", function() return {
		["Enough! I shall land and crush you myself!"] = "그만! 내 친히 내려가서 너희를 짓이겨주마!",
		["Insects! Let me show you my strength up close!"] = "하루살이 같은 놈들! 나의 힘을 똑똑히 보여주겠다!",
		["Miserable vermin. I shall exterminate you from the air!"] = "이 더러운 기생충들, 내가 하늘에서 너희의 씨를 말리리라!"
	} end)

	Nightbane:RegisterTranslation("zhTW", function() return {
		["Enough! I shall land and crush you myself!"] = "夠了!我要親自挑戰你!",
		["Insects! Let me show you my strength up close!"] = "昆蟲!給你們近距離嚐嚐我的厲害!",
		["Miserable vermin. I shall exterminate you from the air!"] = "悲慘的害蟲。我將讓你消失在空氣中!"
	} end)

	Nightbane:RegisterTranslation("zhCN", function() return {
		["Enough! I shall land and crush you myself!"] = "够了！我要落下来把你们打得粉碎！",
		["Insects! Let me show you my strength up close!"] = "没用的虫子！让你们见识一下我的力量吧！",
		["Miserable vermin. I shall exterminate you from the air!"] = "可怜的渣滓。我要腾空而起，让你尝尝毁灭的滋味！"
	} end)

	Nightbane:RegisterTranslation("ruRU", function() return {
		["Enough! I shall land and crush you myself!"] = "Довольно! Я сойду на землю и сам раздавлю тебя!",
		["Insects! Let me show you my strength up close!"] = "Ничтожества! Я вам покажу мою силу поближе!",
		["Miserable vermin. I shall exterminate you from the air!"] = "Жалкий гнус! Я изгоню тебя из воздуха!"
	} end)

	------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------
	local yell1 = Nightbane:GetTranslation("Enough! I shall land and crush you myself!")
	local yell2 = Nightbane:GetTranslation("Insects! Let me show you my strength up close!")
	local yell3 = Nightbane:GetTranslation("Miserable vermin. I shall exterminate you from the air!")

	Nightbane:UnregisterTranslations()

	function Nightbane:Init()
		self:RegisterCombatant(NIGHTBANE_ID, true)

		self:RegisterChatEvent("yell", yell1, self.endPhaseTransition)
		self:RegisterChatEvent("yell", yell2, self.endPhaseTransition)
		self:RegisterChatEvent("yell", yell3, self.endPhaseTransition)
	end

	function Nightbane:endPhaseTransition()
		self:WipeRaidThreatOnMob(NIGHTBANE_ID)
	end
end)
