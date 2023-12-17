local T, C, L = unpack(ShestakUI)
local _, ns = ...
local oUF = ns.oUF

local FALLBACK_ICON = 136243 -- Interface\ICONS\Trade_Engineering
local FAILED = _G.FAILED or 'Failed'
local INTERRUPTED = _G.INTERRUPTED or 'Interrupted'
local CASTBAR_STAGE_DURATION_INVALID = -1 -- defined in FrameXML/CastingBarFrame.lua

local UnitChannelInfo = UnitChannelInfo
local EventFunctions = {}

local LibClassicCasterino = (oUF:IsVanilla() and LibStub('LibClassicCasterino-ShestakUI', true))
if(LibClassicCasterino) then
	UnitChannelInfo = function(unit)
		return LibClassicCasterino:UnitChannelInfo(unit)
	end
end

-- Tradeskill block
local tradeskillCurrent, tradeskillTotal, mergeTradeskill = 0, 0, false
-- end block

local function resetAttributes(self)
	self.castID = nil
	self.casting = nil
	self.channeling = nil
	self.empowering = nil
	self.notInterruptible = nil
	self.spellID = nil
	self.rank = nil
	self.numStages = nil
	self.curStage = nil

	table.wipe(self.stagePoints)

	for _, pip in next, self.Pips do
		pip:Hide()
		if pip.texture then
			pip.texture:Hide()
			pip.gap:Hide()
		end
	end
end

local colorStage = {
	[1] = {1, 0, 0},
	[2] = {1, 0.9, 0},
	[3] = {0, 1, 0.5},
}

local colorStages = {
	[1] = {1, 0, 0},
	[2] = {1, 0.4, 0},
	[3] = {1, 0.9, 0},
	[4] = {0, 1, 0.5},
}

local function CreatePip(element, stage, numStages)
	local frame = CreateFrame("Frame", nil, element)
	frame:SetSize(2, element:GetHeight())

	local color = numStages == 4 and colorStages[stage] or colorStage[stage] or {0, 0, 0}

	frame.texture = element:CreateTexture(nil, "BORDER", nil, -2)
	frame.texture:SetTexture(C.media.texture)
	frame.texture:SetVertexColor(unpack(color))

	local r, g, b = frame.texture:GetVertexColor()
	frame.gap = element:CreateTexture(nil, "ARTWORK")
	frame.gap:SetAllPoints(frame)
	frame.gap:SetTexture(C.media.texture)
	frame.gap:SetVertexColor(r * 0.75, g * 0.75, b * 0.75)

	return frame
end

