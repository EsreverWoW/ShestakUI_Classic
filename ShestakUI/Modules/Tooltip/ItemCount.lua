local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.item_count ~= true then return end

----------------------------------------------------------------------------------------
--	Item count in bags and bank(by Tukz)
----------------------------------------------------------------------------------------
local function OnTooltipSetItem(self)
	local _, link = T.Classic and self:GetItem() or TooltipUtil.GetDisplayedItem(self)
	local num = GetItemCount(link, true)

	if num > 1 then
		self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_COUNT.." "..num.."|r")
	end
end
if T.Classic then
	GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
else
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
end
