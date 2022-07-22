local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalentUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	_G["PlayerTalentFrame"]:StripTextures()
	_G["PlayerTalentFrame"]:CreateBackdrop("Transparent")
	_G["PlayerTalentFrame"].backdrop:SetPoint("TOPLEFT", 10, -12)
	_G["PlayerTalentFrame"].backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	_G["PlayerTalentFramePortrait"]:Hide()

	T.SkinCloseButton(_G["PlayerTalentFrameCloseButton"], _G["PlayerTalentFrame"].backdrop)

	_G["PlayerTalentFrameTitleText"]:ClearAllPoints()
	_G["PlayerTalentFrameTitleText"]:SetPoint("TOP", _G["PlayerTalentFrame"].backdrop, "TOP", 0, -6)

	if T.Wrath then
		_G["PlayerTalentFrameSpentPointsText"]:ClearAllPoints()
		_G["PlayerTalentFrameSpentPointsText"]:SetPoint("TOP", _G["PlayerTalentFrame"].backdrop, "TOP", 0, -30)
	else
		_G["PlayerTalentFrameSpentPoints"]:ClearAllPoints()
		_G["PlayerTalentFrameSpentPoints"]:SetPoint("TOP", _G["PlayerTalentFrame"].backdrop, "TOP", 0, -30)

		_G["PlayerTalentFrameCancelButton"]:Kill()
	end

	_G["PlayerTalentFrameTab1"]:ClearAllPoints()
	_G["PlayerTalentFrameTab1"]:SetPoint("TOPLEFT", _G["PlayerTalentFrame"].backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, 5 do
		T.SkinTab(_G["PlayerTalentFrameTab"..i])
	end

	_G["PlayerTalentFrameScrollFrame"]:StripTextures()
	_G["PlayerTalentFrameScrollFrame"]:CreateBackdrop("Default")
	_G["PlayerTalentFrameScrollFrame"].backdrop:SetPoint("TOPLEFT", -1, 1)
	_G["PlayerTalentFrameScrollFrame"].backdrop:SetPoint("BOTTOMRIGHT", 6, -1)

	T.SkinScrollBar(_G["PlayerTalentFrameScrollFrameScrollBar"])
	_G["PlayerTalentFrameScrollFrameScrollBar"]:SetPoint("TOPLEFT", _G["PlayerTalentFrameScrollFrame"], "TOPRIGHT", 10, -16)

	_G["PlayerTalentFrameTalentPointsText"]:SetPoint("BOTTOMRIGHT", PlayerTalentFrame, "BOTTOMLEFT", 220, 84)

	for i = 1, MAX_NUM_TALENTS do
		local talent = _G["PlayerTalentFrameTalent"..i]
		local icon = _G["PlayerTalentFrameTalent"..i.."IconTexture"]
		local rank = _G["PlayerTalentFrameTalent"..i.."Rank"]

		if talent then
			talent:StripTextures()
			talent:SetTemplate("Default")
			talent:StyleButton()

			icon:SetInside()
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("ARTWORK")

			rank:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		end
	end

	if T.Wrath then
		for i = 1, MAX_TALENT_TABS do
			local tab = _G["PlayerSpecTab"..i]
			tab:GetRegions():Hide()

			tab:SetTemplate("Default")
			tab:StyleButton(true)

			tab:GetNormalTexture():SetInside()
			tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end

		PlayerTalentFrameStatusFrame:SetPoint("TOPLEFT", 57, -40)
		PlayerTalentFrameActivateButton:SetPoint("TOP", 0, -40)

		PlayerTalentFrameScrollFrame:SetWidth(302)
		PlayerTalentFrameScrollFrame:SetPoint("TOPRIGHT", PlayerTalentFrame, "TOPRIGHT", -62, -77)
		PlayerTalentFrameScrollFrame:SetPoint("BOTTOM", PlayerTalentFramePointsBar, "TOP", 0, 0)

		PlayerTalentFrameScrollFrameScrollBar:SetPoint("TOPLEFT", PlayerTalentFrameScrollFrame, "TOPRIGHT", 4, -18)
		PlayerTalentFrameScrollFrameScrollBar:SetPoint("BOTTOMLEFT", PlayerTalentFrameScrollFrame, "BOTTOMRIGHT", 4, 18)

		PlayerTalentFrameResetButton:SetPoint("RIGHT", -4, 1)
		PlayerTalentFrameLearnButton:SetPoint("RIGHT", PlayerTalentFrameResetButton, "LEFT", -3, 0)

		PlayerSpecTab1:SetPoint("TOPLEFT", PlayerTalentFrame, "TOPRIGHT", -33, -65)
		PlayerSpecTab1.ClearAllPoints = T.dummy
		PlayerSpecTab1.SetPoint = T.dummy

		PlayerTalentFrameTab1:SetPoint("BOTTOMLEFT", 11, 46)
	end

	local f = CreateFrame("Frame")
	f:RegisterEvent("CHARACTER_POINTS_CHANGED")
	f:SetScript("OnEvent", function()
		PlayerTalentFrame_Update()
	end)
end

T.SkinFuncs["Blizzard_TalentUI"] = LoadSkin
