local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Force readycheck warning
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(_, initiator)
	if initiator ~= "player" then
		PlaySound(SOUNDKIT.READY_CHECK, "Master")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
if T.Mainline then
	ForceWarning:RegisterEvent("PET_BATTLE_QUEUE_PROPOSE_MATCH")
	ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
end
ForceWarning:RegisterEvent("RESURRECT_REQUEST")
ForceWarning:SetScript("OnEvent", function(_, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" then
		for i = 1, GetMaxBattlefieldID() do
			local status = GetBattlefieldStatus(i)
			if status == "confirm" then
				PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE, "Master")
				break
			end
			i = i + 1
		end
	elseif event == "PET_BATTLE_QUEUE_PROPOSE_MATCH" then
		PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE, "Master")
	elseif event == "LFG_PROPOSAL_SHOW" then
		PlaySound(SOUNDKIT.READY_CHECK, "Master")
	elseif event == "RESURRECT_REQUEST" then
		PlaySound(37, "Master")
	end
end)

----------------------------------------------------------------------------------------
--	Misclicks for some popups
----------------------------------------------------------------------------------------
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
PetBattleQueueReadyFrame.hideOnEscape = nil
if T.Classic then
	PVPReadyDialog.hideButton:Hide()
	PVPReadyDialog.enterButton:ClearAllPoints()
	PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 16)
else
	PVPReadyDialog.leaveButton:Hide()
	PVPReadyDialog.enterButton:ClearAllPoints()
	PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)
end

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclipse)
----------------------------------------------------------------------------------------
if C.misc.afk_spin_camera == true then
	local spinning
	local function SpinStart()
		spinning = true
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	local function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		if InCombatLockdown() then return end
		UIParent:Show()
	end

	local SpinCam = CreateFrame("Frame")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", function(_, event)
		if event == "PLAYER_LEAVING_WORLD" then
			SpinStop()
		else
			if UnitIsAFK("player") and not InCombatLockdown() then
				SpinStart()
			else
				SpinStop()
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
----------------------------------------------------------------------------------------
if T.Mainline then
	-- It cause taint SetEntryTitle()
	-- local firstLFD
	-- LFDParentFrame:HookScript("OnShow", function()
		-- if not firstLFD then
			-- firstLFD = 1
			-- for i = 1, GetNumRandomDungeons() do
				-- local id = GetLFGRandomDungeonInfo(i)
				-- local isHoliday = select(15, GetLFGDungeonInfo(id))
				-- if isHoliday and not GetLFGDungeonRewards(id) then
					-- LFDQueueFrame_SetType(id)
				-- end
			-- end
		-- end
	-- end)
end

----------------------------------------------------------------------------------------
--	Undress button in dress-up frame(by Nefarion)
----------------------------------------------------------------------------------------
local strip = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate")
strip:SetText(L_MISC_UNDRESS)
strip:SetWidth(strip:GetTextWidth() + 40)
strip:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
if T.Classic then
	strip:SetFrameLevel(DressUpModelFrame:GetFrameLevel() + 2)
end
strip:RegisterForClicks("AnyUp")
strip:SetScript("OnClick", function(self, button)
	local actor = T.Classic and self.model or T.Mainline and DressUpFrame.ModelScene:GetPlayerActor()
	if not actor then return end
	if button == "RightButton" then
		actor:UndressSlot(19)
	else
		actor:Undress()
	end
	PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)

if T.Classic then
	strip:RegisterEvent("AUCTION_HOUSE_SHOW")
	strip:RegisterEvent("AUCTION_HOUSE_CLOSED")
	strip:SetScript("OnEvent", function(self)
		if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
			self:SetParent(SideDressUpModel)
			self:ClearAllPoints()
			self:SetPoint("TOP", SideDressUpModelResetButton, "BOTTOM", 0, -3)
			self.model = SideDressUpModel
		elseif self.model ~= DressUpModelFrame then
			self:SetParent(DressUpModelFrame)
			self:ClearAllPoints()
			self:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -2, 0)
			self.model = DressUpModelFrame
		end
	end)
end

----------------------------------------------------------------------------------------
--	Boss Banner Hider
----------------------------------------------------------------------------------------
if T.Mainline then
	if C.general.hide_banner == true then
		BossBanner.PlayBanner = function() end
	end
end

----------------------------------------------------------------------------------------
--	Easy delete good items
----------------------------------------------------------------------------------------
local deleteDialog = StaticPopupDialogs["DELETE_GOOD_ITEM"]
if deleteDialog.OnShow then
	hooksecurefunc(deleteDialog, "OnShow", function(s) s.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) s.editBox:SetAutoFocus(false) s.editBox:ClearFocus() end)
end

----------------------------------------------------------------------------------------
--	Change UIErrorsFrame strata
----------------------------------------------------------------------------------------
UIErrorsFrame:SetFrameLevel(0)

----------------------------------------------------------------------------------------
--	Increase speed for AddonList scroll
----------------------------------------------------------------------------------------
if T.Mainline then
	AddonList.ScrollBox.wheelPanScalar = 6
	AddonList.ScrollBar.wheelPanScalar = 6
end

----------------------------------------------------------------------------------------
--	Max Camera Distance
----------------------------------------------------------------------------------------
if C.misc.max_camera_distance == true then
	local OnLogon = CreateFrame("Frame")
	OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
	OnLogon:SetScript("OnEvent", function()
		SetCVar("cameraDistanceMaxZoomFactor", T.Classic and 3.4 or 2.6)
	end)
end