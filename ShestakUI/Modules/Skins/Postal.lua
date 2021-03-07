local T, C, L, _ = unpack(select(2, ...))
if C.skins.postal ~= true then return end

----------------------------------------------------------------------------------------
--	Postal skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("Postal") then return end
	T.SkinRotateButton(Postal_ModuleMenuButton)
	Postal_ModuleMenuButton:ClearAllPoints()
	Postal_ModuleMenuButton:SetWidth(18)
	Postal_ModuleMenuButton:SetHeight(18)
	Postal_ModuleMenuButton:SetPoint("TOPRIGHT", MailFrameCloseButton, "TOPLEFT", -2, 0)

	T.SkinRotateButton(Postal_OpenAllMenuButton)
	Postal_OpenAllMenuButton:ClearAllPoints()
	Postal_OpenAllMenuButton:SetWidth(18)
	Postal_OpenAllMenuButton:SetHeight(18)
	Postal_OpenAllMenuButton:SetPoint("TOPLEFT", PostalOpenAllButton, "TOPRIGHT", 2, -4)

	T.SkinRotateButton(Postal_BlackBookButton)
	Postal_BlackBookButton:ClearAllPoints()
	Postal_BlackBookButton:SetWidth(16)
	Postal_BlackBookButton:SetHeight(20)
	Postal_BlackBookButton:SetPoint("TOPLEFT", SendMailNameEditBox, "TOPRIGHT", 0, -2)

	PostalSelectOpenButton:SkinButton()
	PostalSelectReturnButton:SkinButton()
	PostalOpenAllButton:SkinButton()

	if T.classic then
		for i = 1, INBOXITEMS_TO_DISPLAY do
			local button = _G["MailItem"..i]
			local expireTime = _G["MailItem"..i.."ExpireTime"]

			button:SetWidth(290)

			expireTime:ClearAllPoints()
			expireTime:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, -4)
		end
	end
end)
