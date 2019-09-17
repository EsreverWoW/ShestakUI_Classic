local _, ns = ...
local oUF = ns.oUF
local Private = oUF.Private

local unitSelectionType = Private.unitSelectionType

local function UpdateColor(element, unit, cur, max)
	local parent = element.__owner

	local r, g, b, t
	if(element.colorTapping and not UnitPlayerControlled(unit) and UnitIsTapDenied(unit)) then
		t = parent.colors.tapped
	elseif(element.colorDisconnected and element.disconnected) then
		t = parent.colors.disconnected
	elseif(element.colorHappiness and UnitIsUnit(unit, 'pet') and GetPetHappiness()) then
		t = parent.colors.happiness[GetPetHappiness()]
	elseif(element.colorClass and UnitIsPlayer(unit)) or
		(element.colorClassNPC and not UnitIsPlayer(unit)) or
		(element.colorClassPet and UnitPlayerControlled(unit) and not UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		t = parent.colors.class[class]
	elseif(element.colorSelection and unitSelectionType(unit, element.considerSelectionInCombatHostile)) then
		t = parent.colors.selection[unitSelectionType(unit, element.considerSelectionInCombatHostile)]
	elseif(element.colorReaction and UnitReaction(unit, 'player')) then
		t = parent.colors.reaction[UnitReaction(unit, 'player')]
	elseif(element.colorSmooth) then
		r, g, b = parent:ColorGradient(cur or 1, max or 1, unpack(element.smoothGradient or parent.colors.smooth))
	elseif(element.colorHealth) then
		t = parent.colors.health
	end

	if(t) then
		r, g, b = t[1], t[2], t[3]
	end

	if(r or g or b) then
		element:SetStatusBarColor(r, g, b)

		local bg = element.bg
		if(bg) then
			local mu = bg.multiplier or 1
			bg:SetVertexColor(r * mu, g * mu, b * mu)
		end
	end

	if(element.PostUpdateColor) then
		element:PostUpdateColor(unit, r, g, b)
	end
end

local function ColorPath(self, ...)
	--[[ Override: Health.UpdateColor(self, event, unit)
	Used to completely override the internal function for updating the widgets' colors.
	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	--]]
	(self.Health.UpdateColor or UpdateColor) (self, ...)
end

local function Update(self, event, unit)
	if(not unit or self.unit ~= unit) then return end
	local element = self.Health

	--[[ Callback: Health:PreUpdate(unit)
	Called before the element has been updated.

	* self - the Health element
	* unit - the unit for which the update has been triggered (string)
	--]]
	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	local cur, max = UnitHealth(unit), UnitHealthMax(unit)
	local disconnected = not UnitIsConnected(unit)

	if(oUF:IsClassic() and IsAddOnLoaded('RealMobHealth')) then
		local hpRMH, maxhpRMH = RealMobHealth.GetUnitHealth(unit, true)

		if hpRMH and maxhpRMH then
			cur, max = hpRMH, maxhpRMH
		end
	end

	element:SetMinMaxValues(0, max)

	if(disconnected) then
		element:SetValue(max)
	else
		element:SetValue(cur)
	end

	element.cur = cur
	element.max = max
	element.disconnected = disconnected

	--[[ Override: Health:UpdateColor(unit, cur, max)
	Used to completely override the internal function for updating the widgets' colors.

	* self - the Health element
	* unit - the unit for which the update has been triggered (string)
	* cur  - the unit's current health value (number)
	* max  - the unit's maximum possible health value (number)
	--]]
	element:UpdateColor(unit, cur, max)

	--[[ Callback: Health:PostUpdate(unit, cur, max)
	Called after the element has been updated.

	* self - the Health element
	* unit - the unit for which the update has been triggered (string)
	* cur  - the unit's current health value (number)
	* max  - the unit's maximum possible health value (number)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(unit, cur, max)
	end
end

local function Path(self, ...)
	--[[ Override: Health.Override(self, event, unit)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	--]]
	(self.Health.Override or Update) (self, ...)

	return ColorPath(self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function SetColorDisconnected(element, state)
	if(element.colorDisconnected ~= state) then
		element.colorDisconnected = state
		if(element.colorDisconnected) then
			element.__owner:RegisterEvent('UNIT_CONNECTION', ColorPath)
		else
			element.__owner:UnregisterEvent('UNIT_CONNECTION', ColorPath)
		end
	end
end

--[[ Health:SetColorTapping(state)
Used to toggle coloring if the unit isn't tapped by the player.
* self  - the Health element
* state - the desired state (boolean)
--]]
local function SetColorTapping(element, state)
	if(element.colorTapping ~= state) then
		element.colorTapping = state
		if(element.colorTapping) then
			element.__owner:RegisterEvent('UNIT_FACTION', ColorPath)
		else
			element.__owner:UnregisterEvent('UNIT_FACTION', ColorPath)
		end
	end
end

local function Enable(self, unit)
	local element = self.Health
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate
		element.SetColorDisconnected = SetColorDisconnected
		element.SetColorTapping = SetColorTapping

		if(element.colorDisconnected) then
			self:RegisterEvent('UNIT_CONNECTION', ColorPath)
		end

		if(element.colorTapping) then
			self:RegisterEvent('UNIT_FACTION', ColorPath)
		end

		self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)
		if(oUF:IsClassic()) then
			self:RegisterEvent('UNIT_HAPPINESS', Path)
		end

		if(element:IsObjectType('StatusBar') and not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		if(not element.UpdateColor) then
			element.UpdateColor = UpdateColor
		end

		element:Show()

		return true
	end
end

local function Disable(self)
	local element = self.Health
	if(element) then
		element:Hide()

		self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_CONNECTION', Path)
		self:UnregisterEvent('UNIT_FACTION', Path)
		if(oUF:IsClassic()) then
			self:UnregisterEvent('UNIT_HAPPINESS', Path)
		end
	end
end

oUF:AddElement('Health', Path, Enable, Disable)
