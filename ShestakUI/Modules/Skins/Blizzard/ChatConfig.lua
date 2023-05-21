local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ChatConfig skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ChatConfigFrame:StripTextures()
	ChatConfigFrame:SetTemplate("Transparent")

	local ChatConfigFrameHeader = T.Classic and ChatConfigFrameHeader or ChatConfigFrame.Header
	ChatConfigFrameHeader:StripTextures()
	ChatConfigFrameHeader:ClearAllPoints()
	ChatConfigFrameHeader:SetPoint("TOP", ChatConfigFrame, 0, 7)

	local frames = {
		"ChatConfigCategoryFrame",
		"ChatConfigBackgroundFrame",
		"ChatConfigChatSettingsClassColorLegend",
		"ChatConfigChatSettingsLeft",
		"ChatConfigChannelSettingsAvailable",
		"ChatConfigChannelSettingsLeft",
		"ChatConfigChannelSettingsClassColorLegend",
		"ChatConfigOtherSettingsCombat",
		"ChatConfigOtherSettingsSystem",
		"ChatConfigOtherSettingsCreature",
		"ChatConfigOtherSettingsPVP",
		"ChatConfigCombatSettingsFilters",
		"CombatConfigMessageSourcesDoneBy",
		"CombatConfigMessageSourcesDoneTo",
		"CombatConfigColorsUnitColors",
		"CombatConfigColorsHighlighting",
		"ChatConfigTextToSpeechChannelSettingsLeft"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:StripTextures()
			frame:SetTemplate("Overlay")
		end
	end

	local colorize = {
		"CombatConfigColorsColorizeUnitName",
		"CombatConfigColorsColorizeSpellNames",
		"CombatConfigColorsColorizeDamageNumber",
		"CombatConfigColorsColorizeDamageSchool",
		"CombatConfigColorsColorizeEntireLine"
	}

	for i = 1, getn(colorize) do
		local frame = _G[colorize[i]]
		if frame then
			local bg = CreateFrame("Frame", nil, frame)
			bg:SetPoint("TOPLEFT", 0, 0)
			bg:SetPoint("BOTTOMRIGHT", 0, 2)
			bg:SetTemplate("Overlay")
		end
	end

	local buttons = {
		"ChatConfigFrameDefaultButton",
		"ChatConfigFrameOkayButton",
		"ChatConfigFrameCancelButton",
		"ChatConfigFrameRedockButton",
		"ChatConfigCombatSettingsFiltersCopyFilterButton",
		"ChatConfigCombatSettingsFiltersAddFilterButton",
		"ChatConfigCombatSettingsFiltersDeleteButton",
		"CombatConfigSettingsSaveButton",
		"CombatLogDefaultButton"
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton()
			button:ClearAllPoints()
		end
	end

	if T.Classic then
		ChatConfigFrame.ToggleChatButton:SkinButton()
	end

	local checkboxes = {
		"CombatConfigColorsHighlightingLine",
		"CombatConfigColorsHighlightingAbility",
		"CombatConfigColorsHighlightingDamage",
		"CombatConfigColorsHighlightingSchool",
		"CombatConfigColorsColorizeUnitNameCheck",
		"CombatConfigColorsColorizeSpellNamesCheck",
		"CombatConfigColorsColorizeSpellNamesSchoolColoring",
		"CombatConfigColorsColorizeDamageNumberCheck",
		"CombatConfigColorsColorizeDamageNumberSchoolColoring",
		"CombatConfigColorsColorizeDamageSchoolCheck",
		"CombatConfigColorsColorizeEntireLineCheck",
		"CombatConfigFormattingShowTimeStamp",
		"CombatConfigFormattingShowBraces",
		"CombatConfigFormattingUnitNames",
		"CombatConfigFormattingSpellNames",
		"CombatConfigFormattingItemNames",
		"CombatConfigFormattingFullText",
		"CombatConfigSettingsShowQuickButton",
		"CombatConfigSettingsSolo",
		"CombatConfigSettingsParty",
		"CombatConfigSettingsRaid",
		"CombatConfigColorsColorizeEntireLineBySource",
		"CombatConfigColorsColorizeEntireLineByTarget"
	}

	for i = 1, getn(checkboxes) do
		local checkbox = _G[checkboxes[i]]
		if checkbox then
			T.SkinCheckBox(checkbox)
		end
	end

	local ReskinColourSwatch = function(f)
		if f.InnerBorder then
			f.InnerBorder:SetAlpha(0)
			f.SwatchBg:SetAlpha(0)
		end

		f:CreateBackdrop("Overlay")
		f:SetFrameLevel(f:GetFrameLevel() + 2)
		f.backdrop:SetOutside(f.Color, 2, 2)

		local function ReskinCombatColourSwatch(f)
			local SwatchBg = _G[f:GetName().."SwatchBg"]
			if SwatchBg then
				SwatchBg:SetAlpha(0)
			end

			f:CreateBackdrop("Overlay")
			f:SetFrameLevel(f:GetFrameLevel() + 2)
			f.backdrop:SetInside(f, 1, 1)
		end

		hooksecurefunc("ChatConfig_UpdateCheckboxes", function(frame)
			if not FCF_GetCurrentChatFrame() then return end

			if frame == ChatConfigTextToSpeechChannelSettingsLeft then -- init after
				local nameString = frame:GetName().."CheckBox"
				for index in ipairs(frame.checkBoxTable) do
					local checkBoxName = nameString..index
					local checkbox = _G[checkBoxName]
					if checkbox and not checkbox.IsSkinned then
						checkbox:StripTextures()

						local bg = CreateFrame("Frame", nil, checkbox)
						bg:SetPoint("TOPLEFT", 2, -1)
						bg:SetPoint("BOTTOMRIGHT", -2, 1)
						bg:SetTemplate("Overlay")

						T.SkinCheckBox(_G[checkBoxName.."Check"])
						checkbox.IsSkinned = true
					end
				end
			end
		end)
	end

	hooksecurefunc("ChatConfig_CreateCheckboxes", function(frame, checkBoxTable, checkBoxTemplate)
		if frame.styled then return end

		local checkBoxNameString = frame:GetName().."CheckBox"

		if checkBoxTemplate == "ChatConfigCheckBoxTemplate" then
			for index in ipairs(checkBoxTable) do
				local checkBoxName = checkBoxNameString..index
				local checkbox = _G[checkBoxName]

				checkbox:StripTextures()
				local bg = CreateFrame("Frame", nil, checkbox)
				bg:SetPoint("TOPLEFT", 2, -1)
				bg:SetPoint("BOTTOMRIGHT", -2, 1)
				bg:SetTemplate("Overlay")

				T.SkinCheckBox(_G[checkBoxName.."Check"])
			end
		elseif checkBoxTemplate == "ChatConfigCheckBoxWithSwatchTemplate" or checkBoxTemplate == "ChatConfigWideCheckBoxWithSwatchTemplate" or checkBoxTemplate == "MovableChatConfigWideCheckBoxWithSwatchTemplate" then
			for index in ipairs(checkBoxTable) do
				local checkBoxName = checkBoxNameString..index
				local checkbox = _G[checkBoxName]

				checkbox:StripTextures()
				local bg = CreateFrame("Frame", nil, checkbox)
				bg:SetPoint("TOPLEFT", 2, -1)
				bg:SetPoint("BOTTOMRIGHT", -2, 1)
				bg:CreateBackdrop("Overlay")
				bg.backdrop:SetAllPoints(bg)

				ReskinColourSwatch(_G[checkBoxName.."ColorSwatch"])

				T.SkinCheckBox(_G[checkBoxName.."Check"])
			end
		end

		frame.styled = true
	end)

	hooksecurefunc("ChatConfig_CreateTieredCheckboxes", function(frame, checkBoxTable)
		if frame.IsSkinned then return end

		local nameString = frame:GetName().."CheckBox"
		for index, value in ipairs(checkBoxTable) do
			local checkBoxName = nameString..index
			T.SkinCheckBox(_G[checkBoxName])

			if value.subTypes then
				for i in ipairs(value.subTypes) do
					T.SkinCheckBox(_G[checkBoxName.."_"..i])
				end
			end
		end

		frame.IsSkinned = true
	end)

	hooksecurefunc("ChatConfig_CreateColorSwatches", function(frame, swatchTable) -- combat log only (in Mainline)
		if frame.styled then return end

		local nameString = frame:GetName().."Swatch"

		for index in ipairs(swatchTable) do
			local swatchName = nameString..index
			local swatch = _G[swatchName]

			swatch:StripTextures()

			local bg = CreateFrame("Frame", nil, swatch)
			bg:SetPoint("TOPLEFT", 0, 0)
			bg:SetPoint("BOTTOMRIGHT", 0, 0)
			bg:SetFrameLevel(swatch:GetFrameLevel() - 1)
			bg:CreateBorder(true)
			bg.iborder:SetBackdropBorderColor(unpack(C.media.border_color))

			local bg2 = CreateFrame("Frame", nil, bg)
			bg2:SetPoint("TOPLEFT", 1, -1)
			bg2:SetPoint("BOTTOMRIGHT", -1, 1)
			bg2:CreateBorder(true, true)

			if T.Classic then
				ReskinColourSwatch(_G[swatchName.."ColorSwatch"])
			else
				ReskinCombatColourSwatch(_G[swatchName.."ColorSwatch"])
			end
		end

		frame.styled = true
	end)

	ChatConfigBackgroundFrame:SetScript("OnShow", function()
		ReskinColourSwatch(CombatConfigColorsColorizeSpellNamesColorSwatch)
		ReskinColourSwatch(CombatConfigColorsColorizeDamageNumberColorSwatch)

		for i = 1, (T.Vanilla or T.TBC) and 5 or 4 do
			for j = 1, MAX_WOW_CHAT_CHANNELS or 20 do
				if _G["CombatConfigMessageTypesLeftCheckBox"..i] and _G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j])
				end
				if _G["CombatConfigMessageTypesRightCheckBox"..i] and _G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j])
				end
			end
			T.SkinCheckBox(_G["CombatConfigMessageTypesMiscCheckBox"..i])
		end
	end)

	for i = 1, #COMBAT_CONFIG_TABS do
		local tab = _G["CombatConfigTab"..i]
		if tab then
			tab:StripTextures()
			T.SkinTab(tab, true)
			tab:SetHeight(tab:GetHeight() - 3)
			tab:ClearAllPoints()
			if i == 1 then
				tab:SetPoint("BOTTOMLEFT", _G["ChatConfigBackgroundFrame"], "TOPLEFT", -2, 1)
			else
				tab:SetPoint("LEFT", _G["CombatConfigTab"..i-1], "RIGHT", 1, 0)
			end
			local text = tab.Text
			if text then
				text:SetWidth(text:GetWidth() + 10)
			end
		end
		if T.Mainline then
			T.SkinScrollBar(ChatConfigCombatSettingsFilters.ScrollBar)
		end
	end

	T.SkinEditBox(_G["CombatConfigSettingsNameEditBox"], nil, _G["CombatConfigSettingsNameEditBox"]:GetHeight() - 2)
	T.SkinNextPrevButton(_G["ChatConfigMoveFilterUpButton"], nil, "Up")
	T.SkinNextPrevButton(_G["ChatConfigMoveFilterDownButton"], nil, "Down")
	_G["ChatConfigFrameDefaultButton"]:SetWidth(125)
	_G["CombatLogDefaultButton"]:SetWidth(125)

	_G["ChatConfigMoveFilterUpButton"]:SetPoint("TOPLEFT", _G["ChatConfigCombatSettingsFilters"], "BOTTOMLEFT", 0, -1)
	_G["ChatConfigMoveFilterDownButton"]:SetPoint("TOPLEFT", _G["ChatConfigMoveFilterUpButton"], "TOPRIGHT", 1, 0)
	_G["ChatConfigFrameDefaultButton"]:SetPoint("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
	ChatConfigFrameRedockButton:SetPoint("LEFT", ChatConfigFrameDefaultButton, "RIGHT", 3, 0)
	if T.Classic then
		ChatConfigFrame.ToggleChatButton:SetPoint("LEFT", ChatConfigFrameRedockButton, "RIGHT", 3, 0)
	end
	_G["ChatConfigFrameOkayButton"]:SetPoint("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
	_G["CombatLogDefaultButton"]:SetPoint("TOPLEFT", _G["ChatConfigCategoryFrame"], "BOTTOMLEFT", 0, -4)
	_G["CombatConfigSettingsSaveButton"]:SetPoint("TOPLEFT", _G["CombatConfigSettingsNameEditBox"], "TOPRIGHT", 5, 2)
	_G["ChatConfigCombatSettingsFiltersDeleteButton"]:SetPoint("TOPRIGHT", _G["ChatConfigCombatSettingsFilters"], "BOTTOMRIGHT", 0, -1)
	_G["ChatConfigCombatSettingsFiltersCopyFilterButton"]:SetPoint("RIGHT", _G["ChatConfigCombatSettingsFiltersDeleteButton"], "LEFT", -3, 0)
	_G["ChatConfigCombatSettingsFiltersAddFilterButton"]:SetPoint("RIGHT", _G["ChatConfigCombatSettingsFiltersCopyFilterButton"], "LEFT", -3, 0)

	T.SkinCheckBox(TextToSpeechCharacterSpecificButton, 25)

	hooksecurefunc(ChatConfigFrameChatTabManager, "UpdateWidth", function(self)
		for tab in self.tabPool:EnumerateActive() do
			if not tab.IsSkinned then
				tab:StripTextures()

				tab.IsSkinned = true
			end
		end
	end)

	-- TextToSpeech
	if T.Mainline then
		local checkBoxes = {
			TextToSpeechFramePanelContainer.PlaySoundSeparatingChatLinesCheckButton,
			TextToSpeechFramePanelContainer.AddCharacterNameToSpeechCheckButton,
			TextToSpeechFramePanelContainer.PlayActivitySoundWhenNotFocusedCheckButton,
			TextToSpeechFramePanelContainer.NarrateMyMessagesCheckButton,
			TextToSpeechFramePanelContainer.UseAlternateVoiceForSystemMessagesCheckButton
		}

		for i = 1, #checkBoxes do
			T.SkinCheckBox(checkBoxes[i])
		end

		TextToSpeechDefaultButton:SkinButton()
		TextToSpeechFramePlaySampleButton:SkinButton()
		TextToSpeechFramePlaySampleAlternateButton:SkinButton()

		T.SkinDropDownBox(TextToSpeechFrameTtsVoiceDropdown)
		T.SkinDropDownBox(TextToSpeechFrameTtsVoiceAlternateDropdown)

		T.SkinSlider(TextToSpeechFrameAdjustRateSlider)
		T.SkinSlider(TextToSpeechFrameAdjustVolumeSlider)

		hooksecurefunc("TextToSpeechFrame_UpdateMessageCheckboxes", function(frame)
			local checkBoxTable = frame.checkBoxTable
			if checkBoxTable then
				local checkBoxNameString = frame:GetName().."CheckBox"
				local checkBoxName, checkBox
				for index in ipairs(checkBoxTable) do
					checkBoxName = checkBoxNameString..index
					checkBox = _G[checkBoxName]
					if checkBox and not checkBox.styled then
						T.SkinCheckBox(checkBox)
						checkBox.styled = true
					end
				end
			end
		end)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
