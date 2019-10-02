local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local AZUREGOS_ID = 6109

ThreatLib:GetModule("NPCCore"):RegisterModule(AZUREGOS_ID, function(Azuregos)
	Azuregos:RegisterTranslation("enUS", function() return {
		["Come, little ones. Face me!"] = "Come, little ones. Face me!",
	} end)

	Azuregos:RegisterTranslation("deDE", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("esES", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("esMX", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("frFR", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("itIT", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("koKR", function() return {
		["Come, little ones. Face me!"] = "오너라, 조무래기들아! 덤벼봐라!",
	} end)

	Azuregos:RegisterTranslation("ptBR", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("ruRU", function() return {
		["Come, little ones. Face me!"] = nil, -- STRING NEEDED
	} end)

	Azuregos:RegisterTranslation("zhCN", function() return {
		["Come, little ones. Face me!"] = "来吧，小子。面对我！",
	} end)

	Azuregos:RegisterTranslation("zhTW", function() return {
		["Come, little ones. Face me!"] = "來吧，小子。面對我!",
	} end)

	local teleport = Azuregos:GetTranslation("Come, little ones. Face me!")
	Azuregos:UnregisterTranslations()

	function Azuregos:Init()
		self:RegisterCombatant(AZUREGOS_ID, true)
		self:RegisterChatEvent("yell", teleport, self:WipeAllRaidThreat())
	end
end)
