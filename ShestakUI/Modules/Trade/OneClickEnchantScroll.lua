local T, C, L = unpack(ShestakUI)
if C.trade.enchantment_scroll ~= true or IsAddOnLoaded("OneClickEnchantScroll") then return end

----------------------------------------------------------------------------------------
--	Enchantment scroll on TradeSkill frame(OneClickEnchantScroll by Sara.Festung)
----------------------------------------------------------------------------------------
if T.Classic then
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(self, event, addon)
		if addon == "Blizzard_TradeSkillUI" and not IsAddOnLoaded("OneClickEnchantScroll") then
			local button = CreateFrame("Button", "TradeSkillCreateScrollButton", TradeSkillFrame, "MagicButtonTemplate")
			if C.skins.blizzard_frames == true then
				button:SkinButton(true)
				button:SetPoint("TOPRIGHT", TradeSkillCreateButton, "TOPLEFT", -1, 0)
			else
				button:SetPoint("TOPRIGHT", TradeSkillCreateButton, "TOPLEFT")
			end
			button:SetScript("OnClick", function()
				DoTradeSkill(TradeSkillFrame.selectedSkill)
				UseItemByName(38682)
			end)

			hooksecurefunc("TradeSkillFrame_SetSelection", function(id)
				local skillName, _, _, _, altVerb = GetTradeSkillInfo(id)
				if IsTradeSkillGuild() or IsTradeSkillLinked() then
					button:Hide()
				elseif altVerb and CURRENT_TRADESKILL == GetSpellInfo(7411) then
					button:Show()
					local creatable = 1
					if not skillName then
						creatable = nil
					end
					local scrollnum = GetItemCount(38682)
					button:SetText(L_MISC_SCROLL.." ("..scrollnum..")")
					if scrollnum == 0 then
						creatable = nil
					end
					for i = 1, GetTradeSkillNumReagents(id) do
						local _, _, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i)
						if playerReagentCount < reagentCount then
							creatable = nil
						end
					end
					if creatable then
						button:Enable()
					else
						button:Disable()
					end
				else
					button:Hide()
				end
			end)
		end
	end)
else
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(_, _, addon)
		if addon == "Blizzard_Professions" then
			local button = CreateFrame("Button", "TradeSkillCreateScrollButton", ProfessionsFrame, "MagicButtonTemplate")
			if C.skins.blizzard_frames == true then
				button:SkinButton(true)
				button:SetPoint("TOPRIGHT", ProfessionsFrame.CraftingPage.CreateButton, "TOPLEFT", -1, 0)
			else
				button:SetPoint("TOPRIGHT", ProfessionsFrame.CraftingPage.CreateButton, "TOPLEFT")
			end
			button:SetScript("OnClick", function()
				local currentRecipeInfo = ProfessionsFrame.CraftingPage.SchematicForm:GetRecipeInfo()
				if currentRecipeInfo then
					C_TradeSkillUI.CraftRecipe(currentRecipeInfo.recipeID)
					UseItemByName(38682)
				end
			end)

			hooksecurefunc(ProfessionsFrame.CraftingPage, "ValidateControls", function(self)
				if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() or C_TradeSkillUI.IsTradeSkillLinked() then
					button:Hide()
				else
					local currentRecipeInfo = ProfessionsFrame.CraftingPage.SchematicForm:GetRecipeInfo()
					if currentRecipeInfo and currentRecipeInfo.alternateVerb then
						local professionInfo = ProfessionsFrame:GetProfessionInfo()
						if professionInfo and professionInfo.parentProfessionID == 333 then
							button:Show()
							local isEnchantingRecipe = currentRecipeInfo.isEnchantingRecipe
							local numScrollsAvailable = GetItemCount(38682)
							button:SetText(L_MISC_SCROLL.." ("..numScrollsAvailable..")")
							if numScrollsAvailable == 0 then
								isEnchantingRecipe = false
							end
							if isEnchantingRecipe then
								button:Enable()
							else
								button:Disable()
							end
						else
							button:Hide()
						end
					else
						button:Hide()
					end
				end
			end)
		end
	end)
end