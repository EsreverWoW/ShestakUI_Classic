local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	Move QuestWatchFrame (with ModernQuestWatch from Ketho - EU-Boulderfist)
----------------------------------------------------------------------------------------
local ObjectiveTracker = CreateFrame("Frame", "ObjectiveTrackerAnchor", UIParent)
ObjectiveTracker:SetPoint(unpack(C.position.quest))
ObjectiveTracker:SetHeight(150)
ObjectiveTracker:SetWidth(224)
ObjectiveTracker:SetFrameStrata("LOW")

local ClickFrames = {}

local function OnMouseUp(self)
	if IsShiftKeyDown() then -- untrack quest
		local questID = GetQuestIDFromLogIndex(self.questIndex)
		for index, value in ipairs(QUEST_WATCH_LIST) do
			if value.id == questID then
				tremove(QUEST_WATCH_LIST, index)
			end
		end
		RemoveQuestWatch(self.questIndex)
		QuestWatch_Update()
	else -- open to quest log
		if QuestLogEx then -- https://www.wowinterface.com/downloads/info24980-QuestLogEx.html
			ShowUIPanel(QuestLogExFrame)
			QuestLogEx:QuestLog_SetSelection(self.questIndex)
			QuestLogEx:Maximize()
		elseif ClassicQuestLog then -- https://www.wowinterface.com/downloads/info24937-ClassicQuestLogforClassic.html
			ShowUIPanel(ClassicQuestLog)
			QuestLog_SetSelection(self.questIndex)
		else
			ShowUIPanel(QuestLogFrame)
			QuestLog_SetSelection(self.questIndex)
			local valueStep = QuestLogListScrollFrame.ScrollBar:GetValueStep()
			QuestLogListScrollFrame.ScrollBar:SetValue(self.questIndex*valueStep/2)
		end
	end
	QuestLog_Update()
end

local function SetHighlightColor(self)
	self.watchText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b) -- 1, .82, 0
	for _, text in ipairs(self.objectiveTexts) do
		text:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b) -- 1, 1, 1
	end
end

local function SetNormalColor(self)
	self.watchText:SetTextColor(.75, .61, 0)
	for _, text in ipairs(self.objectiveTexts) do
		text:SetTextColor(.8, .8, .8)
	end
end

local function OnEnter(self)
	if self.completed then
		SetNormalColor(self) -- use normal colors instead as highlight
	else
		SetHighlightColor(self)
	end
	GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT", 20, 20)
	GameTooltip:ClearLines()
	GameTooltip:AddLine("|cfffed100Click:|r "..QUEST_LOG.."\n|cfffed100Shift-Click:|r "..UNTRACK_QUEST_ABBREV, 1, 1, 1)
	GameTooltip:Show()
end

local function OnLeave(self)
	if self.completed then
		SetHighlightColor(self)
	else
		SetNormalColor(self)
	end
	GameTooltip:Hide()
end

local function CreateClickFrame(watchIndex, questIndex, watchText, objectiveTexts, completed)
	if not ClickFrames[watchIndex] then
		ClickFrames[watchIndex] = CreateFrame("Frame")
		ClickFrames[watchIndex]:SetScript("OnMouseUp", OnMouseUp)
		ClickFrames[watchIndex]:SetScript("OnEnter", OnEnter)
		ClickFrames[watchIndex]:SetScript("OnLeave", OnLeave)
	end
	local f = ClickFrames[watchIndex]
	f:SetAllPoints(watchText)
	f.watchIndex = watchIndex
	f.questIndex = questIndex
	f.watchText = watchText
	f.objectiveTexts = objectiveTexts
	f.completed = completed
end

local QuestWatchFrameHeader = CreateFrame("Frame", "QuestWatchFrameHeader", ObjectiveTracker)
QuestWatchFrameHeader:CreatePanel("ClassColor", 1, 1, "TOPLEFT", QuestWatchFrame, "TOPRIGHT", 0, 0)

