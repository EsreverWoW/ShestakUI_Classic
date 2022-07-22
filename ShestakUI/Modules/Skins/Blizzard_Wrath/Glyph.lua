local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GlyphUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()   
	-- Glyph Tab
	GlyphFrame:StripTextures()
	GlyphFrame:CreateBackdrop("Transparent")
	GlyphFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	GlyphFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	GlyphFrameBackground:SetDrawLayer("OVERLAY")
	GlyphFrameBackground:SetPoint("TOPLEFT", 5, 0)
	GlyphFrameBackground:SetPoint("BOTTOMRIGHT", -5, 2)

	for i = 1, 6 do
		_G["GlyphFrameGlyph"..i]:SetFrameLevel(_G["GlyphFrameGlyph"..i]:GetFrameLevel() + 5)
	end
end

T.SkinFuncs["Blizzard_GlyphUI"] = LoadSkin