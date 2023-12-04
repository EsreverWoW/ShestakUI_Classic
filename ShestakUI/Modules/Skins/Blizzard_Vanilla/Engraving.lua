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

	local function UpdateRuneList()
		for i = 1, #C_Engraving.GetRuneCategories(true, true) do
			if not _G["EngravingFrameHeader"..i].isSkinned then
				_G["EngravingFrameHeader"..i]:StripTextures()
				_G["EngravingFrameHeader"..i]:SetTemplate("Transparent")
				_G["EngravingFrameHeader"..i].isSkinned = true
			end
		end

		for i = 1, #EngravingFrame.scrollFrame.buttons do
			if not _G["EngravingFrameScrollFrameButton"..i].isSkinned then
				_G["EngravingFrameScrollFrameButton"..i]:SkinButton()
				-- _G["EngravingFrameScrollFrameButton"..i.."Icon"]:SkinIcon(true)
				-- _G["EngravingFrameScrollFrameButton"..i.."Icon"]:SetSize(32, 32)
				_G["EngravingFrameScrollFrameButton"..i].isSkinned = true
			end
		end
	end

	hooksecurefunc("EngravingFrame_UpdateRuneList", UpdateRuneList)
end

T.SkinFuncs["Blizzard_EngravingUI"] = LoadSkin
