local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_power_spark ~= true then return end

local _, ns = ...
local oUF = ns.oUF
local lastTickTime = GetTime()
local tickValue = 2
local currentValue = UnitPower('player')
local lastValue = currentValue
local allowPowerEvent = true

local Update = function(self, elapsed)
	local element = self.PowerSpark

	element.sinceLastUpdate = (element.sinceLastUpdate or 0) + (tonumber(elapsed) or 0)

	if(element.sinceLastUpdate > 0.01) then
		local powerType = UnitPowerType('player')

		element:SetValue(0)
		element.Spark:Hide()

		if(powerType ~= Enum.PowerType.Energy and powerType ~= Enum.PowerType.Mana) then
			return
		end

		currentValue = UnitPower('player', powerType)

		-- element.disableMax to overide energy ticker when at max energy
		if(not currentValue or (currentValue >= UnitPowerMax('player', powerType) and (powerType ~= Enum.PowerType.Energy or element.disableMax))) then
			return
		end

		local now = GetTime() or 0
		if(not (now == nil)) then
			local timer = now - lastTickTime

			if((currentValue > lastValue) or (now >= lastTickTime + tickValue)) then
				lastTickTime = now
			end

			if(timer > 0) then
				element.Spark:Show()
				element:SetValue(timer)
				allowPowerEvent = true
			end

			lastValue = currentValue
			element.sinceLastUpdate = 0
		end
	end
end

local EventHandler = function(self, event, _, _, spellID)
	local powerType = UnitPowerType('player')

	if(powerType ~= Enum.PowerType.Mana) then
		return
	end

	if(event == 'PLAYER_REGEN_ENABLED') then
		tickValue = 2
	elseif(event == 'PLAYER_REGEN_DISABLED') then
		tickValue = 5
	end

	if(event == 'UNIT_POWER_UPDATE' and allowPowerEvent) then
		lastTickTime = GetTime()
	end

	if(event == 'UNIT_SPELLCAST_SUCCEEDED') then
		-- prevent ranged weapon from triggering
		if(spellID == 75 or spellID == 5019) then
			return
		end

		lastTickTime = GetTime() + 5
		allowPowerEvent = false
	end
end

local Path = function(self, ...)
	return (self.PowerSpark.Override or Update) (self, ...)
end

local Enable = function(self, unit)
	local element = self.PowerSpark
	local power = self.Power

	if((unit == 'player') and element and power) then
		element.__owner = self

		if(element:IsObjectType('StatusBar')) then
			element:SetStatusBarTexture([[Interface\Buttons\WHITE8X8]])
			element:GetStatusBarTexture():SetAlpha(0)
			element:SetMinMaxValues(0, 2)
		end

		local spark = element.Spark
		if(spark and spark:IsObjectType('Texture')) then
			spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
			spark:SetSize(20, 20)
			spark:SetBlendMode('ADD')
			spark:SetPoint('CENTER', element:GetStatusBarTexture(), 'RIGHT')
		end

		self:RegisterEvent('PLAYER_REGEN_ENABLED', EventHandler, true)
		self:RegisterEvent('PLAYER_REGEN_DISABLED', EventHandler, true)
		self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', EventHandler)
		self:RegisterEvent('UNIT_POWER_UPDATE', EventHandler)

		element:SetScript('OnUpdate', function(_, elapsed) Path(self, elapsed) end)

		return true
	end
end

local Disable = function(self)
	local element = self.PowerSpark
	local power = self.Power

	if((power) and (element)) then
		self:UnregisterEvent('PLAYER_REGEN_ENABLED', EventHandler, true)
		self:UnregisterEvent('PLAYER_REGEN_DISABLED', EventHandler, true)
		self:UnregisterEvent('UNIT_SPELLCAST_SUCCEEDED', EventHandler)
		self:UnregisterEvent('UNIT_POWER_UPDATE', EventHandler)

		element:SetScript('OnUpdate', nil)

		return false
	end
end

oUF:AddElement('PowerSpark', Path, Enable, Disable)
