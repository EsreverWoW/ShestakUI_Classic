-- ShestakUI use old version of HealPrediction. Do not update if you are not sure what you are doing.

local _, ns = ...
local oUF = ns.oUF

if(not oUF:IsClassic()) then return end

local HealComm = LibStub("LibHealComm-4.0")

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local hp = self.HealPrediction
	if(hp.PreUpdate) then hp:PreUpdate(unit) end

	local GUID = UnitGUID(unit)
	local OverTimeHeals = (HealComm:GetHealAmount(GUID, HealComm.OVERTIME_AND_BOMB_HEALS) or 0) * (HealComm:GetHealModifier(GUID) or 1)
	local DirectHeals = UnitGetIncomingHeals(unit) or 0
	local IncomingHeals = DirectHeals >= DirectHeals + OverTimeHeals and DirectHeals or DirectHeals + OverTimeHeals
	local Health = UnitHealth(unit)
	local MaxHealth = UnitHealthMax(unit)

	if self.HealPrediction then
		self.HealPrediction:SetMinMaxValues(0, MaxHealth)

		if (IncomingHeals == 0) then
			self.HealPrediction:SetValue(0)
		elseif (Health + IncomingHeals >= MaxHealth) then
			self.HealPrediction:SetValue(MaxHealth)
		else
			self.HealPrediction:SetValue(Health + IncomingHeals)
		end
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

		self:RegisterEvent('UNIT_MAXHEALTH', Path)
		self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
		self:RegisterEvent('UNIT_HEAL_PREDICTION', Path)

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

		HealComm.UnregisterCallback(element, 'HealComm_HealStarted')
		HealComm.UnregisterCallback(element, 'HealComm_HealUpdated')
		HealComm.UnregisterCallback(element, 'HealComm_HealDelayed')
		HealComm.UnregisterCallback(element, 'HealComm_HealStopped')
		HealComm.UnregisterCallback(element, 'HealComm_ModifierChanged')
		HealComm.UnregisterCallback(element, 'HealComm_GUIDDisappeared')

		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
		self:UnregisterEvent('UNIT_HEAL_PREDICTION', Path)
	end
end


oUF:AddElement('HealPrediction', Path, Enable, Disable)