QuestWatchFrameHeader.Text = QuestWatchFrameHeader:CreateFontString(nil, "OVERLAY")
QuestWatchFrameHeader.Text:SetFont(C.media.normal_font, 14, "OUTLINE")
QuestWatchFrameHeader.Text:SetPoint("LEFT", QuestWatchFrameHeader, "LEFT", -2, 14)
QuestWatchFrameHeader.Text:SetText(CURRENT_QUESTS)

hooksecurefunc("QuestWatch_Update", function()
	QuestWatchFrame:SetParent(ObjectiveTrackerAnchor)
	QuestWatchFrame:ClearAllPoints()
	QuestWatchFrame:SetPoint("TOPLEFT", ObjectiveTracker, 0, 0)

	QuestWatchFrameHeader:SetPoint("TOPLEFT", QuestWatchFrame, "TOPLEFT", 0, 0)
	QuestWatchFrameHeader:SetPoint("TOPRIGHT", QuestWatchFrame, "TOPLEFT", QuestWatchFrame:GetWidth(), 0)

	-- Change font of watched quests/objectives
	for i = 1, 30 do
		local line = _G["QuestWatchLine"..i]
		line:SetFont(C.media.normal_font, 14)
		-- line:SetShadowColor(0, 0, 0, 0)
	end

	if GetNumQuestWatches() > 0 then
		ObjectiveTracker:Show()

		local questIndex, numObjectives, title, level, color, hex, watchText, objectivesGroup, objectivesCompleted, finished
		local watchTextIndex = 1
		for i = 1, GetNumQuestWatches() do
			questIndex = GetQuestIndexForWatch(i)
			if questIndex then
				numObjectives = GetNumQuestLeaderBoards(questIndex)
				title, level = GetQuestLogTitle(questIndex)
				color = GetQuestDifficultyColor(level)
				hex = T.RGBToHex(color.r, color.g, color.b)
				text = hex.."["..level.."] "..title

				if numObjectives > 0 then
					watchText = _G["QuestWatchLine"..watchTextIndex]
					watchText:SetText(text)

					watchTextIndex = watchTextIndex + 1
					objectivesGroup = {}
					objectivesCompleted = 0

					for j = 1, numObjectives do
						finished = select(3, GetQuestLogLeaderBoard(j, questIndex))
						if finished then
							watchText:SetTextColor(0, 1, 0)
							objectivesCompleted = objectivesCompleted + 1
						else
							watchText:SetTextColor(0.8, 0.8, 0.8)
						end
						tinsert(objectivesGroup, _G["QuestWatchLine"..watchTextIndex])
						watchTextIndex = watchTextIndex + 1
					end
					CreateClickFrame(i, questIndex, watchText, objectivesGroup, objectivesCompleted == numObjectives)
				end
			end
		end
		-- hide/show frames so it doesnt eat clicks, since we cant parent to a FontString
		for _, frame in pairs(ClickFrames) do
			frame[GetQuestIndexForWatch(frame.watchIndex) and "Show" or "Hide"](frame)
		end
	else
		ObjectiveTracker:Hide()
	end
end)

local function OnEvent(self, event, questIndex)
	-- tracking otherwise untrackable quests (without any objectives) would still count against the watch limit
	-- calling AddQuestWatch() while on the max watch limit silently fails
	if GetCVarBool("autoQuestWatch") and GetNumQuestLeaderBoards(questIndex) ~= 0 and GetNumQuestWatches() < MAX_WATCHABLE_QUESTS then
		AutoQuestWatch_Insert(questIndex, QUEST_WATCH_NO_EXPIRE)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("QUEST_ACCEPTED")
f:SetScript("OnEvent", OnEvent)

