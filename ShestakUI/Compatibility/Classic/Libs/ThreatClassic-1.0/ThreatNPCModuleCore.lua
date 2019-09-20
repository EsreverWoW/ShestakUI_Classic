local ThreatLib = LibStub and LibStub("ThreatClassic-1.0", true)
if not ThreatLib then return end

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- Blizzard Combat Log constants, in case your addon loads before Blizzard_CombatLog or it's disabled by the user
---------------------------------------------------------------------------------------------------------------
local bit_band = _G.bit.band
local bit_bor  = _G.bit.bor

local COMBATLOG_OBJECT_AFFILIATION_MINE		= COMBATLOG_OBJECT_AFFILIATION_MINE		or 0x00000001
local COMBATLOG_OBJECT_AFFILIATION_PARTY	= COMBATLOG_OBJECT_AFFILIATION_PARTY	or 0x00000002
local COMBATLOG_OBJECT_AFFILIATION_RAID		= COMBATLOG_OBJECT_AFFILIATION_RAID		or 0x00000004
local COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	or 0x00000008
local COMBATLOG_OBJECT_AFFILIATION_MASK		= COMBATLOG_OBJECT_AFFILIATION_MASK		or 0x0000000F
-- Reaction
local COMBATLOG_OBJECT_REACTION_FRIENDLY	= COMBATLOG_OBJECT_REACTION_FRIENDLY	or 0x00000010
local COMBATLOG_OBJECT_REACTION_NEUTRAL		= COMBATLOG_OBJECT_REACTION_NEUTRAL		or 0x00000020
local COMBATLOG_OBJECT_REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE		or 0x00000040
local COMBATLOG_OBJECT_REACTION_MASK		= COMBATLOG_OBJECT_REACTION_MASK		or 0x000000F0
-- Ownership
local COMBATLOG_OBJECT_CONTROL_PLAYER		= COMBATLOG_OBJECT_CONTROL_PLAYER		or 0x00000100
local COMBATLOG_OBJECT_CONTROL_NPC			= COMBATLOG_OBJECT_CONTROL_NPC			or 0x00000200
local COMBATLOG_OBJECT_CONTROL_MASK			= COMBATLOG_OBJECT_CONTROL_MASK			or 0x00000300
-- Unit type
local COMBATLOG_OBJECT_TYPE_PLAYER			= COMBATLOG_OBJECT_TYPE_PLAYER			or 0x00000400
local COMBATLOG_OBJECT_TYPE_NPC				= COMBATLOG_OBJECT_TYPE_NPC				or 0x00000800
local COMBATLOG_OBJECT_TYPE_PET				= COMBATLOG_OBJECT_TYPE_PET				or 0x00001000
local COMBATLOG_OBJECT_TYPE_GUARDIAN		= COMBATLOG_OBJECT_TYPE_GUARDIAN		or 0x00002000
local COMBATLOG_OBJECT_TYPE_OBJECT			= COMBATLOG_OBJECT_TYPE_OBJECT			or 0x00004000
local COMBATLOG_OBJECT_TYPE_MASK			= COMBATLOG_OBJECT_TYPE_MASK			or 0x0000FC00

-- Special cases (non-exclusive)
local COMBATLOG_OBJECT_TARGET				= COMBATLOG_OBJECT_TARGET				or 0x00010000
local COMBATLOG_OBJECT_FOCUS				= COMBATLOG_OBJECT_FOCUS				or 0x00020000
local COMBATLOG_OBJECT_MAINTANK				= COMBATLOG_OBJECT_MAINTANK				or 0x00040000
local COMBATLOG_OBJECT_MAINASSIST			= COMBATLOG_OBJECT_MAINASSIST			or 0x00080000
local COMBATLOG_OBJECT_RAIDTARGET1			= COMBATLOG_OBJECT_RAIDTARGET1			or 0x00100000
local COMBATLOG_OBJECT_RAIDTARGET2			= COMBATLOG_OBJECT_RAIDTARGET2			or 0x00200000
local COMBATLOG_OBJECT_RAIDTARGET3			= COMBATLOG_OBJECT_RAIDTARGET3			or 0x00400000
local COMBATLOG_OBJECT_RAIDTARGET4			= COMBATLOG_OBJECT_RAIDTARGET4			or 0x00800000
local COMBATLOG_OBJECT_RAIDTARGET5			= COMBATLOG_OBJECT_RAIDTARGET5			or 0x01000000
local COMBATLOG_OBJECT_RAIDTARGET6			= COMBATLOG_OBJECT_RAIDTARGET6			or 0x02000000
local COMBATLOG_OBJECT_RAIDTARGET7			= COMBATLOG_OBJECT_RAIDTARGET7			or 0x04000000
local COMBATLOG_OBJECT_RAIDTARGET8			= COMBATLOG_OBJECT_RAIDTARGET8			or 0x08000000
local COMBATLOG_OBJECT_NONE					= COMBATLOG_OBJECT_NONE					or 0x80000000
local COMBATLOG_OBJECT_SPECIAL_MASK			= COMBATLOG_OBJECT_SPECIAL_MASK			or 0xFFFF0000

