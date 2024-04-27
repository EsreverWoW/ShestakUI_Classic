local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	BarbershopUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if T.Classic then
		BarberShopFrame:StripTextures()
		BarberShopFrame:CreateBackdrop("Transparent")
		BarberShopFrame.backdrop:SetPoint("TOPLEFT", 2, -2)
		BarberShopFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, 35)

		BarberShopFrameMoneyFrame:StripTextures()
		BarberShopFrameMoneyFrame:CreateBackdrop("Overlay")
		BarberShopFrameMoneyFrame.backdrop:SetPoint("TOPLEFT", -3, 0)
		BarberShopFrameMoneyFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 3)

		BarberShopFrameOkayButton:SkinButton(true)
		BarberShopFrameCancelButton:SkinButton(true)
		BarberShopFrameResetButton:SkinButton(true)

		for i = 1, #BarberShopFrame.Selector do
			local prevBtn, nextBtn = BarberShopFrame.Selector[i]:GetChildren()
			T.SkinNextPrevButton(prevBtn, true)
			T.SkinNextPrevButton(nextBtn)
		end

		BarberShopBannerFrameBGTexture:Kill()
		BarberShopBannerFrame:Kill()

		BarberShopBannerFrameCaption:ClearAllPoints()
		BarberShopBannerFrameCaption:SetPoint("TOP", BarberShopFrame, 0, 0)
		BarberShopBannerFrameCaption:SetParent(BarberShopFrame)

		BarberShopAltFormFrameBorder:StripTextures()
		BarberShopAltFormFrame:SetPoint("BOTTOM", BarberShopFrame, "TOP", 0, 3)
		BarberShopAltFormFrame:StripTextures()
		BarberShopAltFormFrame:CreateBackdrop("Transparent")
	else
		local buttons = {
			BarberShopFrame.AcceptButton,
			BarberShopFrame.CancelButton,
			BarberShopFrame.ResetButton
		}

		for i = 1, #buttons do
			local button = buttons[i]
			button:SkinButton(true)
			button:SetScale(UIParent:GetScale())
		end

		local smallButtons = {
			CharCustomizeFrame.SmallButtons.ResetCameraButton,
			CharCustomizeFrame.SmallButtons.ZoomOutButton,
			CharCustomizeFrame.SmallButtons.ZoomInButton,
			CharCustomizeFrame.SmallButtons.RotateLeftButton,
			CharCustomizeFrame.SmallButtons.RotateRightButton,
		}

		for i = 1, #smallButtons do
			local button = smallButtons[i]
			button:SetNormalTexture(0)
			button:SetPushedTexture(0)
			button:SetHighlightTexture(0)
		end
	end
end

T.SkinFuncs["Blizzard_BarbershopUI"] = LoadSkin
