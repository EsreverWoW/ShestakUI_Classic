local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.actionbar.micromenu ~= true then return end

----------------------------------------------------------------------------------------
--	Micro menu(by Elv22)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "MicroAnchor", T_PetBattleFrameHider or UIParent)
frame:SetPoint(unpack(C.position.micro_menu))
frame:SetSize(T.Classic and 208 or 284, 30)

UpdateMicroButtonsParent(frame)
if C.actionbar.micromenu_mouseover == true then frame:SetAlpha(0) end

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
	"MainMenuMicroButton",
	"HelpMicroButton",
	"StoreMicroButton",
}

for _, button in pairs(MICRO_BUTTONS) do
	local bu = _G[button]
	local normal = bu:GetNormalTexture()
	local pushed = bu:GetPushedTexture()
	local disabled = bu:GetDisabledTexture()

	bu:SetParent(frame)
	bu.SetParent = T.dummy
	if T.Classic then
		_G[button.."Flash"]:SetTexture("")
	else
		if button.Flash then
			button.Flash:SetInside()
			button.Flash:SetTexture()
		end
	end
	bu:SetHighlightTexture(C.media.empty)
	bu.SetHighlightTexture = T.dummy

	local f = CreateFrame("Frame", nil, bu)
	f:SetFrameLevel(1)
	f:SetFrameStrata("BACKGROUND")
	if T.Classic then
		f:SetPoint("BOTTOMLEFT", bu, "BOTTOMLEFT", 2, 0)
		f:SetPoint("TOPRIGHT", bu, "TOPRIGHT", -2, -28)
	else
		f:SetPoint("BOTTOMLEFT", bu, "BOTTOMLEFT", 1, 0)
		f:SetPoint("TOPRIGHT", bu, "TOPRIGHT", -1, -2)
	end
	f:SetTemplate("Default")
	bu.frame = f

	if T.Classic then
		normal:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	else
		normal:SetTexCoord(0.1, 0.85, 0.12, 0.78)
	end
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	normal:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)

	if T.Classic then
		pushed:SetTexCoord(0.17, 0.87, 0.5, 0.908)
	else
		pushed:SetTexCoord(0.1, 0.85, 0.12, 0.78)
	end
	pushed:ClearAllPoints()
	pushed:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	pushed:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)

	if disabled then
		if T.Classic then
			disabled:SetTexCoord(0.17, 0.87, 0.5, 0.908)
		else
			disabled:SetTexCoord(0.1, 0.85, 0.12, 0.78)
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
end

-- Fix textures for buttons
hooksecurefunc("UpdateMicroButtons", function()
	if T.Classic then
		MicroButtonPortrait:ClearAllPoints()
		MicroButtonPortrait:SetPoint("TOPLEFT", CharacterMicroButton.frame, "TOPLEFT", 2, -2)
		MicroButtonPortrait:SetPoint("BOTTOMRIGHT", CharacterMicroButton.frame, "BOTTOMRIGHT", -2, 2)
	end

	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -2, 0)

	if T.Mainline then
		-- GuildMicroButtonTabard:ClearAllPoints()
		-- GuildMicroButtonTabard:SetPoint("TOP", GuildMicroButton.frame, "TOP", 0, 25)
	end

	if T.Classic then
		MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 0)
	else
		MainMenuMicroButton.MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 0)
	end
end)