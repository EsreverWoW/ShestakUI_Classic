local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	EngravingUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	EngravingFrame:StripTextures()
	EngravingFrame:CreateBackdrop("Transparent")
	EngravingFrame.backdrop:SetPoint("TOPLEFT", -5, 58)
	EngravingFrame.backdrop:SetPoint("BOTTOMRIGHT", 8, -18)

	T.SkinEditBox(EngravingFrameSearchBox)
	EngravingFrameSearchBoxSearchIcon:SetPoint("LEFT", EngravingFrameSearchBox, "LEFT", 2, -2)

	T.SkinDropDownBox(EngravingFrameFilterDropDown)
	EngravingFrameFilterDropDown:SetSize(212, 34)
	EngravingFrameFilterDropDown:SetPoint("TOPLEFT", EngravingFrameSearchBox, "BOTTOMLEFT", -22, -3)
	EngravingFrameFilterDropDownText:SetPoint("LEFT", EngravingFrameFilterDropDown, "LEFT", 28, 1)

	EngravingFrameSideInset:StripTextures()
	EngravingFrameScrollFrame:StripTextures()
	T.SkinScrollBar(EngravingFrameScrollFrameScrollBar)

	-- EngravingFrameCollectedFrame
	-- EngravingFrameCollectedFrameLabel
end

T.SkinFuncs["Blizzard_EngravingUI"] = LoadSkin
