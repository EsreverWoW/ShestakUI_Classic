local T, C, L, _ = unpack(select(2, ...))
if C.announcements.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local spells = {
	[20484] = true,		-- Rebirth
	[61999] = true,		-- Raise Ally
	[20707] = true,		-- Soulstone
	[50769] = true,		-- Revive
	[2006] = true,		-- Resurrection
	[7328] = true,		-- Redemption
	[2008] = true,		-- Ancestral Spirit
	[115178] = true,	-- Resuscitate
}

-- temporary
local classicLookup = T.classic and {
	[GetSpellInfo(20484)] = 20484,		-- Rebirth
	[GetSpellInfo(20707)] = 20707,		-- Soulstone
	[GetSpellInfo(2006)] = 2006,		-- Resurrection
	[GetSpellInfo(7328)] = 7328,		-- Redemption
	[GetSpellInfo(2008)] = 2008,		-- Ancestral Spirit
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function()
	local _, subEvent, _, _, buffer, _, _, _, player, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
	if T.classic and spellID == 0 then
		spellID = classicLookup[spellName]
	end
	for key, value in pairs(spells) do
		if spellID == key and value == true and player == T.name and buffer ~= T.name and subEvent == "SPELL_CAST_SUCCESS" then
			SendChatMessage(L_ANNOUNCE_SS_THANKS..GetSpellLink(spellID)..", "..buffer:gsub("%-[^|]+", ""), "WHISPER", nil, buffer)
			print(GetSpellLink(spellID)..L_ANNOUNCE_SS_RECEIVED..buffer)
		end
	end
end)