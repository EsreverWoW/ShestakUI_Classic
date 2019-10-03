local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local NEFARIAN_ID = 11583

ThreatLib:GetModule("NPCCore"):RegisterModule(NEFARIAN_ID, function(Nefarian)
	Nefarian:RegisterTranslation("enUS", function() return {
		["BURN! You wretches! BURN!"] = "BURN! You wretches! BURN!",
	} end)

	Nefarian:RegisterTranslation("deDE", function() return {
		["BURN! You wretches! BURN!"] = "BRENNT! Ihr Elenden! BRENNT!",
	} end)

	Nefarian:RegisterTranslation("esES", function() return {
		["BURN! You wretches! BURN!"] = nil, -- STRING NEEDED
	} end)

	Nefarian:RegisterTranslation("esMX", function() return {
		["BURN! You wretches! BURN!"] = nil, -- STRING NEEDED
	} end)

	Nefarian:RegisterTranslation("frFR", function() return {
		["BURN! You wretches! BURN!"] = nil, -- STRING NEEDED
	} end)

	Nefarian:RegisterTranslation("itIT", function() return {
		["BURN! You wretches! BURN!"] = nil, -- STRING NEEDED
	} end)

	Nefarian:RegisterTranslation("koKR", function() return {
		["BURN! You wretches! BURN!"] = "불타라! 활활! 불타라!",
	} end)

	Nefarian:RegisterTranslation("ptBR", function() return {
		["BURN! You wretches! BURN!"] = nil, -- STRING NEEDED
	} end)

	Nefarian:RegisterTranslation("ruRU", function() return {
		["BURN! You wretches! BURN!"] = nil, -- STRING NEEDED
	} end)

	Nefarian:RegisterTranslation("zhCN", function() return {
		["BURN! You wretches! BURN!"] = "燃烧吧！你这个",
	} end)

	Nefarian:RegisterTranslation("zhTW", function() return {
		["BURN! You wretches! BURN!"] = "燃燒吧！你這個不幸的人！燃燒吧！",
	} end)

	local phaseTwo = Nefarian:GetTranslation("BURN! You wretches! BURN!")
	Nefarian:UnregisterTranslations()

	function Nefarian:Init()
		self:RegisterCombatant(NEFARIAN_ID, true)
		self:RegisterChatEvent("yell", phaseTwo, self.phaseTwo)
	end

	function Nefarian:phaseTwo()
		self:WipeRaidThreatOnMob(NEFARIAN_ID)
	end
end)