-- Object type constants
local COMBATLOG_FILTER_ME = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PLAYER
						)

local COMBATLOG_FILTER_MINE = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_OBJECT
						)

local COMBATLOG_FILTER_MY_PET = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_PET
						)

local COMBATLOG_FILTER_FRIENDLY_UNITS = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_PARTY,
						COMBATLOG_OBJECT_AFFILIATION_RAID,
						COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
						COMBATLOG_OBJECT_REACTION_FRIENDLY,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_CONTROL_NPC,
						COMBATLOG_OBJECT_TYPE_PLAYER,
						COMBATLOG_OBJECT_TYPE_NPC,
						COMBATLOG_OBJECT_TYPE_PET,
						COMBATLOG_OBJECT_TYPE_GUARDIAN,
						COMBATLOG_OBJECT_TYPE_OBJECT
						)

local AURA_TYPE_BUFF = _G.AURA_TYPE_BUFF
local AURA_TYPE_DEBUFF = _G.AURA_TYPE_DEBUFF

local AFFILIATION_IN_GROUP = bit_bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID)
local REACTION_ATTACKABLE = bit_bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_REACTION_NEUTRAL)
---------------------------------------------------------------------------------------------------------------
-- End Combat Log constants
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

local new, del, newHash, newSet = ThreatLib.new, ThreatLib.del, ThreatLib.newHash, ThreatLib.newSet
local ThreatLibNPCModuleCore = ThreatLib:GetModule("NPCCore", true) or ThreatLib:NewModule("NPCCore", nil, "AceEvent-3.0", "AceTimer-3.0")

local _G = _G
local GetLocale = _G.GetLocale
local type = _G.type
local select = _G.select
local error = _G.error
local InCombatLockdown = _G.InCombatLockdown
local UnitGUID = _G.UnitGUID
local tostring = _G.tostring

ThreatLibNPCModuleCore.modulePrototype = {}

local combatantToModule = {}
local registeredModules = {}
local moduleValueOverrides = {}
local moduleValues = {}

local function ModifyThreat(guid, target, multi, add)
	local module
	if target == "player" then
		module = ThreatLib:GetModule("Player")
	elseif target == "pet" then
		module = ThreatLib:GetModule("Pet")
	end
	if module and module.targetThreat[guid] then
		module:MultiplyTargetThreat(guid, multi)
		module:AddTargetThreat(guid, add)
	end
end

local function ModifyThreatOnTargetGUID(GUID, targetGUID, ...)
	if targetGUID == ThreatLib:GetModule("Player").unitGUID then
		ModifyThreat(GUID, "player", ...)
	end
	if targetGUID == ThreatLib:GetModule("Pet").unitGUID then
		ModifyThreat(GUID, "pet", ...)
	end
end

local onyThreat = function(mob, target)
	local npcID = ThreatLib:NPCID(mob)
	if npcID and npcID ~= 10184 then return end

	ModifyThreat(mob, target, 0.75, 0) -- set Onyxia threat *0.75 on Knock Away
end

local halveThreat = function(mob, target)
	-- hack to prevent Onyxia threat modifications since spellIDs were removed from CLEU
	local npcID = ThreatLib:NPCID(mob)
	if npcID and npcID == 10184 then return end

	ModifyThreat(mob, target, 0.5, 0)
