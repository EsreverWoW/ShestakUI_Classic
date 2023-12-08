local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Loot skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Loot History frame
	if T.Classic then
		LootHistoryFrame:StripTextures()
		LootHistoryFrame:SetTemplate("Transparent")

		T.SkinCloseButton(LootHistoryFrame.CloseButton)
		T.SkinCloseButton(LootHistoryFrame.ResizeButton, nil, " ")
		LootHistoryFrameScrollFrame:GetRegions():Hide()
		T.SkinScrollBar(LootHistoryFrameScrollFrameScrollBar)

		LootHistoryFrame.ResizeButton:SetTemplate("Default")
		LootHistoryFrame.ResizeButton:SetWidth(LootHistoryFrame:GetWidth())
		LootHistoryFrame.ResizeButton:ClearAllPoints()
		LootHistoryFrame.ResizeButton:SetPoint("TOP", LootHistoryFrame, "BOTTOM", 0, -1)
	else
		GroupLootHistoryFrame:StripTextures()
		GroupLootHistoryFrame:CreateBackdrop("Transparent")

		T.SkinCloseButton(GroupLootHistoryFrame.ClosePanelButton)
		T.SkinScrollBar(GroupLootHistoryFrame.ScrollBar)
		T.SkinDropDownBox(GroupLootHistoryFrame.EncounterDropDown)

		GroupLootHistoryFrame.ResizeButton:StripTextures()
		GroupLootHistoryFrame.ResizeButton:SetHeight(13)

		do
			local line1 = GroupLootHistoryFrame.ResizeButton:CreateTexture()
			line1:SetTexture(C.media.blank)
			line1:SetVertexColor(0.8, 0.8, 0.8)
			line1:SetSize(30, T.mult)
			line1:SetPoint("TOP", 0, -5)

			local line2 = GroupLootHistoryFrame.ResizeButton:CreateTexture()
			line2:SetTexture(C.media.blank)
			line2:SetVertexColor(0.8, 0.8, 0.8)
			line2:SetSize(20, T.mult)
			line2:SetPoint("TOP", 0, -8)

			local line3 = GroupLootHistoryFrame.ResizeButton:CreateTexture()
			line3:SetTexture(C.media.blank)
			line3:SetVertexColor(0.8, 0.8, 0.8)
			line3:SetSize(10, T.mult)
			line3:SetPoint("TOP", 0, -11)

			GroupLootHistoryFrame.ResizeButton:HookScript("OnEnter", function()
				line1:SetVertexColor(unpack(C.media.classborder_color))
				line2:SetVertexColor(unpack(C.media.classborder_color))
				line3:SetVertexColor(unpack(C.media.classborder_color))
			end)

			GroupLootHistoryFrame.ResizeButton:HookScript("OnLeave", function()
				line1:SetVertexColor(0.8, 0.8, 0.8)
				line2:SetVertexColor(0.8, 0.8, 0.8)
				line3:SetVertexColor(0.8, 0.8, 0.8)
			end)
		end

		hooksecurefunc(LootHistoryElementMixin, "Init", function(button)
			local item = button.Item
			if item and not item.styled then
				item:StyleButton()
				item:SetNormalTexture(0)
				item:SetTemplate("Default")
				item:SetSize(35, 35)

				item.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				item.icon:ClearAllPoints()
				item.icon:SetPoint("TOPLEFT", 2, -2)
				item.icon:SetPoint("BOTTOMRIGHT", -2, 2)

				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

				item.IconBorder:SetAlpha(0)
				button.NameFrame:Hide()

				item.styled = true
			end

			button.BorderFrame:SetAlpha(0)
		end)
	end

	local function UpdateLoots(self)
		local numItems = C_LootHistory.GetNumItems()
		for i = 1, numItems do
			local frame = self.itemFrames[i]

			if not frame.isSkinned then
				local Icon = frame.Icon:GetTexture()

				frame:StripTextures()

				frame:CreateBackdrop("Default")
				frame.backdrop:SetPoint("TOPLEFT", frame.Icon, -2, 2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame.Icon, 2, -2)

				frame.Icon:SetTexture(Icon)
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.Icon:SetParent(frame.backdrop)

				frame.isSkinned = true
			end
		end
	end

	if T.Classic then
		hooksecurefunc("LootHistoryFrame_FullUpdate", UpdateLoots)
		LootHistoryFrame:HookScript("OnShow", UpdateLoots)
	else
		-- hooksecurefunc("GroupLootHistoryFrame_FullUpdate", UpdateLoots)
		-- GroupLootHistoryFrame:HookScript("OnShow", UpdateLoots)
	end

	-- Master Looter frame
	MasterLooterFrame:StripTextures()
	MasterLooterFrame:SetTemplate("Transparent")

	hooksecurefunc("MasterLooterFrame_Show", function()
		local button = MasterLooterFrame.Item
		if button then
			local icon = button.Icon
			local texture = icon:GetTexture()
			local color = ITEM_QUALITY_COLORS[LootFrame.selectedQuality]

			button:StripTextures()

			icon:SetTexture(texture)
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button:CreateBackdrop("Default")
			button.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
			button.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)
			button.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
		end

		for i = 1, MasterLooterFrame:GetNumChildren() do
			local child = select(i, MasterLooterFrame:GetChildren())
			if child and not child.isSkinned and not child:GetName() then
				if child:GetObjectType() == "Button" then
					if child:GetPushedTexture() then
						T.SkinCloseButton(child)
					else
						child:StripTextures()
						child:SkinButton()
					end
					child.isSkinned = true
				end
			end
		end
	end)

	-- Loot frame
	if C.loot.lootframe == true or (IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag") or IsAddOnLoaded("Baganator")) then return end

	if T.Classic then
		LootFrame:StripTextures()
		LootFrame:SetTemplate("Transparent")
		LootFrameInset:StripTextures()
		LootFramePortraitOverlay:Kill()

		T.SkinNextPrevButton(LootFrameDownButton)
		T.SkinNextPrevButton(LootFrameUpButton, true)

		T.SkinCloseButton(LootFrameCloseButton)

		for i = 1, LOOTFRAME_NUMBUTTONS do
			local slot = _G["LootButton"..i]
			local icon = _G["LootButton"..i.."IconTexture"]
			local name = _G["LootButton"..i.."NameFrame"]

			slot:StyleButton()
			slot:SetNormalTexture(0)
			slot:SetTemplate("Default")

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)

			name:Hide()
			name.border = CreateFrame("Frame", nil, slot)
			name.border:CreateBackdrop("Overlay")
			name.border.backdrop:SetPoint("TOPLEFT", name, 11, -13)
			name.border.backdrop:SetPoint("BOTTOMRIGHT", name, -8, 12)
		end
	else
		LootFrame:StripTextures(true)
		LootFrame:SetTemplate("Transparent")
		T.SkinCloseButton(LootFrame.ClosePanelButton)

		hooksecurefunc(LootFrameElementMixin, "Init", function(button)
			local item = button.Item
			if item and not item.styled then
				item:StyleButton()
				item:SetNormalTexture(0)
				item:SetTemplate("Default")

				item.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				item.icon:ClearAllPoints()
				item.icon:SetPoint("TOPLEFT", 2, -2)
				item.icon:SetPoint("BOTTOMRIGHT", -2, 2)

				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

				button.HighlightNameFrame:SetAlpha(0)
				button.PushedNameFrame:SetAlpha(0)
				item.IconBorder:SetAlpha(0)
				button.NameFrame:Hide()

				item.styled = true
			end

			button.IconQuestTexture:SetAlpha(0)
			button.BorderFrame:SetAlpha(0)
			if button.QualityStripe then
				button.QualityStripe:SetAlpha(0)
			end
			if button.IconQuestTexture:IsShown() then
				item:SetBackdropBorderColor(1, 1, 0)
			else
				item:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
