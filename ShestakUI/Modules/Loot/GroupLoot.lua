local T, C, L = unpack(ShestakUI)
if C.loot.rolllootframe ~= true then return end

----------------------------------------------------------------------------------------
--	Based on teksLoot(by Tekkub)
----------------------------------------------------------------------------------------
local pos = "TOP"
local frames = {}
local cancelled_rolls = {}
local rolltypes = {[1] = "need", [2] = "greed", [3] = "disenchant", [4] = "transmog", [0] = "pass"}

local LootRollAnchor = CreateFrame("Frame", "LootRollAnchor", UIParent)
LootRollAnchor:SetSize(313, 26)

local function ClickRoll(frame)
	if T.Mainline and not frame.parent.rollID then return end
	RollOnLoot(frame.parent.rollID, frame.rolltype)
end

local function HideTip() GameTooltip:Hide() end
local function HideTip2() GameTooltip:Hide() ResetCursor() end

local function SetTip(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
	GameTooltip:SetText(frame.tiptext)
	if not frame:IsEnabled() then
		GameTooltip:AddLine(frame.errtext, 1, 0.2, 0.2, 1)
	end
	for name, roll in pairs(frame.parent.rolls) do if roll == rolltypes[frame.rolltype] then GameTooltip:AddLine(name, 1, 1, 1) end end
	GameTooltip:Show()
end

local function SetItemTip(frame)
	if not frame.link then return end
	GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
	GameTooltip:SetHyperlink(frame.link)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	if IsModifiedClick("DRESSUP") then ShowInspectCursor() else ResetCursor() end
end

local function ItemOnUpdate(frame)
	if GameTooltip:IsOwned(frame) then
		if IsShiftKeyDown() then
			GameTooltip_ShowCompareItem()
		else
			ShoppingTooltip1:Hide()
			ShoppingTooltip2:Hide()
		end

		if IsControlKeyDown() then
			ShowInspectCursor()
		else
			ResetCursor()
		end
	end
end

local function LootClick(frame)
	if IsControlKeyDown() then
		DressUpItemLink(frame.link)
	elseif IsShiftKeyDown() then
		local _, item = GetItemInfo(frame.link)
		if ChatEdit_GetActiveWindow() then
			ChatEdit_InsertLink(item)
		else
			ChatFrame_OpenChat(item)
		end
	end
end

local function OnEvent(frame, event, rollID)
	if event == "CANCEL_ALL_LOOT_ROLLS" then
		frame.rollID = nil
		frame.time = nil
		frame:Hide()
	else
		cancelled_rolls[rollID] = true
		if frame.rollID ~= rollID then return end

		frame.rollID = nil
		frame.time = nil
		frame:Hide()
	end
end

local function StatusUpdate(frame)
	if not frame.parent.rollID then return end
	local t = GetLootRollTimeLeft(frame.parent.rollID)
	frame:SetValue(t)
end

local textpos = {
	[1] = {0, 1},	-- need
	[2] = {1, 2},	-- greed
	-- [4] = {2, 0},	-- transmog
	-- [3] = {1, 2},	-- disenchant
	[0] = {1, -1},	-- pass
}

local function CreateRollButton(parent, ntex, ptex, htex, rolltype, tiptext, ...)
	local f = CreateFrame("Button", nil, parent)
	f:SetPoint(...)
	f:SetSize(24, 24)
	f:SetNormalTexture(ntex)
	if ptex then f:SetPushedTexture(ptex) end
	f:SetHighlightTexture(htex)
	f.rolltype = rolltype
	f.parent = parent
	f.tiptext = tiptext
	f:SetScript("OnEnter", SetTip)
	f:SetScript("OnLeave", HideTip)
	f:SetScript("OnClick", ClickRoll)
	f:SetMotionScriptsWhileDisabled(true)

	local txt

	if T.Classic then
		txt = f:CreateFontString(nil, nil)
		txt:SetFont(C.font.loot_font, C.font.loot_font_size, C.font.loot_font_style)
		txt:SetShadowOffset(C.font.loot_font_shadow and 1 or 0, C.font.loot_font_shadow and -1 or 0)
		txt:SetPoint("CENTER", textpos[rolltype][1] or 0, textpos[rolltype][2] or 0)
	end

	return f, txt
end

local function CreateRollFrame()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:CreateBackdrop("Default")
	frame:SetSize(280, 22)
	frame:SetFrameStrata("MEDIUM")
	frame:SetFrameLevel(10)
	frame:SetScript("OnEvent", OnEvent)
	frame:RegisterEvent("CANCEL_LOOT_ROLL")
	frame:RegisterEvent("CANCEL_ALL_LOOT_ROLLS")
	frame:RegisterEvent("MAIN_SPEC_NEED_ROLL")
	frame:Hide()

	local button = CreateFrame("Button", nil, frame)
	button:SetPoint("LEFT", -29, 0)
	button:SetSize(22, 22)
	button:CreateBackdrop("Default")
	button:SetScript("OnEnter", SetItemTip)
	button:SetScript("OnLeave", HideTip2)
	button:SetScript("OnUpdate", ItemOnUpdate)
	button:SetScript("OnClick", LootClick)
	frame.button = button

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetAllPoints()
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	local status = CreateFrame("StatusBar", nil, frame)
	status:SetSize(326, 20)
	status:SetPoint("TOPLEFT", 0, 0)
	status:SetPoint("BOTTOMRIGHT", 0, 0)
	status:SetScript("OnUpdate", StatusUpdate)
	status:SetFrameLevel(status:GetFrameLevel() - 1)
	status:SetStatusBarTexture(C.media.texture)
	status:SetStatusBarColor(0.8, 0.8, 0.8, 0.9)
	status.parent = frame
	frame.status = status

	status.bg = status:CreateTexture(nil, "BACKGROUND")
	status.bg:SetAlpha(0.1)
	status.bg:SetAllPoints()
	status.bg:SetDrawLayer("BACKGROUND", 2)

	local need, needText, greed, greedText, transmog, transmogText, de, deText, pass, passText

	if T.Classic then
		need, needText = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Dice-Up", "Interface\\Buttons\\UI-GroupLoot-Dice-Highlight", "Interface\\Buttons\\UI-GroupLoot-Dice-Down", 1, NEED, "LEFT", frame.button, "RIGHT", 7, -1.2)
		greed, greedText = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Coin-Up", "Interface\\Buttons\\UI-GroupLoot-Coin-Highlight", "Interface\\Buttons\\UI-GroupLoot-Coin-Down", 2, GREED, "LEFT", need, "RIGHT", 0, -1)
		pass, passText = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Pass-Up", nil, "Interface\\Buttons\\UI-GroupLoot-Pass-Down", 0, PASS, "LEFT", greed, "RIGHT", 0, 3)
	else
		need, needText = CreateRollButton(frame, "lootroll-toast-icon-need-up", "lootroll-toast-icon-need-highlight", "lootroll-toast-icon-need-down", 1, NEED, "LEFT", frame.button, "RIGHT", 8, -1)
		greed, greedText = CreateRollButton(frame, "lootroll-toast-icon-greed-up", "lootroll-toast-icon-greed-highlight", "lootroll-toast-icon-greed-down", 2, GREED, "LEFT", need, "RIGHT", 0, 1)
		transmog, transmogText = CreateRollButton(frame, "lootroll-toast-icon-transmog-up", "lootroll-toast-icon-transmog-highlight", "lootroll-toast-icon-transmog-down", 4, TRANSMOGRIFY, "LEFT", need, "RIGHT", -1, 1)
		de, deText = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-DE-Up", "Interface\\Buttons\\UI-GroupLoot-DE-Highlight", "Interface\\Buttons\\UI-GroupLoot-DE-Down", 3, ROLL_DISENCHANT, "LEFT", greed, "RIGHT", -2, -2)
		pass, passText = CreateRollButton(frame, "lootroll-toast-icon-pass-up", "lootroll-toast-icon-pass-highlight", "lootroll-toast-icon-pass-down", 0, PASS, "LEFT", de or greed, "RIGHT", 0, 2.2)
	end

	frame.need, frame.greed, frame.disenchant, frame.transmog = need, greed, de, transmog
	frame.needText, frame.greedText, frame.passText, frame.disenchantText, frame.transmogText = needText, greedText, passText, deText, transmogText

	local bind = frame:CreateFontString()
	bind:SetPoint("LEFT", pass, "RIGHT", 3, -1)
	bind:SetFont(C.font.loot_font, C.font.loot_font_size, C.font.loot_font_style)
	bind:SetShadowOffset(C.font.loot_font_shadow and 1 or 0, C.font.loot_font_shadow and -1 or 0)
	frame.fsbind = bind

	local loot = frame:CreateFontString(nil, "ARTWORK")
	loot:SetFont(C.font.loot_font, C.font.loot_font_size, C.font.loot_font_style)
	loot:SetShadowOffset(C.font.loot_font_shadow and 1 or 0, C.font.loot_font_shadow and -1 or 0)
	loot:SetPoint("LEFT", bind, "RIGHT", 5, 0)
	loot:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
	loot:SetSize(200, 10)
	loot:SetJustifyH("LEFT")
	frame.fsloot = loot

	frame.rolls = {}

	return frame
end

local function GetFrame()
	for _, f in ipairs(frames) do
		if not f.rollID then return f end
	end

	local f = CreateRollFrame()
	if pos == "TOP" then
		if next(frames) then
			f:SetPoint("TOPRIGHT", frames[#frames], "BOTTOMRIGHT", 0, -7)
		else
			f:SetPoint("TOPRIGHT", LootRollAnchor, "TOPRIGHT", -2, -2)
		end
	else
		if next(frames) then
			f:SetPoint("BOTTOMRIGHT", frames[#frames], "TOPRIGHT", 0, 7)
		else
			f:SetPoint("TOPRIGHT", LootRollAnchor, "TOPRIGHT", -2, -2)
		end
	end
	table.insert(frames, f)
	return f
end

local function FindFrame(rollID)
	for _, f in ipairs(frames) do
		if f.rollID == rollID then return f end
	end
end

local typemap = {[0] = "pass", "need", "greed", "disenchant"}
local function UpdateRoll(i, rolltype)
	local num = 0
	local rollID, _, numPlayers, isDone = C_LootHistory.GetItem(i)

	if isDone or not numPlayers then return end

	local f = FindFrame(rollID)
	if not f then return end

	for j = 1, numPlayers do
		local name, _, thisrolltype = C_LootHistory.GetPlayerInfo(i, j)
		f.rolls[name] = typemap[thisrolltype]
		if rolltype == thisrolltype then num = num + 1 end
	end

	f[typemap[rolltype]]:SetText(num)
end

local function START_LOOT_ROLL(rollID, time)
	if cancelled_rolls[rollID] then return end

	local f = GetFrame()
	f.rollID = rollID
	f.time = time
	for i in pairs(f.rolls) do f.rolls[i] = nil end
	if T.Classic then
		f.needText:SetText(0)
		f.greedText:SetText(0)
		-- f.transmogText:SetText(0)
		-- f.disenchantText:SetText(0)
		f.passText:SetText(0)
	end

	local texture, name, _, quality, bop, canNeed, canGreed, canDisenchant, reasonNeed, reasonGreed, reasonDisenchant, deSkillRequired, canTransmog = GetLootRollItemInfo(rollID)
	f.button.icon:SetTexture(texture)
	f.button.link = GetLootRollItemLink(rollID)

	if C.loot.auto_greed and T.level == MAX_PLAYER_LEVEL and quality == 2 and not bop then return end

	if canNeed then
		f.need:Enable()
		f.need:SetAlpha(1)
		if T.Classic then
			f.needText:SetAlpha(1)
		end
		SetDesaturation(f.need:GetNormalTexture(), false)
	else
		f.need:Disable()
		f.need:SetAlpha(0.2)
		if T.Classic then
			f.needText:SetAlpha(0)
		end
		SetDesaturation(f.need:GetNormalTexture(), true)
		f.need.errtext = _G["LOOT_ROLL_INELIGIBLE_REASON"..reasonNeed]
	end

	if canTransmog and T.Mainline then
		f.transmog:Show()
		f.greed:Hide()
	else
		if T.Mainline then
			f.transmog:Hide()
		end
		f.greed:Show()
		if canGreed then
			f.greed:Enable()
			f.greed:SetAlpha(1)
			if T.Classic then
				f.greedText:SetAlpha(1)
			end
			SetDesaturation(f.greed:GetNormalTexture(), false)
		else
			f.greed:Disable()
			f.greed:SetAlpha(0.2)
			if T.Classic then
				f.greedText:SetAlpha(0)
			end
			SetDesaturation(f.greed:GetNormalTexture(), true)
			f.greed.errtext = _G["LOOT_ROLL_INELIGIBLE_REASON"..reasonGreed]
		end
	end

	if T.Mainline then
		if canDisenchant then
			f.disenchant:Enable()
			f.disenchant:SetAlpha(1)
			-- f.disenchantText:SetAlpha(1)
			SetDesaturation(f.disenchant:GetNormalTexture(), false)
		else
			f.disenchant:Disable()
			f.disenchant:SetAlpha(0.2)
			-- f.disenchantText:SetAlpha(0)
			SetDesaturation(f.disenchant:GetNormalTexture(), true)
			f.disenchant.errtext = format(_G["LOOT_ROLL_INELIGIBLE_REASON"..reasonDisenchant], deSkillRequired)
		end
	end

	f.fsbind:SetText(bop and "BoP" or "BoE")
	f.fsbind:SetVertexColor(bop and 1 or 0.3, bop and 0.3 or 1, bop and 0.1 or 0.3)

	local color = ITEM_QUALITY_COLORS[quality]
	f.fsloot:SetText(name)
	f.fsloot:SetVertexColor(color.r, color.g, color.b)

	f.status:SetStatusBarColor(color.r, color.g, color.b, 0.7)
	f.status.bg:SetColorTexture(color.r, color.g, color.b)

	f.backdrop:SetBackdropBorderColor(color.r, color.g, color.b, 0.7)
	f.button.backdrop:SetBackdropBorderColor(color.r, color.g, color.b, 0.7)

	f.status:SetMinMaxValues(0, time)
	f.status:SetValue(time)

	if T.Classic then
		f:SetPoint("CENTER", UIParent, "CENTER")
	end
	f:Show()
end

local function LOOT_HISTORY_ROLL_CHANGED(rollindex, playerindex)
	local _, _, rolltype = C_LootHistory.GetPlayerInfo(rollindex, playerindex)
	UpdateRoll(rollindex, rolltype)
end

LootRollAnchor:RegisterEvent("ADDON_LOADED")
LootRollAnchor:SetScript("OnEvent", function(_, _, addon)
	if addon ~= "ShestakUI" then return end

	LootRollAnchor:UnregisterEvent("ADDON_LOADED")
	LootRollAnchor:RegisterEvent("START_LOOT_ROLL")
	if T.Classic then
		LootRollAnchor:RegisterEvent("LOOT_HISTORY_ROLL_CHANGED")
	end

	UIParent:UnregisterEvent("START_LOOT_ROLL")
	UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")

	LootRollAnchor:SetScript("OnEvent", function(_, event, ...)
		if event == "LOOT_HISTORY_ROLL_CHANGED" and T.Classic then
			return LOOT_HISTORY_ROLL_CHANGED(...)
		else
			return START_LOOT_ROLL(...)
		end
	end)

	if C.unitframe.enable and _G.oUF_Player then
		LootRollAnchor:SetPoint(unpack(C.position.group_loot))
	else
		LootRollAnchor:SetPoint("BOTTOM", UIParent, "BOTTOM", -238, 470)
	end
end)

local function testRoll(f)
	local items = T.Classic and {19019, 22811, 20530, 19972} or {32837, 34196, 33820, 84004}
	local item = items[math.random(1, #items)]
	local name, _, quality, _, _, _, _, _, _, texture = GetItemInfo(item)
	local r, g, b = GetItemQualityColor(quality or 1)

	f.button.icon:SetTexture(texture)
	f.button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	f.fsloot:SetText(name)
	f.fsloot:SetVertexColor(r, g, b)

	f.status:SetMinMaxValues(0, 100)
	f.status:SetValue(math.random(50, 90))
	f.status:SetStatusBarColor(r, g, b, 0.7)
	f.status.bg:SetColorTexture(r, g, b)

	f.backdrop:SetBackdropBorderColor(r, g, b, 0.7)
	f.button.backdrop:SetBackdropBorderColor(r, g, b, 0.7)

	if T.Classic then
		f.needText:SetText(1)
		f.greedText:SetText(2)
		-- f.transmogText:SetText(2)
		-- f.disenchantText:SetText(0)
		f.passText:SetText(0)
	end

	f.button.link = "item:"..item..":0:0:0:0:0:0:0"
	if T.Mainline then
		local greed = math.random(0, 1)
		if greed == 0 then
			f.transmog:Show()
			f.greed:Hide()
		else
			f.transmog:Hide()
			f.greed:Show()
		end
	end

	return name
end

SlashCmdList.TESTROLL = function()
	local f = GetFrame()
	if f:IsShown() then
		f:Hide()
	else
		if testRoll(f) then
			f:Show()
		else
			C_Timer.After(1, function()
				if not f:IsShown() and testRoll(f) then
					f:Show()
				end
			end)
		end
	end
end
SLASH_TESTROLL1 = "/testroll"
SLASH_TESTROLL2 = "/еуыекщдд"
