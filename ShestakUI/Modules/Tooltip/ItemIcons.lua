local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.item_icon ~= true then return end

----------------------------------------------------------------------------------------
--	Adds item icons to tooltips(Tipachu by Tuller)
----------------------------------------------------------------------------------------
local function setTooltipIcon(self, icon)
	local title = icon and _G[self:GetName().."TextLeft1"]
	if title then
		title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 20, title:GetText())
	end
end

local whiteTooltip = {
	[GameTooltip] = true,
	[ItemRefTooltip] = true,
	[ItemRefShoppingTooltip1] = true,
	[ItemRefShoppingTooltip2] = true,
	[ShoppingTooltip1] = true,
	[ShoppingTooltip2] = true,
}

if T.Classic then
	local function newTooltipHooker(method, func)
		return function(tooltip)
			local modified = false

			tooltip:HookScript("OnTooltipCleared", function()
				modified = false
			end)

			tooltip:HookScript(method, function(self, ...)
				if not modified then
					modified = true
					func(self, ...)
				end
			end)
		end
	end

	local hookItem = newTooltipHooker("OnTooltipSetItem", function(self)
		local _, link = self:GetItem()
		if link then
			setTooltipIcon(self, GetItemIcon(link))
		end
	end)

	local hookSpell = newTooltipHooker("OnTooltipSetSpell", function(self)
		local _, id = self:GetSpell()
		if id then
			setTooltipIcon(self, select(3, GetSpellInfo(id)))
		end
	end)

	for tooltip in pairs(whiteTooltip) do
		hookItem(tooltip)
		hookSpell(tooltip)
	end
else
	local function hookItem(self)
		if whiteTooltip[self] then
			local _, link = TooltipUtil.GetDisplayedItem(self)
			if link then
				setTooltipIcon(self, GetItemIcon(link))
			end
		end
	end

	local function hookSpell(self)
		if whiteTooltip[self] then
			local _, id = self:GetSpell()
			if id then
				setTooltipIcon(self, select(3, GetSpellInfo(id)))
			end
		end
	end

	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, hookItem)
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, hookSpell)
end