end

local threatHalveSpellIDs = {
	-- Wing Buffet
	-- We have assumed that all Wing Buffet effects reduce threat by half by default
	--18500, -- Onyxia, Wing Buffet, recorded combatlog says this spell doesn't actually land on anyone and only exists in SPELL_CAST_START from Onyxia
	23339, -- Ebonroc, Firemaw, Flamegor, Wing Buffet, needs testing
	29905, -- Shadikith the Glider, Wing Buffet
	37157, -- Triggered by Phoenix-Hawk ability 37165 called Dive, Wing Buffet
	37319, -- Phoenix-Hawk Hatchling, Wing Buffet
	41572, -- Used by nothing known, Wing Buffet
	32914, -- Used by 7 common mobs in Outlands, Wing Buffet
	38110, -- Cobalt Serpent, Wing Buffet
	--31475, 38593, -- Epoch Hunter/Temporus, Wing Buffet, we think their Wing Buffet doesn't reduce threat
	--29328, -- Sapphiron's Wing Buffet, this spell is not used by Sapphiron

	-- Knock Away
	-- We have assumed that all Knock Away effects reduce threat by half by default
	-- 21737, Applies aura to periodically do spellID 25778
	10101, -- Used by 25 mobs (some are bosses), Knock Away
	11130, -- Gurubashi Berserker, Mekgineer Thermaplugg, Qiraji Champion, Teremus the Devourer, Knock Away
	18670, -- Used by 8 mobs (some are bosses), Knock Away
	18813, -- Drillmaster Zurok, Earthen Templar, Shadowmoon Weapon Master, Swamplord Musel'ek, Knock Away
	18945, -- Molten Giant, Cyrukh the Firelord, Knock Away
	20686, -- Used by nothing known, Knock Away
	23382, -- Used by nothing known, Knock Away
	31389, -- Luzran, Rokdar the Sundered Lord, Knock Away
	32959, -- Cragskaar, Goliathon, Gurok the Usurper, Knock Away
	36512, -- Wrath-Scryer Soccothrates, Knock Away
	37102, -- Crystalcore Devastator, Knock Away
	40434, -- Gezzarak the Huntress, Knock Away

	33707, -- Blackheart the Inciter, War Stomp
}

local threeQuarterThreat = function(mob, target) ModifyThreat(mob, target, 0.75, 0) end
local threatThreeQuarterSpellIDs = {
	-- 25778, -- Void Reaver, Fathom Lurker, Fathom Sporebat, Underbog Lord, Knock Away
	-- 19633, -- Onyxia, Knock Away
	20566, -- Ragnaros, Wrath of Ragnaros
	40486, -- Gurtogg Bloodboil, Eject (we ignore spellID 40597 which has a stun component rather than a knock back component)
}

local wipeThreat = function(mob, target) ModifyThreat(mob, target, 0, 0) end
local threatWipeSpellIDs = {
	26102, -- Ouro, Sand Blast
	46288, -- Petrify, Chaos Gazer, Sunwell Plateau
}

function ThreatLibNPCModuleCore:OnInitialize()
	self.activeModule = nil
	self.activeModuleID = nil
	self.ModifyThreatSpells = {}

	-- Necessary for WoW Classic
	self.ModifyThreatSpells[10101] = onyThreat -- 10101 (instead of 19633) because that's what in the lookup

	for i = 1, #threatHalveSpellIDs do
		self.ModifyThreatSpells[threatHalveSpellIDs[i]] = halveThreat
	end
	for i = 1, #threatThreeQuarterSpellIDs do
		self.ModifyThreatSpells[threatThreeQuarterSpellIDs[i]] = threeQuarterThreat
	end
	for i = 1, #threatWipeSpellIDs do
		self.ModifyThreatSpells[threatWipeSpellIDs[i]] = wipeThreat
	end
end