----------------------------------------------------------------------------------------
--	Expand / Collapse Button
----------------------------------------------------------------------------------------
local ExpandButton = CreateFrame("Button", "QuestWatchFrameExpandButton", UIParent)
ExpandButton:CreatePanel("Overlay", 17, 17, "TOPLEFT", QuestWatchFrameHeader, "TOPLEFT", -26, 22)
ExpandButton:EnableMouse(true)
ExpandButton:RegisterForClicks("AnyUp")
ExpandButton:SetFrameLevel(1)
ExpandButton:SetFrameStrata("HIGH")

ExpandButton.minus = ExpandButton:CreateTexture(nil, "OVERLAY")
ExpandButton.minus:SetSize(7, 1)
ExpandButton.minus:SetPoint("CENTER")
ExpandButton.minus:SetTexture(C.media.blank)

ExpandButton.plus = ExpandButton:CreateTexture(nil, "OVERLAY")
ExpandButton.plus:SetSize(1, 7)
ExpandButton.plus:SetPoint("CENTER")
ExpandButton.plus:SetTexture(C.media.blank)

ExpandButton:HookScript("OnEnter", T.SetModifiedBackdrop)
ExpandButton:HookScript("OnLeave", T.SetOriginalBackdrop)

ExpandButton:HookScript("OnEnter", T.SetModifiedBackdrop)
ExpandButton:HookScript("OnLeave", T.SetOriginalBackdrop)

ExpandButton.plus:Hide()

local expanded = true

local function QuestWatchCollapse()
	local f = ExpandButton
	f.plus:Show()
	if C.misc.minimize_mouseover then
		f:SetAlpha(0)
		f:HookScript("OnEnter", function() f:SetAlpha(1) end)
		f:HookScript("OnLeave", function() f:SetAlpha(0) end)
	end
	QuestWatchFrame:Hide()
	QuestWatchFrameHeader:Hide()
end

local function QuestWatchExpand()
	local f = ExpandButton
	f.plus:Hide()
	if C.misc.minimize_mouseover then
		f:SetAlpha(1)
		f:HookScript("OnEnter", function() f:SetAlpha(1) end)
		f:HookScript("OnLeave", function() f:SetAlpha(1) end)
	end
	QuestWatchFrame:Show()
	QuestWatchFrameHeader:Show()
end

ExpandButton:SetScript("OnMouseUp", function(self)
	expanded = not expanded
	PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
	if expanded then
		QuestWatchExpand()
	else
		QuestWatchCollapse()
	end
end)

----------------------------------------------------------------------------------------
--	Auto collapse QuestWatchFrame
----------------------------------------------------------------------------------------
if C.automation.auto_collapse or C.automation.auto_collapse_reload then
	local collapse = CreateFrame("Frame")
	collapse:RegisterEvent("PLAYER_ENTERING_WORLD")
	collapse:SetScript("OnEvent", function()
		if C.automation.auto_collapse and not C.automation.auto_collapse_reload then
			if IsInInstance() then
				C_Timer.After(2, QuestWatchCollapse)
				ExpandButton.plus:Show()
				expanded = false
			elseif not expanded and not InCombatLockdown() then
				C_Timer.After(2, QuestWatchExpand)
				ExpandButton.plus:Hide()
				expanded = true
			end
		elseif C.automation.auto_collapse_reload then
			C_Timer.After(2, QuestWatchCollapse)
			ExpandButton.plus:Show()
			expanded = false
		end
	end)
end

----------------------------------------------------------------------------------------
--	Move QuestTimerFrame (issues with the mover)
----------------------------------------------------------------------------------------
local ObjectiveTimer = CreateFrame("Frame", "ObjectiveTimerAnchor", UIParent)
ObjectiveTimer:SetPoint("BOTTOM", Minimap, "TOP", 0, 64)
ObjectiveTimer:SetHeight(80)
ObjectiveTimer:SetWidth(120)

QuestTimerFrame:StripTextures()
QuestTimerFrame:SetParent(ObjectiveTimer)
QuestTimerFrame:ClearAllPoints()
QuestTimerFrame:SetAllPoints(ObjectiveTimer)