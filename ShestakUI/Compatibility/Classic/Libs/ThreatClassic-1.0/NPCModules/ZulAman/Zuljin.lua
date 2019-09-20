local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local ZULJIN_ID = 23863
ThreatLib:GetModule("NPCCore"):RegisterModule(ZULJIN_ID, function(Zuljin)
	Zuljin:RegisterTranslation("enUS", function() return {
		["Got me some new tricks... like me brudda bear...."] = "Got me some new tricks... like me brudda bear....",
		["Dere be no hidin' from da eagle!"] = "Dere be no hidin' from da eagle!",
		["Let me introduce you to me new bruddas: fang and claw!"] = "Let me introduce you to me new bruddas: fang and claw!",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "Ya don' have to look to da sky to see da dragonhawk!",
	} end)

	Zuljin:RegisterTranslation("deDE", function() return {
		["Got me some new tricks... like me brudda bear...."] = "Sagt 'Hallo' zu Bruder Bär...",
		["Dere be no hidin' from da eagle!"] = "Niemand versteckt sich vor dem Adler!",
		["Let me introduce you to me new bruddas: fang and claw!"] = "Lernt meine Brüder kennen: Reißzahn und Klaue!",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "Was starrt Ihr in die Luft? Der Drachenfalke steht schon vor Euch!",
	} end)

	Zuljin:RegisterTranslation("koKR", function() return {
		["Got me some new tricks... like me brudda bear...."] = "새로운 기술을 익혔지... 내 형제, 곰처럼...",
		["Dere be no hidin' from da eagle!"] = "독수리의 눈을 피할 수는 없다!",
		["Let me introduce you to me new bruddas: fang and claw!"] = "내 새로운 형제, 송곳니와 발톱을 보아라!",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "용매를 하늘에서만 찾을 필요는 없다!",
	} end)

	Zuljin:RegisterTranslation("frFR", function() return {
		["Got me some new tricks... like me brudda bear...."] = "J'ai des nouveaux tours… comme mon frère ours…",
		["Dere be no hidin' from da eagle!"] = "L'aigle, il vous trouvera partout !",
		["Let me introduce you to me new bruddas: fang and claw!"] = "J'vous présente mes nouveaux frères : griffe et croc !",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "Pas besoin d'lever les yeux au ciel pour voir l'faucon-dragon !",
	} end)

	Zuljin:RegisterTranslation("zhTW", function() return {
		["Got me some new tricks... like me brudda bear...."] = "賜給我一些新的力量……讓我像熊一樣……",
		["Dere be no hidin' from da eagle!"] = "在雄鷹之下無所遁形!",
		["Let me introduce you to me new bruddas: fang and claw!"] = "讓我來介紹我的新兄弟:尖牙和利爪!",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "你不需要仰望天空才看得到龍鷹!",
	} end)

	Zuljin:RegisterTranslation("zhCN", function() return {
		["Got me some new tricks... like me brudda bear...."] = "你看我有许多新招，变个熊……",
		["Dere be no hidin' from da eagle!"] = "变成猎鹰，谁也别想逃出我的眼睛！",
		["Let me introduce you to me new bruddas: fang and claw!"] = "现在来让你看看我的尖牙和利爪！",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "龙鹰，不用抬头就能看见！",
	} end)

	Zuljin:RegisterTranslation("ruRU", function() return {
		["Got me some new tricks... like me brudda bear...."] = "Выучил новый фокус… прямо как братишка-медведь…",
		["Dere be no hidin' from da eagle!"] = "От орла нигде не скрыться!",
		["Let me introduce you to me new bruddas: fang and claw!"] = "Позвольте представить моих двух братцев: клык и коготь!",
		["Ya don' have to look to da sky to see da dragonhawk!"] = "Для того чтобы увидеть дракондора, в небо смотреть необязательно!",
	} end)


	local bear = Zuljin:GetTranslation("Got me some new tricks... like me brudda bear....")
	local eagle = Zuljin:GetTranslation("Dere be no hidin' from da eagle!")
	local lynx = Zuljin:GetTranslation("Let me introduce you to me new bruddas: fang and claw!")
	local dragonhawk = Zuljin:GetTranslation("Ya don' have to look to da sky to see da dragonhawk!")

	Zuljin:UnregisterTranslations()

	local function clear(self)
		self:WipeAllRaidThreat()
	end

	function Zuljin:Init()
		self:RegisterCombatant(ZULJIN_ID, true)
		self:RegisterChatEvent("yell", bear, clear)
		self:RegisterChatEvent("yell", eagle, clear)
		self:RegisterChatEvent("yell", lynx, clear)
		self:RegisterChatEvent("yell", dragonhawk, clear)
	end
end)
