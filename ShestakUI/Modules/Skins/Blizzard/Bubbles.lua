local T, C, L = unpack(ShestakUI)
if C.skins.bubbles ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBubbles skin
----------------------------------------------------------------------------------------
local offset = C.skins.bubbles_offset and C.skins.bubbles_offset or 2

local function styleBubble(bubble)
	if bubble:IsForbidden() then return end

	local frame = bubble:GetChildren(1)

	frame:DisableDrawLayer("BORDER")
	frame.Tail:Hide()

	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetPoint("TOPLEFT", offset, -offset)
	frame.backdrop:SetPoint("BOTTOMRIGHT", -offset, offset)
	frame.backdrop:SetScale(UIParent:GetScale())

	bubble:SetClampedToScreen(false)
	bubble:SetFrameStrata("BACKGROUND")
	bubble.styled = true
end

local function onUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 0.1 then return end
	self.elapsed = 0

	for _, bubble in pairs(C_ChatBubbles.GetAllChatBubbles()) do
		if not bubble.styled then
			styleBubble(bubble)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
	local _, instanceType = IsInInstance()
	if instanceType == "party" or instanceType == "raid" then
		f:SetScript("OnUpdate", nil)
	else
		f:SetScript("OnUpdate", onUpdate)
	end
end)
