local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_swing ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Swing(by p3lim and Thalyra)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local swingResets = {}
if T.classic then
	swingResets = {
		[GetSpellInfo(6807)]	= true, -- Maul
		[GetSpellInfo(2973)] 	= true, -- Raptor Strike
		[GetSpellInfo(845)]		= true, -- Cleave
		[GetSpellInfo(78)]		= true, -- Heroic Strike
		[GetSpellInfo(1464)]	= true, -- Slam
	}
end

local function OnDurationUpdate(self)
	self:SetMinMaxValues(self.min, self.max)

	local swingelapsed = GetTime()
	if swingelapsed > self.max then
		self:Hide()
		self:SetScript("OnUpdate", nil)
	else
		self:SetValue(self.min + (swingelapsed - self.min))

		if self.Text then
			if self.OverrideText then
				self:OverrideText(swingelapsed)
			else
				self.Text:SetFormattedText("%.1f", self.max - swingelapsed)
			end
		end
	end
end

local function Melee(self)
	local _, event, _, GUID, _, _, _, tarGUID, _, _, _, missType, spellName, _, _, _, _, _, _, _, isOffhand = CombatLogGetCurrentEventInfo()
	local bar = self.Swing
	local barOH = self.SwingOH

	local now = GetTime()
	local mhSpeed, ohSpeed = UnitAttackSpeed(self.unit)
	local itemId = GetInventoryItemID("player", 17)

	local itemType = itemId and select(6, GetItemInfo(itemId)) or ""
	local weaponType = GetItemInfo(25) or WEAPON
	local isWeapon = itemType == weaponType

	if UnitGUID(self.unit) == tarGUID and event == "SWING_MISSED" then
		if missType == "PARRY" then
			bar.max = bar.max or bar.min + mhSpeed -- prevent issues swapping from ranged
			bar.max = bar.min + ((bar.max - bar.min) * 0.6)
			bar:SetMinMaxValues(bar.min, bar.max)

			if isWeapon and barOH then
				barOH.max = barOH.max or barOH.min + ohSpeed -- prevent issues swapping from ranged
				barOH.max = barOH.min + ((barOH.max - barOH.min) * 0.6)
				barOH:SetMinMaxValues(barOH.min, barOH.max)
			end
		end
	elseif UnitGUID(self.unit) == GUID then
		local shouldReset
		if event == "SPELL_DAMAGE" or event == "SPELL_MISSED" then
			if swingResets[spellName] then
				shouldReset = true
			end
		end

		if not (string.find(event, "SWING") or shouldReset) then return end

		local offhandEvent = (event == "SWING_DAMAGE" and isOffhand == true) or (event == "SWING_MISSED" and spellName == true)

		if isWeapon and barOH and offhandEvent then
			barOH.min = now
			barOH.max = barOH.min + ohSpeed

			barOH:Show()
			barOH:SetMinMaxValues(barOH.min, barOH.max)
			barOH:SetScript("OnUpdate", OnDurationUpdate)
		else
			bar.min = now
			bar.max = bar.min + mhSpeed

			bar:Show()
			bar:SetMinMaxValues(bar.min, bar.max)
			bar:SetScript("OnUpdate", OnDurationUpdate)
		end
	end
end

local function Ranged(self, _, unit, _, spellID)
	if spellID ~= 75 and spellID ~= 5019 then return end

	local bar = self.Swing
	bar.min = GetTime()
	bar.max = bar.min + UnitRangedDamage(unit)

	bar:Show()
	bar:SetMinMaxValues(bar.min, bar.max)
	bar:SetScript("OnUpdate", OnDurationUpdate)
end

local function Ooc(self)
	local bar = self.Swing
	local barOH = self.SwingOH
	bar:Hide()
	if barOH then barOH:Hide() end
end

local function Enable(self, unit)
	local bar = self.Swing
	local barOH = self.SwingOH
	if bar and unit == "player" then

		if not bar.disableRanged then
			self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", Ranged)
		end

		if not bar.disableMelee then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", Melee, true)
		end

		if not bar.disableOoc then
			self:RegisterEvent("PLAYER_REGEN_ENABLED", Ooc, true)
		end

		bar:Hide()
		if barOH then barOH:Hide() end

		return true
	end
end

local function Disable(self)
	local bar = self.Swing
	if bar then
		if not bar.disableRanged then
			self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", Ranged)
		end

		if not bar.disableMelee then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", Melee)
		end

		if not bar.disableOoc then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED", Ooc)
		end
	end
end

oUF:AddElement("Swing", nil, Enable, Disable)