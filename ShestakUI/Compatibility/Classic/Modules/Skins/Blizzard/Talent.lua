local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalentUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local TalentFrame = T.BCC and "PlayerTalentFrame" or "TalentFrame"

	_G[TalentFrame]:StripTextures()
	_G[TalentFrame]:CreateBackdrop("Transparent")
	_G[TalentFrame].backdrop:SetPoint("TOPLEFT", 10, -12)
	_G[TalentFrame].backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	_G[TalentFrame.."Portrait"]:Hide()

	T.SkinCloseButton(_G[TalentFrame.."CloseButton"], _G[TalentFrame].backdrop)

	_G[TalentFrame.."TitleText"]:ClearAllPoints()
	_G[TalentFrame.."TitleText"]:SetPoint("TOP", _G[TalentFrame].backdrop, "TOP", 0, -6)

	_G[TalentFrame.."SpentPoints"]:ClearAllPoints()
	_G[TalentFrame.."SpentPoints"]:SetPoint("TOP", _G[TalentFrame].backdrop, "TOP", 0, -30)

	_G[TalentFrame.."CancelButton"]:Kill()

	_G[TalentFrame.."Tab1"]:ClearAllPoints()
	_G[TalentFrame.."Tab1"]:SetPoint("TOPLEFT", _G[TalentFrame].backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, 5 do
		T.SkinTab(_G[TalentFrame.."Tab"..i])
	end

	_G[TalentFrame.."ScrollFrame"]:StripTextures()
	_G[TalentFrame.."ScrollFrame"]:CreateBackdrop("Default")
	_G[TalentFrame.."ScrollFrame"].backdrop:SetPoint("TOPLEFT", -1, 1)
	_G[TalentFrame.."ScrollFrame"].backdrop:SetPoint("BOTTOMRIGHT", 6, -1)

	T.SkinScrollBar(_G[TalentFrame.."ScrollFrameScrollBar"])
	_G[TalentFrame.."ScrollFrameScrollBar"]:SetPoint("TOPLEFT", _G[TalentFrame.."ScrollFrame"], "TOPRIGHT", 10, -16)

	_G[TalentFrame.."TalentPointsText"]:SetPoint("BOTTOMRIGHT", TalentFrame, "BOTTOMLEFT", 220, 84)

	for i = 1, MAX_NUM_TALENTS do
		local talent = _G[TalentFrame.."Talent"..i]
		local icon = _G[TalentFrame.."Talent"..i.."IconTexture"]
		local rank = _G[TalentFrame.."Talent"..i.."Rank"]

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

	local f = CreateFrame("Frame")
	f:RegisterEvent("CHARACTER_POINTS_CHANGED")
	f:SetScript("OnEvent", function()
		if not T.BCC then
			TalentFrame_Update()
		else
			PlayerTalentFrame_Update()
		end
	end)
end

T.SkinFuncs["Blizzard_TalentUI"] = LoadSkin