function ThreatLibNPCModuleCore:OnEnable()
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function ThreatLibNPCModuleCore:RegisterModule(...)
	local n = select('#', ...)
	if n < 1 then
		error("Error registering module, must provide at least one combatant NPC ID.", 2)
	end

	local npc_id = ...

	if type(npc_id) ~= "number" then
		error(("Bad argument #2 to `RegisterModule'. Expecting %q, got %q."):format("number", type(npc_id)), 2)
	end
	ThreatLib:Debug("Registered module: %s", npc_id)

	if registeredModules[npc_id] then
		error(("Error, module %q already registered"):format(npc_id), 2)
	end

	for i = 1, n - 1 do
		local combatant = select(i, ...)
		if type(combatant) ~= "number" then
			error(("Bad argument #%d to `RegisterModule'. Expecting %q, got %q."):format(i + 1, "number", type(combatant)), 2)
		end
		if combatantToModule[combatant] then
			error(("Error registering module %q, as combatant %q is already registered to module %q."):format(npc_id, combatant, combatantToModule[combatant]), 2)
		end
		combatantToModule[combatant] = npc_id
	end

	local func = select(n, ...)
	if type(func) ~= "function" then
		error(("Bad argument #%d to `RegisterModule'. Expecting %q, got %q."):format(n + 1, "function", type(func)), 2)
	end

	registeredModules[npc_id] = func
end

function ThreatLibNPCModuleCore:GetOrCreateModule(name)
	local nameString = tostring(name)
	return self:GetModule(nameString, true) or self:NewModule(nameString, ThreatLibNPCModuleCore.modulePrototype, "AceEvent-3.0", "AceTimer-3.0")
end

local function activateModule(self, mobGUID, localActivation)
	local npc_id = mobGUID
	if type(mobGUID) == "string"  then
		npc_id = ThreatLib:NPCID(mobGUID)
	end
	local moduleID = combatantToModule[npc_id]
	if not moduleID then return end
	if self.activeModuleID ~= moduleID then
		if self.activeModule then
			self.activeModule:Disable()
		end

		local mod = self:GetOrCreateModule(moduleID)
		self.activeModuleID = moduleID
		ThreatLib:Debug("Activated %s module", moduleID)
		registeredModules[moduleID](mod)

		mod:OnInitialize()
		mod:Enable()

		if localActivation then
			ThreatLib:NotifyGroupModuleActivate(mobGUID)
		end
	end
end

function ThreatLibNPCModuleCore:SetModuleVar(var, value)
	ThreatLib:Debug("Set %q = %s", var, value)
	moduleValueOverrides[var] = value
end

-- Mob name, when passed from a chat message, should be localized to English by the passer via GetReverseTranslation()
-- So, we can just translate it to our native locale
function ThreatLibNPCModuleCore:ActivateModule(mobGUID)
	activateModule(self, mobGUID, false)
end

function ThreatLibNPCModuleCore:UPDATE_MOUSEOVER_UNIT()
	local guid = UnitGUID("mouseover")
	if guid then
		activateModule(self, guid, true)
	end
end

function ThreatLibNPCModuleCore:PLAYER_TARGET_CHANGED()
	local guid = UnitGUID("target")
	if guid then
		activateModule(self, guid, true)
	end
end

