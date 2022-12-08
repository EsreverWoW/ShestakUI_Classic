local T, C, L, _ = unpack(ShestakUI)
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Style ActionBars buttons(by Tukz)
----------------------------------------------------------------------------------------
local NUM_STANCE_SLOTS = NUM_STANCE_SLOTS or 10
local function StyleNormalButton(button, size)
	if not button.isSkinned then
		local name = button:GetName()
		local icon = _G[name.."Icon"]
		local count = _G[name.."Count"]
		local flash = _G[name.."Flash"]
		local hotkey = _G[name.."HotKey"]
		local border = button.Border or _G[name.."Border"]
		local btname = _G[name.."Name"]
		local normal = _G[name.."NormalTexture"]
		local float = _G[name.."FloatingBG"]
		local highlight = button.SpellHighlightTexture
		local isMultiCast = name:match("MultiCast")
		local isExtraAction = name:match("ExtraAction")
		local isFlyout = name:match("Flyout")
		local flyoutBorder = _G[name.."FlyoutBorder"]
		local flyoutBorderShadow = _G[name.."FlyoutBorderShadow"]
		local autocast = button.AutoCastable or _G[name.."AutoCastable"]
		local shine = _G[name.."Shine"]

		local normal = button.NormalTexture or _G[name.."NormalTexture"]
		local normal2 = button:GetNormalTexture()

		if button.IconMask then
			button.IconMask:Hide()
		end

		if button.SlotArt then
			button.SlotArt:SetAlpha(0)
		end

		if button.RightDivider then
			button.RightDivider:Kill()
		end

		if button.SlotBackground then
			button.SlotBackground:SetAlpha(0)
		end

		if button.NewActionTexture then
			button.NewActionTexture:SetAlpha(0)
		end

		if normal then
			normal:SetTexture()
			normal:Hide()
			normal:SetAlpha(0)
		end

		if normal2 then
			normal2:SetTexture()
			normal2:Hide()
			normal2:SetAlpha(0)
		end

		-- _G[button:GetName().."NormalTexture"]:SetAlpha(0)
		-- _G[button:GetName().."NormalTexture"]:Hide()
		-- button:GetNormalTexture():SetAlpha(0)
		-- button:GetNormalTexture():Hide()

		flash:SetTexture("")
		button:SetNormalTexture(0)

		if float then
			float:SetTexture("")
		end

		if border then
			border:Kill()
		end

		if not isMultiCast and not isExtraAction then
			count:ClearAllPoints()
			count:SetPoint("BOTTOMRIGHT", 0, 2)
			count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			count:SetHeight(C.font.action_bars_font_size)
		end

		if btname then
			if C.actionbar.macro == true then
				btname:ClearAllPoints()
				btname:SetPoint("BOTTOM", 0, 1)
				btname:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
				btname:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
				btname:SetWidth(C.actionbar.button_size - 1)
				btname:SetHeight(C.font.action_bars_font_size)
			else
				btname:Kill()
			end
		end

		if C.actionbar.hotkey == true then
			hotkey:ClearAllPoints()
			hotkey:SetPoint("TOPRIGHT", 0, -1)
			hotkey.SetPoint = T.dummy -- BETA It's bad way but work while I find better
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:SetWidth(C.actionbar.button_size - 1)
			hotkey:SetHeight(C.font.action_bars_font_size)
		else
			hotkey:Kill()
		end

		if not isFlyout and not isMultiCast and not isExtraAction then
			button:SetSize(size or C.actionbar.button_size, size or C.actionbar.button_size)
		end
		button:SetTemplate("Transparent")
		if C.actionbar.classcolor_border == true then
			button:SetBackdropBorderColor(unpack(C.media.classborder_color))
		end

		icon:CropIcon()
		icon:SetDrawLayer("BACKGROUND", 7)

		if normal then
			normal:ClearAllPoints()
			normal:SetPoint("TOPLEFT")
			normal:SetPoint("BOTTOMRIGHT")
		end

		if highlight then
			highlight:ClearAllPoints()
			highlight:SetPoint("TOPLEFT", -4, 4)
			highlight:SetPoint("BOTTOMRIGHT", 4, -4)
		end

		button.oborder:SetFrameLevel(button:GetFrameLevel())
		button.iborder:SetFrameLevel(button:GetFrameLevel())

		if button.QuickKeybindHighlightTexture then
			button.QuickKeybindHighlightTexture:SetTexture("")
		end

		if flyoutBorder then
			flyoutBorder:SetTexture("")
		end
		if flyoutBorderShadow then
			flyoutBorderShadow:SetTexture("")
		end

		if autocast then
			autocast:SetSize((C.actionbar.button_size * 2) - 10, (C.actionbar.button_size * 2) - 10)
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)
		end

		if shine then
			shine:SetSize(C.actionbar.button_size, C.actionbar.button_size)
		end

		button:StyleButton()

		button.isSkinned = true
	end
