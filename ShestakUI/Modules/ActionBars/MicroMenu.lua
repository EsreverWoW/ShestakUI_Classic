local T, C, L = unpack(ShestakUI)
if C.actionbar.enable ~= true or C.actionbar.micromenu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "MicroAnchor", T_PetBattleFrameHider or UIParent)
frame:SetPoint(unpack(C.position.micro_menu))
frame:SetSize(250, 25)

if T.Classic then
	UpdateMicroButtonsParent(frame)
end

if C.actionbar.micromenu_mouseover then
	frame:SetAlpha(0)
	frame:SetScript("OnEnter", function() frame:SetAlpha(1) end)
	frame:SetScript("OnLeave", function() frame:SetAlpha(0) end)
end

local MICRO_BUTTONS = T.Classic and MICRO_BUTTONS or {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"EJMicroButton",
	"CollectionsMicroButton",
	"StoreMicroButton",
	"MainMenuMicroButton",
	"HelpMicroButton",
}

for i, button in pairs(MICRO_BUTTONS) do
	local bu = _G[button]
	local normal = bu:GetNormalTexture()
	local pushed = bu:GetPushedTexture()
	local disabled = bu:GetDisabledTexture()
	if T.Mainline then
		bu:SetSize(22, 29)
	end

	local point = bu:GetPoint()
	if point then
		bu:ClearAllPoints()
		if T.Classic then
			if i == 1 then
				bu:SetPoint("TOPLEFT", frame, "TOPLEFT", -1, 28)
			else
				local n = (not T.Vanilla or i <= 7) and i or i - 1
				bu:SetPoint("TOPLEFT", frame, "TOPLEFT", ((n - 1) * 26) - 1, 28)
			end
		else
			if i == 1 then
				bu:SetPoint("TOPLEFT", frame, "TOPLEFT", -1, 2)
			else
				bu:SetPoint("TOPLEFT", frame, "TOPLEFT", ((i - 1) * 23) - 1, 2)
			end
		end
	end

	bu:SetParent(frame)
	bu.SetParent = T.dummy

	bu:SetHighlightTexture(0)
	bu.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, bu)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	if T.Classic then
		f:SetPoint("BOTTOMLEFT", bu, "BOTTOMLEFT", 2, 0)
		f:SetPoint("TOPRIGHT", bu, "TOPRIGHT", -2, -28)
	else
		f:SetPoint("BOTTOMLEFT", bu, "BOTTOMLEFT", 1, 2)
		f:SetPoint("TOPRIGHT", bu, "TOPRIGHT", -1, -2)
	end
	f:SetTemplate("Default")
	bu.frame = f

	if T.Classic then
		_G[button.."Flash"]:SetTexture(0)
	else
		local flash = bu.FlashBorder
		if flash then
			flash:SetInside(f)
			flash:SetTexture(C.media.blank)
			flash:SetVertexColor(0.6, 0.6, 0.6)
		end
		if bu.FlashContent then bu.FlashContent:SetTexture(nil) end

		local highlight = bu:GetHighlightTexture()
		if highlight then
			highlight:SetAlpha(0)
			highlight:SetTexCoord(0.1, 0.9, 0.12, 0.9)
		end
	end

	if normal then
		if T.Classic then
			normal:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		else
			normal:SetTexCoord(0.1, 0.85, 0.12, 0.78)
		end
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
		normal:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	end

	if pushed then
		if T.Classic then
			pushed:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		else
			pushed:SetTexCoord(0.1, 0.85, 0.12, 0.78)
		end
		pushed:ClearAllPoints()
		pushed:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
		pushed:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	end

	if disabled then
		if T.Classic then
			disabled:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		else
			disabled:SetTexCoord(0.2, 0.80, 0.22, 0.8)
		end
		disabled:ClearAllPoints()
		disabled:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
		disabled:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	end

	bu:HookScript("OnEnter", function(self)
		self.frame:SetBackdropBorderColor(unpack(C.media.classborder_color))
		if C.actionbar.micromenu_mouseover then
			frame:SetAlpha(1)
		end
	end)
	bu:HookScript("OnLeave", function(self)
		self.frame:SetBackdropBorderColor(unpack(C.media.border_color))
		if C.actionbar.micromenu_mouseover then
			frame:SetAlpha(0)
		end
	end)

	if bu.Background then bu.Background:SetAlpha(0) end
	if bu.PushedShadow then bu.PushedShadow:SetTexture() end
	if bu.Shadow then bu.Shadow:SetTexture() end
	if bu.PushedBackground then bu.PushedBackground:SetAlpha(0) end
	if bu.PortraitMask then bu.PortraitMask:Hide() end
end

-- Fix textures for buttons
if T.Classic then
	hooksecurefunc("UpdateMicroButtons", function()
		MicroButtonPortrait:ClearAllPoints()
		MicroButtonPortrait:SetPoint("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
		MicroButtonPortrait:SetPoint("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)

		MainMenuBarPerformanceBar:SetTexture(C.media.texture)
		MainMenuBarPerformanceBar:SetSize(20, 2)
		MainMenuBarPerformanceBar:ClearAllPoints()
		MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 2)
	end)
else
	MainMenuMicroButton.MainMenuBarPerformanceBar:SetTexture(C.media.texture)
	MainMenuMicroButton.MainMenuBarPerformanceBar:SetSize(16, 2)
	MainMenuMicroButton.MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 4)

	if CharacterMicroButton then
		local function SkinCharacterPortrait(self)
			self.Portrait:SetInside(self, 4, 4)
		end

		hooksecurefunc(CharacterMicroButton, "SetPushed", SkinCharacterPortrait)
		hooksecurefunc(CharacterMicroButton, "SetNormal", SkinCharacterPortrait)
	end
end
