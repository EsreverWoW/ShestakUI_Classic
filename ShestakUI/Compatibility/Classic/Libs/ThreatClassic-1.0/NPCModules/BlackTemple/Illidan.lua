local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

local ILLIDAN_ID = 22917
local FLAME_ID = 22997

ThreatLib:GetModule("NPCCore"):RegisterModule(ILLIDAN_ID, function(Illidan)
	Illidan:RegisterTranslation("enUS", function() return {
		["Behold the power... of the demon within!"] = "Behold the power... of the demon within!",
	} end)

	Illidan:RegisterTranslation("deDE", function() return {
		["Behold the power... of the demon within!"] = "Erzittert vor der Macht des Dämonen!",
	} end)

	Illidan:RegisterTranslation("esES", function() return {
		["Behold the power... of the demon within!"] = nil, -- STRNG NEEDED
	} end)

	Illidan:RegisterTranslation("esMX", function() return {
		["Behold the power... of the demon within!"] = nil, -- STRNG NEEDED
	} end)

	Illidan:RegisterTranslation("frFR", function() return {
		["Behold the power... of the demon within!"] = "Contemplez la puissance... du démon intérieur !",
	} end)

	Illidan:RegisterTranslation("itIT", function() return {
		["Behold the power... of the demon within!"] = nil, -- STRNG NEEDED
	} end)

	Illidan:RegisterTranslation("koKR", function() return {
		["Behold the power... of the demon within!"] = "내 안에 깃든... 악마의 힘을 보여주마!",
	} end)

	Illidan:RegisterTranslation("ptBR", function() return {
		["Behold the power... of the demon within!"] = nil, -- STRNG NEEDED
	} end)

	Illidan:RegisterTranslation("ruRU", function() return {
		["Behold the power... of the demon within!"] = "Узрите мощь демона!",
	} end)

	Illidan:RegisterTranslation("zhCN", function() return {
		["Behold the power... of the demon within!"] = "感受我体内的恶魔之力吧！",
	} end)

	Illidan:RegisterTranslation("zhTW", function() return {
		["Behold the power... of the demon within!"] = "感受我體內的惡魔之力吧!",
	} end)

	local demon = Illidan:GetTranslation("Behold the power... of the demon within!")
	Illidan:UnregisterTranslations()

	local phaseTimer, prisonTimer

	function Illidan:Init()
		self:RegisterCombatant(ILLIDAN_ID, true)
		self:RegisterChatEvent("yell", demon, self.PhaseDemon)
		self:RegisterSpellHandler("SPELL_CAST_SUCCESS", self.flameSpawn, 39855)
		-- self:RegisterSpellHandler("SPELL_CAST_SUCCESS", self.ShadowPrison, 40647)
		self:RegisterCombatant(FLAME_ID, self.flameDies)
	end

	-- Phase 4
	function Illidan:PhaseDemon()
		self:WipeRaidThreatOnMob(ILLIDAN_ID)
		phaseTimer = self:ScheduleTimer("PhaseNormal", 65)
	end

	-- Phase 3
	function Illidan:PhaseNormal()
		phaseTimer = nil
		self:WipeRaidThreatOnMob(ILLIDAN_ID)
	end

	-- Phase 2
	local flames = 0
	function Illidan:flameSpawn(mobGUID, targetGUID)
		self:WipeAllRaidThreat()
		flames = 2
	end

	function Illidan:flameDies()
		flames = flames - 1
		if flames == 0 then
			self:WipeAllRaidThreat()
		end
	end

	-- Phase 5
	--[[function Illidan:ShadowPrison()
		if phaseTimer then
			self:CancelTimer(phaseTimer, true)
			phaseTimer = nil
		end
		self:ScheduleTimer("WipeAllRaidThreat", 30)
	end]]
end)