local function UpdatePips(element, numStages)
	local stageTotalDuration = 0
	local stageMaxValue = element.max * 1000
	local isHoriz = element:GetOrientation() == 'HORIZONTAL'
	local elementSize = isHoriz and element:GetWidth() or element:GetHeight()
	element.numStages = numStages
	element.curStage = 0 -- NOTE: Updates only if the PostUpdateStage callback is present

	for stage = 1, numStages do
		local duration
		if(stage > numStages) then
			duration = GetUnitEmpowerHoldAtMaxTime(element.__owner.unit)
		else
			duration = GetUnitEmpowerStageDuration(element.__owner.unit, stage - 1)
		end

		if(duration > CASTBAR_STAGE_DURATION_INVALID) then
			stageTotalDuration = stageTotalDuration + duration
			element.stagePoints[stage] = stageTotalDuration / 1000

			local portion = stageTotalDuration / stageMaxValue
			local offset = elementSize * portion

			local pip = element.Pips[stage]
			if(not pip) then
				--[[ Override: Castbar:CreatePip(stage)
				Creates a "pip" for the given stage, used for empowered casts.

				* self - the Castbar widget

				## Returns

				* pip - a frame used to depict an empowered stage boundary, typically with a line texture (frame)
				--]]
				pip = (element.CreatePip or CreatePip) (element, stage, numStages)
				element.Pips[stage] = pip
			end

			pip:ClearAllPoints()
			pip:Show()

			if(isHoriz) then
				pip:RotateTextures(0)

				if(element:GetReverseFill()) then
					pip:SetPoint('TOP', element, 'TOPRIGHT', -offset, 0)
					pip:SetPoint('BOTTOM', element, 'BOTTOMRIGHT', -offset, 0)
				else
					pip:SetPoint('TOP', element, 'TOPLEFT', offset, 0)
					pip:SetPoint('BOTTOM', element, 'BOTTOMLEFT', offset, 0)
				end
			else
				pip:RotateTextures(1.5708)

				if(element:GetReverseFill()) then
					pip:SetPoint('LEFT', element, 'TOPLEFT', 0, -offset)
					pip:SetPoint('RIGHT', element, 'TOPRIGHT', 0, -offset)
				else
					pip:SetPoint('LEFT', element, 'BOTTOMLEFT', 0, offset)
					pip:SetPoint('RIGHT', element, 'BOTTOMRIGHT', 0, offset)
				end
			end
		end
	end
	local maxStage = #element.Pips
	for i, pip in next, element.Pips do
		pip.texture:Show()
		pip.gap:Show()
		pip.texture:ClearAllPoints()

		if(element:GetReverseFill()) then
			if i == maxStage then
				pip.texture:SetPoint('TOPLEFT', element, 0, 0)
				pip.texture:SetPoint('BOTTOMRIGHT', pip, 0, 0)
			else
				local anchor = element.Pips[i + 1]
				pip.texture:SetPoint('TOPLEFT', anchor, 0, 0)
				pip.texture:SetPoint('BOTTOMRIGHT', pip, 0, 0)
			end
		else
			if i == maxStage then
				pip.texture:SetPoint('TOPRIGHT', element, 0, 0)
				pip.texture:SetPoint('BOTTOMLEFT', pip, 0, 0)
			else
				local anchor = element.Pips[i + 1]
				pip.texture:SetPoint('TOPRIGHT', anchor, 0, 0)
				pip.texture:SetPoint('BOTTOMLEFT', pip, 0, 0)
			end
		end
	end

	--[[ Callback: Castbar:PostUpdatePips(numStages)
	Called after the element has updated stage separators (pips) in an empowered cast.
	* self - the Castbar widget
	* numStages - the number of stages in the current cast (number)
	--]]
	if(element.PostUpdatePips) then
		element:PostUpdatePips(numStages)
	end
end

