local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	Message for BG Queues (temporary)
----------------------------------------------------------------------------------------
local hasShown = false

local PvPMessage = CreateFrame("Frame")
PvPMessage:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
PvPMessage:SetScript("OnEvent", function()
	if not hasShown and StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
		hasShown = true
		print("|cffffff00".."There is an issue with entering BGs from the StaticPopupDialog. Please enter by right clicking the minimap icon.".."|r")
	else
		hasShown = false
	end
end)

----------------------------------------------------------------------------------------
--	NOOP / Pass Functions not found in Classic
----------------------------------------------------------------------------------------
UnitInVehicle = _G.UnitInVehicle or T.dummy

----------------------------------------------------------------------------------------
--	LibClassicDurations (by d87)
----------------------------------------------------------------------------------------
local LibClassicDurations = LibStub("LibClassicDurations")
LibClassicDurations:Register("ShestakUI")

----------------------------------------------------------------------------------------
--	TBC+ Shaman Coloring (config option later)
----------------------------------------------------------------------------------------
RAID_CLASS_COLORS.SHAMAN.r = 0
RAID_CLASS_COLORS.SHAMAN.g = 0.44
RAID_CLASS_COLORS.SHAMAN.b = 0.87
RAID_CLASS_COLORS.SHAMAN.colorStr = "0070de"

----------------------------------------------------------------------------------------
--	Specialization Functions
----------------------------------------------------------------------------------------
local spellLookup = {
	-- Feasts and Portals
	698,		-- Ritual of Summoning
	18400,		-- Piccolo of the Flaming Fire
	22700,		-- Field Repair Bot 74A
	10059,		-- Portal: Stormwind
	11416,		-- Portal: Ironforge
	11419,		-- Portal: Darnassus
	11417,		-- Portal: Orgrimmar
	11420,		-- Portal: Thunder Bluff
	11418,		-- Portal: Undercity
	28148,		-- Portal: Karazhan

	-- Announcements / Raid CDs
	633,		-- Lay on Hands
	694,		-- Mocking Blow
	724,		-- Lightwell
	740,		-- Tranquility
	871,		-- Shield Wall
	1022,		-- Blessing of Protection
	1161,		-- Challenging Shout
	2006,		-- Resurrection
	2008,		-- Ancestral Spirit
	5209,		-- Challenging Roar
	6346,		-- Fear Ward
	7328,		-- Redemption
	10060,		-- Power Infusion
	12975,		-- Last Stand
	16190,		-- Mana Tide Totem
	19801,		-- Tranquilizing Shot
	20707,		-- Soulstone Resurrection
	20484,		-- Rebirth
	27740,		-- Reincarnation
	29166,		-- Innervate

	-- Enemy CDs
	-- TODO

	-- Combat Text Heal Filters
	22842,		-- Frenzied Regeneration
	774,		-- Rejuvenation
	8936,		-- Regrowth
	740,		-- Tranquility
	136,		-- Mend Pet
	19579,		-- Spirit Bond
	19579,		-- Judgement of Light
	15290,		-- Vampiric Embrace
	23455,		-- Holy Nova
	139,		-- Renew
	596,		-- Prayer of Healing
	5672,		-- Healing Stream
	1064,		-- Chain Heal
	23880,		-- Bloodthirst

	-- Combat Text Damage Filters
	6603,		-- Auto Attack
	779,		-- Swipe
	779,		-- Moonfire
	16914,		-- Hurricane
	1822,		-- Rake
	22570,		-- Mangle
	1079,		-- Rip
	1978,		-- Serpent Sting
	2643,		-- Multi-Shot
	13812,		-- Explosive Trap Effect
	1510,		-- Volley
	2120,		-- Flamestrike
	12654,		-- Ignite
	10,			-- Blizzard
	122,		-- Frost Nova
	1449,		-- Arcane Explosion
	120,		-- Cone of Cold
	7268,		-- Arcane Missiles
	11113,		-- Blast Wave
	26573,		-- Consecration
	20911,		-- Blessing of Sanctuary
	20925,		-- Holy Shield
	-- 15237,		-- Holy Nova
	589,		-- Shadow Word: Pain
	14914,		-- Holy Fire
	2818,		-- Deadly Poison
	703,		-- Garrote
	8680,		-- Instant Poison
	22482,		-- Blade Flurry
	1943,		-- Rupture
	26545,		-- Lightning Shield
	421,		-- Chain Lightning
	8349,		-- Fire Nova
	8187,		-- Magma Totem
	8050,		-- Flame Shock
	10444,		-- Flametongue Attack
	-- 3606,		-- Attack (Searing Bolt)
	172,		-- Corruption
	348,		-- Immolate
	980,		-- Curse of Agony
	18265,		-- Siphon Life
	5740,		-- Rain of Fire
	1949,		-- Hellfire
	20153,		-- Immolation (Infrenal)
	22703,		-- Infernal Awakening
	845,		-- Cleave
	5308,		-- Execute
	7384,		-- Overpower
	1464,		-- Slam
	12294,		-- Mortal Strike
	12162,		-- Deep Wounds
	1680,		-- Whirlwind
	6343,		-- Thunder Clap
	6572,		-- Revenge
	772,		-- Rend
	-- 23881,		-- Bloodthirst
}

