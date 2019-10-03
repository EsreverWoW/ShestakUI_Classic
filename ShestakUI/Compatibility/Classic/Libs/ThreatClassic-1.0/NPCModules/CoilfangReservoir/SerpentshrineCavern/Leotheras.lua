local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local LEOTHERAS_ID = 21215
local WHIRLWIND_ID = 37640		-- TODO: Just a guess, need validation
ThreatLib:GetModule("NPCCore"):RegisterModule(LEOTHERAS_ID, function(Leotheras)
	Leotheras:RegisterTranslation("enUS", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "Be gone, trifling elf.  I am in control now!",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him.",
	} end)

	Leotheras:RegisterTranslation("deDE", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "Ich habe jetzt die Kontrolle!",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "Ich bin der Meister! H\195\182rt Ihr?",
	} end)

	Leotheras:RegisterTranslation("esES", function() return {
		["Be gone, trifling elf.  I am in control now!"] = nil, -- STRING NEEDED
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = nil, -- STRING NEEDED
	} end)

	Leotheras:RegisterTranslation("esMX", function() return {
		["Be gone, trifling elf.  I am in control now!"] = nil, -- STRING NEEDED
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = nil, -- STRING NEEDED
	} end)

	Leotheras:RegisterTranslation("frFR", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "Hors d'ici, elfe insignifiant. Je prends le contrôle !",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "Non… Non ! Mais qu'avez-vous fait ? C'est moi le maître ! Vous entendez ? Moi ! Je suis… Aaargh ! Impossible… de… retenir…",
	} end)

	Leotheras:RegisterTranslation("itIT", function() return {
		["Be gone, trifling elf.  I am in control now!"] = nil, -- STRING NEEDED
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = nil, -- STRING NEEDED
	} end)

	Leotheras:RegisterTranslation("koKR", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "꺼져라, 엘프 꼬맹이. 지금부터는 내가 주인이다!",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "안 돼... 안 돼! 무슨 짓이냐? 내가 주인이야! 내 말 듣지 못해? 나란 말이야! 내가... 으아악! 놈을 억누를 수... 없... 어.",
	} end)

	Leotheras:RegisterTranslation("ptBR", function() return {
		["Be gone, trifling elf.  I am in control now!"] = nil, -- STRING NEEDED
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = nil, -- STRING NEEDED
	} end)

	Leotheras:RegisterTranslation("ruRU", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "Уйди, эльфийская мелюзга. Я теперь контролирую ситуацию!",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "Нет… нет! Что ты делаешь? Я господин! Ты меня слышишь? Я… а! Не могу… его сдержать.",
	} end)

	Leotheras:RegisterTranslation("zhCN", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "滚开吧，脆弱的精灵。现在我说了算！",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "不……不！你在干什么？我才是主宰！你听到没有？我……啊啊啊啊！控制……不住了。",
	} end)

	Leotheras:RegisterTranslation("zhTW", function() return {
		["Be gone, trifling elf.  I am in control now!"] = "消失吧，微不足道的精靈。現在開始由我掌管!",
		["No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."] = "不…不!你做了什麼?我是主人!你沒聽見我在說話嗎?我…..啊!無法…控制它。",
	} end)

	local demonPhase = Leotheras:GetTranslation("Be gone, trifling elf.  I am in control now!")
	local splitPhase = Leotheras:GetTranslation("No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him.")

	Leotheras:UnregisterTranslations()

	local demonTimer
	local wwTimer
	function Leotheras:Init()
		self:RegisterCombatant(LEOTHERAS_ID, true)
		self.buffGains[WHIRLWIND_ID] = self.wwStart

		self:RegisterChatEvent("yell", demonPhase, self.demonTransition)
		self:RegisterChatEvent("yell", splitPhase, self.splitTransition)
	end

	function Leotheras:wwStart()
		if wwTimer then
			self:CancelTimer(wwTimer, true)
		end
		wwTimer = self:ScheduleTimer("humanTransition", 12)
	end

	function Leotheras:demonTransition()
		self:WipeAllRaidThreat()
		if demonTimer then
			self:CancelTimer(demonTimer, true)
		end
		if wwTimer then
			self:CancelTimer(wwTimer, true)
		end
		demonTimer = self:ScheduleTimer("humanTransition", 60)
	end

	function Leotheras:humanTransition()
		self:WipeAllRaidThreat()
	end

	function Leotheras:splitTransition()
		self:WipeAllRaidThreat()
		if demonTimer then
			self:CancelTimer(demonTimer, true)
		end
		if wwTimer then
			self:CancelTimer(wwTimer, true)
		end
	end
end)