local function CastStart(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.Castbar

	local numStages, _
	local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
	event = 'UNIT_SPELLCAST_START'
	if(not name) then
		name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID, _, numStages = UnitChannelInfo(unit)
		event = (numStages and numStages > 0) and 'UNIT_SPELLCAST_EMPOWER_START' or 'UNIT_SPELLCAST_CHANNEL_START'
	end

	if(not name or (isTradeSkill and element.hideTradeSkills)) then
		resetAttributes(element)
		element:Hide()

		return
	end

	local rank
	if(oUF:IsClassic() and not oUF:IsCata()) then
		rank = spellID and GetSpellSubtext(spellID)
		rank = rank and strmatch(rank, "%d+")
	end

	if(not text or text == '' or text == CHANNELING) then
		text = name
	end

	element.casting = event == 'UNIT_SPELLCAST_START'
	element.channeling = event == 'UNIT_SPELLCAST_CHANNEL_START'
	element.empowering = event == 'UNIT_SPELLCAST_EMPOWER_START'

	if(element.empowering) then
		endTime = endTime + GetUnitEmpowerHoldAtMaxTime(unit)
	end

	endTime = endTime / 1000
	startTime = startTime / 1000

	element.max = endTime - startTime
	element.startTime = startTime
	element.delay = 0
	element.notInterruptible = notInterruptible
	element.holdTime = 0
	element.castID = castID
	element.spellID = spellID
	element.rank = rank

	if(element.channeling) then
		element.duration = endTime - GetTime()
	else
		element.duration = GetTime() - startTime
	end

	-- Tradeskill block
	if(mergeTradeskill and isTradeSkill and unit == 'player') then
		element.duration = element.duration + (element.max * tradeskillCurrent)
		element.max = element.max * tradeskillTotal
		element.holdTime = 1

		tradeskillCurrent = tradeskillCurrent + 1
	end
	-- end block

	element:SetMinMaxValues(0, element.max)
	element:SetValue(element.duration)

	if(texture == 136235) then
		texture = FALLBACK_ICON
	end

	if(element.Icon) then element.Icon:SetTexture(texture or FALLBACK_ICON) end
	if(element.Shield) then element.Shield:SetShown(notInterruptible) end
	if(element.Spark) then element.Spark:Show() end
	if(rank) then
		if(element.Text) then element.Text:SetText(text .. " " .. rank) end
	else
		if(element.Text) then element.Text:SetText(text) end
	end
	if(element.Time) then element.Time:SetText() end

	local safeZone = element.SafeZone
	if(safeZone) then
		local isHoriz = element:GetOrientation() == 'HORIZONTAL'

		safeZone:ClearAllPoints()
		safeZone:SetPoint(isHoriz and 'TOP' or 'LEFT')
		safeZone:SetPoint(isHoriz and 'BOTTOM' or 'RIGHT')

		if(element.channeling) then
			safeZone:SetPoint(element:GetReverseFill() and (isHoriz and 'RIGHT' or 'TOP') or (isHoriz and 'LEFT' or 'BOTTOM'))
		else
			safeZone:SetPoint(element:GetReverseFill() and (isHoriz and 'LEFT' or 'BOTTOM') or (isHoriz and 'RIGHT' or 'TOP'))
		end

		local ratio = (select(4, GetNetStats()) / 1000) / element.max
		if(ratio > 1) then
			ratio = 1
		end

		safeZone[isHoriz and 'SetWidth' or 'SetHeight'](safeZone, element[isHoriz and 'GetWidth' or 'GetHeight'](element) * ratio)
	end

	if(element.empowering) and unit == "player" then
		--[[ Override: Castbar:UpdatePips(numStages)
		Handles updates for stage separators (pips) in an empowered cast.

		* self      - the Castbar widget
		* numStages - the number of stages in the current cast (number)
		--]]
		(element.UpdatePips or UpdatePips) (element, numStages)
	end

	--[[ Callback: Castbar:PostCastStart(unit)
	Called after the element has been updated upon a spell cast or channel start.

	* self - the Castbar widget
	* unit - the unit for which the update has been triggered (string)
	--]]
	if(element.PostCastStart) then
		element:PostCastStart(unit)
	end

	element:Show()
end

local function CastUpdate(self, event, unit, castID, spellID)
	if(self.unit ~= unit) then return end

	local element = self.Castbar
	if unit == 'player' then
		if(not element:IsShown() or element.castID ~= castID or element.spellID ~= spellID) then
			return
		end
	else
		if(not element:IsShown()) then
			return
		end
	end

	local name, startTime, endTime, _
	if(event == 'UNIT_SPELLCAST_DELAYED') then
		name, _, _, startTime, endTime = UnitCastingInfo(unit)
	else
		name, _, _, startTime, endTime = UnitChannelInfo(unit)
	end

	if(not name) then return end

	if(element.empowering) then
		endTime = endTime + GetUnitEmpowerHoldAtMaxTime(unit)
	end

	endTime = endTime / 1000
	startTime = startTime / 1000

	local delta
	if(element.channeling) then
		delta = element.startTime - startTime

		element.duration = endTime - GetTime()
	else
		delta = startTime - element.startTime

		element.duration = GetTime() - startTime
	end

	if(delta < 0) then
		delta = 0
	end

	element.max = endTime - startTime
	element.startTime = startTime
	element.delay = element.delay + delta

	element:SetMinMaxValues(0, element.max)
	element:SetValue(element.duration)

	--[[ Callback: Castbar:PostCastUpdate(unit)
	Called after the element has been updated when a spell cast or channel has been updated.

	* self - the Castbar widget
	* unit - the unit that the update has been triggered (string)
	--]]
	if(element.PostCastUpdate) then
		return element:PostCastUpdate(unit)
	end
end

local function CastStop(self, event, unit, castID, spellID)
	if(self.unit ~= unit) then return end

	local element = self.Castbar
	if unit == 'player' then
		if(not element:IsShown() or element.castID ~= castID or element.spellID ~= spellID) then
			return
		end
	else
		if(not element:IsShown()) then
			return
		end
	end

	-- Tradeskill block
	if mergeTradeskill and UnitIsUnit(unit, 'player') then
		if tradeskillCurrent == tradeskillTotal then
			mergeTradeskill = false
		end
	end
	-- end block

	resetAttributes(element)

	--[[ Callback: Castbar:PostCastStop(unit, spellID)
	Called after the element has been updated when a spell cast or channel has stopped.

	* self    - the Castbar widget
	* unit    - the unit for which the update has been triggered (string)
	* spellID - the ID of the spell (number)
	--]]
	if(element.PostCastStop) then
		return element:PostCastStop(unit, spellID)
	end
end

local function CastFail(self, event, unit, castID, spellID)
	if(self.unit ~= unit) then return end

	local element = self.Castbar
	if unit == 'player' then
		if(not element:IsShown() or element.castID ~= castID or element.spellID ~= spellID) then
			return
		end
	else
		if(not element:IsShown()) then
			return
		end
	end

	if(element.Text) then
		element.Text:SetText(event == 'UNIT_SPELLCAST_FAILED' and FAILED or INTERRUPTED)
	end

	if(element.Spark) then element.Spark:Hide() end

	element.holdTime = element.timeToHold or 0

	-- Tradeskill block
	if mergeTradeskill and UnitIsUnit(unit, 'player') then
		mergeTradeskill = false
	end
	-- end block

	resetAttributes(element)
	element:SetValue(element.max)

	--[[ Callback: Castbar:PostCastFail(unit, spellID)
	Called after the element has been updated upon a failed or interrupted spell cast.

	* self    - the Castbar widget
	* unit    - the unit for which the update has been triggered (string)
	* spellID - the ID of the spell (number)
	--]]
	if(element.PostCastFail) then
		return element:PostCastFail(unit, spellID)
	end
end

local function CastInterruptible(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.Castbar
	if(not element:IsShown()) then return end

	element.notInterruptible = event == 'UNIT_SPELLCAST_NOT_INTERRUPTIBLE'

	if(element.Shield) then element.Shield:SetShown(element.notInterruptible) end

	--[[ Callback: Castbar:PostCastInterruptible(unit)
	Called after the element has been updated when a spell cast has become interruptible or uninterruptible.

	* self - the Castbar widget
	* unit - the unit for which the update has been triggered (string)
	--]]
	if(element.PostCastInterruptible) then
		return element:PostCastInterruptible(unit)
	end
end

local function onUpdate(self, elapsed)
	if(self.casting or self.channeling or self.empowering) then
		local isCasting = self.casting or self.empowering
		if(isCasting) then
			self.duration = self.duration + elapsed
			if(self.duration >= self.max) then
				local spellID = self.spellID

				resetAttributes(self)
				self:Hide()

				if(self.PostCastStop) then
					self:PostCastStop(self.__owner.unit, spellID)
				end

				return
			end
		else
			self.duration = self.duration - elapsed
			if(self.duration <= 0) then
				local spellID = self.spellID

				resetAttributes(self)
				self:Hide()

				if(self.PostCastStop) then
					self:PostCastStop(self.__owner.unit, spellID)
				end

				return
			end
		end

		if(self.Time) then
			if(self.delay ~= 0) then
				if(self.CustomDelayText) then
					self:CustomDelayText(self.duration)
				else
					self.Time:SetFormattedText('%.1f|cffff0000%s%.2f|r', self.duration, isCasting and '+' or '-', self.delay)
				end
			else
				if(self.CustomTimeText) then
					self:CustomTimeText(self.duration)
				else
					self.Time:SetFormattedText('%.1f', self.duration)
				end
			end
		end

		--[[ Callback: Castbar:PostUpdateStage(stage)
		Called after the current stage changes.
		* self - the Castbar widget
		* stage - the stage of the empowered cast (number)
		--]]
		if(self.empowering and self.PostUpdateStage) then
			local old = self.curStage
			for i = old + 1, self.numStages do
				if(self.stagePoints[i]) then
					if(self.duration > self.stagePoints[i]) then
						self.curStage = i

						if(self.curStage ~= old) then
							self:PostUpdateStage(i)
						end
					else
						break
					end
				end
			end
		end

		self:SetValue(self.duration)
	elseif(self.holdTime > 0) then
		self.holdTime = self.holdTime - elapsed
	else
		resetAttributes(self)
		self:Hide()
	end
end

local function Update(...)
	CastStart(...)
end

local function ForceUpdate(element)
	return Update(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.Castbar
	if(element and unit and not unit:match('%wtarget$')) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_SPELLCAST_START', CastStart)
		self:RegisterEvent('UNIT_SPELLCAST_STOP', CastStop)
		self:RegisterEvent('UNIT_SPELLCAST_DELAYED', CastUpdate)
		self:RegisterEvent('UNIT_SPELLCAST_FAILED', CastFail)
		self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED', CastFail)
		self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', CastUpdate)

		if(not oUF:IsVanilla() or self.unit == 'player') then
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_START', CastStart)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', CastStop)
		elseif(LibClassicCasterino) then
			local CastbarEventHandler = function(event, ...)
				return EventFunctions[event](self, event, ...)
			end
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_START', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_STOP', CastbarEventHandler)
		end

		if(oUF:IsMainline()) then
			self:RegisterEvent('UNIT_SPELLCAST_EMPOWER_START', CastStart)
			self:RegisterEvent('UNIT_SPELLCAST_EMPOWER_STOP', CastStop)
			self:RegisterEvent('UNIT_SPELLCAST_EMPOWER_UPDATE', CastUpdate)
			self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE', CastInterruptible)
			self:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTIBLE', CastInterruptible)
		end

		element.holdTime = 0
		element.stagePoints = {}
		element.Pips = element.Pips or {}

		element:SetScript('OnUpdate', element.OnUpdate or onUpdate)

		if(self.unit == 'player' and not (self.hasChildren or self.isChild or self.isNamePlate)) then
			if(oUF:IsClassic()) then
				CastingBarFrame_SetUnit(CastingBarFrame, nil)
				CastingBarFrame_SetUnit(PetCastingBarFrame, nil)
			else
				PlayerCastingBarFrame:SetUnit(nil)
				PetCastingBarFrame:SetUnit(nil)
				PetCastingBarFrame:UnregisterEvent('UNIT_PET')
			end
		end

		if(element:IsObjectType('StatusBar') and not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		local spark = element.Spark
		if(spark and spark:IsObjectType('Texture') and not spark:GetTexture()) then
			spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
		end

		local shield = element.Shield
		if(shield and shield:IsObjectType('Texture') and not shield:GetTexture()) then
			shield:SetTexture([[Interface\CastingBar\UI-CastingBar-Small-Shield]])
		end

		local safeZone = element.SafeZone
		if(safeZone and safeZone:IsObjectType('Texture') and not safeZone:GetTexture()) then
			safeZone:SetColorTexture(1, 0, 0)
		end

		element:Hide()

		return true
	end
end

local function Disable(self)
	local element = self.Castbar
	if(element) then
		element:Hide()

		self:UnregisterEvent('UNIT_SPELLCAST_START', CastStart)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_START', CastStart)
		self:UnregisterEvent('UNIT_SPELLCAST_EMPOWER_START', CastStart)
		self:UnregisterEvent('UNIT_SPELLCAST_STOP', CastStop)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', CastStop)
		self:UnregisterEvent('UNIT_SPELLCAST_EMPOWER_STOP', CastStop)
		self:UnregisterEvent('UNIT_SPELLCAST_DELAYED', CastUpdate)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', CastUpdate)
		self:UnregisterEvent('UNIT_SPELLCAST_EMPOWER_UPDATE', CastUpdate)
		self:UnregisterEvent('UNIT_SPELLCAST_FAILED', CastFail)
		self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTED', CastFail)
		self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE', CastInterruptible)
		self:UnregisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTIBLE', CastInterruptible)

		if(LibClassicCasterino) then
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_START')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_STOP')
		end

		element:SetScript('OnUpdate', nil)

		if(self.unit == 'player' and not (self.hasChildren or self.isChild or self.isNamePlate)) then
			if(oUF:IsClassic()) then
				CastingBarFrame_OnLoad(CastingBarFrame, 'player', true, false)
				PetCastingBarFrame_OnLoad(PetCastingBarFrame)
			else
				PlayerCastingBarFrame:OnLoad()
				PetCastingBarFrame:PetCastingBar_OnLoad()
			end
		end
	end
end

if(LibClassicCasterino) then
	EventFunctions['UNIT_SPELLCAST_CHANNEL_START'] = CastStart
	EventFunctions['UNIT_SPELLCAST_CHANNEL_STOP'] = CastStop
end

-- Tradeskill block
if(oUF:IsClassic()) then
	hooksecurefunc('DoTradeSkill', function(_, num)
		tradeskillCurrent = 0
		tradeskillTotal = num or 1
		mergeTradeskill = true
	end)
else
	hooksecurefunc(C_TradeSkillUI, 'CraftRecipe', function(_, num)
		tradeskillCurrent = 0
		tradeskillTotal = num or 1
		mergeTradeskill = true
	end)
end
-- end block

oUF:AddElement('Castbar', Update, Enable, Disable)
