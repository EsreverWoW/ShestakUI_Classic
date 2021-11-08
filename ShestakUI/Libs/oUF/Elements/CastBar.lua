local _, ns = ...
local oUF = ns.oUF

local FALLBACK_ICON = 136243 -- Interface\ICONS\Trade_Engineering

local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local EventFunctions = {}

local LibClassicCasterino = (oUF:IsClassic() and not oUF:IsBCC()) and LibStub('LibClassicCasterino', true)
if(LibClassicCasterino) then
	UnitCastingInfo = function(unit)
		return LibClassicCasterino:UnitCastingInfo(unit)
	end

	UnitChannelInfo = function(unit)
		return LibClassicCasterino:UnitChannelInfo(unit)
	end
end

-- Tradeskill block
local tradeskillCurrent, tradeskillTotal, mergeTradeskill = 0, 0, false
local UNIT_SPELLCAST_SENT = function (self, event, unit, target, castID, spellID)
	local castbar = self.Castbar
	castbar.curTarget = (target and target ~= '') and target or nil

	if castbar.isTradeSkill then
		castbar.tradeSkillCastId = castID
	end
end
-- end block

local function resetAttributes(self)
	self.castID = nil
	self.casting = nil
	self.channeling = nil
	self.notInterruptible = nil
	self.spellID = nil
end

