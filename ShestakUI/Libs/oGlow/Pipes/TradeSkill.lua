local _E
local hook

local pipe
if oGlow:IsClassic() then
	pipe = function(id)
		if not id then return end
		local itemLink = GetTradeSkillItemLink(id)

		if itemLink then
			oGlow:CallFilters("tradeskill", TradeSkillSkillIcon, _E and itemLink)
		end

		for i = 1, GetTradeSkillNumReagents(id) do
			local reagentFrame = _G["TradeSkillReagent"..i.."IconTexture"]
			local reagentLink = GetTradeSkillReagentItemLink(id, i)

			oGlow:CallFilters("tradeskill", reagentFrame, _E and reagentLink)
		end
	end
else
	pipe = function(_, id)
		if not id then return end
		local itemLink = C_TradeSkillUI.GetRecipeItemLink(id)

		if itemLink then
			oGlow:CallFilters("tradeskill", TradeSkillFrame.DetailsFrame.Contents.ResultIcon, _E and itemLink)
		end

		for i = 1, C_TradeSkillUI.GetRecipeNumReagents(id) do
			local reagentFrame = TradeSkillFrame.DetailsFrame.Contents.Reagents[i].Icon
			local reagentLink = C_TradeSkillUI.GetRecipeReagentItemLink(id, i)

			oGlow:CallFilters("tradeskill", reagentFrame, _E and reagentLink)
		end
	end
end

local doHook = function()
	if not hook then
		hook = function(...)
			if _E then return pipe(...) end
		end

		if oGlow:IsClassic() then
			hooksecurefunc("TradeSkillFrame_SetSelection", hook)
		else
			hooksecurefunc(TradeSkillFrame.RecipeList, "SetSelectedRecipeID", hook)
		end
	end
end

local function ADDON_LOADED(self, event, addon)
	if addon == "Blizzard_TradeSkillUI" then
		doHook()
		self:UnregisterEvent(event, ADDON_LOADED)
	end
end

local update = function(self)
	local id = GetTradeSkillSelectionIndex()
	if id and IsAddOnLoaded("Blizzard_TradeSkillUI") then
		return pipe(id)
	end
end

local enable = function(self)
	_E = true

	if IsAddOnLoaded("Blizzard_TradeSkillUI") then
		doHook()
	else
		self:RegisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local disable = function(self)
	_E = nil

	self:UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
end

oGlow:RegisterPipe("tradeskill", enable, disable, update, "Profession frame")
