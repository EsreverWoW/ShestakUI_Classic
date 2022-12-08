local T, C, L, _ = unpack(select(2, ...))
if C.loot.lootframe == true then return end

local hook
local _E

local update = function(self)
	if oGlow:IsClassic() then
		if LootFrame:IsShown() and oGlow:IsPipeEnabled("loot") then
			for i = 1, LOOTFRAME_NUMBUTTONS or 4 do
				local slotFrame = _G["LootButton"..i]
				local slot = slotFrame.slot

				local itemLink
				if slot then
					itemLink = GetLootSlotLink(slot)
				end

				oGlow:CallFilters("loot", slotFrame, _E and itemLink)
			end
		end
	else
		local slot = self:GetSlotIndex()
		local slotFrame = self.Item

		local itemLink
		if slot then
			itemLink = GetLootSlotLink(slot)
		end

		oGlow:CallFilters("loot", slotFrame, _E and itemLink)
	end
end

local enable = function(self)
	_E = true

	if not hook then
		if oGlow:IsClassic() then
			LootFrameUpButton:HookScript("OnClick", update)
			LootFrameDownButton:HookScript("OnClick", update)
		else
			hooksecurefunc(LootFrameElementMixin, "Init", update)
		end

		hook = true
	end

	if oGlow:IsClassic() then
		self:RegisterEvent("LOOT_OPENED", update)
		self:RegisterEvent("LOOT_SLOT_CLEARED", update)
		self:RegisterEvent("LOOT_SLOT_CHANGED", update)
	end
end

local disable = function(self)
	_E = nil

	if oGlow:IsClassic() then
		self:UnregisterEvent("LOOT_OPENED", update)
		self:UnregisterEvent("LOOT_SLOT_CLEARED", update)
		self:UnregisterEvent("LOOT_SLOT_CHANGED", update)
	end
end

oGlow:RegisterPipe("loot", enable, disable, update, "Loot frame")
