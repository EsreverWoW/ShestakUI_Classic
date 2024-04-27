local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Gossip skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		GossipFrame,
		GossipFrame.GreetingPanel
	}

	for i = 1, #StripAllTextures do
		local button = StripAllTextures[i]
		button:StripTextures()
	end

	local KillTextures = {
		"GossipFramePortrait"
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		GossipFrame.GreetingPanel.GoodbyeButton
	}

	for i = 1, #buttons do
		buttons[i]:SkinButton(true)
	end

	local function ReplaceGossipFormat(button, textFormat, text)
		local newFormat, count = gsub(textFormat, "000000", "ffffff")
		if count > 0 then
			button:SetFormattedText(newFormat, text)
		end
	end

	local ReplacedGossipColor = {
		["000000"] = "ffffff",
		["414141"] = "7b8489",
	}

	local function ReplaceGossipText(button, text)
		if text and text ~= "" then
			local newText, count = gsub(text, ":32:32:0:0", ":32:32:0:0:64:64:5:59:5:59")
			if count > 0 then
				text = newText
				button:SetFormattedText("%s", text)
			end

			local colorStr, rawText = strmatch(text, "|c[fF][fF](%x%x%x%x%x%x)(.-)|r")
			colorStr = ReplacedGossipColor[colorStr]
			if colorStr and rawText then
				button:SetFormattedText("|cff%s%s|r", colorStr, rawText)
			end
		end
	end

	local function replaceTextColor(text, r)
		if r ~= 1 then
			text:SetTextColor(1, 1, 1)
		end
	end

	_G.QuestFont:SetTextColor(1, 1, 1)
	_G.QuestFont:SetShadowOffset(1, -1)

	GossipFrame:CreateBackdrop("Transparent")
	GossipFrame.backdrop:SetAllPoints()
	if T.Classic then
		GossipFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
		GossipFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 66)
	end
	GossipFrame:DisableDrawLayer("BACKGROUND")

	if T.Classic then
		T.SkinCloseButton(GossipFrame.CloseButton, GossipFrame.backdrop)
	else
		T.SkinCloseButton(GossipFrameCloseButton, GossipFrame.backdrop)
	end

	T.SkinScrollBar(GossipFrame.GreetingPanel.ScrollBar)

	if T.Mainline then
		GossipFrame.FriendshipStatusBar:StripTextures()
		GossipFrame.FriendshipStatusBar:SetStatusBarTexture(C.media.texture)
		GossipFrame.FriendshipStatusBar:CreateBackdrop("Overlay")
		GossipFrame.FriendshipStatusBar.icon:SetPoint("TOPLEFT", -30, 7)
	end

	-- Extreme hackage, blizzard makes button text on quest frame use hex color codes for some reason
	hooksecurefunc(GossipFrame.GreetingPanel.ScrollBox, "Update", function(frame)
		for _, button in next, {frame.ScrollTarget:GetChildren()} do
			if not button.IsSkinned then
				local buttonText = button.GreetingText or button.GetFontString and button:GetFontString()
				if buttonText then
					buttonText:SetTextColor(1, 1, 1)
					hooksecurefunc(buttonText, "SetTextColor", replaceTextColor)
				end

				local buttonText = button.GetFontString and button:GetFontString()
				if buttonText then
					ReplaceGossipText(button, button:GetText())
					hooksecurefunc(button, "SetText", ReplaceGossipText)
					hooksecurefunc(button, "SetFormattedText", ReplaceGossipFormat)
				end

				button.IsSkinned = true
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)
