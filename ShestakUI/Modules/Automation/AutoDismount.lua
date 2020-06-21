local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.automation.dismount_stand ~= true then return end

----------------------------------------------------------------------------------------
--	ClassicAutoDismount (by EsreverWoW)
----------------------------------------------------------------------------------------
local mountedMessages = {
	[ERR_ATTACK_MOUNTED]						= true,
	[ERR_MOUNT_ALREADYMOUNTED]					= true,
	[ERR_NOT_WHILE_MOUNTED]						= true,
	[ERR_TAXIPLAYERALREADYMOUNTED]				= true,
	[SPELL_FAILED_NOT_MOUNTED]					= true,
}

local sittingMessages = {
	[ERR_CANTATTACK_NOTSTANDING]				= true,
	[ERR_LOOT_NOTSTANDING]						= true,
	[ERR_TAXINOTSTANDING]						= true,
	[SPELL_FAILED_NOT_STANDING]					= true,
}

local function CheckErrorMessage(self, event, messageType, msg)
	if mountedMessages[msg] then
		if not IsMounted() then return end
		Dismount()
		UIErrorsFrame:Clear()
	elseif sittingMessages[msg] then
		DoEmote("stand")
		UIErrorsFrame:Clear()
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("UI_ERROR_MESSAGE")
f:SetScript("OnEvent", CheckErrorMessage)
