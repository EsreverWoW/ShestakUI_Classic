local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.unitframe.enable ~= true or C.unitframe.plugins_power_spark ~= true then return end

local _, ns = ...
local oUF = ns.oUF
local lastTickTime = GetTime()
local tickValue = 2
local currentValue = UnitPower('player')
local lastValue = currentValue
local allowPowerEvent = true
local ignoredSpells = {
	[75]	= true,	-- Auto Shot
	[5019]	= true,	-- Shoot

	[1454]	= true,	-- Life Tap r1
	[1455]	= true,	-- Life Tap r2
	[1456]	= true,	-- Life Tap r3
	[11687]	= true,	-- Life Tap r4
	[11688]	= true,	-- Life Tap r5
	[11689]	= true,	-- Life Tap r6
	[27222]	= true,	-- Life Tap r7

	[12051]	= true,	-- Evocation

	[18182]	= true,	-- Improved Life Tap r1
	[18183]	= true,	-- Improved Life Tap r2

	[31818]	= true,	-- Life Tap (Mana Return Effect)
	[32553]	= true,	-- Life Tap (Mana Return Effect)

	[5677]	= true,	-- Mana Spring r1
	[10491]	= true,	-- Mana Spring r2
	[10493]	= true,	-- Mana Spring r3
	[10494]	= true,	-- Mana Spring r4
	[25569]	= true,	-- Mana Spring r5
	[24853]	= true,	-- Mana Spring ??
}

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

		-- element.disableMax to override energy ticker when at max energy
		if(not currentValue or (currentValue >= UnitPowerMax('player', powerType) and (powerType ~= Enum.PowerType.Energy or element.disableMax))) then
			element:SetValue(0)
			element.Spark:Hide()
			return
		end

		if powerType == Enum.PowerType.Mana and (not currentValue or currentValue >= UnitPowerMax('player', Enum.PowerType.Mana)) then
			element:SetValue(0)
			element.Spark:Hide()
			return
		end

		local now = GetTime() or 0
		if(not (now == nil)) then
			local timer = now - lastTickTime

			if((currentValue > lastValue) or powerType == Enum.PowerType.Energy and (now >= lastTickTime + 2)) then
				lastTickTime = now
			end

			if(timer > 0) then -- Energy
				element.Spark:Show()
				element:SetMinMaxValues(0, 2)
				element.Spark:SetVertexColor(1, 1, 1, 1)
				element:SetValue(timer)
				allowPowerEvent = true

				lastValue = currentValue
			elseif timer < 0 then -- Mana
				element.Spark:Show()
				element:SetMinMaxValues(0, 5)
				element.Spark:SetVertexColor(1, 1, 0, 1)
				element:SetValue(math.abs(timer))
			end

			element.sinceLastUpdate = 0
		end
	end
end

local EventHandler = function(_, event, _, _, spellID)
	local powerType = UnitPowerType('player')

	if(powerType ~= Enum.PowerType.Mana) then
		return
	end

	if(event == 'UNIT_POWER_UPDATE' and allowPowerEvent) then
		local time = GetTime()

		tickValue = time - lastTickTime

		if tickValue > 5 then
			if powerType == Enum.PowerType.Mana and InCombatLockdown() then
				tickValue = 5
			else
				tickValue = 2
			end
		end

		lastTickTime = time
	end

	if(event == 'UNIT_SPELLCAST_SUCCEEDED') then
		local powerCost = GetSpellPowerCost(spellID)
		local cost = powerCost[1] and powerCost[1].cost

		if (not cost or ignoredSpells[spellID]) then
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

		element.Spark:Hide()
		element:SetScript('OnUpdate', nil)

		return false
	end
end

oUF:AddElement('PowerSpark', Path, Enable, Disable)
