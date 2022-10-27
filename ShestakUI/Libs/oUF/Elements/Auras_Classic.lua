local _, ns = ...
local oUF = ns.oUF

if(not oUF:IsClassic()) then return end

local LibClassicDurations = (oUF:IsVanilla() and LibStub('LibClassicDurations'))

local VISIBLE = 1
local HIDDEN = 0

local function UpdateTooltip(self)
	if(GameTooltip:IsForbidden()) then return end

	GameTooltip:SetUnitAura(self:GetParent().__owner.unit, self:GetID(), self.filter)
end

local function onEnter(self)
	if(GameTooltip:IsForbidden() or not self:IsVisible()) then return end

	-- Avoid parenting GameTooltip to frames with anchoring restrictions,
	-- otherwise it'll inherit said restrictions which will cause issues with
	-- its further positioning, clamping, etc
	GameTooltip:SetOwner(self, self:GetParent().__restricted and 'ANCHOR_CURSOR' or self:GetParent().tooltipAnchor)
	self:UpdateTooltip()
end

local function onLeave()
	if(GameTooltip:IsForbidden()) then return end

	GameTooltip:Hide()
end

local function CreateButton(element, index)
	local button = CreateFrame('Button', element:GetDebugName() .. 'Button' .. index, element)
	button:RegisterForClicks('RightButtonUp')

	local cd = CreateFrame('Cooldown', '$parentCooldown', button, 'CooldownFrameTemplate')
	cd:SetAllPoints()
	cd:SetDrawEdge(false) -- ShestakUI
	button.Cooldown = cd

	local icon = button:CreateTexture(nil, 'BORDER')
	icon:SetAllPoints()
	button.Icon = icon

	local countFrame = CreateFrame('Frame', nil, button)
	countFrame:SetAllPoints(button)
	countFrame:SetFrameLevel(cd:GetFrameLevel() + 1)

	local count = countFrame:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
	count:SetPoint('BOTTOMRIGHT', countFrame, 'BOTTOMRIGHT', -1, 0)
	button.Count = count

	local overlay = button:CreateTexture(nil, 'OVERLAY')
	overlay:SetTexture([[Interface\Buttons\UI-Debuff-Overlays]])
	overlay:SetAllPoints()
	overlay:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
	button.Overlay = overlay

	local stealable = button:CreateTexture(nil, 'OVERLAY')
	stealable:SetTexture([[Interface\TargetingFrame\UI-TargetingFrame-Stealable]])
	stealable:SetPoint('TOPLEFT', -3, 3)
	stealable:SetPoint('BOTTOMRIGHT', 3, -3)
	stealable:SetBlendMode('ADD')
	button.Stealable = stealable

	button.UpdateTooltip = UpdateTooltip
	button:SetScript('OnEnter', onEnter)
	button:SetScript('OnLeave', onLeave)

	--[[ Callback: Auras:PostCreateButton(button)
	Called after a new aura button has been created.

	* self   - the widget holding the aura buttons
	* button - the newly created aura button (Button)
	--]]
	if(element.PostCreateButton) then element:PostCreateButton(button) end

	return button
end

local function SetPosition(element, from, to)
	local width = element.width or element.size or 16
	local height = element.height or element.size or 16
	local sizex = width + (element['spacing-x'] or element.spacing or 0)
	local sizey = height + (element['spacing-y'] or element.spacing or 0)
	local anchor = element.initialAnchor or 'BOTTOMLEFT'
	local growthx = (element['growth-x'] == 'LEFT' and -1) or 1
	local growthy = (element['growth-y'] == 'DOWN' and -1) or 1
	local cols = math.floor(element:GetWidth() / sizex + 0.5)

	for i = from, to do
		local button = element[i]
		if(not button) then break end

		local col = (i - 1) % cols
		local row = math.floor((i - 1) / cols)

		button:ClearAllPoints()
		button:SetPoint(anchor, element, anchor, col * sizex * growthx, row * sizey * growthy)
	end
end

local function FilterAura(element, unit, button, name)
	if((element.onlyShowPlayer and button.isPlayer) or (not element.onlyShowPlayer and name)) then
		return true
	end
end

