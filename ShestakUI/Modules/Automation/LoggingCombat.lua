local T, C, L = unpack(ShestakUI)
if C.automation.logging_combat ~= true then return end

----------------------------------------------------------------------------------------
--	Auto enables combat log text file in raid instances(EasyLogger by Sildor)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("RAID_INSTANCE_WELCOME")
frame:SetScript("OnEvent", function()
	local _, instanceType = IsInInstance()
	local _, _, difficultyID, _, _, _, _, instanceID = GetInstanceInfo()
	if (instanceType == "raid" or (T.SoD and (difficultyID == 198 or instanceID == 48))) and IsInRaid(LE_PARTY_CATEGORY_HOME) then
		if not LoggingCombat() then
			LoggingCombat(1)
			print("|cffffff00"..COMBATLOGENABLED.."|r")
		end
	else
		if LoggingCombat() then
			LoggingCombat(0)
			print("|cffffff00"..COMBATLOGDISABLED.."|r")
		end
	end
end)
