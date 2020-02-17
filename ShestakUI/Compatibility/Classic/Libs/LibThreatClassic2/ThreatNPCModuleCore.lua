if not _G.THREATLIB_LOAD_MODULES then return end -- only load if LibThreatClassic2.lua allows it
if not LibStub then return end
local ThreatLib, MINOR = LibStub("LibThreatClassic2", true)
if not ThreatLib then return end

ThreatLib:Debug("Loading NPC module core revision %s", MINOR)
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

local AURA_TYPE_BUFF = "BUFF" -- hardcode because _G.AURA_TYPE_BUFF returns nil here
local AURA_TYPE_DEBUFF = "DEBUFF"  -- hardcode because _G.AURA_TYPE_DEBUFF returns nil here

local AFFILIATION_IN_GROUP = bit_bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID)
local REACTION_ATTACKABLE = bit_bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_REACTION_NEUTRAL)
---------------------------------------------------------------------------------------------------------------
-- End Combat Log constants
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

local new, del, newHash, newSet = ThreatLib.new, ThreatLib.del, ThreatLib.newHash, ThreatLib.newSet
local ThreatLibNPCModuleCore = ThreatLib:GetModule("NPCCore-r"..MINOR, true) or ThreatLib:NewModule("NPCCore-r"..MINOR, nil, "AceEvent-3.0", "AceTimer-3.0")

local _G = _G
local GetLocale = _G.GetLocale
local type = _G.type
local select = _G.select
local error = _G.error
local InCombatLockdown = _G.InCombatLockdown
local UnitGUID = _G.UnitGUID
local UnitIsDead = _G.UnitIsDead
local tostring = _G.tostring
local GetSpellInfo = _G.GetSpellInfo

ThreatLibNPCModuleCore.modulePrototype = {}

local combatantToModule = {}
local registeredModules = {}
local moduleValueOverrides = {}
local moduleValues = {}

function ThreatLibNPCModuleCore:OnInitialize()
	self.activeModule = nil
	self.activeModuleID = nil
end

function ThreatLibNPCModuleCore:OnEnable()
	ThreatLib:Debug("NPCCore module revision %s enabled", MINOR)
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
end

function ThreatLibNPCModuleCore:OnDisable()
	ThreatLib:Debug("NPCCore module revision %s disabled", MINOR)
	self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
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
	ThreatLib:Debug("Registered npc module: %s", npc_id)

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
	local nameString = tostring(name).."-r"..MINOR
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
			self.activeModule:OnDisable()
		end

		local mod = self:GetOrCreateModule(moduleID)
		self.activeModuleID = moduleID
		ThreatLib:Debug("Activated npc module %s revision %s", moduleID, MINOR)
		registeredModules[moduleID](mod)

		mod:OnInitialize()
		mod:OnEnable()

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
	local dead = UnitIsDead("mouseover")
	local guid = UnitGUID("mouseover")
	if guid and not dead then
		activateModule(self, guid, true)
	end
end

function ThreatLibNPCModuleCore:PLAYER_TARGET_CHANGED()
	local dead = UnitIsDead("target")
	local guid = UnitGUID("target")
	if guid and not dead then
		activateModule(self, guid, true)
	end
end

function ThreatLibNPCModuleCore.modulePrototype:OnInitialize()
	if not self.initted then
		self.chatEvents = {}
		self.encounterEnemies = {}
		self.SpellHandlers = {}
		self.SpellDamageHandlers = {}
		self.buffGains = {}
		self.buffFades = {}
		self.translations = {}
		self.timers = {}
		self:Init()
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

