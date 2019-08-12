local T, C, L, _ = unpack(select(2, ...))
if C.announcements.interrupts ~= true then return end

----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
	if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end

	if T.classic and spellID == 0 then
		SendChatMessage(L_ANNOUNCE_INTERRUPTED.." "..destName..": "..spellName, T.CheckChat())
	else
		SendChatMessage(L_ANNOUNCE_INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), T.CheckChat())
	end
end)