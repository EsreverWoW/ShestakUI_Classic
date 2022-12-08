local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Bank/Container skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag") then return end

	-- Container Frame
	for i = 1, NUM_CONTAINER_FRAMES do
		local frame = _G["ContainerFrame"..i]
		local close = _G["ContainerFrame"..i.."CloseButton"]

		frame:StripTextures(true)
		frame:CreateBackdrop("Transparent")
		frame.backdrop:SetPoint("TOPLEFT", 4, -2)
		frame.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)

		frame.PortraitButtonTexture = frame.PortraitButton:CreateTexture(nil, "OVERLAY")
		frame.PortraitButtonTexture:SetSize(30, 30)
		frame.PortraitButtonTexture:SetPoint("CENTER", 0, 0)
		frame.PortraitButtonTexture:SetTexture("Interface\\Icons\\inv_misc_bag_08")
		frame.PortraitButtonTexture:SkinIcon()

		T.SkinCloseButton(close, frame.backdrop)

		for j = 1, MAX_CONTAINER_ITEMS do
			local item = _G["ContainerFrame"..i.."Item"..j]
			local icon = _G["ContainerFrame"..i.."Item"..j.."IconTexture"]

			item:SetNormalTexture(0)
			item:StyleButton()
			item:SetTemplate("Default")

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	-- Bank Frame
	BankFrame:StripTextures(true)
	BankFrame:CreateBackdrop("Transparent")
	BankFrame.backdrop:SetAllPoints()

	BankFrameMoneyFrame:StripTextures()

	BankFramePurchaseButton:SkinButton()
	T.SkinCloseButton(BankCloseButton, BankFrame.backdrop)

	BankSlotsFrame:StripTextures()

	for i = 1, 24 do
		local item = _G["BankFrameItem"..i]
		local icon = _G["BankFrameItem"..i.."IconTexture"]

		item:SetNormalTexture(0)
		item:StyleButton()
		item:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	for i = 1, not T.Vanilla and 7 or 6 do
		local bag = BankSlotsFrame["Bag"..i]
		local icon = bag.icon

		bag.IconBorder:Kill()

		bag:StripTextures()
		bag:StyleButton()
		bag:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	-- Tabs
	for i = 1, 2 do
		T.SkinTab(_G["BankFrameTab"..i])
	end

	-- Frame Anchors
	hooksecurefunc("UpdateContainerFrameAnchors", function()
		local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column
		local screenWidth = GetScreenWidth()
		local containerScale = 1
		local leftLimit = 0

		if BankFrame:IsShown() then
			leftLimit = BankFrame:GetRight() - 25
		end

		while containerScale > CONTAINER_SCALE do
			screenHeight = GetScreenHeight() / containerScale
			xOffset = CONTAINER_OFFSET_X / containerScale
			yOffset = CONTAINER_OFFSET_Y / containerScale
			freeScreenHeight = screenHeight - yOffset
			leftMostPoint = screenWidth - xOffset
			column = 1
			local frameHeight
			for index, frameName in ipairs(ContainerFrame1.bags) do
				frameHeight = _G[frameName]:GetHeight()
				if freeScreenHeight < frameHeight then
					column = column + 1
					leftMostPoint = screenWidth - (column * CONTAINER_WIDTH * containerScale) - xOffset
					freeScreenHeight = screenHeight - yOffset
				end
				freeScreenHeight = freeScreenHeight - frameHeight - VISIBLE_CONTAINER_SPACING
			end
			if leftMostPoint < leftLimit then
				containerScale = containerScale - 0.01
			else
				break
			end
		end

		if containerScale < CONTAINER_SCALE then
			containerScale = CONTAINER_SCALE
		end

		screenHeight = GetScreenHeight() / containerScale
		xOffset = CONTAINER_OFFSET_X / containerScale
		yOffset = CONTAINER_OFFSET_Y / containerScale
		freeScreenHeight = screenHeight - yOffset
		column = 0

		local bagsPerColumn = 0
		for index, frameName in ipairs(ContainerFrame1.bags) do
			frame = _G[frameName]
			frame:SetScale(1)
			if index == 1 then
				frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 22)
				bagsPerColumn = bagsPerColumn + 1
			elseif freeScreenHeight < frame:GetHeight() then
				column = column + 1
				freeScreenHeight = screenHeight - yOffset
				if column > 1 then
					frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[(index - bagsPerColumn) - 1], "BOTTOMLEFT", -CONTAINER_SPACING, 0)
				else
					frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - bagsPerColumn], "BOTTOMLEFT", -CONTAINER_SPACING, 0)
				end
				bagsPerColumn = 0
			else
				frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, CONTAINER_SPACING)
				bagsPerColumn = bagsPerColumn + 1
			end
			freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
