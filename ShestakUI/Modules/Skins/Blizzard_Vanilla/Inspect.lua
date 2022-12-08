local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	InspectUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	InspectFrame:StripTextures(true)
	InspectFrame:CreateBackdrop("Transparent")
	InspectFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	InspectFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(InspectFrameCloseButton, InspectFrame.backdrop)

	InspectNameText:ClearAllPoints()
    InspectNameText:SetPoint("TOP", InspectFrame.backdrop, "TOP", 0, -6)

	InspectFrameTab1:ClearAllPoints()
	InspectFrameTab1:SetPoint("TOPLEFT", InspectFrame.backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, not T.Vanilla and 3 or 2 do
		T.SkinTab(_G["InspectFrameTab"..i])
	end

	-- Character Frame
	InspectPaperDollFrame:StripTextures()

	InspectModelFrame:StripTextures()

	T.SkinRotateButton(InspectModelFrameRotateLeftButton)
	InspectModelFrameRotateLeftButton:SetPoint("TOPLEFT", 2, 2)

	T.SkinRotateButton(InspectModelFrameRotateRightButton)
	InspectModelFrameRotateRightButton:SetPoint("TOPLEFT", InspectModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

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
		"RangedSlot"
	}

	for _, slot in pairs(slots) do
		local icon = _G["Inspect"..slot.."IconTexture"]
		local slot = _G["Inspect"..slot]

		slot:StripTextures()
		slot:StyleButton()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:CreateBackdrop("Default")
		slot.backdrop:SetAllPoints()

		hooksecurefunc(slot.IconBorder, "SetVertexColor", function(self, r, g, b)
			self:SetTexture(0)
		end)
	end

	-- Honor Frame
	if InspectHonorFrame then
		InspectHonorFrame:StripTextures(true)

		InspectHonorFrameProgressBar:ClearAllPoints()
		InspectHonorFrameProgressBar:SetPoint("TOP", InspectFrame.backdrop, "TOP", 1, -65)

		InspectHonorFrameProgressBar:CreateBackdrop("Default")
		InspectHonorFrameProgressBar:SetHeight(24)
	end

	-- PVP Frame
	if InspectPVPFrame then
		InspectPVPFrame:StripTextures(true)
	end

	-- Talent Frame
	if InspectTalentFrame then
		if not T.Wrath then
			InspectTalentFrameCancelButton:Kill()
		end
		InspectTalentFrameCloseButton:Kill()

		InspectTalentFrame:StripTextures(true)

		T.SkinCloseButton(InspectTalentFrameCloseButton, InspectFrame.backdrop)

		for i = 1, 3 do
			local tab = _G["InspectTalentFrameTab"..i]
			local lastTab = _G["InspectTalentFrameTab"..i-1]
			tab:ClearAllPoints()
			if lastTab then
				tab:SetPoint("LEFT", lastTab, "RIGHT", 4, 0)
			else
				tab:SetPoint("TOPLEFT", 70, -48)
			end
			T.SkinTab(tab)
		end

		InspectTalentFrameScrollFrame:StripTextures()
		InspectTalentFrameScrollFrame:CreateBackdrop("Default")
		InspectTalentFrameScrollFrame.backdrop:SetPoint("TOPLEFT", -1, 1)
		InspectTalentFrameScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 6, -1)

		T.SkinScrollBar(InspectTalentFrameScrollFrameScrollBar)
		InspectTalentFrameScrollFrameScrollBar:SetPoint("TOPLEFT", InspectTalentFrameScrollFrame, "TOPRIGHT", 10, -16)

		if not T.Wrath then
			InspectTalentFrameSpentPoints:SetPoint("BOTTOMLEFT", InspectTalentFrame, "BOTTOMLEFT", 8, 84)
		end

		for i = 1, MAX_NUM_TALENTS do
			local talent = _G["InspectTalentFrameTalent"..i]
			local icon = _G["InspectTalentFrameTalent"..i.."IconTexture"]
			local rank = _G["InspectTalentFrameTalent"..i.."Rank"]

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
	end
end

T.SkinFuncs["Blizzard_InspectUI"] = LoadSkin
