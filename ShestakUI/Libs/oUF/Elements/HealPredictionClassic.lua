-- ShestakUI use old version of HealPrediction. Do not update if you are not sure what you are doing.

local _, ns = ...
local oUF = ns.oUF

if(not oUF:IsClassic()) then return end

local myGUID = UnitGUID('player')
local HealComm = LibStub("LibHealComm-4.0")

local function UpdateFillBar(frame, previousTexture, bar, amount, maxHealth)
	if amount == 0 then
		bar:Hide()
		return previousTexture
	end

	local totalWidth, totalHeight = frame.Health:GetSize()
	if frame.Health:GetOrientation() == "VERTICAL" then
		bar:SetPoint("BOTTOM", previousTexture, "TOP", 0, 0)

		local barSize = (amount / maxHealth) * totalHeight
		bar:SetHeight(barSize)
	else
		bar:SetPoint('TOPLEFT', previousTexture, 'TOPRIGHT', 0, 0)
		bar:SetPoint('BOTTOMLEFT', previousTexture, 'BOTTOMRIGHT', 0, 0)

		local barSize = (amount / maxHealth) * totalWidth
		bar:SetWidth(barSize)
	end
	bar:Show()

	return bar
end

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local hp = self.HealPrediction
	if(hp.PreUpdate) then hp:PreUpdate(unit) end

	local guid = UnitGUID(unit)

	local allIncomingHeal = HealComm:GetHealAmount(guid, hp.healType) or 0
	local myIncomingHeal = (HealComm:GetHealAmount(guid, hp.healType, nil, myGUID) or 0) * (HealComm:GetHealModifier(myGUID) or 1)
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
	local otherIncomingHeal = 0

	if(health + allIncomingHeal > maxHealth * hp.maxOverflow) then
		allIncomingHeal = maxHealth * hp.maxOverflow - health
	end

	if(allIncomingHeal < myIncomingHeal) then
		myIncomingHeal = allIncomingHeal
	else
		otherIncomingHeal = HealComm:GetOthersHealAmount(guid, HealComm.ALL_HEALS) or 0
	end

	-- if health + myIncomingHeal + allIncomingHeal + totalAbsorb >= maxHealth then
		-- totalAbsorb = max(0, maxHealth - (health + myIncomingHeal + allIncomingHeal))
	-- end

	local previousTexture = self.Health:GetStatusBarTexture()

	previousTexture = UpdateFillBar(self, previousTexture, hp.myBar, myIncomingHeal, maxHealth)
	previousTexture = UpdateFillBar(self, previousTexture, hp.otherBar, otherIncomingHeal, maxHealth)
	-- previousTexture = UpdateFillBar(self, previousTexture, hp.absorbBar, totalAbsorb, maxHealth)

	if(hp.PostUpdate) then
		return hp:PostUpdate(unit)
	end
end

local function Path(self, ...)
	return (self.HealPrediction.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local element = self.HealPrediction
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate
		element.healType = element.healType or HealComm.ALL_HEALS

		self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
		self:RegisterEvent('UNIT_MAXHEALTH', Path)

		local function HealCommUpdate(...)
			if self.HealPrediction and self:IsVisible() then
				for i = 1, select('#', ...) do
					if self.unit and UnitGUID(self.unit) == select(i, ...) then
						Path(self, nil, self.unit)
					end
				end
			end
		end

		local function HealComm_Heal_Update(event, casterGUID, spellID, healType, _, ...)
			HealCommUpdate(...)
		end

		local function HealComm_Modified(event, guid)
			HealCommUpdate(guid)
		end

		HealComm.RegisterCallback(element, 'HealComm_HealStarted', HealComm_Heal_Update)
		HealComm.RegisterCallback(element, 'HealComm_HealUpdated', HealComm_Heal_Update)
		HealComm.RegisterCallback(element, 'HealComm_HealDelayed', HealComm_Heal_Update)
		HealComm.RegisterCallback(element, 'HealComm_HealStopped', HealComm_Heal_Update)
		HealComm.RegisterCallback(element, 'HealComm_ModifierChanged', HealComm_Modified)
		HealComm.RegisterCallback(element, 'HealComm_GUIDDisappeared', HealComm_Modified)

		if(not element.maxOverflow) then
			element.maxOverflow = 1.05
		end

		if(element.myBar) then
			if(element.myBar:IsObjectType('StatusBar') and not element.myBar:GetStatusBarTexture()) then
				element.myBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end
		end

		if(element.otherBar) then
			if(element.otherBar:IsObjectType('StatusBar') and not element.otherBar:GetStatusBarTexture()) then
				element.otherBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end
		end

		if(element.absorbBar) then
			if(element.absorbBar:IsObjectType('StatusBar') and not element.absorbBar:GetStatusBarTexture()) then
				element.absorbBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end
		end

		if(element.healAbsorbBar) then
			if(element.healAbsorbBar:IsObjectType('StatusBar') and not element.healAbsorbBar:GetStatusBarTexture()) then
				element.healAbsorbBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end
		end

		if(element.overAbsorb) then
			if(element.overAbsorb:IsObjectType('Texture') and not element.overAbsorb:GetTexture()) then
				element.overAbsorb:SetTexture([[Interface\RaidFrame\Shield-Overshield]])
				element.overAbsorb:SetBlendMode('ADD')
			end
		end

		if(element.overHealAbsorb) then
			if(element.overHealAbsorb:IsObjectType('Texture') and not element.overHealAbsorb:GetTexture()) then
				element.overHealAbsorb:SetTexture([[Interface\RaidFrame\Absorb-Overabsorb]])
				element.overHealAbsorb:SetBlendMode('ADD')
			end
		end

		return true
	end
end

local function Disable(self)
	local element = self.HealPrediction
	if(element) then
		if(element.myBar) then
			element.myBar:Hide()
		end

		if(element.otherBar) then
			element.otherBar:Hide()
		end

		if(element.absorbBar) then
			element.absorbBar:Hide()
		end

		if(element.healAbsorbBar) then
			element.healAbsorbBar:Hide()
		end

		if(element.overAbsorb) then
			element.overAbsorb:Hide()
		end

		if(element.overHealAbsorb) then
			element.overHealAbsorb:Hide()
		end

		HealComm.UnregisterCallback(element, 'HealComm_HealStarted')
		HealComm.UnregisterCallback(element, 'HealComm_HealUpdated')
		HealComm.UnregisterCallback(element, 'HealComm_HealDelayed')
		HealComm.UnregisterCallback(element, 'HealComm_HealStopped')
		HealComm.UnregisterCallback(element, 'HealComm_ModifierChanged')
		HealComm.UnregisterCallback(element, 'HealComm_GUIDDisappeared')

		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
	end
end


oUF:AddElement('HealPrediction', Path, Enable, Disable)