local T, C, L, _ = unpack(select(2, ...))
if C.announcements.says_thanks ~= true then return end

----------------------------------------------------------------------------------------
--	Says thanks for some spells(SaySapped by Bitbyte, modified by m2jest1c)
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		if T.Classic then
			print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to EsreverWoW.|r")
		else
			print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		end
		return "Empty"
	end
end

local spells = {}
if T.Wrath then
	spells = {
		[SpellName(20484)] = true,		-- Rebirth
		[SpellName(61999)] = true,		-- Raise Ally
		[SpellName(20707)] = true,		-- Soulstone
		[SpellName(50769)] = true,		-- Revive
		[SpellName(2006)] = true,		-- Resurrection
		[SpellName(7328)] = true,		-- Redemption
		[SpellName(2008)] = true,		-- Ancestral Spirit
	}
elseif T.Vanilla or T.TBC then
	spells = {
		[SpellName(20484)] = true,		-- Rebirth
		[SpellName(20707)] = true,		-- Soulstone
		[SpellName(2006)] = true,		-- Resurrection
		[SpellName(7328)] = true,		-- Redemption
		[SpellName(2008)] = true,		-- Ancestral Spirit
	}
else
	spells = {
		[SpellName(20484)] = true,		-- Rebirth
		[SpellName(61999)] = true,		-- Raise Ally
		[SpellName(20707)] = true,		-- Soulstone
		[SpellName(50769)] = true,		-- Revive
		[SpellName(2006)] = true,		-- Resurrection
		[SpellName(7328)] = true,		-- Redemption
		[SpellName(2008)] = true,		-- Ancestral Spirit
		[SpellName(115178)] = true,		-- Resuscitate
	}
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function()
	local _, subEvent, _, _, buffer, _, _, _, player, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
	for key, value in pairs(spells) do
		if spellName == key and value == true and player == T.name and buffer ~= T.name and subEvent == "SPELL_CAST_SUCCESS" then
			SendChatMessage(L_ANNOUNCE_SS_THANKS..GetSpellLink(spellID)..", "..buffer:gsub("%-[^|]+", ""), "WHISPER", nil, buffer)
			print(GetSpellLink(spellID)..L_ANNOUNCE_SS_RECEIVED..buffer)
		end
	end
end)