function ThreatLibNPCModuleCore.modulePrototype:RegisterSpellHandler(event, npcId, spellId, func)
	if type(event) ~= "string" or event:sub(1,6) ~= "SPELL_" then
		error("First parameter to :RegisterSpellHandler must be a SPELL_* event, got " .. tostring(event), 2)
	end
	if type(func) ~= "function" then
		error("Second parameter to :RegisterSpellHandler must be a function, got " .. type(func), 2)
	end
	assert(type(npcId) == "number", "npcId must be a number")
	assert(type(spellId) == "number", "spellId must be a number")

	-- convert spellId to spellName and use together with npcIds as  classic does
	-- not provide spellId in combat log events to hide spell ranks from addons
	local spellName = GetSpellInfo(spellId)
	assert(spellName, "No spell found for registered spellId")

	if not self.SpellHandlers[event] then
		self.SpellHandlers[event] = {}
	end
	local npcHandlers = self.SpellHandlers[event]
	if not npcHandlers[npcId] then
		npcHandlers[npcId] = {}
	end
	npcHandlers[npcId][spellName] = func
	
end

-- this is used when threat is reduced by being hit by a spell rather than being the target of a spell
-- it also needs special handling as resists and absorbs can also reduce threat
function ThreatLibNPCModuleCore.modulePrototype:RegisterSpellDamageHandler(npcId, spellId, func)
	if type(func) ~= "function" then
		error("Second parameter to :RegisterSpellDamageHandler must be a function, got " .. type(func), 2)
	end
	assert(type(npcId) == "number", "npcId must be a number")
	assert(type(spellId) == "number", "spellId must be a number")
	-- convert spellId to spellName and use together with npcIds as  classic does
	-- not provide spellId in combat log events to hide spell ranks from addons
	local spellName = GetSpellInfo(spellId)
	assert(spellName, "No spell found for registered spellId")

	if not self.SpellDamageHandlers[npcId] then
		self.SpellDamageHandlers[npcId] = {}
	end
	local handlers = self.SpellDamageHandlers[npcId]

	ThreatLib:Debug("spell damage handler registered")
	handlers[spellName] = func
end

function ThreatLibNPCModuleCore.modulePrototype:RegisterBuffGainsHandler(npcId, spellId, func)
	if type(func) ~= "function" then
		error("Second parameter to :RegisterBuffHandler must be a function, got " .. type(func), 2)
	end
	assert(type(npcId) == "number", "npcId must be a number")
	assert(type(spellId) == "number", "spellId must be a number")
	-- convert spellId to spellName and use together with npcIds as  classic does
	-- not provide spellId in combat log events to hide spell ranks from addons
	local spellName = GetSpellInfo(spellId)
	assert(spellName, "No spell found for registered spellId")

	if not self.buffGains[npcId] then
		self.buffGains[npcId] = {}
	end

	local handlers = self.buffGains[npcId]
	handlers[spellName] = func
end

function ThreatLibNPCModuleCore.modulePrototype:RegisterBuffFadesHandler(npcId, spellId, func)
	if type(func) ~= "function" then
		error("Second parameter to :RegisterBuffHandler must be a function, got " .. type(func), 2)
	end
	assert(type(npcId) == "number", "npcId must be a number")
	assert(type(spellId) == "number", "spellId must be a number")
	-- convert spellId to spellName and use together with npcIds as  classic does
	-- not provide spellId in combat log events to hide spell ranks from addons
	local spellName = GetSpellInfo(spellId)
	assert(spellName, "No spell found for registered spellId")

	if not self.buffFades[npcId] then
		self.buffFades[npcId] = {}
	end

	local handlers = self.buffFades[npcId]
	handlers[spellName] = func
end

function ThreatLibNPCModuleCore.modulePrototype:GetTranslation(string)
	local selfName = self.name
	local data = translations[selfName]
	if not data then
		if ThreatLib.WarnMissingTranslations then
			error("LibThreatClassic2: No translations registered for " .. selfName)
		end
		return
	end
	local data_MY_LOCALE = data[MY_LOCALE]
	if not data_MY_LOCALE then
		if ThreatLib.WarnMissingTranslations then
			error(("LibThreatClassic2: Missing %s translation for %q in module %q"):format(MY_LOCALE, string, selfName))
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

	self:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
	ThreatLibNPCModuleCore.activeModule = nil
	ThreatLibNPCModuleCore.activeModuleID = nil
end

