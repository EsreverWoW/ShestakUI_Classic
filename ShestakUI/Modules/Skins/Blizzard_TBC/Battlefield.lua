local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Arena skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	BattlefieldFrame:StripTextures(true)
	BattlefieldFrame:CreateBackdrop("Transparent")
	BattlefieldFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	BattlefieldFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(BattlefieldFrameCloseButton, BattlefieldFrame.backdrop)

	if BattlefieldListScrollFrame then
		BattlefieldListScrollFrame:StripTextures()
		T.SkinScrollBar(BattlefieldListScrollFrameScrollBar)
	end

	if BattlefieldFrameInfoScrollFrame then
		BattlefieldFrameInfoScrollFrame:StripTextures()
		T.SkinScrollBar(BattlefieldFrameInfoScrollFrame)
	end

	if BattlefieldFrameZoneDescription then
		BattlefieldFrameZoneDescription:SetTextColor(1, 1, 1)
	end

	if BattlefieldFrameInfoScrollFrameChildFrameDescription then
		BattlefieldFrameInfoScrollFrameChildFrameDescription:SetTextColor(1, 1, 1)
	end

	if BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription then
		BattlefieldFrameInfoScrollFrameChildFrameRewardsInfoDescription:SetTextColor(1, 1, 1)
	end

	BattlefieldFrameCancelButton:SkinButton()
	BattlefieldFrameJoinButton:SkinButton()
	BattlefieldFrameGroupJoinButton:SkinButton()

	BattlefieldFrameGroupJoinButton:SetPoint("RIGHT", BattlefieldFrameJoinButton, "LEFT", -2, 0)
end

table.insert(T.SkinFuncs["ShestakUI"], LoadSkin)