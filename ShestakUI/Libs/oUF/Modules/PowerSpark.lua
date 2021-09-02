local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.unitframe.enable ~= true or C.unitframe.plugins_power_spark ~= true then return end

local _, ns = ...
local oUF = ns.oUF

local lastTickTime = GetTime()
local tickDelay = 2.025 -- Average tick time is slightly over 2 seconds
local currentValue = UnitPower('player')
local lastValue = currentValue
local mp5Delay = 5
local mp5DelayWillEnd = nil

local mp5IgnoredSpells = {
	[1454]	= true,	-- Life Tap r1
	[1455]	= true,	-- Life Tap r2
	[1456]	= true,	-- Life Tap r3
	[11687]	= true,	-- Life Tap r4
	[11688]	= true,	-- Life Tap r5
	[11689]	= true,	-- Life Tap r6
	[27222]	= true,	-- Life Tap r7
	[18182]	= true,	-- Improved Life Tap r1
	[18183]	= true,	-- Improved Life Tap r2
}

-- Sets tick time to the last possible time based on the last tick
local UpdateTickTime = function(now)
	lastTickTime = now - ((now - lastTickTime) % tickDelay)
end

local Update = function(self, elapsed)
	local element = self.PowerSpark
	element.sinceLastUpdate = (element.sinceLastUpdate or 0) + (tonumber(elapsed) or 0)

	if(element.sinceLastUpdate > 0.01) then
		local powerType = UnitPowerType('player')
		if(powerType ~= Enum.PowerType.Energy and powerType ~= Enum.PowerType.Mana) then
			element.Spark:Hide()
			return
		end

		currentValue = UnitPower('player', powerType)
		local maxPower = UnitPowerMax('player', powerType)
		local now = GetTime()

		if(powerType == Enum.PowerType.Mana) then
			if currentValue >= maxPower then
				element:SetValue(0)
				element.Spark:Hide()
				return
			end

			-- Sync last tick time after 5 seconds are over
			if mp5DelayWillEnd and mp5DelayWillEnd < now then
				mp5DelayWillEnd = nil
				UpdateTickTime(now)
			end
		elseif(powerType == Enum.PowerType.Energy) then
			-- If energy is not full we just wait for the next tick
			if now >= lastTickTime + tickDelay and currentValue >= maxPower then
				UpdateTickTime(now)
			end
		end

		if mp5DelayWillEnd and powerType == Enum.PowerType.Mana then
			-- Show 5 second indicator
			element.Spark:Show()
			element:SetMinMaxValues(0, mp5Delay)
			element.Spark:SetVertexColor(1, 1, 0, 1)
			element:SetValue(mp5DelayWillEnd - now)
		else
			-- Show tick indicator
			element.Spark:Show()
			element:SetMinMaxValues(0, tickDelay)
			element.Spark:SetVertexColor(1, 1, 1, 1)
			element:SetValue(now - lastTickTime)
		end

		element.sinceLastUpdate = 0
	end
end

local OnUnitPowerUpdate = function()
	local powerType = UnitPowerType('player')
	if powerType ~= Enum.PowerType.Mana and powerType ~= Enum.PowerType.Energy then
		return
	end

	-- We also register ticks from mp5 gear within the 5-second-rule to get a more accurate sync later.
	-- Unfortunately this registers a tick when a mana pot or life tab is used.
	local CurrentValue = UnitPower('player', powerType)
	if CurrentValue > lastValue then
		lastTickTime = GetTime()
	end
	lastValue = CurrentValue
end

local OnUnitSpellcastSucceeded = function(_, _, _, _, spellID)
	local powerType = UnitPowerType('player')
	if powerType ~= Enum.PowerType.Mana then
		return
	end

	local spellCost = false
	local costTable = GetSpellPowerCost(spellID)
	for _, costInfo in next, costTable do
		if costInfo.cost then
			spellCost = true
		end
	end

	if not spellCost or mp5IgnoredSpells[spellID] then
		return
	end

	mp5DelayWillEnd = GetTime() + 5
end

local Path = function(self, ...)
	return (self.PowerSpark.Override or Update) (self, ...)
end

local Enable = function(self, unit)
	local element = self.PowerSpark
	local power = self.Power

	if((unit == 'player') and element and power and T.class ~= 'WARRIOR') then
		element.__owner = self
		element.sparksize = element.sparksize or 20

		if(element:IsObjectType('StatusBar')) then
			element:SetStatusBarTexture([[Interface\Buttons\WHITE8X8]])
			element:GetStatusBarTexture():SetAlpha(0)
			element:SetMinMaxValues(0, 2)
		end

		local spark = element.Spark
		if(spark and spark:IsObjectType('Texture')) then
			local orientation = element:GetOrientation()
			local relativePoint = orientation == 'VERTICAL' and 'TOP' or 'RIGHT'

			spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
			spark:SetSize(element.sparksize, element.sparksize)
			spark:SetBlendMode('ADD')
			spark:SetPoint('CENTER', element:GetStatusBarTexture(), relativePoint)
		end

		self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', OnUnitSpellcastSucceeded)
		self:RegisterEvent('UNIT_POWER_UPDATE', OnUnitPowerUpdate)

		element:SetScript('OnUpdate', function(_, elapsed) Path(self, elapsed) end)

		return true
	end
end

local Disable = function(self)
	local element = self.PowerSpark
	local power = self.Power

	if((power) and (element)) then
		self:UnregisterEvent('UNIT_SPELLCAST_SUCCEEDED', OnUnitSpellcastSucceeded)
		self:UnregisterEvent('UNIT_POWER_UPDATE', OnUnitPowerUpdate)

		element.Spark:Hide()
		element:SetScript('OnUpdate', nil)

		return false
	end
end

oUF:AddElement('PowerSpark', Path, Enable, Disable)