end

local function StyleSmallButton(normal, button, icon, name, pet)
	if not button.isSkinned then
		local flash = _G[name.."Flash"]
		local hotkey = _G[name.."HotKey"]

		button:SetNormalTexture(0)

		if button.IconMask then
			button.IconMask:Hide()
		end

		hooksecurefunc(button, "SetNormalTexture", function(self, texture)
			if texture and texture ~= "" then
				self:SetNormalTexture(0)
			end
		end)

		flash:SetColorTexture(0.8, 0.8, 0.8, 0.5)
		flash:SetPoint("TOPLEFT", button, 2, -2)
		flash:SetPoint("BOTTOMRIGHT", button, -2, 2)

		if C.actionbar.hotkey == true then
			hotkey:ClearAllPoints()
			hotkey:SetPoint("TOPRIGHT", 0, 0)
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:SetWidth(C.actionbar.button_size - 1)
		else
			hotkey:Kill()
		end

		button:SetSize(C.actionbar.button_size, C.actionbar.button_size)
		button:SetTemplate("Transparent")
		if C.actionbar.classcolor_border == true then
			button:SetBackdropBorderColor(unpack(C.media.classborder_color))
		end

		icon:CropIcon()
		icon:SetDrawLayer("BACKGROUND", 7)

		if pet then
			local autocast = button.AutoCastable or _G[name.."AutoCastable"]
			autocast:SetSize((C.actionbar.button_size * 2) - 10, (C.actionbar.button_size * 2) - 10)
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)

			local shine = _G[name.."Shine"]
			shine:SetSize(C.actionbar.button_size, C.actionbar.button_size)

			local cooldown = _G[name.."Cooldown"]
			cooldown:SetSize(C.actionbar.button_size - 2, C.actionbar.button_size - 2)
		end

		if normal then
			normal:ClearAllPoints()
			normal:SetPoint("TOPLEFT")
			normal:SetPoint("BOTTOMRIGHT")
		end

		if button.QuickKeybindHighlightTexture then
			button.QuickKeybindHighlightTexture:SetTexture("")
		end

		button:StyleButton()

		button.isSkinned = true
	end
end

function T.StyleShift()
	for i = 1, NUM_STANCE_SLOTS do
		local name = "StanceButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture"]
		StyleSmallButton(normal, button, icon, name)
	end
end

function T.StylePet()
	for i = 1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture2"]
		StyleSmallButton(normal, button, icon, name, true)
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	for i = 1, 12 do
		StyleNormalButton(_G["ActionButton"..i], C.actionbar.editor and C.actionbar.bar1_size)
		StyleNormalButton(_G["MultiBarBottomLeftButton"..i], C.actionbar.editor and C.actionbar.bar2_size)
		StyleNormalButton(_G["MultiBarLeftButton"..i], C.actionbar.editor and C.actionbar.bar3_size)
		StyleNormalButton(_G["MultiBarRightButton"..i], C.actionbar.editor and C.actionbar.bar4_size)
		StyleNormalButton(_G["MultiBarBottomRightButton"..i], C.actionbar.editor and C.actionbar.bar5_size)
		if T.Wrath then
			StyleNormalButton(_G["MultiCastActionButton"..i])
		end
	end

	if T.Mainline and C.actionbar.custom_bar_enable then
		for i = 1, 12 do
			StyleNormalButton(_G["CustomBarButton"..i], C.actionbar.custom_bar_size)
		end
	end

	if T.Mainline then
		StyleNormalButton(ExtraActionButton1)
	end
