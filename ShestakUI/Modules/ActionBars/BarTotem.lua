local T, C, L = unpack(select(2, ...))
if C.actionbar.enable ~= true or T.class ~= "SHAMAN" or C.actionbar.stancebar_hide == true then return end

----------------------------------------------------------------------------------------
--	Setup Totem Bar by Tukz
----------------------------------------------------------------------------------------
if MultiCastActionBarFrame then
    MultiCastActionBarFrame:SetScript("OnUpdate", nil)
    MultiCastActionBarFrame:SetScript("OnShow", nil)
    MultiCastActionBarFrame:SetScript("OnHide", nil)
    MultiCastActionBarFrame:SetParent(StanceBarAnchor)
    MultiCastActionBarFrame:ClearAllPoints()
    MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", StanceBarAnchor, "BOTTOMLEFT", -3, -3)

    hooksecurefunc("MultiCastActionButton_Update", function(button) if not InCombatLockdown() then button:SetAllPoints(button.slotButton) end end)

    for i = 1, 12 do
        if i < 6 then
            local button = _G["MultiCastSlotButton"..i] or MultiCastRecallSpellButton
            local prev = _G["MultiCastSlotButton"..(i-1)] or MultiCastSummonSpellButton
            prev.idx = i - 1
            button:ClearAllPoints()
            ActionButton1.SetPoint(button, "LEFT", prev, "RIGHT", C.actionbar.button_space, 0)
        end
    end

    MultiCastActionBarFrame.SetParent = T.dummy
    MultiCastActionBarFrame.SetPoint = T.dummy
    MultiCastRecallSpellButton.SetPoint = T.dummy -- This causes taint
end