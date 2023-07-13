local T, C, L = unpack(ShestakUI)
if C.unitframe.unit_castbar ~= true or C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Mirror Timers (Underwater Breath, etc.) [from oMirrorBars (by Haste) + ElvUI]
----------------------------------------------------------------------------------------
local position = {
	BREATH = -96;
	EXHAUSTION = -116;
	FEIGNDEATH = -142;
}

local loadPosition = function(self, timer)
	local y = position[timer] or -96

	return self:SetPoint("TOP", UIParent, "TOP", 0, y)
end

local colors = {
	EXHAUSTION = {1, 0.9, 0};
	BREATH = {0.31, 0.45, 0.63};
	DEATH = {1, 0.7, 0};
	FEIGNDEATH = {0.3, 0.7, 0};
}

if T.Classic then
	local Spawn, PauseAll
	do
		local barPool = {}

		local OnUpdate = function(self)
			if self.paused then return end

			self:SetValue(GetMirrorTimerProgress(self.type) / 1e3)
		end

		local Start = function(self, value, maxvalue, _, paused, text)
			if paused > 0 then
				self.paused = 1
			elseif self.paused then
				self.paused = nil
			end

			self.text:SetText(text)

			self:SetMinMaxValues(0, maxvalue / 1e3)
			self:SetValue(value / 1e3)

			if not self:IsShown() then self:Show() end
		end

		function Spawn(type)
			if barPool[type] then return barPool[type] end
			local frame = CreateFrame("StatusBar", nil, UIParent)

			frame:SetScript("OnUpdate", OnUpdate)

			local r, g, b = unpack(colors[type])

			local bg = frame:CreateTexture(nil, "BACKGROUND")
			bg:SetAllPoints(frame)
			bg:SetTexture(C.media.texture)
			bg:SetVertexColor(r * 0.3, g * 0.3, b * 0.3)

			local border = CreateFrame("Frame", nil, frame)
			border:SetPoint("TOPLEFT", frame, -2, 2)
			border:SetPoint("BOTTOMRIGHT", frame, 2, -2)
			border:SetTemplate("Default")
			border:SetFrameLevel(0)

			local text = frame:CreateFontString(nil, "OVERLAY")
			text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
			text:SetJustifyH("CENTER")
			text:SetShadowOffset(0, 0)
			text:SetTextColor(1, 1, 1)

			text:SetPoint("LEFT", frame)
			text:SetPoint("RIGHT", frame)
			text:SetPoint("TOP", frame, 0, 1)
			text:SetPoint("BOTTOM", frame)

			frame:SetSize(281, 16)

			frame:SetStatusBarTexture(C.media.texture)
			frame:SetStatusBarColor(r, g, b)

			frame.type = type
			frame.text = text

			frame.Start = Start
			frame.Stop = Stop

			loadPosition(frame)

			barPool[type] = frame
			return frame
		end

		function PauseAll(val)
			for _, bar in next, barPool do
				bar.paused = val
			end
		end
	end

	local frame = CreateFrame("Frame")
	frame:SetScript("OnEvent", function(self, event, ...)
		return self[event](self, ...)
	end)

	function frame:ADDON_LOADED(addon)
		if addon == "ShestakUI" then
			UIParent:UnregisterEvent("MIRROR_TIMER_START")

			self:UnregisterEvent("ADDON_LOADED")
			self.ADDON_LOADED = nil
		end
	end
	frame:RegisterEvent("ADDON_LOADED")

	function frame:PLAYER_ENTERING_WORLD()
		for i = 1, MIRRORTIMER_NUMTIMERS do
			local type, value, maxvalue, scale, paused, text = GetMirrorTimerInfo(i)
			if type ~= "UNKNOWN" then
				Spawn(type):Start(value, maxvalue, scale, paused, text)
			end
		end
	end
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")

	function frame:MIRROR_TIMER_START(type, value, maxvalue, scale, paused, text)
		return Spawn(type):Start(value, maxvalue, scale, paused, text)
	end
	frame:RegisterEvent("MIRROR_TIMER_START")

	function frame:MIRROR_TIMER_STOP(type)
		return Spawn(type):Hide()
	end
	frame:RegisterEvent("MIRROR_TIMER_STOP")

	function frame:MIRROR_TIMER_PAUSE(duration)
		return PauseAll((duration > 0 and duration) or nil)
	end
	frame:RegisterEvent("MIRROR_TIMER_PAUSE")
else
	local function SetupTimer(container, timer)
		local bar = container:GetAvailableTimer(timer)
		if not bar then return end

		if not bar.atlasHolder then
			bar.atlasHolder = CreateFrame("Frame", nil, bar)
			bar.atlasHolder:SetClipsChildren(true)
			bar.atlasHolder:SetInside()

			bar.StatusBar:SetParent(bar.atlasHolder)
			bar.StatusBar:ClearAllPoints()
			bar.StatusBar:SetSize(281, 16)
			bar.StatusBar:SetPoint("TOP", 0, -2)

			bar.Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
			bar.Text:SetShadowOffset(0, 0)
			bar.Text:ClearAllPoints()
			bar.Text:SetParent(bar.StatusBar)
			bar.Text:SetPoint("CENTER", bar.StatusBar, 0, 0)

			bar:SetSize(289, 23)
			bar:StripTextures()
			bar:CreateBackdrop("Overlay")
			bar.backdrop:SetPoint("TOPLEFT", 2, -2)
			bar.backdrop:SetPoint("BOTTOMRIGHT", -2, 1)

			bar:ClearAllPoints()
			loadPosition(bar, timer)
		end

		local r, g, b = unpack(colors[timer])
		bar.StatusBar:SetStatusBarTexture(C.media.texture)
		bar.StatusBar:SetStatusBarColor(r, g, b)
	end

	hooksecurefunc(_G.MirrorTimerContainer, "SetupTimer", SetupTimer)
end