local spellLookupLocalized = {}
for i = 1, #spellLookup do
	local name = GetSpellInfo(spellLookup[i])
	if not name then
		print("|cffff0000WARNING: spell ID ["..tostring(spellLookup[i]).."] no longer exists! Report this to EsreverWoW.|r")
	else
		spellLookupLocalized[name] = spellLookup[i]
	end
end
spellLookup = nil

function T.GetSpellID(spellName, unit, auraType)
	-- change localized MELEE string into the appropriate spellID
	if spellName == MELEE then
		return 6603
	-- get spellID from auras
	elseif auraType and unit then
		if auraType == AURA_TYPE_DEBUFF then
			return select(10, AuraUtil.FindAuraByName(spellName, unit, "HARMFUL")) or 0
		else
			return select(10, AuraUtil.FindAuraByName(spellName, unit)) or 0
		end
	-- get spellID from lookup/spellbook
	else
		-- eventually build a cache from UNIT_SPELLCAST_* events to track lower ranks
		-- for now, we just assume max rank and get that spellID from the spellbook
		local spellID = spellLookupLocalized[spellName]
		if not spellID then
			spellID = select(7, GetSpellInfo(spellName))
		end

		return spellID or 0
	end
end

----------------------------------------------------------------------------------------
--	Specialization Functions
----------------------------------------------------------------------------------------
local specializationID = {
	["DRUID"] = {
		[1] = 102, -- Balance
		[2] = 103, -- Feral
		[3] = 105, -- Restoration
	},
	["HUNTER"] = {
		[1] = 253, -- Beast Mastery
		[2] = 254, -- Marksmanship
		[3] = 255, -- Survival
	},
	["MAGE"] = {
		[1] = 62, -- Arcane
		[2] = 63, -- Fire
		[3] = 64, -- Frost
	},
	["PALADIN"] = {
		[1] = 65, -- Holy
		[2] = 66, -- Protection
		[3] = 67, -- Retribution
	},
	["PRIEST"] = {
		[1] = 256, -- Discipline
		[2] = 257, -- Holy
		[3] = 258, -- Shadow
	},
	["ROGUE"] = {
		[1] = 259, -- Assassination
		[2] = 260, -- Combat
		[3] = 261, -- Subtlety
	},
	["SHAMAN"] = {
		[1] = 262, -- Elemental
		[2] = 263, -- Enhancement
		[3] = 264, -- Restoration
	},
	["WARLOCK"] = {
		[1] = 265, -- Affliction
		[2] = 266, -- Demonology
		[3] = 267, -- Destruction
	},
	["WARRIOR"] = {
		[1] = 71, -- Arms
		[2] = 72, -- Fury
		[3] = 73, -- Protection
	}
}

local specializationIcons = {
	["DRUID"] = {
		[1] = "Spell_nature_starfall",			-- Balance
		[2] = "Ability_druid_catform",			-- Feral
		[3] = "Spell_nature_healingtouch"		-- Restoration
	},
	["HUNTER"] = {
		[1] = "Ability_hunter_beasttaming",		-- Beast Mastery
		[2] = "Ability_marksmanship",			-- Marksmanship
		[3] = "Ability_hunter_swiftstrike"		-- Survival
	},
	["MAGE"] = {
		[1] = "Spell_holy_magicalsentry",		-- Arcane
		[2] = "Spell_fire_firebolt02",			-- Fire
		[3] = "Spell_frost_frostbolt02"			-- Frost
	},
	["PALADIN"] = {
		[1] = "Spell_holy_holybolt",			-- Holy
		[2] = "Spell_holy_devotionaura",		-- Protection
		[3] = "Spell_holy_auraoflight"			-- Retribution
	},
	["PRIEST"] = {
		[1] = "Spell_holy_wordfortitude",		-- Discipline
		[2] = "Spell_holy_holybolt",			-- Holy
		[3] = "Spell_shadow_shadowwordpain"		-- Shadow
	},
	["ROGUE"] = {
		[1] = "Ability_rogue_eviscerate",		-- Assassination
		[2] = "Ability_backstab",				-- Combat
		[3] = "Ability_stealth"					-- Subtlety
	},
	["SHAMAN"] = {
		[1] = "Spell_nature_lightning",			-- Elemental
		[2] = "Spell_nature_lightningshield",	-- Enhancement
		[3] = "Spell_nature_magicimmunity"		-- Restoration
	},
	["WARLOCK"] = {
		[1] = "Spell_shadow_deathcoil",			-- Affliction
		[2] = "Spell_shadow_metamorphosis",		-- Demonology
		[3] = "Spell_shadow_rainoffire"			-- Destruction
	},
	["WARRIOR"] = {
		[1] = "Ability_rogue_eviscerate",		-- Arms
		[2] = "Ability_warrior_innerrage",		-- Fury
		[3] = "Ability_warrior_defensivestance"	-- Protection
	}
}

