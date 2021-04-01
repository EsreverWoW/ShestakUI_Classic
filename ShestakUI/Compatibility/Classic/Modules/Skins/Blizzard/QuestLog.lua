local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true or IsAddOnLoaded("QuestLogEx") then return end -- incomplete

----------------------------------------------------------------------------------------
--	QuestLog skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestLogTimerText:SetTextColor(1, 1, 1)

	QuestLogFrame:SetAttribute("UIPanelLayout-width", T.Scale(685))
	QuestLogFrame:SetAttribute("UIPanelLayout-height", T.Scale(490))
	QuestLogFrame:SetSize(685, 490)
	QuestLogFrame:CreateBackdrop("Transparent")
	QuestLogFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	QuestLogFrame.backdrop:SetPoint("BOTTOMRIGHT", -1, 8)

	QuestLogTitleText:ClearAllPoints()
	QuestLogTitleText:SetPoint("TOP", QuestLogFrame.backdrop, "TOP", 0, -6)

	T.SkinCloseButton(QuestLogFrameCloseButton)
	QuestLogFrameCloseButton:ClearAllPoints()
	QuestLogFrameCloseButton:SetPoint("TOPRIGHT", -5, -16)

	QuestLogListScrollFrame:StripTextures()
	QuestLogListScrollFrame:CreateBackdrop("Default", true)
	QuestLogListScrollFrame.backdrop:SetPoint("TOPLEFT", -4, 4)
	QuestLogListScrollFrame:SetSize(301, 373)

	QuestLogDetailScrollFrame:StripTextures()
	QuestLogDetailScrollFrame:CreateBackdrop("Default", true)
	QuestLogDetailScrollFrame.backdrop:SetPoint("TOPLEFT", -4, 2)
	QuestLogDetailScrollFrame:SetSize(300, 375)
	QuestLogDetailScrollFrame:ClearAllPoints()
	QuestLogDetailScrollFrame:SetPoint("TOPRIGHT", QuestLogFrame, -32, -73)

	QuestLogNoQuestsText:ClearAllPoints()
	QuestLogNoQuestsText:SetPoint("CENTER", EmptyQuestLogFrame, "CENTER", -45, 65)

	QuestLogFrameAbandonButton:SetPoint("BOTTOMLEFT", 15, 15)
	QuestLogFrameAbandonButton:SetWidth(101)
	QuestLogFrameAbandonButton:SetText(ABANDON_QUEST)

	QuestFramePushQuestButton:ClearAllPoints()
	QuestFramePushQuestButton:SetPoint("LEFT", QuestLogFrameAbandonButton, "RIGHT", 2, 0)
	QuestFramePushQuestButton:SetWidth(101)
	QuestFramePushQuestButton:SetText(SHARE_QUEST)

	QuestFrameExitButton:SetPoint("BOTTOMRIGHT", -31, 15)
	QuestFrameExitButton:SetWidth(100)

	T.SkinScrollBar(QuestLogDetailScrollFrameScrollBar)
	T.SkinScrollBar(QuestLogListScrollFrameScrollBar)
	QuestLogListScrollFrameScrollBar:SetPoint("TOPLEFT", QuestLogListScrollFrame, "TOPRIGHT", 5, -16)

	local QuestStrip = {
		"QuestLogFrame",
		"QuestLogCount",
		"QuestLogQuestCount",
		"EmptyQuestLogFrame"
	}

	for i = 1, getn(QuestStrip) do
		local object = _G[QuestStrip[i]]
		if object then
			object:StripTextures(true)
		end
	end

	QuestLogQuestCount:ClearAllPoints()
	QuestLogQuestCount:SetPoint("TOPRIGHT", QuestLogFrame.backdrop, "TOPRIGHT", -32, -40)

	local QuestButtons = {
		"QuestLogFrameAbandonButton",
		"QuestFrameExitButton",
		"QuestFramePushQuestButton",
	}

	for i = 1, getn(QuestButtons) do
		local object = _G[QuestButtons[i]]
		if object then
			object:StripTextures()
			object:SkinButton()
		end
	end

	for i = 1, MAX_NUM_ITEMS do
		local item = _G["QuestLogItem"..i]
		local icon = _G["QuestLogItem"..i.."IconTexture"]
		local count = _G["QuestLogItem"..i.."Count"]

		item:StripTextures()
		item:SetTemplate("Default")
		item:StyleButton()
		item:SetSize(143, 40)
		item:SetFrameLevel(item:GetFrameLevel() + 2)

		icon:SetSize(32, 32)
		icon:SetDrawLayer("OVERLAY")
		icon:SetPoint("TOPLEFT", 4, -4)
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		-- count:SetParent(item.backdrop)
		count:SetDrawLayer("OVERLAY")
	end

	local function QuestQualityColors(frame, text, quality, link)
		if link and not quality then
			quality = select(3, GetItemInfo(link))
		end

		if T.BCC and frame then
			Mixin(frame, BackdropTemplateMixin) -- 9.0 to set backdrop
		end

		if quality then
			if frame then
				frame:SetBackdropBorderColor(GetItemQualityColor(quality))
				-- frame.backdrop:SetBackdropBorderColor(GetItemQualityColor(quality))
			end
			text:SetTextColor(GetItemQualityColor(quality))
		else
			if frame then
				frame:SetBackdropBorderColor(unpack(C.media.backdrop_color))
				-- frame.backdrop:SetBackdropBorderColor(unpack(C.media.backdrop_color))
			end
			text:SetTextColor(1, 1, 1)
		end
	end

	hooksecurefunc("QuestRewardItem_OnClick", function()
		QuestRewardItemHighlight:ClearAllPoints();
		QuestRewardItemHighlight:SetOutside(this:GetName().."IconTexture")
		_G[this:GetName().."Name"]:SetTextColor(1, 1, 0)

		for i = 1, MAX_NUM_ITEMS do
			local questItem = _G["QuestRewardItem"..i]
			local questName = _G["QuestRewardItem"..i.."Name"]
			local link = questItem.type and GetQuestItemLink(questItem.type, questItem:GetID())

			if questItem ~= this then
				QuestQualityColors(nil, questName, nil, link)
			end
		end
	end)

	local function QuestObjectiveTextColor()
		local numObjectives = GetNumQuestLeaderBoards()
		local objective
		local _, type, finished
		local numVisibleObjectives = 0
		for i = 1, numObjectives do
			_, type, finished = GetQuestLogLeaderBoard(i)
			if type ~= "spell" then
				numVisibleObjectives = numVisibleObjectives + 1
				objective = _G["QuestLogObjective"..numVisibleObjectives]
				if finished then
					objective:SetTextColor(1, 0.80, 0.10)
				else
					objective:SetTextColor(0.6, 0.6, 0.6)
				end
			end
		end
	end

	hooksecurefunc("QuestLog_UpdateQuestDetails", function()
		local requiredMoney = GetQuestLogRequiredMoney()
		if requiredMoney > 0 then
			if requiredMoney > GetMoney() then
				QuestLogRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestLogRequiredMoneyText:SetTextColor(1, 0.80, 0.10)
			end
		end
	end)

	hooksecurefunc("QuestFrameItems_Update", function(questState)
		local titleTextColor = {1, 0.80, 0.10}
		local textColor = {1, 1, 1}

		QuestLogDescriptionTitle:SetTextColor(unpack(titleTextColor))
		QuestLogQuestTitle:SetTextColor(unpack(titleTextColor))
		QuestLogRewardTitleText:SetTextColor(unpack(titleTextColor))
		QuestLogObjectivesText:SetTextColor(unpack(textColor))
		QuestLogQuestDescription:SetTextColor(unpack(textColor))
		QuestLogItemChooseText:SetTextColor(unpack(textColor))
		QuestLogItemReceiveText:SetTextColor(unpack(textColor))
		QuestLogSpellLearnText:SetTextColor(unpack(textColor))

		if GetQuestLogRequiredMoney() > 0 then
			if GetQuestLogRequiredMoney() > GetMoney() then
				QuestLogRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestLogRequiredMoneyText:SetTextColor(unpack(textColor))
			end
		end

		QuestObjectiveTextColor()

		local numQuestRewards, numQuestChoices
		if questState == "QuestLog" then
			numQuestRewards, numQuestChoices = GetNumQuestLogRewards(), GetNumQuestLogChoices()
		else
			numQuestRewards, numQuestChoices = GetNumQuestRewards(), GetNumQuestChoices()
		end

		local rewardsCount = numQuestChoices + numQuestRewards
		if rewardsCount > 0 then
			local questItem, itemName, link
			local questItemName = questState.."Item"

			for i = 1, rewardsCount do
				questItem = _G[questItemName..i]
				itemName = _G[questItemName..i.."Name"]
				link = questItem.type and (questState == "QuestLog" and GetQuestLogItemLink or GetQuestItemLink)(questItem.type, questItem:GetID())

				QuestQualityColors(questItem, itemName, nil, link)
			end
		end
	end)

	QuestLogTrack:Hide()

	local QuestTrack = CreateFrame("Button", "QuestTrack", QuestLogFrame, "UIPanelButtonTemplate")
	QuestTrack:SkinButton()
	QuestTrack:SetPoint("LEFT", QuestFramePushQuestButton, "RIGHT", 2, 0)
	QuestTrack:SetSize(101, 21)
	QuestTrack:SetText(TRACK_QUEST)

	QuestTrack:HookScript("OnClick", function()
		if IsQuestWatched(GetQuestLogSelection()) then
			RemoveQuestWatch(GetQuestLogSelection())

			QuestWatch_Update()
		else
			if GetNumQuestLeaderBoards(GetQuestLogSelection()) == 0 then
				UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0)
				return
			end

			if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
				UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0)
				return
			end

			AddQuestWatch(GetQuestLogSelection())

			QuestLog_Update()
			QuestWatch_Update()
		end

		QuestLog_Update()
	end)

	hooksecurefunc("QuestLog_Update", function()
		local numEntries = GetNumQuestLogEntries()
		if numEntries == 0 then
			QuestTrack:Disable()
		else
			QuestTrack:Enable()
		end

		QuestLogListScrollFrame:Show()
	end)

	QUESTS_DISPLAYED = 20

	for i = 7, 20 do
		local questLogTitle = CreateFrame("Button", "QuestLogTitle"..i, QuestLogFrame, "QuestLogTitleButtonTemplate")

		questLogTitle:SetID(i)
		questLogTitle:Hide()
		questLogTitle:SetPoint("TOPLEFT", _G["QuestLogTitle"..i - 1], "BOTTOMLEFT", 0, 1)
	end

	QuestLogCollapseAllButton:ClearAllPoints()
	QuestLogCollapseAllButton:SetPoint("TOPLEFT", -48, -2)
	QuestLogCollapseAllButton:StripTextures()
	T.SkinExpandOrCollapse(QuestLogCollapseAllButton)

	--[[
	local function UpdateQuests() -- causing issues
		local numEntries, numQuests = GetNumQuestLogEntries()
		local offset = FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
		local index, questLogTitle, highlight, text
		
		for i = 1, QUESTS_DISPLAYED do
			questLogTitle = _G["QuestLogTitle"..i]
			highlight = _G["QuestLogTitle"..i.."Highlight"]
			text = _G["QuestLogTitle"..i.."NormalText"]
			index = offset + i

			if index <= numEntries then
				questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(index)
				if isHeader then
					questLogTitle:SetSize(14, 14)
					questLogTitle:SetPoint("CENTER")
					questLogTitle:SetHitRectInsets(1, 1, 1, 1)

					highlight:SetTexture("")
					highlight.SetTexture = T.dummy

					text:ClearAllPoints()
					text:SetPoint("LEFT", questLogTitle, "RIGHT", 6, 0)

					hooksecurefunc(questLogTitle, "SetNormalTexture", function(self, texture)
						self:StripTextures()
						self:SetTemplate("Overlay")

						self.minus = self:CreateTexture(nil, "OVERLAY")
						self.minus:SetSize(7, 1)
						self.minus:SetPoint("CENTER")
						self.minus:SetTexture(C.media.blank)

						if not string.find(texture, "MinusButton") then
							self.plus = self:CreateTexture(nil, "OVERLAY")
							self.plus:SetSize(1, 7)
							self.plus:SetPoint("CENTER")
							self.plus:SetTexture(C.media.blank)
						end
					end)
				end
			end
		end
	end
	hooksecurefunc("QuestLog_Update", UpdateQuests)
	--]]
end

table.insert(T.SkinFuncs["ShestakUI"], LoadSkin)