end)

local function SetupFlyoutButton(button, self)
	if button:GetHeight() ~= C.actionbar.button_size and not InCombatLockdown() then
		button:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	end

	if not button.IsSkinned then
		StyleNormalButton(button)

		if C.actionbar.rightbars_mouseover == true then
			SpellFlyout:HookScript("OnEnter", function() RightBarMouseOver(1) end)
			SpellFlyout:HookScript("OnLeave", function() RightBarMouseOver(0) end)
			button:HookScript("OnEnter", function() RightBarMouseOver(1) end)
			button:HookScript("OnLeave", function() RightBarMouseOver(0) end)
		end

		if C.actionbar.bottombars_mouseover == true then
			SpellFlyout:HookScript("OnEnter", function() BottomBarMouseOver(1) end)
			SpellFlyout:HookScript("OnLeave", function() BottomBarMouseOver(0) end)
			button:HookScript("OnEnter", function() BottomBarMouseOver(1) end)
			button:HookScript("OnLeave", function() BottomBarMouseOver(0) end)
		end
		button.IsSkinned = true
	end
end

local function StyleFlyoutButton(self)
	local button, i = _G["SpellFlyoutButton1"], 1
	while button do
		SetupFlyoutButton(button, self)

		i = i + 1
		button = _G["SpellFlyoutButton"..i]
	end
end

if T.Mainline then
	SpellFlyout:HookScript("OnShow", StyleFlyoutButton)
	--BETA hooksecurefunc("SpellButton_OnClick", StyleFlyoutButton)
	-- SpellFlyoutHorizontalBackground:SetAlpha(0)
	-- SpellFlyoutVerticalBackground:SetAlpha(0)
	-- SpellFlyoutBackgroundEnd:SetAlpha(0)
	SpellFlyout.Background:Hide()
end

if C.actionbar.hotkey == true then
	local gsub = string.gsub
	local function UpdateHotkey(self)
		local hotkey = _G[self:GetName().."HotKey"]
		local text = hotkey:GetText()
		if not text then return end

		text = gsub(text, "(s%-)", "S")
		text = gsub(text, "(a%-)", "A")
		text = gsub(text, "(а%-)", "A") -- fix ruRU
		text = gsub(text, "(c%-)", "C")
		text = gsub(text, "(Mouse Button )", "M")
		text = gsub(text, "(Кнопка мыши )", "M")
		text = gsub(text, KEY_BUTTON3, "M3")
		text = gsub(text, KEY_PAGEUP, "PU")
		text = gsub(text, KEY_PAGEDOWN, "PD")
		text = gsub(text, KEY_SPACE, "SpB")
		text = gsub(text, KEY_INSERT, "Ins")
		text = gsub(text, KEY_HOME, "Hm")
		text = gsub(text, KEY_DELETE, "Del")
		text = gsub(text, KEY_NUMPADDECIMAL, "Nu.")
		text = gsub(text, KEY_NUMPADDIVIDE, "Nu/")
		text = gsub(text, KEY_NUMPADMINUS, "Nu-")
		text = gsub(text, KEY_NUMPADMULTIPLY, "Nu*")
		text = gsub(text, KEY_NUMPADPLUS, "Nu+")
		text = gsub(text, KEY_NUMLOCK, "NuL")
		text = gsub(text, KEY_MOUSEWHEELDOWN, "MWD")
		text = gsub(text, KEY_MOUSEWHEELUP, "MWU")

		if hotkey:GetText() == _G["RANGE_INDICATOR"] then
			hotkey:SetText("")
		else
			hotkey:SetText(text)
		end
	end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("UPDATE_BINDINGS")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:SetScript("OnEvent", function()
		for i = 1, 12 do
			UpdateHotkey(_G["ActionButton"..i])
			UpdateHotkey(_G["MultiBarBottomLeftButton"..i])
			UpdateHotkey(_G["MultiBarBottomRightButton"..i])
			UpdateHotkey(_G["MultiBarLeftButton"..i])
			UpdateHotkey(_G["MultiBarRightButton"..i])
			if T.Wrath then
				UpdateHotkey(_G["MultiCastActionButton"..i])
			end
		end
		for i = 1, 10 do
			UpdateHotkey(_G["StanceButton"..i])
			UpdateHotkey(_G["PetActionButton"..i])
		end
		if T.Mainline then
			UpdateHotkey(ExtraActionButton1)
		end
	end)
