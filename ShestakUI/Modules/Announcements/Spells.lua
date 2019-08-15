local T, C, L, _ = unpack(select(2, ...))
if C.announcements.spells ~= true then return end

----------------------------------------------------------------------------------------
--	Announce some spells
----------------------------------------------------------------------------------------
-- temporary
local classicLookup = T.classic and {
	[GetSpellInfo(20484)] = 20484,		-- Rebirth
	[GetSpellInfo(20707)] = 20707,		-- Soulstone
	[GetSpellInfo(633)] = 633,			-- Lay on Hands
	[GetSpellInfo(19801)] = 19801,		-- Tranquilizing Shot
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self)
	local _, event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
	if T.classic and spellID == 0 then
		spellID = classicLookup[spellName]
	end
	local spells = T.AnnounceSpells
	local _, _, difficultyID = GetInstanceInfo()
	if difficultyID == 0 or event ~= "SPELL_CAST_SUCCESS" then return end

	if sourceName then sourceName = sourceName:gsub("%-[^|]+", "") end
	if destName then destName = destName:gsub("%-[^|]+", "") end
	if C.announcements.spells_from_all == true and not (sourceGUID == UnitGUID("player") and sourceName == T.name) then
		if not sourceName then return end

		for _, spells in pairs(spells) do
			if spellID == spells then
				if destName == nil then
					SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), T.CheckChat())
				else
					SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID).." -> "..destName), T.CheckChat())
				end
			end
		end
	else
		if not (sourceGUID == UnitGUID("player") and sourceName == T.name) then return end

		for _, spells in pairs(spells) do
			if spellID == spells then
				if destName == nil then
					SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), T.CheckChat())
				else
					SendChatMessage(GetSpellLink(spellID).." -> "..destName, T.CheckChat())
				end
			end
		end
	end
end)