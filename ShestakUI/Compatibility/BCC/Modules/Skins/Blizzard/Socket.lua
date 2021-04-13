local T, C, L, _ = unpack(select(2, ...))
if not T.BCC or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Socket skin
----------------------------------------------------------------------------------------
local function LoadSkin()
    -- /run LoadAddOn("Blizzard_ItemSocketingUI");ItemSocketingFrame:Show()

    ItemSocketingFrame:StripTextures(true)
    ItemSocketingFrame:CreateBackdrop("Transparent")
    ItemSocketingFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
    ItemSocketingFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, 31)

    T.SkinCloseButton(ItemSocketingCloseButton, ItemSocketingFrame.backdrop)

    ItemSocketingDescription:DisableDrawLayer("BORDER")

    ItemSocketingFrame:DisableDrawLayer("BACKGROUND")

    ItemSocketingScrollFrame:StripTextures()
    ItemSocketingScrollFrame:CreateBackdrop("Default")
    ItemSocketingScrollFrame.backdrop:SetPoint("TOPLEFT", -1, 1)
    ItemSocketingScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 6, -1)

    T.SkinScrollBar(ItemSocketingScrollFrameScrollBar)
    ItemSocketingScrollFrameScrollBar:SetPoint("TOPLEFT", ItemSocketingScrollFrame, "TOPRIGHT", 10, -16)

    for i = 1, MAX_NUM_SOCKETS  do
        local socket = _G["ItemSocketingSocket"..i]
        local icon = _G["ItemSocketingSocket"..i.."IconTexture"]

        socket:StripTextures()
        socket:StyleButton()

        icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        icon:ClearAllPoints()
        icon:SetPoint("TOPLEFT", 2, -2)
        icon:SetPoint("BOTTOMRIGHT", -2, 2)
    end

    ItemSocketingSocketButton:SkinButton()
end

T.SkinFuncs["Blizzard_ItemSocketingUI"] = LoadSkin