local T, C, L, _ = unpack(select(2, ...))
if C.automation.accept_quest ~= true then return end

----------------------------------------------------------------------------------------
--	Quest automation(QuickQuest by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local QuickQuestDB = {
	general = {
		share = false,
		skipgossip = true,
		skipgossipwhen = 1,
		pausekey = 'SHIFT',
		pausekeyreverse = false,
	},
	blocklist = {
		items = {},
		npcs = {},
		quests = {},
	},
}

local EventHandler = CreateFrame('Frame')
EventHandler.events = {}
EventHandler:SetScript('OnEvent', function(self, event, ...)
	self:Trigger(event, ...)
end)

function EventHandler:Register(event, func)
	local registered = not not self.events[event]
	if not registered then
		self.events[event] = {}
	end

	for _, f in next, self.events[event] do
		if f == func then
			-- avoid the same function being registered multiple times for the same event
			return
		end
	end

	table.insert(self.events[event], func)

	if not registered then
		self:RegisterEvent(event)
	end
end

function EventHandler:Unregister(event, func)
	local funcs = self.events[event]
	if funcs then
		for i, f in next, funcs do
			if f == func then
				funcs[i] = nil
				break
			end
		end
	end

	if funcs and #funcs == 0 then
		self:UnregisterEvent(event)
	end
end

function EventHandler:Trigger(event, ...)
	local funcs = self.events[event]
	if funcs then
		for _, func in next, funcs do
			if type(func) == 'string' then
				self:Trigger(func, ...)
			else
				if func(...) then
					self:Unregister(event, func)
				end
			end
		end
	end
end

ns.EventHandler = EventHandler

local NPC_ID_PATTERN = '%w+%-.-%-.-%-.-%-.-%-(.-)%-'
function ns.GetNPCID(unit)
	local npcGUID = UnitGUID(unit or 'npc')
	if npcGUID then
		return tonumber(npcGUID:match(NPC_ID_PATTERN))
	end
end

function ns.ShouldAcceptTrivialQuests()
	for index = 1, C_Minimap.GetNumTrackingTypes() do
		local name, _, isActive = C_Minimap.GetTrackingInfo(index)
		if name == MINIMAP_TRACKING_TRIVIAL_QUESTS then
			return isActive
		end
	end
end

function ns.tLength(t)
	local count = 0
	for _ in next, t do
		count = count + 1
	end
	return count
end

local EventHandler = ns.EventHandler
local paused

local ignoredQuests = {}
local cashRewards = {
	[45724] = 1e5, -- Champion's Purse, 10 gold
}
local function IsQuestIgnored(questID)
	if ignoredQuests[questID] then
		return true
	end

	local questTitle = tonumber(questID) and C_QuestLog.GetQuestInfo(questID) or ''
	for key in next, QuickQuestDB.blocklist.quests do
		if key == questID or questTitle:lower():find(tostring(key):lower()) then
			return true
		end
	end

	return false
end

EventHandler:Register('GOSSIP_SHOW', function()
	-- triggered when the player interacts with an NPC that presents dialogue
	if paused then
		return
	end

	if QuickQuestDB.blocklist.npcs[ns.GetNPCID()] then
		return
	end

	-- turn in all completed quests
	for index, info in next, C_GossipInfo.GetActiveQuests() do
		if not IsQuestIgnored(info.questID) then
			if info.isComplete then
				C_GossipInfo.SelectActiveQuest(index)
			end
		end
	end

	-- accept all available quests
	for index, info in next, C_GossipInfo.GetAvailableQuests() do
		if not IsQuestIgnored(info.questID) then
			if not info.isTrivial or ns.ShouldAcceptTrivialQuests() then
				C_GossipInfo.SelectAvailableQuest(info.questID)
			end
		end
	end
end)
EventHandler:Register('QUEST_GREETING', 'GOSSIP_SHOW')

EventHandler:Register('QUEST_DETAIL', function(questItemID)
	-- triggered when the information about an available quest is available
	if paused then
		return
	end

	AcceptQuest()
end)

EventHandler:Register('QUEST_PROGRESS', function()
	-- triggered when an active quest is selected during turn-in
	if paused then
		return
	end

	if QuickQuestDB.blocklist.npcs[ns.GetNPCID()] then
		return
	end

	if not IsQuestCompletable() then
		return
	end

	-- iterate through the items part of the quest
	for index = 1, GetNumQuestItems() do
		local itemLink = GetQuestItemLink('required', index)
		if itemLink then
			-- check to see if the item is blocked
			local questItemID = GetItemInfoFromHyperlink(itemLink)
			for itemID in next, QuickQuestDB.blocklist.items do
				if itemID == questItemID then
					-- item is blocked, prevent this quest from opening again and close it
					ignoredQuests[GetQuestID()] = true
					CloseQuest()
					return
				end
			end
		else
			-- item is not cached yet, trigger the item and wait for the cache to populate
			EventHandler:Register('QUEST_ITEM_UPDATE', 'QUEST_PROGRESS')
			GetQuestItemInfo('required', index)
			return
		end
	end

	CompleteQuest()
	EventHandler:Unregister('QUEST_ITEM_UPDATE', 'QUEST_PROGRESS')
end)

EventHandler:Register('QUEST_COMPLETE', function()
	-- triggered when an active quest is ready to be completed
	if paused then
		return
	end

	if GetNumQuestChoices() <= 1 then
		-- complete the quest by accepting the first item
		GetQuestReward(1)
	end
end)

EventHandler:Register('QUEST_COMPLETE', function()
	-- triggered when an active quest is ready to be completed
	local numItemRewards = GetNumQuestChoices()
	if numItemRewards <= 1 then
		-- no point iterating over a single item or none at all
		return
	end

	local highestItemValue, highestItemValueIndex = 0

	-- iterate through the item rewards and automatically select the one worth the most
	for index = 1, numItemRewards do
		local itemLink = GetQuestItemLink('choice', index)
		if itemLink then
			-- check the value on the item and compare it to the others
			local _, _, _, _, _, _, _, _, _, _, itemValue = GetItemInfo(itemLink)
			local itemID = GetItemInfoFromHyperlink(itemLink)

			-- some items are containers that contains currencies of worth
			itemValue = cashRewards[itemID] or itemValue

			-- compare the values
			if itemValue > highestItemValue then
				highestItemValue = itemValue
				highestItemValueIndex = index
			end
		else
			-- item is not cached yet, trigger the item and wait for the cache to populate
			EventHandler:Register('QUEST_ITEM_UPDATE', 'QUEST_COMPLETE')
			GetQuestItemInfo('choice', index)
			return
		end
	end

	if highestItemValueIndex then
		-- this is considered an intrusive action, as we're modifying the UI
		QuestInfoItem_OnClick(QuestInfoRewardsFrame.RewardButtons[highestItemValueIndex])
	end

	EventHandler:Unregister('QUEST_ITEM_UPDATE', 'QUEST_COMPLETE')
end)

EventHandler:Register('QUEST_ACCEPT_CONFIRM', function()
	-- triggered when a quest is shared in the party, but requires confirmation (like escorts)
	if paused then
		return
	end

	AcceptQuest()
end)

EventHandler:Register('QUEST_ACCEPTED', function(questID)
	-- triggered when a quest has been accepted by the player
	if QuickQuestDB.general.share then
		local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
		if questLogIndex then
			QuestLogPushQuest(questLogIndex)
		end
	end
end)

EventHandler:Register('MODIFIER_STATE_CHANGED', function(key, state)
	-- triggered when the player clicks any modifier keys on the keyboard
	if string.sub(key, 2) == QuickQuestDB.general.pausekey then
		-- change the paused state
		if QuickQuestDB.general.pausekeyreverse then
			paused = state ~= 1
		else
			paused = state == 1
		end
	end
end)

EventHandler:Register('PLAYER_LOGIN', function()
	-- triggered when the game has completed the login process
	if QuickQuestDB.general.pausekeyreverse then
		-- default to a paused state
		paused = true
	end
end)