local specializationInfoDB = { -- needs localized names
	[102] = {
		["name"] = "Balance",
		["description"] = "",
		["icon"] = "Spell_nature_starfall",
		["role"] = "DAMAGER",
		["class"] = "DRUID"
	},
	[103] = {
		["name"] = "Feral",
		["description"] = "",
		["icon"] = "Ability_druid_catform",
		["role"] = "TANK",
		["class"] = "DRUID"
	},
	[105] = {
		["name"] = "Restoration",
		["description"] = "",
		["icon"] = "Spell_nature_healingtouch",
		["role"] = "TANK",
		["class"] = "DRUID"
	},
	[253] = {
		["name"] = "Beast Mastery",
		["description"] = "",
		["icon"] = "Ability_hunter_beasttaming",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[254] = {
		["name"] = "Marksmanship",
		["description"] = "",
		["icon"] = "Ability_marksmanship",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[255] = {
		["name"] = "Survival",
		["description"] = "",
		["icon"] = "Ability_hunter_swiftstrike",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[62] = {
		["name"] = "Arcane",
		["description"] = "",
		["icon"] = "Spell_holy_magicalsentry",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[63] = {
		["name"] = "Fire",
		["description"] = "",
		["icon"] = "Spell_fire_firebolt02",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[64] = {
		["name"] = "Frost",
		["description"] = "",
		["icon"] = "Spell_frost_frostbolt02",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[65] = {
		["name"] = "Holy",
		["description"] = "",
		["icon"] = "Spell_holy_holybolt",
		["role"] = "HEALER",
		["class"] = "PALADIN"
	},
	[66] = {
		["name"] = "Protection",
		["description"] = "",
		["icon"] = "Spell_holy_devotionaura",
		["role"] = "TANK",
		["class"] = "PALADIN"
	},
	[67] = {
		["name"] = "Retribution",
		["description"] = "",
		["icon"] = "Spell_holy_auraoflight",
		["role"] = "DAMAGER",
		["class"] = "PALADIN"
	},
	[256] = {
		["name"] = "Discipline",
		["description"] = "",
		["icon"] = "Spell_holy_wordfortitude",
		["role"] = "HEALER",
		["class"] = "PRIEST"
	},
	[257] = {
		["name"] = "Holy",
		["description"] = "",
		["icon"] = "Spell_holy_holybolt",
		["role"] = "HEALER",
		["class"] = "PRIEST"
	},
	[258] = {
		["name"] = "Shadow",
		["description"] = "",
		["icon"] = "Spell_shadow_shadowwordpain",
		["role"] = "DAMAGER",
		["class"] = "PRIEST"
	},
	[259] = {
		["name"] = "Assassination",
		["description"] = "",
		["icon"] = "Ability_rogue_eviscerate",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[260] = {
		["name"] = "Combat",
		["description"] = "",
		["icon"] = "Ability_backstab",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[261] = {
		["name"] = "Subtlety",
		["description"] = "",
		["icon"] = "Ability_stealth",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[262] = {
		["name"] = "Elemental",
		["description"] = "",
		["icon"] = "Spell_nature_lightning",
		["role"] = "DAMAGER",
		["class"] = "SHAMAN"
	},
	[263] = {
		["name"] = "Enhancement",
		["description"] = "",
		["icon"] = "Spell_nature_lightningshield",
		["role"] = "DAMAGER",
		["class"] = "SHAMAN"
	},
	[264] = {
		["name"] = "Restoration",
		["description"] = "",
		["icon"] = "Spell_nature_magicimmunity",
		["role"] = "HEALER",
		["class"] = "SHAMAN"
	},
	[265] = {
		["name"] = "Affliction",
		["description"] = "",
		["icon"] = "Spell_shadow_deathcoil",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[266] = {
		["name"] = "Demonology",
		["description"] = "",
		["icon"] = "Spell_shadow_metamorphosis",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[267] = {
		["name"] = "Destruction",
		["description"] = "",
		["icon"] = "Spell_shadow_rainoffire",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[71] = {
		["name"] = "Arms",
		["description"] = "",
		["icon"] = "Ability_rogue_eviscerate",
		["role"] = "DAMAGER",
		["class"] = "WARRIOR"
	},
	[72] = {
		["name"] = "Fury",
		["description"] = "",
		["icon"] = "Ability_warrior_innerrage",
		["role"] = "DAMAGER",
		["class"] = "WARRIOR"
	},
	[73] = {
		["name"] = "Protection",
		["description"] = "",
		["icon"] = "Ability_warrior_defensivestance",
		["role"] = "TANK",
		["class"] = "WARRIOR"
	},
}

function T.GetSpecialization(...)
	local current = {}
	local primaryTree = 1
	for i = 1, 3 do
		_, _, current[i] = GetTalentTabInfo(i, "player", nil)
		if current[i] > current[primaryTree] then
			primaryTree = i
		end
	end
	return primaryTree
end

function T.GetSpecializationRole()
	local tree = T.GetSpecialization()
	local role
	if ((T.class == "PALADIN" and tree == 2) or (T.class == "WARRIOR" and tree == 3)) or (T.class == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		role = "TANK"
	elseif ((T.class == "PALADIN" and tree == 1) or (T.class == "DRUID" and tree == 3) or (T.class == "SHAMAN" and tree == 3) or (T.class == "PRIEST" and tree ~= 3)) then
		role = "HEALER"
	else
		local int = select(2, UnitStat("player", 4))
		local agi = select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player")
		local ap = base + posBuff + negBuff

		if (((ap > int) or (agi > int)) and not (T.class == "SHAMAN" and tree ~= 1 and tree ~= 3) and not AuraUtil.FindAuraByName(GetSpellInfo(24858), "player")) or T.class == "ROGUE" or T.class == "HUNTER" or (T.class == "SHAMAN" and tree == 2) then
			role = "MELEE" -- ordinarily "DAMAGER"
		else
			role = "CASTER" -- ordinarily "DAMAGER"
		end
	end

	return role
end

function T.GetSpecializationInfo(specIndex, ...)
	local id = specializationID[T.class][specIndex]
	local name, description, points, background = GetTalentTabInfo(specIndex)
	local icon = "Interface\\ICONS\\" .. specializationIcons[T.class][specIndex]
	local role = T.GetSpecializationRole()
	if role == "CASTER" or role == "MELEE" then
		role = "DAMAGER"
	end
	local primaryStat = ""
	return id, name, description, icon, background, role, primaryStat
end

function T.GetSpecializationInfoByID(specID)
	if specializationInfoDB[specID] then
		local id = specID
		local name = specializationInfoDB[specID].name
		local description = specializationInfoDB[specID].description
		local icon = "Interface\\ICONS\\"..specializationInfoDB[specID].icon
		local role = specializationInfoDB[specID].role
		local class = specializationInfoDB[specID].class

		if name then
			return id, name, description, icon, role, class
		end
	end
end

UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned or function(unit) -- Needs work
	if unit == "player" then
		local role = T.GetSpecializationRole()
		if role == "MELEE" or role == "CASTER" then
			role = "DAMAGER"
		else
			role = role or ""
		end
		return role
	end
end

-- Add later
GetAverageItemLevel = _G.GetAverageItemLevel or function()
	local slotName = {
		"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot",
		"Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot"
	}

	local i, total, slot, itn, level = 0, 0, nil, 0

	for i in pairs(slotName) do
		slot = GetInventoryItemLink("player", GetInventorySlotInfo(slotName[i]))
		if slot ~= nil then
			itn = itn + 1
			level = select(4, GetItemInfo(slot))
			total = total + level
		end
	end

	if total < 1 or itn < 1 then return 0 end

	return floor(total / itn), floor(total / itn)
end

----------------------------------------------------------------------------------------
--	Threat Functions
----------------------------------------------------------------------------------------
local ThreatLib = LibStub:GetLibrary("ThreatClassic-1.0")
if not ThreatLib then return end

local ThreatFrame = CreateFrame("Frame")

ThreatLib.RegisterCallback(ThreatFrame, "Activate", T.dummy)
ThreatLib.RegisterCallback(ThreatFrame, "Deactivate", T.dummy)
ThreatLib:RequestActiveOnSolo(true)

GetThreatStatusColor = _G.GetThreatStatusColor or function(statusIndex)
	return ThreatLib:GetThreatStatusColor(statusIndex)
end

UnitDetailedThreatSituation = _G.UnitDetailedThreatSituation or function(unit, target)
	return ThreatLib:UnitDetailedThreatSituation(unit, target)
end

UnitThreatSituation = _G.UnitThreatSituation or function(unit, target)
	return ThreatLib:UnitThreatSituation(unit, target)
end
