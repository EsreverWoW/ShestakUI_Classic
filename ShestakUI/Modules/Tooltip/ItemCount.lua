local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.item_count ~= true then return end

----------------------------------------------------------------------------------------
--	Item count in bags and bank(by Tukz)
----------------------------------------------------------------------------------------
local function OnTooltipSetItem(self, data)
	if self ~= GameTooltip or self:IsForbidden() then return end
	local num
	if T.Classic then
		local _, link = self:GetItem()
		num = GetItemCount(link, true)
	else
		num = GetItemCount(data.id, true)
	end

	if num > 1 then
		self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_COUNT.." "..num.."|r")
	end
end

if T.Classic then
	GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
else
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
end