local function updateAura(element, unit, index, offset, filter, isHarmful, visible)
	local name, texture, count, debuffType, duration, expiration, caster, isStealable,
	nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
	timeMod, effect1, effect2, effect3

	if(LibClassicDurations and filter == 'HELPFUL') then
		name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
		timeMod, effect1, effect2, effect3 = LibClassicDurations:UnitAura(unit, index, filter)
	else
		name, texture, count, debuffType, duration, expiration, caster, isStealable,
		nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
		timeMod, effect1, effect2, effect3 = UnitAura(unit, index, filter)
	end

	if(name) then
		local position = visible + offset + 1
		local button = element[position]
		if(not button) then
			--[[ Override: Auras:CreateIcon(position)
			Used to create the aura button at a given position.

			* self     - the widget holding the aura buttons
			* position - the position at which the aura button is to be created (number)

			## Returns

			* button - the button used to represent the aura (Button)
			--]]
			button = (element.CreateIcon or CreateButton) (element, position)
			button.data = {}

			table.insert(element, button)
			element.createdButtons = element.createdButtons + 1
		end

		if(LibClassicDurations and duration == 0 and expiration == 0) then
			duration, expiration = LibClassicDurations:GetAuraDurationByUnit(unit, spellID, caster, name)

			button.isLibClassicDuration = true
		end

		button.caster = caster
		button.filter = filter
		button.isHarmful = isHarmful
		button.isPlayer = caster == 'player' or caster == 'vehicle'

		--[[ Override: Auras:FilterAura(unit, button, ...)
		Defines a custom filter that controls if the aura button should be shown.

		* self   - the widget holding the aura buttons
		* unit   - the unit on which the aura is cast (string)
		* button - the button displaying the aura (Button)
		* ...    - the return values from [UnitAura](http://wowprogramming.com/docs/api/UnitAura.html)

		## Returns

		* show - indicates whether the aura button should be shown (boolean)
		--]]
		local show = (element.FilterAura or FilterAura) (element, unit, button, name, texture,
		count, debuffType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID,
		canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,timeMod, effect1, effect2, effect3)

		if(show) then
			-- We might want to consider delaying the creation of an actual cooldown
			-- object to this point, but I think that will just make things needlessly
			-- complicated.
			if(button.Cooldown and not element.disableCooldown) then
				if(duration and duration > 0) then
					button.Cooldown:SetCooldown(expiration - duration, duration)
					button.Cooldown:Show()
				else
					button.Cooldown:Hide()
				end
			end

			if(button.Overlay) then
				if((isHarmful and element.showDebuffType) or (not isHarmful and element.showBuffType) or element.showType) then
					local color = element.__owner.colors.debuff[debuffType] or element.__owner.colors.debuff.none

					button.Overlay:SetVertexColor(color[1], color[2], color[3])
					button.Overlay:Show()
				else
					button.Overlay:Hide()
				end
			end

			if(button.Stealable) then
				if(not isHarmful and isStealable and element.showStealableBuffs and not UnitIsUnit('player', unit)) then
					button.Stealable:Show()
				else
					button.Stealable:Hide()
				end
			end

			if(button.Icon) then button.Icon:SetTexture(texture) end
			if(button.Count) then button.Count:SetText(count > 1 and count) end

			local width = element.width or element.size or 16
			local height = element.height or element.size or 16
			button:SetSize(width, height)

			button:EnableMouse(not element.disableMouse)
			button:SetID(index)
			button:Show()

			--[[ Callback: Auras:PostUpdateButton(unit, button, index, position)
			Called after the aura button has been updated.

			* self        - the widget holding the aura buttons
			* unit        - the unit on which the aura is cast (string)
			* button      - the updated aura button (Button)
			* index       - the index of the aura (number)
			* position    - the actual position of the aura button (number)
			* duration    - the aura duration in seconds (number?)
			* expiration  - the point in time when the aura will expire. Comparable to GetTime() (number)
			* debuffType  - the debuff type of the aura (string?)['Curse', 'Disease', 'Magic', 'Poison']
			* isStealable - whether the aura can be stolen or purged (boolean)
			--]]
			if(element.PostUpdateButton) then
				element:PostUpdateButton(unit, button, index, position, duration, expiration, debuffType, isStealable)
			end

			return VISIBLE
		else
			return HIDDEN
		end
	end
end

local function filterIcons(element, unit, filter, limit, isHarmful, offset, dontHide)
	if(not offset) then offset = 0 end
	local index = 1
	local visible = 0
	local hidden = 0
	while(visible < limit) do
		local result = updateAura(element, unit, index, offset, filter, isHarmful, visible)
		if(not result) then
			break
		elseif(result == VISIBLE) then
			visible = visible + 1
		elseif(result == HIDDEN) then
			hidden = hidden + 1
		end

		index = index + 1
	end

	if(not dontHide) then
		for i = visible + offset + 1, #element do
			element[i]:Hide()
		end
	end

	return visible, hidden
end

local function UpdateAuras(self, event, unit)
	if(self.unit ~= unit) then return end

	local auras = self.Auras
	if(auras) then
		--[[ Callback: Auras:PreUpdate(unit)
		Called before the element has been updated.

		* self - the widget holding the aura buttons
		* unit - the unit for which the update has been triggered (string)
		--]]
		if(auras.PreUpdate) then auras:PreUpdate(unit) end

		local numBuffs = auras.numBuffs or 32
		local numDebuffs = auras.numDebuffs or 40
		local max = auras.numTotal or numBuffs + numDebuffs

		local visibleBuffs = filterIcons(auras, unit, auras.buffFilter or auras.filter or 'HELPFUL', math.min(numBuffs, max), nil, 0, true)

		local hasGap
		if(visibleBuffs ~= 0 and auras.gap) then
			hasGap = true
			visibleBuffs = visibleBuffs + 1

			local button = auras[visibleBuffs]
			if(not button) then
				button = (auras.CreateIcon or CreateButton) (auras, visibleBuffs)
				table.insert(auras, button)
				auras.createdButtons = auras.createdButtons + 1
			end

			-- Prevent the button from displaying anything.
			if(button.Cooldown) then button.Cooldown:Hide() end
			if(button.Icon) then button.Icon:SetTexture() end
			if(button.Overlay) then button.Overlay:Hide() end
			if(button.Stealable) then button.Stealable:Hide() end
			if(button.Count) then button.Count:SetText() end

			button:EnableMouse(false)
			button:Hide()

			--[[ Callback: Auras:PostUpdateGapButton(unit, gapButton, visibleBuffs)
			Called after an invisible aura button has been created. Only used by Auras when the `gap` option is enabled.

			* self         - the widget holding the aura buttons
			* unit         - the unit that has the invisible aura button (string)
			* gapButton    - the invisible aura button (Button)
			* visibleBuffs - the number of currently visible aura buttons (number)
			--]]
			if(auras.PostUpdateGapButton) then
				auras:PostUpdateGapButton(unit, button, visibleBuffs)
			end
		end

		local visibleDebuffs = filterIcons(auras, unit, auras.debuffFilter or auras.filter or 'HARMFUL', math.min(numDebuffs, max - visibleBuffs), true, visibleBuffs)
		auras.visibleDebuffs = visibleDebuffs

		if(hasGap and visibleDebuffs == 0) then
			auras[visibleBuffs]:Hide()
			visibleBuffs = visibleBuffs - 1
		end

		auras.visibleBuffs = visibleBuffs
		auras.visibleAuras = auras.visibleBuffs + auras.visibleDebuffs

		local fromRange, toRange
		--[[ Callback: Auras:PreSetPosition(max)
		Called before the aura buttons have been (re-)anchored.

		* self - the widget holding the aura buttons
		* max  - the maximum possible number of aura buttons (number)

		## Returns

		* from - the offset of the first aura button to be (re-)anchored (number)
		* to   - the offset of the last aura button to be (re-)anchored (number)
		--]]
		if(auras.PreSetPosition) then
			fromRange, toRange = auras:PreSetPosition(max)
		end

		if(fromRange or auras.createdButtons > auras.anchoredButtons) then
			--[[ Override: Auras:SetPosition(from, to)
			Used to (re-)anchor the aura buttons.
			Called when new aura buttons have been created or if :PreSetPosition is defined.

			* self - the widget that holds the aura buttons
			* from - the offset of the first aura button to be (re-)anchored (number)
			* to   - the offset of the last aura button to be (re-)anchored (number)
			--]]
			(auras.SetPosition or SetPosition) (auras, fromRange or auras.anchoredButtons + 1, toRange or auras.createdButtons)
			auras.anchoredButtons = auras.createdButtons
		end

		--[[ Callback: Auras:PostUpdate(unit)
		Called after the element has been updated.

		* self - the widget holding the aura buttons
		* unit - the unit for which the update has been triggered (string)
		--]]
		if(auras.PostUpdate) then auras:PostUpdate(unit) end
	end

	local buffs = self.Buffs
	if(buffs) then
		if(buffs.PreUpdate) then buffs:PreUpdate(unit) end

		local numBuffs = buffs.num or 32
		local visibleBuffs = filterIcons(buffs, unit, buffs.filter or 'HELPFUL', numBuffs)
		buffs.visibleBuffs = visibleBuffs

		local fromRange, toRange
		if(buffs.PreSetPosition) then
			fromRange, toRange = buffs:PreSetPosition(numBuffs)
		end

		if(fromRange or buffs.createdButtons > buffs.anchoredButtons) then
			(buffs.SetPosition or SetPosition) (buffs, fromRange or buffs.anchoredButtons + 1, toRange or buffs.createdButtons)
			buffs.anchoredButtons = buffs.createdButtons
		end

		if(buffs.PostUpdate) then buffs:PostUpdate(unit) end
	end

	local debuffs = self.Debuffs
	if(debuffs) then
		if(debuffs.PreUpdate) then debuffs:PreUpdate(unit) end

		local numDebuffs = debuffs.num or 40
		local visibleDebuffs = filterIcons(debuffs, unit, debuffs.filter or 'HARMFUL', numDebuffs, true)
		debuffs.visibleDebuffs = visibleDebuffs

		local fromRange, toRange
		if(debuffs.PreSetPosition) then
			fromRange, toRange = debuffs:PreSetPosition(numDebuffs)
		end

		if(fromRange or debuffs.createdButtons > debuffs.anchoredButtons) then
			(debuffs.SetPosition or SetPosition) (debuffs, fromRange or debuffs.anchoredButtons + 1, toRange or debuffs.createdButtons)
			debuffs.anchoredButtons = debuffs.createdButtons
		end

		if(debuffs.PostUpdate) then debuffs:PostUpdate(unit) end
	end
end

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	UpdateAuras(self, event, unit)

	-- Assume no event means someone wants to re-anchor things. This is usually
	-- done by UpdateAllElements and :ForceUpdate.
	if(event == 'ForceUpdate' or not event) then
		local auras = self.Auras
		if(auras) then
			(auras.SetPosition or SetPosition) (auras, 1, auras.createdButtons)
		end

		local buffs = self.Buffs
		if(buffs) then
			(buffs.SetPosition or SetPosition) (buffs, 1, buffs.createdButtons)
		end

		local debuffs = self.Debuffs
		if(debuffs) then
			(debuffs.SetPosition or SetPosition) (debuffs, 1, debuffs.createdButtons)
		end
	end
end

local function ForceUpdate(element)
	return Update(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	if(self.Auras or self.Buffs or self.Debuffs) then
		self:RegisterEvent('UNIT_AURA', UpdateAuras)
		if(LibClassicDurations) then
			LibClassicDurations.RegisterCallback(self, 'UNIT_BUFF', UpdateAuras)
		end

		local auras = self.Auras
		if(auras) then
			auras.__owner = self
			-- check if there's any anchoring restrictions
			auras.__restricted = not pcall(self.GetCenter, self)
			auras.ForceUpdate = ForceUpdate

			auras.createdButtons = auras.createdButtons or 0
			auras.anchoredButtons = 0
			auras.tooltipAnchor = auras.tooltipAnchor or 'ANCHOR_BOTTOMRIGHT'

			-- auras:Show() -- ShestakUI
		end

		local buffs = self.Buffs
		if(buffs) then
			buffs.__owner = self
			-- check if there's any anchoring restrictions
			buffs.__restricted = not pcall(self.GetCenter, self)
			buffs.ForceUpdate = ForceUpdate

			buffs.createdButtons = buffs.createdButtons or 0
			buffs.anchoredButtons = 0
			buffs.tooltipAnchor = buffs.tooltipAnchor or 'ANCHOR_BOTTOMRIGHT'

			-- buffs:Show() -- ShestakUI
		end

		local debuffs = self.Debuffs
		if(debuffs) then
			debuffs.__owner = self
			-- check if there's any anchoring restrictions
			debuffs.__restricted = not pcall(self.GetCenter, self)
			debuffs.ForceUpdate = ForceUpdate

			debuffs.createdButtons = debuffs.createdButtons or 0
			debuffs.anchoredButtons = 0
			debuffs.tooltipAnchor = debuffs.tooltipAnchor or 'ANCHOR_BOTTOMRIGHT'

			-- debuffs:Show() -- ShestakUI
		end

		return true
	end
end

local function Disable(self)
	if(self.Auras or self.Buffs or self.Debuffs) then
		self:UnregisterEvent('UNIT_AURA', UpdateAuras)
		if(LibClassicDurations) then
			LibClassicDurations.UnregisterCallback(self, 'UNIT_BUFF')
		end

		if(self.Auras) then self.Auras:Hide() end
		if(self.Buffs) then self.Buffs:Hide() end
		if(self.Debuffs) then self.Debuffs:Hide() end
	end
end

oUF:AddElement('Auras', Update, Enable, Disable)
