local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local SOLARIAN_ID = 18805

ThreatLib:GetModule("NPCCore"):RegisterModule(SOLARIAN_ID, function(Solarian)
	Solarian:RegisterTranslation("enUS", function() return {
		["I will crush your delusions of grandeur!"] = "I will crush your delusions of grandeur!",
		["You are hopelessly outmatched!"] = "You are hopelessly outmatched!",
	} end)

	Solarian:RegisterTranslation("deDE", function() return {
		["I will crush your delusions of grandeur!"] = "Ich werde Euch Euren Hochmut austreiben!",
		["You are hopelessly outmatched!"] = "Ihr seid eindeutig in der Unterzahl!",
	} end)

	Solarian:RegisterTranslation("frFR", function() return {
		["I will crush your delusions of grandeur!"] = "Je vais balayer vos illusions de grandeur !",
		["You are hopelessly outmatched!"] = "Vous êtes désespérément surclassés !",
	} end)

	Solarian:RegisterTranslation("koKR", function() return {
		["I will crush your delusions of grandeur!"] = "그 오만한 콧대를 꺾어주마!",
		["You are hopelessly outmatched!"] = "한 줌의 희망마저 짓밟아주마!",
	} end)

	Solarian:RegisterTranslation("zhTW", function() return {
		["I will crush your delusions of grandeur!"] = "我會粉碎你那偉大的夢想!",
		["You are hopelessly outmatched!"] = "我的實力遠勝於你!",
	} end)

	Solarian:RegisterTranslation("zhCN", function() return {
		["I will crush your delusions of grandeur!"] = "我要让你们自以为是的错觉荡然无存！",
		["You are hopelessly outmatched!"] = "你们势单力薄！",
	} end)

	local zergPhase1 = Solarian:GetTranslation("I will crush your delusions of grandeur!")
	local zergPhase2 = Solarian:GetTranslation("You are hopelessly outmatched!")
	Solarian:UnregisterTranslations()

	function Solarian:Init()
		self:RegisterCombatant(SOLARIAN_ID, true)
		self:RegisterChatEvent("yell", zergPhase1, self.phaseTransition)
		self:RegisterChatEvent("yell", zergPhase2, self.phaseTransition)
	end

	function Solarian:phaseTransition()
		self:WipeAllRaidThreat()
	end
end)