end

if T.Mainline and C.actionbar.hide_highlight == true then
	local function HideHighlightButton(self)
		if self.overlay then
			self.overlay:Hide()
			ActionButton_HideOverlayGlow(self)
		end
	end

	hooksecurefunc("ActionButton_ShowOverlayGlow", HideHighlightButton)
end

----------------------------------------------------------------------------------------
--	TotemBar style
----------------------------------------------------------------------------------------
if not T.Wrath or T.class ~= "SHAMAN" then return end

local SLOT_EMPTY_TCOORDS = {
	[EARTH_TOTEM_SLOT] = {
		left = 66 / 128,
		right = 96 / 128,
		top = 3 / 256,
		bottom = 33 / 256,
	},
	[FIRE_TOTEM_SLOT] = {
		left = 67 / 128,
		right = 97 / 128,
		top = 100 / 256,
		bottom = 130 / 256,
	},
	[WATER_TOTEM_SLOT] = {
		left = 39 / 128,
		right = 69 / 128,
		top = 209 / 256,
		bottom = 239 / 256,
	},
	[AIR_TOTEM_SLOT] = {
		left = 66 / 128,
		right = 96 / 128,
		top = 36 / 256,
		bottom = 66 / 256,
	},
}

-- Totem Fly Out
local function StyleTotemFlyout(flyout)
	-- Remove blizzard flyout texture
	flyout.top:SetTexture(nil)
	flyout.middle:SetTexture(nil)

	-- Buttons
	local last = nil
	for _, button in ipairs(flyout.buttons) do
		button:SetTemplate("Default")
		local icon = select(1, button:GetRegions())
		if icon then
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("ARTWORK")
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		end
		if not InCombatLockdown() then
			button:SetSize(C.actionbar.button_size, C.actionbar.button_size)
			button:ClearAllPoints()
			button:SetPoint("BOTTOM", last, "TOP", 0, C.actionbar.button_space)
		end
		if button:IsVisible() then
			last = button
		end
		button:SetBackdropBorderColor(flyout.parent:GetBackdropBorderColor())
		button:StyleButton()
		if C.actionbar.stancebar_mouseover == true then
			button:HookScript("OnEnter", function() StanceBarMouseOver(1) end)
			button:HookScript("OnLeave", function() if not HoverBind.enabled then StanceBarMouseOver(0) end end)
		end
	end

	flyout.buttons[1]:SetPoint("BOTTOM", flyout, "BOTTOM", 0, 0)

	if flyout.type == "slot" then
		local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
		flyout.buttons[1].icon:SetTexCoord(tcoords.left, tcoords.right, tcoords.top, tcoords.bottom)
	end

	-- Close Button
	local close = MultiCastFlyoutFrameCloseButton
	close:SetTemplate("Default")
	close:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	close:GetHighlightTexture():SetPoint("TOPLEFT", close, "TOPLEFT", 2, -2)
	close:GetHighlightTexture():SetPoint("BOTTOMRIGHT", close, "BOTTOMRIGHT", -2, 2)
	close:GetNormalTexture():SetTexture(nil)
	close:ClearAllPoints()
	close:SetPoint("BOTTOMLEFT", last, "TOPLEFT", 0, C.actionbar.button_space)
	close:SetPoint("BOTTOMRIGHT", last, "TOPRIGHT", 0, C.actionbar.button_space)
	close:SetHeight(C.actionbar.button_space * 4)
	close:SetBackdropBorderColor(last:GetBackdropBorderColor())

	flyout:ClearAllPoints()
	flyout:SetPoint("BOTTOM", flyout.parent, "TOP", 0, C.actionbar.button_space)
end
hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout", function(self) StyleTotemFlyout(self) end)