local function CastStart(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.Castbar

	local name, _, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit)
	event = 'UNIT_SPELLCAST_START'
	if(not name) then
		name, _, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit)
		event = 'UNIT_SPELLCAST_CHANNEL_START'
	end

	if(not spellID and type(notInterruptible) == "number") then
		spellID = notInterruptible -- there is no notInterruptible return in some builds of Classic/BCC
		notInterruptible = false
	end

	if(not name or (isTradeSkill and element.hideTradeSkills)) then
		resetAttributes(element)
		element:Hide()

		return
	end

	endTime = endTime / 1000
	startTime = startTime / 1000

	element.max = endTime - startTime
	element.startTime = startTime
	element.delay = 0
	element.casting = event == 'UNIT_SPELLCAST_START'
	element.channeling = event == 'UNIT_SPELLCAST_CHANNEL_START'
	element.notInterruptible = notInterruptible
	element.holdTime = 0
	element.castID = castID
	element.spellID = spellID

	if(element.casting) then
		element.duration = GetTime() - startTime
	else
		element.duration = endTime - GetTime()
	end

	-- Tradeskill block
	if(mergeTradeskill and isTradeSkill and UnitIsUnit(unit, 'player')) then
		element.duration = element.duration + (element.max * tradeskillCurrent);
		element.max = element.max * tradeskillTotal;
		element.holdTime = 1

		if(unit == 'player') then
			tradeskillCurrent = tradeskillCurrent + 1;
		end
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
	if(element.Text) then element.Text:SetText(name) end
	if(element.Time) then element.Time:SetText() end

	local safeZone = element.SafeZone
	if(safeZone) then
		local isHoriz = element:GetOrientation() == 'HORIZONTAL'

		safeZone:ClearAllPoints()
		safeZone:SetPoint(isHoriz and 'TOP' or 'LEFT')
		safeZone:SetPoint(isHoriz and 'BOTTOM' or 'RIGHT')

		if(element.casting) then
			safeZone:SetPoint(element:GetReverseFill() and (isHoriz and 'LEFT' or 'BOTTOM') or (isHoriz and 'RIGHT' or 'TOP'))
		else
			safeZone:SetPoint(element:GetReverseFill() and (isHoriz and 'RIGHT' or 'TOP') or (isHoriz and 'LEFT' or 'BOTTOM'))
		end

		local ratio = (select(4, GetNetStats()) / 1000) / element.max
		if(ratio > 1) then
			ratio = 1
		end

		safeZone[isHoriz and 'SetWidth' or 'SetHeight'](safeZone, element[isHoriz and 'GetWidth' or 'GetHeight'](element) * ratio)
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

	endTime = endTime / 1000
	startTime = startTime / 1000

	local delta
	if(element.casting) then
		delta = startTime - element.startTime

		element.duration = GetTime() - startTime
	else
		delta = element.startTime - startTime

		element.duration = endTime - GetTime()
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
		element.tradeSkillCastId = nil
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
	if(self.casting or self.channeling) then
		local isCasting = self.casting
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

		if((not oUF:IsClassic() or oUF:IsBCC()) or self.unit == 'player') then
			self:RegisterEvent('UNIT_SPELLCAST_START', CastStart)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_START', CastStart)
			self:RegisterEvent('UNIT_SPELLCAST_STOP', CastStop)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', CastStop)
			self:RegisterEvent('UNIT_SPELLCAST_DELAYED', CastUpdate)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', CastUpdate)
			self:RegisterEvent('UNIT_SPELLCAST_FAILED', CastFail)
			self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED', CastFail)
			if(not oUF:IsClassic()) then
				self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE', CastInterruptible)
				self:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTIBLE', CastInterruptible)
			end
		elseif(LibClassicCasterino) then
			local CastbarEventHandler = function(event, ...)
				return EventFunctions[event](self, event, ...)
			end
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_START', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_START', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_STOP', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_STOP', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_DELAYED', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_UPDATE', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_FAILED', CastbarEventHandler)
			LibClassicCasterino.RegisterCallback(self, 'UNIT_SPELLCAST_INTERRUPTED', CastbarEventHandler)
		end

		-- Tradeskill block
		self:RegisterEvent('UNIT_SPELLCAST_SENT', UNIT_SPELLCAST_SENT, true)
		-- end block

		element.holdTime = 0

		element:SetScript('OnUpdate', element.OnUpdate or onUpdate)

		if(self.unit == 'player' and not (self.hasChildren or self.isChild or self.isNamePlate)) then
			CastingBarFrame_SetUnit(CastingBarFrame, nil)
			CastingBarFrame_SetUnit(PetCastingBarFrame, nil)
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
		self:UnregisterEvent('UNIT_SPELLCAST_DELAYED', CastUpdate)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', CastUpdate)
		self:UnregisterEvent('UNIT_SPELLCAST_STOP', CastStop)
		self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', CastStop)
		self:UnregisterEvent('UNIT_SPELLCAST_FAILED', CastFail)
		self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTED', CastFail)
		self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE', CastInterruptible)
		self:UnregisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTIBLE', CastInterruptible)

		if(LibClassicCasterino) then
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_START')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_START')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_DELAYED')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_UPDATE')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_STOP')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_CHANNEL_STOP')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_FAILED')
			LibClassicCasterino.UnregisterCallback(self, 'UNIT_SPELLCAST_INTERRUPTED')
		end

		element:SetScript('OnUpdate', nil)

		if(self.unit == 'player' and not (self.hasChildren or self.isChild or self.isNamePlate)) then
			CastingBarFrame_OnLoad(CastingBarFrame, 'player', true, false)
			PetCastingBarFrame_OnLoad(PetCastingBarFrame)
		end
	end
end

if(LibClassicCasterino) then
	EventFunctions['UNIT_SPELLCAST_START'] = CastStart
	EventFunctions['UNIT_SPELLCAST_CHANNEL_START'] = CastStart
	EventFunctions['UNIT_SPELLCAST_DELAYED'] = CastUpdate
	EventFunctions['UNIT_SPELLCAST_CHANNEL_UPDATE'] = CastUpdate
	EventFunctions['UNIT_SPELLCAST_STOP'] = CastStop
	EventFunctions['UNIT_SPELLCAST_CHANNEL_STOP'] = CastStop
	EventFunctions['UNIT_SPELLCAST_FAILED'] = CastFail
	EventFunctions['UNIT_SPELLCAST_INTERRUPTED'] = CastFail
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
