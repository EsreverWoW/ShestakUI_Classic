local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Kill all stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	if C.unitframe.enable and (SavedOptions and (SavedOptions.RaidLayout == "HEAL" or SavedOptions.RaidLayout == "DPS")) then
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
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

	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	HelpOpenTicketButtonTutorial:Kill()
	BagHelpBox:Kill()
	if not T.classic then
		TutorialFrameAlertButton:Kill()
		TalentMicroButtonAlert:Kill()
		CollectionsMicroButtonAlert:Kill()
		ReagentBankHelpBox:Kill()
		EJMicroButtonAlert:Kill()
		PremadeGroupsPvETutorialAlert:Kill()
	end
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_WORLD_MAP_FRAME, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_PET_JOURNAL, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_GARRISON_BUILDING, true)

	SetCVar("countdownForCooldowns", 0)
	InterfaceOptionsActionBarsPanelCountdownCooldowns:Kill()

	if not T.classic then
		SetCVar("fstack_preferParentKeys", 0)
	end

	if C.chat.enable then
		SetCVar("chatStyle", "im")
	end

	if C.unitframe.enable then
		if T.class == "DEATHKNIGHT" and C.unitframe_class_bar.rune ~= true then
			RuneFrame:Kill()
		end
		InterfaceOptionsCombatPanelTargetOfTarget:Kill()
		SetCVar("showPartyBackground", 0)
	end

	if C.actionbar.enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
		InterfaceOptionsActionBarsPanelStackRightBars:Kill()
	end

	if C.nameplate.enable then
		SetCVar("ShowClassColorInNameplate", 1)
	end

	if C.minimap.enable then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end

	if C.bag.enable then
		if not T.classic then
			SetSortBagsRightToLeft(true)
		end
		SetInsertItemsLeftToRight(false)
	end
end)