function ThreatLibNPCModuleCore:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	if not InCombatLockdown() then return end

	local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName = CombatLogGetCurrentEventInfo()

	-- spellId = ThreatLib.Classic and ThreatLib:GetNPCSpellID(spellName) or spellId
	spellId = ThreatLib:GetNPCSpellID(spellName) or spellId

	if subEvent == "SPELL_DAMAGE" and bit_band(sourceFlags, REACTION_ATTACKABLE) ~= 0 and bit_band(sourceFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC then
		local unitID = nil
		if bit_band(destFlags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME then
			unitID = "player"
		elseif bit_band(destFlags, COMBATLOG_FILTER_MY_PET) == COMBATLOG_FILTER_MY_PET then
			unitID = "pet"
		end
		if unitID then
			-- spellId = ThreatLib.Classic and ThreatLib:GetNPCSpellID(spellName) or spellId
			spellId = ThreatLib:GetNPCSpellID(spellName) or spellId
			local func = self.ModifyThreatSpells[spellId]
			if func then
				func(sourceGUID, unitID)
			end
		end
	end
end

function ThreatLibNPCModuleCore.modulePrototype:OnInitialize()
	if not self.initted then
		self.chatEvents = {}
		self.encounterEnemies = {}
		self.SpellHandlers = {}
		self.buffGains = {}
		self.buffFades = {}
		self.translations = {}
		self.timers = {}
		self:Init()
		self.ModifyThreat = ModifyThreat
		self.ModifyThreatOnTargetGUID = ModifyThreatOnTargetGUID
		self.initted = true
	end
end

local MY_LOCALE = GetLocale()
local BASE_LOCALE = "enUS"

local translations = {}
function ThreatLibNPCModuleCore.modulePrototype:RegisterTranslation(locale, translation)
	if locale ~= MY_LOCALE and locale ~= BASE_LOCALE then
		return
	end
	local m = translations[self.name]
	if not m then
		m = {}
		translations[self.name] = m
	end
	m[locale] = translation()
end

function ThreatLibNPCModuleCore.modulePrototype:UnregisterTranslations()
	translations[self.name] = nil
end

function ThreatLibNPCModuleCore.modulePrototype:RegisterSpellHandler(event, func, ...)
	if type(event) ~= "string" or event:sub(1,6) ~= "SPELL_" then
		error("First parameter to :RegisterSpellHandler must be a SPELL_* event, got " .. tostring(event), 2)
	end
	if type(func) ~= "function" then
		error("Second parameter to :RegisterSpellHandler must be a function, got " .. type(func), 2)
	end

	if not self.SpellHandlers[event] then
		self.SpellHandlers[event] = {}
	end

	local handlers = self.SpellHandlers[event]

	for i = 1, select("#", ...) do
		local val = select(i, ...)
		if type(val) ~= "number" then
			error(("Invalid spell registered: %s"):format(val))
		end
		handlers[val] = func
	end
end

function ThreatLibNPCModuleCore.modulePrototype:GetTranslation(string)
	local selfName = self.name
	local data = translations[selfName]
	if not data then
		if ThreatLib.WarnMissingTranslations then
			error("ThreatClassic-1.0: No translations registered for " .. selfName)
		end
		return
	end
	local data_MY_LOCALE = data[MY_LOCALE]
	if not data_MY_LOCALE then
		if ThreatLib.WarnMissingTranslations then
			error(("ThreatClassic-1.0: Missing %s translation for %q in module %q"):format(MY_LOCALE, string, selfName))
		end
		local data_BASE_LOCALE = data[BASE_LOCALE]
		if data_BASE_LOCALE then
			return data_BASE_LOCALE[string]
		end
	end
	local data_MY_LOCALE_string = data_MY_LOCALE[string]
	if data_MY_LOCALE_string == true then
		return string
	end
	return data_MY_LOCALE_string
end

function ThreatLibNPCModuleCore.modulePrototype:OnEnable()
	ThreatLib:Debug("Enabled module: %s", self:GetName())
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	ThreatLibNPCModuleCore.activeModule = self
end

function ThreatLibNPCModuleCore.modulePrototype:OnDisable()
	ThreatLib:Debug("Disabled module: %s", self:GetName())
	ThreatLibNPCModuleCore.activeModule = nil
	ThreatLibNPCModuleCore.activeModuleID = nil
end

function ThreatLibNPCModuleCore.modulePrototype:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	if not InCombatLockdown() then return end

	local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, _, auraType = CombatLogGetCurrentEventInfo()

	-- spellId = ThreatLib.Classic and ThreatLib:GetNPCSpellID(spellName) or spellId
	spellId = ThreatLib:GetNPCSpellID(spellName) or spellId

	if subEvent == "UNIT_DIED" then
		if bit_band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC then
			local npc_id = ThreatLib:NPCID(dstGUID)
			local func = self.encounterEnemies[npc_id]
			if func then
				func(self, npc_id, destGUID, destName, sourceName, sourceGUID)
			end
		end
	elseif subEvent == "SPELL_AURA_REMOVED" then
		if bit_band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC and auraType == AURA_TYPE_BUFF then
			local npc_id = ThreatLib:NPCID(destGUID)
			local func = self.buffFades[spellId]
			if func then
				func(self, npc_id)
			end
		end
	elseif subEvent == "SPELL_AURA_APPLIED" then
		if bit_band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC and auraType == AURA_TYPE_BUFF then
			local npc_id = ThreatLib:NPCID(destGUID)
			local func = self.buffGains[spellId]
			if func then
				func(self, npc_id)
			end
		end
	end

	if self.SpellHandlers[subEvent] then
		local func = self.SpellHandlers[subEvent][spellId]
		if func then
			func(self, sourceGUID, destGUID, spellId)
		end
	end
end


function ThreatLibNPCModuleCore.modulePrototype:CHAT_MSG_MONSTER_EMOTE(event, arg1, arg2)
	if not ThreatLib.running then
		return
	end
	local emote = self.chatEvents.emote
	if not emote then
		return
	end

	local func = emote[arg1]
	if not func then
		return
	end
	func(self)
end

function ThreatLibNPCModuleCore.modulePrototype:CHAT_MSG_MONSTER_YELL(event, arg1, arg2)
	if not ThreatLib.running then return end
	local yell = self.chatEvents.yell
	if not yell then
		return
	end

	local func = yell[arg1]
	if not func then return end
	func(self)
end

function ThreatLibNPCModuleCore.modulePrototype:PLAYER_REGEN_ENABLED()
	if self.timers.ResetMobCount then
		self:CancelTimer(self.timers.ResetMobCount, true)
	end
	self.timers.ResetMobCount = self:ScheduleTimer("ResetFight", 5)
end

function ThreatLibNPCModuleCore.modulePrototype:PLAYER_REGEN_DISABLED()
	if self.timers.ResetMobCount then
		self:CancelTimer(self.timers.ResetMobCount, true)
		self.timers.ResetMobCount = nil
	end
end

function ThreatLibNPCModuleCore.modulePrototype:RegisterCombatant(combatantNPCID, callback)
	if not callback then
		return
	end
	if callback == true then
		callback = self.BossDeath
	end
	self.encounterEnemies[combatantNPCID] = callback
end

-- Override to implement state reset on fight start
ThreatLibNPCModuleCore.modulePrototype.StartFight = function() end

function ThreatLibNPCModuleCore:GetModuleVarList()
	return moduleValues
end

function ThreatLibNPCModuleCore:GetModuleVar(name, default)
	return moduleValueOverrides[name] or default
end

function ThreatLibNPCModuleCore.modulePrototype:RegisterModuleVar(nicename, varname, default)
	moduleValueOverrides[varname] = default
	moduleValues[self.name] = moduleValues[self.name] or {}
	moduleValues[self.name][varname] = nicename
end

function ThreatLibNPCModuleCore.modulePrototype:GetModuleVar(name, default)
	return moduleValueOverrides[name] or default
end

function ThreatLibNPCModuleCore.modulePrototype:ResetFight()
	self.InCombat = false
end

function ThreatLibNPCModuleCore.modulePrototype:StartCombat()
	if not self.InCombat then
		self:StartFight()
		self.InCombat = true
	end
end

function ThreatLibNPCModuleCore.modulePrototype:BossDeath()
	self:ResetFight()
	self:Disable()
end

function ThreatLibNPCModuleCore.modulePrototype:RegisterChatEvent(eventType, text, callback)
	if not text then
		return
	end
	local t = self.chatEvents[eventType]
	if not t then
		t = {}
		self.chatEvents[eventType] = t
	end
	t[text] = callback
end

-- Not used?
function ThreatLibNPCModuleCore.modulePrototype:UnregisterChatEvent(eventType, text)
	local t = self.chatEvents[eventType]
	if not t then
		return
	end
	t[text] = nil
end

----------------------------------------------------------------
-- Module API
----------------------------------------------------------------

function ThreatLibNPCModuleCore.modulePrototype:WipeRaidThreatOnMob(mobID)
	ThreatLib:Debug("Wiping threat on %s", mobID)
	ThreatLib:WipeRaidThreatOnMob(mobID)
end

function ThreatLibNPCModuleCore.modulePrototype:WipeAllRaidThreat()
	ThreatLib:RequestThreatClear()
end
