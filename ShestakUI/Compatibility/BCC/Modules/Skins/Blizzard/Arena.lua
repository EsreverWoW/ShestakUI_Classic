local T, C, L, _ = unpack(select(2, ...))
if not T.BCC or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Arena skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ArenaFrame:StripTextures(true)
	ArenaFrame:CreateBackdrop("Transparent")
	ArenaFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	ArenaFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(ArenaFrameCloseButton, ArenaFrame.backdrop)

	ArenaFrame:DisableDrawLayer("BACKGROUND")

	ArenaFrameFrameLabel:ClearAllPoints()
	ArenaFrameFrameLabel:SetPoint("TOP", TabardFrame.backdrop, "TOP", 0, -10)

	ArenaFrame.zones_bg = CreateFrame("Frame", "ArenaFrameZonesBackground", ArenaFrame)
	ArenaFrame.zones_bg:CreateBackdrop("Transparent")
	ArenaFrame.zones_bg:SetWidth(324)
	ArenaFrame.zones_bg:SetHeight(204)
	ArenaFrame.zones_bg:SetPoint("TOPLEFT", ArenaFrame.backdrop, "TOPLEFT", 9, -62)

	ArenaFrame.tex1 = ArenaFrame.backdrop:CreateTexture("ArenaFrameWorldMap1", "ARTWORK")
	ArenaFrame.tex1:SetTexture("Interface\\BattlefieldFrame\\UI-Battlefield-WorldMap1")
	ArenaFrame.tex1:SetPoint("TOPLEFT", 11, -64)
	ArenaFrame.tex1:SetHeight(240)
	ArenaFrame.tex2 = ArenaFrame.backdrop:CreateTexture("ArenaFrameWorldMap2", "ARTWORK")
	ArenaFrame.tex2:SetTexture("Interface\\BattlefieldFrame\\UI-Battlefield-WorldMap2")
	ArenaFrame.tex2:SetPoint("LEFT", ArenaFrame.tex1, "RIGHT", 0, 0)
	ArenaFrame.tex2:SetHeight(240)

	ArenaFrameNameHeader:ClearAllPoints()
	ArenaFrameNameHeader:SetPoint("BOTTOMLEFT", ArenaFrameDivider, "TOPLEFT", 14, 60)
	ArenaZone1:ClearAllPoints()
	ArenaZone1:SetPoint("TOPLEFT", ArenaFrame, "TOPLEFT", 23, -107)

	ArenaFrameNameHeader2:ClearAllPoints()
	ArenaFrameNameHeader2:SetPoint("BOTTOMLEFT", ArenaFrameDivider, "TOPLEFT", 14, -28)
	ArenaZone4:ClearAllPoints()
	ArenaZone4:SetPoint("TOPLEFT", ArenaZone3, "TOPLEFT", 0, -57)

	ArenaFrame.textbox = CreateFrame("Frame", "ArenaFrameTextBox", ArenaFrame)
	ArenaFrame.textbox:CreateBackdrop("Transparent")
	ArenaFrame.textbox:SetWidth(324)
	ArenaFrame.textbox:SetHeight(110)
	ArenaFrame.textbox:SetPoint("BOTTOM", ArenaFrame.backdrop, "BOTTOM", 0, 36)

	ArenaFrameZoneDescription:SetFontObject(GameFontWhite)
	ArenaFrameZoneDescription:ClearAllPoints()
	ArenaFrameZoneDescription:SetPoint("TOPLEFT", ArenaFrame.textbox, "TOPLEFT", 4, -4)
	ArenaFrameZoneDescription:SetPoint("BOTTOMRIGHT", ArenaFrame.textbox, "BOTTOMRIGHT", -4, 4)

	ArenaFrameCancelButton:SkinButton()
	ArenaFrameJoinButton:SkinButton()
	ArenaFrameGroupJoinButton:SkinButton()

	ArenaFrameCancelButton:SetPoint("BOTTOMRIGHT", ArenaFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	ArenaFrameGroupJoinButton:SetPoint("RIGHT", ArenaFrameJoinButton, "LEFT", -2, 0)

	ArenaFrame:HookScript("OnShow", function() if InCombatLockdown() then return end GossipFrame:Hide() BattlefieldFrame:Hide() end)
	FriendsFrame:HookScript("OnShow", function() if InCombatLockdown() then return end ArenaFrame:Hide() end)

	if ArenaFrame:GetAttribute("UIPanelLayout-allowOtherPanels") ~= true then
		SetUIPanelAttribute(ArenaFrame, "allowOtherPanels", true)
	end
end

table.insert(T.SkinFuncs["ShestakUI"], LoadSkin)