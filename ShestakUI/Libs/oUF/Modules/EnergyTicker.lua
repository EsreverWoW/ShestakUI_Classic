local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_energy_ticker ~= true then return end

--[[ 
	self.EnergyTicker = CreateFrame("Frame", nil, self)
	self.EnergyTicker:SetFrameLevel(self.Power:GetFrameLevel() + 1)
]]

local parent, ns = ...
local oUF = ns.oUF
local LastEnergyTickTime = GetTime()
local LastEnergyValue = 0

local function SetEnergyTickValue(self, timer)
	local Power = self.Power
	local Width = Power:GetWidth()
	local Texture = self.EnergyTicker.Texture

	Texture:SetPoint("CENTER", Power, "LEFT", (Width * timer) / 2, 0)
end

local Update = function(self, elapsed)
	local PType = UnitPowerType("player")
	local EnergyTicker = self.EnergyTicker

	if PType ~= Enum.PowerType.Energy then
		EnergyTicker:SetAlpha(0)
	else
		EnergyTicker:SetAlpha(1)
	end

	local CurrentEnergy = UnitPower("player", Enum.PowerType.Energy)

	local Now = GetTime()
	local Timer = Now - LastEnergyTickTime

	if CurrentEnergy > LastEnergyValue or Now >= LastEnergyTickTime + 2 then
		LastEnergyTickTime = Now
	end

	SetEnergyTickValue(self, Timer)

	LastEnergyValue = CurrentEnergy
end

local Path = function(self, ...)
	return (self.EnergyTicker.Override or Update) (self, ...)
end

local Enable = function(self, unit)
	local EnergyTicker = self.EnergyTicker
	local Power = self.Power

	if (Power) and (EnergyTicker) and (unit == "player") then
		EnergyTicker.__owner = self
		EnergyTicker.UpdateFrame = CreateFrame("Frame")

		if not EnergyTicker.Texture then
			EnergyTicker.Texture = self.EnergyTicker:CreateTexture(nil, 'OVERLAY', 8)
			EnergyTicker.Texture:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
			EnergyTicker.Texture:SetSize(Power:GetHeight() + 4, Power:GetHeight() + 4)
			EnergyTicker.Texture:SetPoint("CENTER", Power, 0, 0)
			EnergyTicker.Texture:SetBlendMode("ADD")
		end

		EnergyTicker:SetAlpha(1)
		EnergyTicker.UpdateFrame:SetScript("OnUpdate", function() Path(self, unit) end)

		return true
	end
end

local Disable = function(self)
	local EnergyTicker = self.EnergyTicker
	local Power = self.Power

	if (Power) and (EnergyTicker) and (unit == "player") then
		EnergyTicker:SetAlpha(0)
		EnergyTicker.UpdateFrame:SetScript("OnUpdate", nil)

		return false
	end
end

oUF:AddElement("EnergyTicker", Path, Enable, Disable)
