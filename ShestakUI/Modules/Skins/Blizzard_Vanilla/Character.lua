local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Character skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local magicResTextureCords = {
		{0.21875, 0.78125, 0.25, 0.3203125},		-- Arcane
		{0.21875, 0.78125, 0.0234375, 0.09375},		-- Fire
		{0.21875, 0.78125, 0.13671875, 0.20703125},	-- Nature
		{0.21875, 0.78125, 0.36328125, 0.43359375},	-- Frost
		{0.21875, 0.78125, 0.4765625, 0.546875}		-- Shadow
	}

	CharacterFrame:StripTextures(true)
	CharacterFrame:CreateBackdrop("Transparent")
	CharacterFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	CharacterFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(CharacterFrameCloseButton, CharacterFrame.backdrop)

	CharacterNameText:ClearAllPoints()
	CharacterNameText:SetPoint("TOP", CharacterFrame.backdrop, "TOP", 0, -6)

	CharacterFrameTab1:ClearAllPoints()
	CharacterFrameTab1:SetPoint("TOPLEFT", CharacterFrame.backdrop, "BOTTOMLEFT", 2, -2)

	for i = 1, #CHARACTERFRAME_SUBFRAMES do
		local tab = _G["CharacterFrameTab"..i]
		T.SkinTab(tab)
	end

	-- Character Frame
	PaperDollFrame:StripTextures()
	CharacterAttributesFrame:StripTextures()
	CharacterResistanceFrame:StripTextures()

	CharacterModelFrame:SetPoint("TOPLEFT", 66, -74)

	T.SkinRotateButton(CharacterModelFrameRotateLeftButton)
	CharacterModelFrameRotateLeftButton:SetPoint("TOPLEFT", 2, -2)

	T.SkinRotateButton(CharacterModelFrameRotateRightButton)
	CharacterModelFrameRotateRightButton:SetPoint("TOPLEFT", CharacterModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

	local function HandleResistanceFrame(frameName)
		for i, coords in pairs(magicResTextureCords) do
			local frame = _G[frameName..i]

			frame:SetSize(24, 24)
			frame:SetTemplate("Default")

			if i ~= 1 then
				frame:ClearAllPoints()
				frame:SetPoint("TOP", _G[frameName..i-1], "BOTTOM", 0, -3)
			end

			select(1, _G[frameName..i]:GetRegions()):SetInside()
			select(1, _G[frameName..i]:GetRegions()):SetDrawLayer("ARTWORK")
			select(2, _G[frameName..i]:GetRegions()):SetDrawLayer("OVERLAY")
			select(1, _G[frameName..i]:GetRegions()):SetTexCoord(coords[1], coords[2], coords[3], coords[4])
		end
	end

	HandleResistanceFrame("MagicResFrame")

	if not T.Vanilla then
		T.SkinDropDownBox(PlayerStatFrameLeftDropDown, 140)
		T.SkinDropDownBox(PlayerStatFrameRightDropDown, 140)
		PlayerStatFrameLeftDropDownButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
		PlayerStatFrameLeftDropDownButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
		PlayerStatFrameLeftDropDownButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")

		T.SkinDropDownBox(PlayerTitleDropDown, 200)
		PlayerTitleDropDown:SetPoint("TOP", -7, -51)
	end

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot",
		"RangedSlot",
		"AmmoSlot"
	}

	for _, slot in pairs(slots) do
		local icon = _G["Character"..slot.."IconTexture"]
		-- local cooldown = _G["Character"..slot.."Cooldown"]

		slot = _G["Character"..slot]
		slot:StripTextures()
		slot:StyleButton(false)
		slot:SetTemplate("Default", true, true)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetInside()

		slot:SetFrameLevel(PaperDollFrame:GetFrameLevel() + 2)

		-- if(cooldown and C.unitframe.enable) then
			-- T.CreateAuraWatch(cooldown)
		-- end
	end

	local function ColorItemBorder()
		for _, slot in pairs(slots) do
			local target = _G["Character"..slot]
			local slotId = GetInventorySlotInfo(slot)
			local itemId = GetInventoryItemTexture("player", slotId)

			if itemId then
				local rarity = GetInventoryItemQuality("player", slotId)
				if rarity and rarity > 1 then
					local R, G, B = GetItemQualityColor(rarity)
					target:SetBackdropBorderColor(R, G, B)
				else
					target:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			else
				target:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end

	local CheckItemBorderColor = CreateFrame("Frame")
	CheckItemBorderColor:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player", "")
	CheckItemBorderColor:SetScript("OnEvent", ColorItemBorder)
	CharacterFrame:HookScript("OnShow", ColorItemBorder)
	ColorItemBorder()

	-- Pet Frame
	PetNameText:ClearAllPoints()
	PetNameText:SetPoint("TOP", CharacterFrame.backdrop, "TOP", 0, -4)

	PetPaperDollFrame:StripTextures()

	for i = 1, 3 do
		local tab = _G["PetPaperDollFrameTab"..i]
		if tab then
			T.SkinTab(tab, true)
		end
	end
	
	PetPaperDollCloseButton:StripTextures()
	PetPaperDollCloseButton:SkinButton()

	T.SkinRotateButton(PetModelFrameRotateLeftButton)
	PetModelFrameRotateLeftButton:ClearAllPoints()
	PetModelFrameRotateLeftButton:SetPoint("TOPLEFT", 3, -3)

	T.SkinRotateButton(PetModelFrameRotateRightButton)
	PetModelFrameRotateRightButton:ClearAllPoints()
	PetModelFrameRotateRightButton:SetPoint("TOPLEFT", PetModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

	PetAttributesFrame:StripTextures()

	HandleResistanceFrame("PetMagicResFrame")

	PetPaperDollFrameExpBar:StripTextures()
	PetPaperDollFrameExpBar:CreateBackdrop("Default")
	PetPaperDollFrameExpBar:SetStatusBarTexture(C.media.blank)

	local function updHappiness(self)
		local happiness = GetPetHappiness()
		local _, isHunterPet = HasPetUI()
		if not happiness or not isHunterPet then return end

		local texture = self:GetRegions()
		if happiness == 1 then
			texture:SetTexCoord(0.41, 0.53, 0.06, 0.30)
		elseif happiness == 2 then
			texture:SetTexCoord(0.22, 0.345, 0.06, 0.30)
		elseif happiness == 3 then
			texture:SetTexCoord(0.04, 0.15, 0.06, 0.30)
		end
	end

	PetPaperDollPetInfo:CreateBackdrop("Default")
	PetPaperDollPetInfo:SetPoint("TOPLEFT", PetModelFrameRotateLeftButton, "BOTTOMLEFT", 9, -3)
	PetPaperDollPetInfo:GetRegions():SetTexCoord(0.04, 0.15, 0.06, 0.30)
	PetPaperDollPetInfo:SetFrameLevel(PetModelFrame:GetFrameLevel() + 2)
	PetPaperDollPetInfo:SetSize(24, 24)

	updHappiness(PetPaperDollPetInfo)
	PetPaperDollPetInfo:RegisterUnitEvent("UNIT_HAPPINESS", "pet", "")
	PetPaperDollPetInfo:SetScript("OnEvent", updHappiness)
	PetPaperDollPetInfo:SetScript("OnShow", updHappiness)

	-- Companion / Mount Frame
	if T.Wrath then
		PetPaperDollFrameCompanionFrame:StripTextures()

		CompanionSummonButton:SkinButton()

		T.SkinNextPrevButton(CompanionPrevPageButton)
		T.SkinNextPrevButton(CompanionNextPageButton)

		CompanionNextPageButton:ClearAllPoints()
		CompanionNextPageButton:SetPoint("TOPLEFT", CompanionPrevPageButton, "TOPRIGHT", 100, 0)

		T.SkinRotateButton(CompanionModelFrameRotateLeftButton)
		CompanionModelFrameRotateLeftButton:ClearAllPoints()
		CompanionModelFrameRotateLeftButton:SetPoint("TOPLEFT", 3, -3)
		T.SkinRotateButton(CompanionModelFrameRotateRightButton)
		CompanionModelFrameRotateRightButton:ClearAllPoints()
		CompanionModelFrameRotateRightButton:SetPoint("TOPLEFT", CompanionModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

		CompanionPageNumber:ClearAllPoints()
		CompanionPageNumber:SetPoint("BOTTOM", -5, 90)

		hooksecurefunc("PetPaperDollFrame_UpdateCompanions", function()
			for i = 1, NUM_COMPANIONS_PER_PAGE do
				local button = _G["CompanionButton"..i]

				if button.creatureID then
					local iconNormal = button:GetNormalTexture()
					iconNormal:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					iconNormal:SetInside()
				end
			end
		end)

		for i = 1, NUM_COMPANIONS_PER_PAGE do
			local button = _G["CompanionButton"..i]
			local iconDisabled = button:GetDisabledTexture()
			local activeTexture = _G["CompanionButton"..i.."ActiveTexture"]

			button:SkinButton()
			button:SetTemplate()
			button:SetCheckedTexture("")

			iconDisabled:SetAlpha(0)

			activeTexture:SetInside(button)
			activeTexture:SetTexture(1, 1, 1, .15)
			activeTexture:SetAlpha(.2)

			if i == 7 then
				button:SetPoint("TOP", CompanionButton1, "BOTTOM", 0, -5)
			elseif i ~= 1 then
				button:SetPoint("LEFT", _G["CompanionButton"..i-1], "RIGHT", 5, 0)
			end
		end
	end

	-- Reputation Frame
	ReputationFrame:StripTextures()

	for i = 1, NUM_FACTIONS_DISPLAYED do
		if T.Wrath then
			local factionRow = _G["ReputationBar"..i]
			local factionBar = _G["ReputationBar"..i.."ReputationBar"]
			local factionButton = _G["ReputationBar"..i.."ExpandOrCollapseButton"]

			factionRow:StripTextures()

			factionBar:StripTextures()
			factionBar:SetStatusBarTexture(C.media.blank)
			factionBar:CreateBackdrop("Default")

			factionButton:SetSize(14, 14)
			factionButton:SetHighlightTexture(0)
			factionButton:SetNormalTexture(0)
			factionButton.SetNormalTexture = T.dummy

			if i == 1 then
				factionRow:SetPoint("TOPLEFT", 20, -86)
			end
		else
			local bar = _G["ReputationBar"..i]
			local header = _G["ReputationHeader"..i]
			local name = _G["ReputationBar"..i.."FactionName"]
			local war = _G["ReputationBar"..i.."AtWarCheck"]

			bar:StripTextures()
			bar:CreateBackdrop("Default")
			bar:SetStatusBarTexture(C.media.blank)
			bar:SetSize(108, 13)

			if i == 1 then
				bar:SetPoint("TOPLEFT", 190, -86)
			end

			name:SetWidth(140)
			name:SetPoint("LEFT", bar, "LEFT", -150, 0)
			name.SetWidth = T.dummy

			header:SetSize(14, 14)
			header:SetHighlightTexture(0)
			header:SetPoint("TOPLEFT", bar, "TOPLEFT", -170, 0)

			war:StripTextures()
			war:SetPoint("LEFT", bar, "RIGHT", -2, 0)

			war.icon = war:CreateTexture(nil, "OVERLAY")
			war.icon:SetPoint("LEFT", 6, -8)
			war.icon:SetSize(32, 32)
			war.icon:SetTexture("Interface\\Buttons\\UI-CheckBox-SwordCheck")
		end
	end

	hooksecurefunc("ReputationFrame_Update", function()
		if CharacterFrame:IsShown() then
			local numFactions = GetNumFactions()
			local index, button
			local offset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)

			for i = 1, NUM_FACTIONS_DISPLAYED, 1 do
				button = T.Wrath and _G["ReputationBar"..i.."ExpandOrCollapseButton"] or _G["ReputationHeader"..i]
				index = offset + i

				if index <= numFactions then
					button:StripTextures()

					button.minus = button.minus or button:CreateTexture(nil, "OVERLAY")
					button.minus:SetSize(7, 1)
					button.minus:SetPoint("CENTER")
					button.minus:SetTexture(C.media.blank)

					if button.isCollapsed then
						button.plus = button.plus or button:CreateTexture(nil, "OVERLAY")
						button.plus:SetSize(1, 7)
						button.plus:SetPoint("CENTER")
						button.plus:SetTexture(C.media.blank)
					end
				end
			end
		end
	end)

	ReputationListScrollFrame:StripTextures()
	T.SkinScrollBar(ReputationListScrollFrameScrollBar)

	ReputationDetailFrame:StripTextures()
	ReputationDetailFrame:SetTemplate("Transparent")
	ReputationDetailFrame:SetPoint("TOPLEFT", ReputationFrame, "TOPRIGHT", -31, -12)

	T.SkinCloseButton(ReputationDetailCloseButton)
	ReputationDetailCloseButton:SetPoint("TOPRIGHT", -4, -4)

	T.SkinCheckBox(ReputationDetailAtWarCheckBox)
	T.SkinCheckBox(ReputationDetailInactiveCheckBox)
	T.SkinCheckBox(ReputationDetailMainScreenCheckBox)

	-- Skill Frame
	SkillFrame:StripTextures()

	SkillFrameExpandButtonFrame:DisableDrawLayer("BACKGROUND")

	SkillFrameCollapseAllButton:SetSize(14, 14)
	SkillFrameCollapseAllButton:SetHighlightTexture(0)
	SkillFrameCollapseAllButton:SetPoint("LEFT", SkillFrameExpandTabLeft, "RIGHT", -58, -3)

	SkillFrameCollapseAllButtonText:ClearAllPoints()
	SkillFrameCollapseAllButtonText:SetPoint("LEFT", SkillFrameCollapseAllButton, "RIGHT", 6, -1)

	hooksecurefunc(SkillFrameCollapseAllButton, "SetNormalTexture", function(self, texture)
		self:StripTextures()

		self.minus = self.minus or self:CreateTexture(nil, "OVERLAY")
		self.minus:SetSize(7, 1)
		self.minus:SetPoint("CENTER")
		self.minus:SetTexture(C.media.blank)

		if not string.find(texture, "MinusButton") then
			self.plus = self.plus or self:CreateTexture(nil, "OVERLAY")
			self.plus:SetSize(1, 7)
			self.plus:SetPoint("CENTER")
			self.plus:SetTexture(C.media.blank)
		end
	end)

	SkillFrameCancelButton:SkinButton()

	for i = 1, SKILLS_TO_DISPLAY do
		local bar = _G["SkillRankFrame"..i]
		local label = _G["SkillTypeLabel"..i]
		local text = _G["SkillTypeLabel"..i.."Text"]
		local border = _G["SkillRankFrame"..i.."Border"]
		local background = _G["SkillRankFrame"..i.."Background"]

		bar:CreateBackdrop("Default")
		bar:SetStatusBarTexture(C.media.blank)

		border:StripTextures()
		background:SetTexture(0)

		label:SetSize(14, 14)
		label:SetHighlightTexture(0)
		label:SetPoint("TOPLEFT", bar, "TOPLEFT", -18, 0)

		text:SetPoint("LEFT", label, "RIGHT", 6, -1)

		hooksecurefunc(label, "SetNormalTexture", function(self, texture)
			self:StripTextures()

			self.minus = self.minus or self:CreateTexture(nil, "OVERLAY")
			self.minus:SetSize(7, 1)
			self.minus:SetPoint("CENTER")
			self.minus:SetTexture(C.media.blank)

			if not string.find(texture, "MinusButton") then
				self.plus = self.plus or self:CreateTexture(nil, "OVERLAY")
				self.plus:SetSize(1, 7)
				self.plus:SetPoint("CENTER")
				self.plus:SetTexture(C.media.blank)
			end
		end)
	end

	SkillListScrollFrame:StripTextures()
	T.SkinScrollBar(SkillListScrollFrameScrollBar)

	SkillDetailScrollFrame:StripTextures()
	T.SkinScrollBar(SkillDetailScrollFrameScrollBar)

	SkillDetailStatusBar:StripTextures()
	SkillDetailStatusBar:SetParent(SkillDetailScrollFrame)
	SkillDetailStatusBar:CreateBackdrop("Default")
	SkillDetailStatusBar:SetStatusBarTexture(C.media.blank)

	T.SkinCloseButton(SkillDetailStatusBarUnlearnButton)
	SkillDetailStatusBarUnlearnButton:SetSize(24, 24)
	SkillDetailStatusBarUnlearnButton:ClearAllPoints()
	SkillDetailStatusBarUnlearnButton:SetPoint("LEFT", SkillDetailStatusBarBorder, "RIGHT", 5, 0)
	SkillDetailStatusBarUnlearnButton:SetHitRectInsets(0, 0, 0, 0)

	-- Honor Frame
	if T.Vanilla then
		HonorFrame:StripTextures(true)

		HonorFrameProgressBar:ClearAllPoints()
		HonorFrameProgressBar:SetPoint("TOP", CharacterFrame.backdrop, "TOP", 1, -65)

		HonorFrameProgressBar:CreateBackdrop("Default")
		HonorFrameProgressBar:SetHeight(24)
	end

	-- PVP Frame
	if not T.Vanilla then
		PVPFrame:StripTextures(true)

		if T.Wrath then
			PVPFrame:CreateBackdrop("Transparent")
			PVPFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
			PVPFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)
			T.SkinCloseButton(PVPParentFrameCloseButton, PVPFrame.backdrop)

			for i = 1, 2 do
				local tab = _G["PVPParentFrameTab"..i]
				if tab then
					T.SkinTab(tab)
					if i == 1 then
						tab:SetPoint("BOTTOMLEFT", PVPParentFrame, "BOTTOMLEFT", 11, 42)
					end
				end
			end
		end

		for i = 1, MAX_ARENA_TEAMS do
			local pvpTeam = _G["PVPTeam"..i]

			pvpTeam:StripTextures()
			pvpTeam:CreateBackdrop("Default")
			pvpTeam.backdrop:SetPoint("TOPLEFT", 9, -4)
			pvpTeam.backdrop:SetPoint("BOTTOMRIGHT", -24, 3)

			Mixin(pvpTeam, BackdropTemplateMixin) -- 9.0 to set backdrop

			pvpTeam:HookScript("OnEnter", T.SetModifiedBackdrop)
			pvpTeam:HookScript("OnLeave", T.SetOriginalBackdrop)

			_G["PVPTeam"..i.."Highlight"]:Kill()
		end

		PVPTeamDetails:StripTextures()
		PVPTeamDetails:SetTemplate("Transparent")
		PVPTeamDetails:SetPoint("TOPLEFT", PVPFrame, "TOPRIGHT", -30, -12)

		T.SkinNextPrevButton(PVPFrameToggleButton)
		PVPFrameToggleButton:SetPoint("BOTTOMRIGHT", PVPFrame, "BOTTOMRIGHT", -48, 81)
		PVPFrameToggleButton:SetSize(14, 14)

		for i = 1, 5 do
			local header = _G["PVPTeamDetailsFrameColumnHeader"..i]

			header:StripTextures()
			header:StyleButton()
		end

		for i = 1, 10 do
			local button = _G["PVPTeamDetailsButton"..i]

			button:SetWidth(335)
			-- button:SetColorTexture(1, 1, 1, 0.3)
		end

		PVPTeamDetailsAddTeamMember:SkinButton()

		T.SkinNextPrevButton(PVPTeamDetailsToggleButton)

		T.SkinCloseButton(PVPTeamDetailsCloseButton)
	end

	-- Token Frame
	if T.Wrath then
		TokenFrame:StripTextures()
		TokenFrameCancelButton:SkinButton()

		local function UpdateCurrencySkins()
			local TokenFramePopup = _G.TokenFramePopup

			if TokenFramePopup then
				TokenFramePopup:ClearAllPoints()
				TokenFramePopup:SetPoint("TOPLEFT", _G.TokenFrame, "TOPRIGHT", 4, -28)
				TokenFramePopup:StripTextures()
				TokenFramePopup:SetTemplate("Transparent")
			end

			local TokenFrameContainer = _G.TokenFrameContainer
			if not TokenFrameContainer.buttons then return end

			local buttons = TokenFrameContainer.buttons
			local numButtons = #buttons

			for i = 1, numButtons do
				local button = buttons[i]

				if button then
					if button.highlight then button.highlight:Kill() end
					if button.categoryLeft then button.categoryLeft:Kill() end
					if button.categoryRight then button.categoryRight:Kill() end
					if button.categoryMiddle then button.categoryMiddle:Kill() end

					if not button.backdrop then
						button:CreateBackdrop(nil, nil, nil, true)
					end

					if button.icon then
						button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						button.icon:SetSize(14, 14)

						button.backdrop:SetOutside(button.icon, 1, 1)
						button.backdrop:Show()
					else
						button.backdrop:Hide()
					end

					if button.expandIcon then
						if not button.highlightTexture then
							button.highlightTexture = button:CreateTexture(button:GetName().."HighlightTexture", "HIGHLIGHT")
							button.highlightTexture:SetTexture([[Interface\Buttons\UI-PlusButton-Hilight]])
							button.highlightTexture:SetBlendMode("ADD")
							button.highlightTexture:SetInside(button.expandIcon)

							-- these two only need to be called once
							-- adding them here will prevent additional calls
							button.expandIcon:ClearAllPoints()
							button.expandIcon:SetPoint("LEFT", 4, 0)
							button.expandIcon:SetSize(12, 12)
						end

						if button.isHeader then
							button.backdrop:Hide()

							-- TODO: WotLK Fix some quirks for the header point keeps changing after you click the expandIcon button.
							for x = 1, button:GetNumRegions() do
								local region = select(x, button:GetRegions())
								if region and region:IsObjectType("FontString") and region:GetText() then
									region:ClearAllPoints()
									region:SetPoint("LEFT", 25, 0)
								end
							end

							button.expandIcon:StripTextures()
							button.highlightTexture:Show()
						else
							button.highlightTexture:Hide()
						end
					end
				end
			end
		end

		hooksecurefunc("TokenFrame_Update", UpdateCurrencySkins)
		hooksecurefunc(_G.TokenFrameContainer, "update", UpdateCurrencySkins)
	end
end

table.insert(T.SkinFuncs["ShestakUI"], LoadSkin)
