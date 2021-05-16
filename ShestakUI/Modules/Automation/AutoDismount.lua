local T, C, L, _ = unpack(select(2, ...))
if C.automation.dismount_stand ~= true then return end

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

local shapeshiftMessages = {
	[ERR_CANT_INTERACT_SHAPESHIFTED]			= true,
	[ERR_MOUNT_SHAPESHIFTED]					= true,
	[ERR_NOT_WHILE_SHAPESHIFTED]				= true,
	[ERR_NO_ITEMS_WHILE_SHAPESHIFTED]			= true,
	[ERR_SHAPESHIFT_FORM_CANNOT_EQUIP]			= true,
	[ERR_TAXIPLAYERSHAPESHIFTED]				= true,
	[SPELL_FAILED_NOT_SHAPESHIFT]				= true,
	[SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED]	= true,
	[SPELL_NOT_SHAPESHIFTED]					= true,
	[SPELL_NOT_SHAPESHIFTED_NOSPACE]			= true,
}

local shapeshiftSpells = {
	[GetSpellInfo(5487)]		= true, -- Bear Form
	[GetSpellInfo(9634)]		= true, -- Dire Bear Form
	[GetSpellInfo(768)]		= true, -- Cat Form
	[GetSpellInfo(783)]		= true, -- Travel Form
	[GetSpellInfo(1066)]		= true, -- Aquatic Form
	[GetSpellInfo(24858)]		= true, -- Moonkin Form
	[GetSpellInfo(2645)]		= true, -- Ghost Wolf
}

local function CheckErrorMessage(_, _, _, msg)
	if mountedMessages[msg] and IsMounted() then
		Dismount()
		UIErrorsFrame:Clear()
	elseif sittingMessages[msg] then
		DoEmote("stand")
		UIErrorsFrame:Clear()
	elseif shapeshiftMessages[msg] then
		for k, _ in pairs(shapeshiftSpells) do
			if not InCombatLockdown() then
				CancelSpellByName(k)
			end
		end
		UIErrorsFrame:Clear()
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("UI_ERROR_MESSAGE")
f:SetScript("OnEvent", CheckErrorMessage)