function ThreatLibNPCModuleCore.modulePrototype:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	if not InCombatLockdown() then return end

	local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, _, auraType = CombatLogGetCurrentEventInfo()
	local missType = auraType
	if subEvent == "UNIT_DIED" then
		if bit_band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC then
			local npcId = ThreatLib:NPCID(destGUID)
			local func = self.encounterEnemies[npcId]
			if func then
				func(self, npcId, destGUID, destName, sourceName, sourceGUID)
			end
		end
	elseif subEvent == "SPELL_AURA_REMOVED" then
		if bit_band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC and auraType == AURA_TYPE_BUFF then
			local npcId = ThreatLib:NPCID(destGUID)
			local spellName = GetSpellInfo(spellId)
			if self.buffFades[npcId] and spellName then
				local func = self.buffFades[npcId][spellName]
				if func then
					func(self, npcId)
				end
			end
		end
	elseif subEvent == "SPELL_AURA_APPLIED" then
		if bit_band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC and auraType == AURA_TYPE_BUFF then
			local npcId = ThreatLib:NPCID(destGUID)
			local spellName = GetSpellInfo(spellId)
			if self.buffGains[npcId] and spellName then
				local func = self.buffGains[npcId][spellName]
				if func then
					func(self, npcId)
				end
			end
			
		end
	-- fully resisted spells apparently still perform threat mods, so SPELL_MISS is needed in Classic
	elseif (subEvent == "SPELL_DAMAGE" or (subEvent == "SPELL_MISSED" and (missType == "RESIST" or missType == "ABSORB"))) and bit_band(sourceFlags, REACTION_ATTACKABLE) ~= 0 and bit_band(sourceFlags, COMBATLOG_OBJECT_TYPE_NPC) == COMBATLOG_OBJECT_TYPE_NPC then
		local npcId = ThreatLib:NPCID(sourceGUID)
		local unitID = nil
		if bit_band(destFlags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME then
			unitID = "player"
		elseif bit_band(destFlags, COMBATLOG_FILTER_MY_PET) == COMBATLOG_FILTER_MY_PET then
			unitID = "pet"
		end
		if unitID and self.SpellDamageHandlers[npcId] then
			local func = self.SpellDamageHandlers[npcId][spellName]
			if func then
				func(self, sourceGUID, unitID)
			end
		end
	end

	if self.SpellHandlers[subEvent] then
		local npcId = ThreatLib:NPCID(sourceGUID)
		if self.SpellHandlers[subEvent][npcId] then
			local unitID = nil
			if bit_band(destFlags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME then
				unitID = "player"
			elseif bit_band(destFlags, COMBATLOG_FILTER_MY_PET) == COMBATLOG_FILTER_MY_PET then
				unitID = "pet"
			end
			-- ThreatLib:Debug("spell cast success %s %s %s %s %s", sourceGUID, destGUID, spellId, GetSpellInfo(spellId))
			local func = self.SpellHandlers[subEvent][npcId][spellName]
			if func then
				func(self, sourceGUID, unitID)
			end
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
	self:OnDisable()
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

function ThreatLibNPCModuleCore.modulePrototype:ModifyThreat(guid, target, multi, add)
	local module
	if target == "player" then
		module = ThreatLib:GetModule("Player-r"..MINOR)
	elseif target == "pet" then
		module = ThreatLib:GetModule("Pet-r"..MINOR)
	end
	if module and module.targetThreat[guid] then
		module:MultiplyTargetThreat(guid, multi)
		module:AddTargetThreat(guid, add)
	end
end

function ThreatLibNPCModuleCore.modulePrototype:ModifyThreatOnTargetGUID(GUID, targetGUID, ...)
	if targetGUID == ThreatLib:GetModule("Player-r"..MINOR).unitGUID then
		ModifyThreat(GUID, "player", ...)
	end
	if targetGUID == ThreatLib:GetModule("Pet-r"..MINOR).unitGUID then
		ModifyThreat(GUID, "pet", ...)
	end
end
