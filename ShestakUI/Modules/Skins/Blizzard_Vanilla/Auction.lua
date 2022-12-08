local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AuctionUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinCloseButton(AuctionFrameCloseButton)
	AuctionFrame:StripTextures(true)
	AuctionFrame:SetTemplate("Transparent")

	BrowseTitle:ClearAllPoints()
    BrowseTitle:SetPoint("TOP", AuctionFrame, "TOP", 0, -6)

	BidTitle:ClearAllPoints()
    BidTitle:SetPoint("TOP", AuctionFrameBid, "TOP", 37, -6)

	AuctionsTitle:ClearAllPoints()
    AuctionsTitle:SetPoint("TOP", AuctionFrameAuctions, "TOP", 37, -6)

	BrowseFilterScrollFrame:StripTextures()
	BrowseScrollFrame:StripTextures()
	AuctionsScrollFrame:StripTextures()
	BidScrollFrame:StripTextures()

	T.SkinScrollBar(BrowseFilterScrollFrameScrollBar)
	T.SkinScrollBar(BrowseScrollFrameScrollBar)
	T.SkinScrollBar(AuctionsScrollFrameScrollBar)
	T.SkinScrollBar(BidScrollFrameScrollBar)

	T.SkinDropDownBox(BrowseDropDown)
	T.SkinDropDownBox(PriceDropDown)
	-- T.SkinDropDownBox(DurationDropDown, 80)

	T.SkinCheckBox(IsUsableCheckButton)
	T.SkinCheckBox(ShowOnPlayerCheckButton)
	-- T.SkinCheckBox(ExactMatchCheckButton)

	-- Dress Up Frame
	AuctionFrame:HookScript("OnShow", function()
		SideDressUpFrame:StripTextures()
		SideDressUpFrame:SetTemplate("Transparent")
		SideDressUpFrameBackgroundTop:Kill()
		SideDressUpFrameBackgroundBot:Kill()

		SideDressUpFrame:ClearAllPoints()
		SideDressUpFrame:SetPoint("TOPLEFT", AuctionFrame, "TOPRIGHT", 3, 0)

		SideDressUpModelResetButton:SkinButton()
		T.SkinCloseButton(SideDressUpModelCloseButton)
		SideDressUpModelCloseButton:SetPoint("TOPRIGHT", 6, 8)
	end)

	-- WoW Token
	-- WowTokenGameTimeTutorial.NineSlice:Hide()
	WowTokenGameTimeTutorial.TitleBg:Hide()
	WowTokenGameTimeTutorial:CreateBackdrop("Transparent")
	-- WowTokenGameTimeTutorialInset.NineSlice:Hide()
	WowTokenGameTimeTutorialBg:Hide()
	StoreButton:SkinButton()
	T.SkinCloseButton(WowTokenGameTimeTutorial.CloseButton)

	BrowseWowTokenResults.Buyout:SkinButton(true)
	local Token = BrowseWowTokenResultsToken
	Token.ItemBorder:Hide()
	Token.IconBorder:Hide()
	Token.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Token:CreateBackdrop("Default")
	Token.backdrop:SetPoint("TOPLEFT", Token.IconBorder, -2, 2)
	Token.backdrop:SetPoint("BOTTOMRIGHT", Token.IconBorder, 2, -2)

	-- Progress Frame
	AuctionProgressFrame:StripTextures()
	AuctionProgressFrame:SetTemplate("Transparent")
	AuctionProgressFrameCancelButton:StyleButton()
	AuctionProgressFrameCancelButton:SetTemplate("Default")
	AuctionProgressFrameCancelButton:SetHitRectInsets(0, 0, 0, 0)
	AuctionProgressFrameCancelButton:GetNormalTexture():ClearAllPoints()
	AuctionProgressFrameCancelButton:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	AuctionProgressFrameCancelButton:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
	AuctionProgressFrameCancelButton:GetNormalTexture():SetTexCoord(0.67, 0.37, 0.61, 0.26)
	AuctionProgressFrameCancelButton:SetSize(28, 28)
	AuctionProgressFrameCancelButton:SetPoint("LEFT", AuctionProgressBar, "RIGHT", 8, 0)

	AuctionProgressBar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	local backdrop = CreateFrame("Frame", nil, AuctionProgressBar.Icon:GetParent())
	backdrop:SetPoint("TOPLEFT", AuctionProgressBar.Icon, "TOPLEFT", -2, 2)
	backdrop:SetPoint("BOTTOMRIGHT", AuctionProgressBar.Icon, "BOTTOMRIGHT", 2, -2)
	backdrop:SetTemplate("Default")
	AuctionProgressBar.Icon:SetParent(backdrop)

	AuctionProgressBar.Text:ClearAllPoints()
	AuctionProgressBar.Text:SetPoint("CENTER")

	AuctionProgressBar:StripTextures()
	AuctionProgressBar:CreateBackdrop("Default")
	AuctionProgressBar:SetStatusBarTexture(C.media.texture)
	AuctionProgressBar:SetStatusBarColor(1, 1, 0)

	T.SkinNextPrevButton(BrowseNextPageButton)
	T.SkinNextPrevButton(BrowsePrevPageButton)

	local buttons = {
		"BrowseBidButton",
		"BidBidButton",
		"BrowseBuyoutButton",
		"BidBuyoutButton",
		"BrowseCloseButton",
		"BidCloseButton",
		"BrowseSearchButton",
		"AuctionsCreateAuctionButton",
		"AuctionsCancelAuctionButton",
		"AuctionsCloseButton",
		-- "BrowseResetButton",
		"AuctionsStackSizeMaxButton",
		"AuctionsNumStacksMaxButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton(true)
	end

	-- Fix Button Positions
	AuctionsCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameAuctions, "BOTTOMRIGHT", 66, 10)
	AuctionsCancelAuctionButton:SetPoint("RIGHT", AuctionsCloseButton, "LEFT", -4, 0)
	BidCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameBid, "BOTTOMRIGHT", 66, 10)
	BidBuyoutButton:SetPoint("RIGHT", BidCloseButton, "LEFT", -4, 0)
	BidBidButton:SetPoint("RIGHT", BidBuyoutButton, "LEFT", -4, 0)
	BrowseCloseButton:SetPoint("BOTTOMRIGHT", AuctionFrameBrowse, "BOTTOMRIGHT", 66, 10)
	BrowseBuyoutButton:SetPoint("RIGHT", BrowseCloseButton, "LEFT", -4, 0)
	BrowseBidButton:SetPoint("RIGHT", BrowseBuyoutButton, "LEFT", -4, 0)
	BrowseSearchButton:ClearAllPoints()
	BrowseSearchButton:SetPoint("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 52, -28)
	BrowseSearchButton:SetWidth(130)
	-- BrowseResetButton:ClearAllPoints()
	-- BrowseResetButton:SetPoint("BOTTOMLEFT", BrowseSearchButton, "TOPLEFT", 0, 3)
	-- BrowseResetButton:SetWidth(80)

	AuctionsItemButton:StripTextures()
	AuctionsItemButton:StyleButton(true)
	AuctionsItemButton:SetTemplate("Default")
	AuctionsItemButton.IconBorder:Kill()

	AuctionsItemButton:HookScript("OnEvent", function(self, event, ...)
		if event == "NEW_AUCTION_UPDATE" and self:GetNormalTexture() then
			self:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self:GetNormalTexture():ClearAllPoints()
			self:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			self:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end)

	local sorttabs = {
		"BrowseQualitySort",
		"BrowseLevelSort",
		"BrowseDurationSort",
		"BrowseHighBidderSort",
		"BrowseCurrentBidSort",
		"BidQualitySort",
		"BidLevelSort",
		"BidDurationSort",
		"BidBuyoutSort",
		"BidStatusSort",
		"BidBidSort",
		"AuctionsQualitySort",
		"AuctionsDurationSort",
		"AuctionsHighBidderSort",
		"AuctionsBidSort"
	}

	for _, sorttab in pairs(sorttabs) do
		_G[sorttab.."Left"]:Kill()
		_G[sorttab.."Middle"]:Kill()
		_G[sorttab.."Right"]:Kill()
	end

	for i = 1, AuctionFrame.numTabs do
		T.SkinTab(_G["AuctionFrameTab"..i])
	end

	for i = 1, NUM_FILTERS_TO_DISPLAY do
		local tab = _G["AuctionFilterButton"..i]
		tab:StyleButton()
		_G["AuctionFilterButton"..i.."NormalTexture"]:SetAlpha(0)
		_G["AuctionFilterButton"..i.."NormalTexture"].SetAlpha = T.dummy
	end

	local editboxes = {
		"BrowseName",
		"BrowseMinLevel",
		"BrowseMaxLevel",
		"BrowseBidPriceGold",
		"BrowseBidPriceSilver",
		"BrowseBidPriceCopper",
		"BidBidPriceGold",
		"BidBidPriceSilver",
		"BidBidPriceCopper",
		"AuctionsStackSizeEntry",
		"AuctionsNumStacksEntry",
		"StartPriceGold",
		"StartPriceSilver",
		"StartPriceCopper",
		"BuyoutPriceGold",
		"BuyoutPriceSilver",
		"BuyoutPriceCopper"
	}

	for _, editbox in pairs(editboxes) do
		T.SkinEditBox(_G[editbox])
		_G[editbox]:SetTextInsets(1, 1, -1, 1)
		if editbox ~= "BrowseName" then
			_G[editbox]:SetWidth(_G[editbox]:GetWidth() + 4)
		else
			_G[editbox]:SetWidth(_G[editbox]:GetWidth() + 19)
		end
	end
	_G["BrowseName"]:SetTextInsets(15, 15, -1, 1)
	_G["BrowseNameText"]:ClearAllPoints()
	_G["BrowseNameText"]:SetPoint("TOPLEFT", _G["AuctionFrameBrowse"], "TOPLEFT", 19, -38)
	_G["BrowseLevelHyphen"]:SetPoint("LEFT", _G["BrowseMinLevel"], "RIGHT", 6, 0)
	_G["BrowseMaxLevel"]:SetPoint("LEFT", _G["BrowseLevelHyphen"], "RIGHT", 2, 0)
	if T.client == "zhCN" or T.client == "zhTW" then
		_G["BrowseMinLevel"]:ClearAllPoints()
		_G["BrowseMinLevel"]:SetPoint("LEFT", _G["BrowseName"], "RIGHT", 42, 0)
		_G["BrowseLevelText"]:ClearAllPoints()
		_G["BrowseLevelText"]:SetPoint("TOPLEFT", _G["BrowseMinLevel"], "TOPLEFT", -2, 16)
		_G["BrowseDropDown"]:ClearAllPoints()
		_G["BrowseDropDown"]:SetPoint("LEFT", _G["BrowseMaxLevel"], "RIGHT", 4, -4)
		_G["BrowseDropDownName"]:ClearAllPoints()
		_G["BrowseDropDownName"]:SetPoint("TOPLEFT", _G["BrowseDropDown"], "TOPLEFT", 20, 12)
		_G["ShowOnPlayerCheckButton"]:ClearAllPoints()
		_G["ShowOnPlayerCheckButton"]:SetPoint("BOTTOMRIGHT", _G["BrowseSearchButton"], "BOTTOMRIGHT", 4, -26)
		_G["BrowseShowOnCharacterText"]:ClearAllPoints()
		_G["BrowseShowOnCharacterText"]:SetPoint("RIGHT", _G["ShowOnPlayerCheckButton"], "LEFT", -8, 0)
	end
	AuctionsStackSizeEntry.backdrop:SetAllPoints()
	AuctionsNumStacksEntry.backdrop:SetAllPoints()

	BrowseBidPriceGold.texture:SetDrawLayer("ARTWORK")
	BidBidPriceGold.texture:SetDrawLayer("ARTWORK")
	StartPriceGold.texture:SetDrawLayer("ARTWORK")
	BuyoutPriceGold.texture:SetDrawLayer("ARTWORK")

	for i = 1, NUM_BROWSE_TO_DISPLAY do
		local button = _G["BrowseButton"..i]
		local icon = _G["BrowseButton"..i.."Item"]

		if _G["BrowseButton"..i.."ItemIconTexture"] then
			_G["BrowseButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["BrowseButton"..i.."ItemIconTexture"]:ClearAllPoints()
			_G["BrowseButton"..i.."ItemIconTexture"]:SetPoint("TOPLEFT", 2, -2)
			_G["BrowseButton"..i.."ItemIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)
		end

		if icon then
			icon:StripTextures()
			icon:StyleButton()
			icon:CreateBackdrop("Default")
			icon.backdrop:SetAllPoints()
			icon.IconBorder:Kill()
		end

		if button then
			button:StripTextures()
			button:StyleButton()
			_G["BrowseButton"..i.."Highlight"] = button:GetHighlightTexture()
			button:GetHighlightTexture():ClearAllPoints()
			button:GetHighlightTexture():SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
			button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
		end
	end

	for i = 1, NUM_AUCTIONS_TO_DISPLAY do
		local button = _G["AuctionsButton"..i]
		local icon = _G["AuctionsButton"..i.."Item"]

		_G["AuctionsButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["AuctionsButton"..i.."ItemIconTexture"]:ClearAllPoints()
		_G["AuctionsButton"..i.."ItemIconTexture"]:SetPoint("TOPLEFT", 2, -2)
		_G["AuctionsButton"..i.."ItemIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)

		icon:StripTextures()
		icon:StyleButton()
		icon:CreateBackdrop("Default")
		icon.backdrop:SetAllPoints()
		icon.IconBorder:Kill()

		button:StripTextures()
		button:StyleButton()
		_G["AuctionsButton"..i.."Highlight"] = button:GetHighlightTexture()
		button:GetHighlightTexture():ClearAllPoints()
		button:GetHighlightTexture():SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
		button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
		button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
	end

	for i = 1, NUM_BIDS_TO_DISPLAY do
		local button = _G["BidButton"..i]
		local icon = _G["BidButton"..i.."Item"]

		_G["BidButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["BidButton"..i.."ItemIconTexture"]:ClearAllPoints()
		_G["BidButton"..i.."ItemIconTexture"]:SetPoint("TOPLEFT", 2, -2)
		_G["BidButton"..i.."ItemIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)

		icon:StripTextures()
		icon:StyleButton()
		icon:CreateBackdrop("Default")
		icon.backdrop:SetAllPoints()
		icon.IconBorder:Kill()

		button:StripTextures()
		button:StyleButton()
		_G["BidButton"..i.."Highlight"] = button:GetHighlightTexture()
		button:GetHighlightTexture():ClearAllPoints()
		button:GetHighlightTexture():SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
		button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
		button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
	end

	-- Custom Backdrops
	AuctionFrameBrowse.bg1 = CreateFrame("Frame", nil, AuctionFrameBrowse)
	AuctionFrameBrowse.bg1:SetTemplate("Overlay")
	AuctionFrameBrowse.bg1:SetPoint("TOPLEFT", 20, -103)
	AuctionFrameBrowse.bg1:SetPoint("BOTTOMRIGHT", -575, 40)
	BrowseFilterScrollFrame:SetHeight(300)

	AuctionFrameBrowse.bg2 = CreateFrame("Frame", nil, AuctionFrameBrowse)
	AuctionFrameBrowse.bg2:SetTemplate("Overlay")
	AuctionFrameBrowse.bg2:SetPoint("TOPLEFT", AuctionFrameBrowse.bg1, "TOPRIGHT", 4, 0)
	AuctionFrameBrowse.bg2:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", -8, 40)
	AuctionFrameBrowse.bg2:SetFrameLevel(AuctionFrameBrowse.bg2:GetFrameLevel() - 2)
	BrowseScrollFrame:SetHeight(300)

	AuctionFrameBid.bg = CreateFrame("Frame", nil, AuctionFrameBid)
	AuctionFrameBid.bg:SetTemplate("Overlay")
	AuctionFrameBid.bg:SetPoint("TOPLEFT", 22, -72)
	AuctionFrameBid.bg:SetPoint("BOTTOMRIGHT", 66, 40)
	AuctionFrameBid.bg:SetFrameLevel(AuctionFrameBid.bg:GetFrameLevel() - 2)
	BidScrollFrame:SetHeight(332)

	AuctionsScrollFrame:SetHeight(336)
	AuctionFrameAuctions.bg1 = CreateFrame("Frame", nil, AuctionFrameAuctions)
	AuctionFrameAuctions.bg1:SetTemplate("Overlay")
	AuctionFrameAuctions.bg1:SetPoint("TOPLEFT", 15, -70)
	AuctionFrameAuctions.bg1:SetPoint("BOTTOMRIGHT", -545, 35)
	AuctionFrameAuctions.bg1:SetFrameLevel(AuctionFrameAuctions.bg1:GetFrameLevel() - 2)

	AuctionFrameAuctions.bg2 = CreateFrame("Frame", nil, AuctionFrameAuctions)
	AuctionFrameAuctions.bg2:SetTemplate("Overlay")
	AuctionFrameAuctions.bg2:SetPoint("TOPLEFT", AuctionFrameAuctions.bg1, "TOPRIGHT", 3, 0)
	AuctionFrameAuctions.bg2:SetPoint("BOTTOMRIGHT", AuctionFrame, -8, 35)
	AuctionFrameAuctions.bg2:SetFrameLevel(AuctionFrameAuctions.bg2:GetFrameLevel() - 2)
end

T.SkinFuncs["Blizzard_AuctionUI"] = LoadSkin
