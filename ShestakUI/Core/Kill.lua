local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			if T.Classic then
				hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
			end
		end
	end

	if ClassPowerBar then
		ClassPowerBar.OnEvent = T.dummy -- Fix error with druid on logon
	end

	if C.unitframe.enable and C.raidframe.layout ~= "BLIZZARD" then
		if T.Classic then
			InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
		end
		if not InCombatLockdown() then
			if C.raidframe.show_raid or not IsAddOnLoaded("Grid2") then -- may need to add more addons here
				CompactRaidFrameManager:Kill()
				CompactRaidFrameContainer:Kill()
			end
		end
		ShowPartyFrame = T.dummy
		HidePartyFrame = T.dummy
		CompactUnitFrameProfiles_ApplyProfile = T.dummy
		CompactRaidFrameManager_UpdateShown = T.dummy
		CompactRaidFrameManager_UpdateOptionsFlowContainer = T.dummy
	end

	if T.Classic then
		Advanced_UseUIScale:Kill()
		Advanced_UIScaleSlider:Kill()
		BagHelpBox:Kill()
	else
		--BETA Display_UseUIScale:Kill()
		-- Display_UIScaleSlider:Kill()
		TutorialFrameAlertButton:Kill()
	end
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_WORLD_MAP_FRAME, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_PET_JOURNAL, true)
	if T.Mainline then
		SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_GARRISON_BUILDING, true)
	end

	SetCVar("countdownForCooldowns", 0)
	if T.Classic then
		InterfaceOptionsActionBarsPanelCountdownCooldowns:Hide()
	end

	if C.chat.enable then
		if T.Classic then
			InterfaceOptionsSocialPanelChatStyle:Hide()
		end
		SetCVar("chatStyle", "im")
	end

	if C.unitframe.enable then
		if T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune ~= true then
			RuneFrame:Kill()
		end
		if T.Classic then
			InterfaceOptionsDisplayPanelDisplayDropDown:Hide()
			InterfaceOptionsCombatPanelTargetOfTarget:Hide()
		end
		SetCVar("showPartyBackground", 0)
	end

	if C.actionbar.enable then
		if T.Classic then
			InterfaceOptionsActionBarsPanelBottomLeft:Hide()
			InterfaceOptionsActionBarsPanelBottomRight:Hide()
			InterfaceOptionsActionBarsPanelRight:Hide()
			InterfaceOptionsActionBarsPanelRightTwo:Hide()
			InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Hide()
			InterfaceOptionsActionBarsPanelStackRightBars:Hide()
			if not InCombatLockdown() then
				SetCVar("multiBarRightVerticalLayout", 0)
			end
		end
	end

	if C.nameplate.enable then
		SetCVar("ShowClassColorInNameplate", 1)
	end

	if C.minimap.enable then
		if T.Classic then
			InterfaceOptionsDisplayPanelRotateMinimap:Hide()
		end
	end

	if C.bag.enable then
		if T.Classic then
			SetInsertItemsLeftToRight(false)
		elseif not T.newPatch then -- BETA
			SetSortBagsRightToLeft(true)
			SetInsertItemsLeftToRight(false)
		end
	end

	if C.combattext.enable then
		if T.Classic then
			InterfaceOptionsCombatPanelEnableFloatingCombatText:Hide()
		end
		if C.combattext.incoming then
			SetCVar("enableFloatingCombatText", 1)
		else
			SetCVar("enableFloatingCombatText", 0)
		end
	end

	if T.Mainline then
		SetCVar('ActionButtonUseKeyDown', 0) -- BETA
	end
end)

if T.Mainline then
	local function AcknowledgeTips()
		if InCombatLockdown() then return end

		for frame in _G.HelpTip.framePool:EnumerateActive() do
			frame:Acknowledge()
		end
	end

	AcknowledgeTips()
	hooksecurefunc(_G.HelpTip, "Show", AcknowledgeTips)
end