-- Totem Fly Out Buttons
local function StyleTotemOpenButton(button, parent)
	button:GetHighlightTexture():SetTexture(nil)
	button:GetNormalTexture():SetTexture(nil)
	button:SetHeight(20)
	button:ClearAllPoints()
	button:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, -1)
	button:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, -1)
	if not button.visibleBut then
		button.visibleBut = CreateFrame("Frame", nil, button)
		button.visibleBut:SetHeight(C.actionbar.button_space * 4)
		button.visibleBut:SetWidth(button:GetWidth())
		button.visibleBut:SetPoint("CENTER")
		button.visibleBut.highlight = button.visibleBut:CreateTexture(nil, "HIGHLIGHT")
		button.visibleBut.highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
		button.visibleBut.highlight:SetPoint("TOPLEFT", button.visibleBut, "TOPLEFT", 1, -1)
		button.visibleBut.highlight:SetPoint("BOTTOMRIGHT", button.visibleBut, "BOTTOMRIGHT", -1, 1)
		button.visibleBut:SetTemplate("Default")
	end

	button.visibleBut:SetBackdropBorderColor(parent:GetBackdropBorderColor())
end
hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show", function(button, _, parent) StyleTotemOpenButton(button, parent) end)

-- Color for borders
local bordercolors = {
	{0.23, 0.45, 0.13},		-- Earth
	{0.58, 0.23, 0.10},		-- Fire
	{0.19, 0.48, 0.60},		-- Water
	{0.42, 0.18, 0.74},		-- Air
}

-- Totem Slot Buttons
local function StyleTotemSlotButton(button, index)
	button:SetTemplate("Default")
	button.overlayTex:SetTexture(nil)
	button.background:SetDrawLayer("ARTWORK")
	button.background:ClearAllPoints()
	button.background:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
	button.background:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)

	if not InCombatLockdown() then
		button:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	end

	button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	button:StyleButton()
end
hooksecurefunc("MultiCastSlotButton_Update", function(self, slot) StyleTotemSlotButton(self, tonumber(string.match(self:GetName(), "MultiCastSlotButton(%d)"))) end)

-- Skin the actual totem buttons
local function StyleTotemActionButton(button, index)
	local name = button:GetName()
	local icon = select(1, button:GetRegions())
	local hotkey = _G[name.."HotKey"]

	if C.actionbar.hotkey == true then
		hotkey:ClearAllPoints()
		hotkey:SetPoint("TOPRIGHT", 0, 0)
		hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
		hotkey:SetWidth(C.actionbar.button_size - 1)
	else
		hotkey:Kill()
	end

	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("ARTWORK")
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end

	button.overlayTex:SetTexture(nil)
	button.overlayTex:Hide()
	button:GetNormalTexture():SetTexCoord(0, 0, 0, 0)

	if not InCombatLockdown() and button.slotButton then
		button:ClearAllPoints()
		button:SetAllPoints(button.slotButton)
		button:SetFrameLevel(button.slotButton:GetFrameLevel() + 1)
	end

	button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	button:SetBackdropColor(0, 0, 0, 0)
	button:StyleButton(true)
end
hooksecurefunc("MultiCastActionButton_Update", function(actionButton, actionId, actionIndex, slot) StyleTotemActionButton(actionButton, actionIndex) end)

-- Summon and Recall Buttons
local function StyleTotemSpellButton(button, index)
	if not button then return end
	local name = button:GetName()
	local icon = select(1, button:GetRegions())
	local hotkey = _G[name.."HotKey"]

	if C.actionbar.hotkey == true then
		hotkey:ClearAllPoints()
		hotkey:SetPoint("TOPRIGHT", 0, 0)
		hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
		hotkey:SetWidth(C.actionbar.button_size - 1)
	else
		hotkey:Kill()
	end

	if icon then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("ARTWORK")
		icon:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end

	button:SetTemplate("Default")
	button:GetNormalTexture():SetTexture(nil)

	if not InCombatLockdown() then
		button:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	end

	_G[name.."Highlight"]:SetTexture(nil)
	_G[name.."NormalTexture"]:SetTexture(nil)
	button:StyleButton(true)
end
hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) StyleTotemSpellButton(self, 0) end)
hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) StyleTotemSpellButton(self, 5) end)