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
	[GetSpellInfo(698)] = 698,			-- Ritual of Summoning
	[GetSpellInfo(18400)] = 18400,		-- Piccolo of the Flaming Fire
	[GetSpellInfo(22700)] = 22700,		-- Field Repair Bot 74A
	[GetSpellInfo(10059)] = 10059,		-- Portal: Stormwind
	[GetSpellInfo(11416)] = 11416,		-- Portal: Ironforge
	[GetSpellInfo(11419)] = 11419,		-- Portal: Darnassus
	[GetSpellInfo(11417)] = 11417,		-- Portal: Orgrimmar
	[GetSpellInfo(11420)] = 11420,		-- Portal: Thunder Bluff
	[GetSpellInfo(11418)] = 11418,		-- Portal: Undercity
	[GetSpellInfo(28148)] = 28148,		-- Portal: Karazhan

	-- Announcements / Raid CDs
	[GetSpellInfo(633)] = 633,			-- Lay on Hands
	[GetSpellInfo(694)] = 694,			-- Mocking Blow
	[GetSpellInfo(724)] = 724,			-- Lightwell
	[GetSpellInfo(740)] = 740,			-- Tranquility
	[GetSpellInfo(871)] = 871,			-- Shield Wall
	[GetSpellInfo(1022)] = 1022,		-- Blessing of Protection
	[GetSpellInfo(1161)] = 1161,		-- Challenging Shout
	[GetSpellInfo(2006)] = 2006,		-- Resurrection
	[GetSpellInfo(2008)] = 2008,		-- Ancestral Spirit
	[GetSpellInfo(5209)] = 5209,		-- Challenging Roar
	[GetSpellInfo(6346)] = 6346,		-- Fear Ward
	[GetSpellInfo(7328)] = 7328,		-- Redemption
	[GetSpellInfo(10060)] = 10060,		-- Power Infusion
	[GetSpellInfo(12975)] = 12975,		-- Last Stand
	[GetSpellInfo(16190)] = 16190,		-- Mana Tide Totem
	[GetSpellInfo(19801)] = 19801,		-- Tranquilizing Shot
	[GetSpellInfo(20707)] = 20707,		-- Soulstone Resurrection
	[GetSpellInfo(20484)] = 20484,		-- Rebirth
	[GetSpellInfo(27740)] = 27740,		-- Reincarnation
	[GetSpellInfo(29166)] = 29166,		-- Innervate

	-- Enemy CDs
	-- TODO

	-- Combat Text Heal Filters
	[GetSpellInfo(774)] = 774,			-- Rejuvenation
	[GetSpellInfo(8936)] = 8936,		-- Regrowth
	[GetSpellInfo(19579)] = 19579,		-- Spirit Bond
	[GetSpellInfo(20267)] = 19579,		-- Judgement of Light
	[GetSpellInfo(15290)] = 15290,		-- Vampiric Embrace
	[GetSpellInfo(23455)] = 23455,		-- Holy Nova
	[GetSpellInfo(139)] = 139,			-- Renew
	[GetSpellInfo(596)] = 596,			-- Prayer of Healing
	[GetSpellInfo(5672)] = 5672,		-- Healing Stream
	[GetSpellInfo(1064)] = 1064,		-- Chain Heal
	[GetSpellInfo(23880)] = 23880,		-- Bloodthirst

	-- Combat Text Damage Filters
	[GetSpellInfo(1079)] = 1079,		-- Rip
	[GetSpellInfo(779)] = 779,			-- Swipe
	[GetSpellInfo(8921)] = 779,			-- Moonfire
	[GetSpellInfo(2643)] = 2643,		-- Multi-Shot
	[GetSpellInfo(1978)] = 1978,		-- Serpent Sting
	[GetSpellInfo(13812)] = 13812,		-- Explosive Trap Effect
	[GetSpellInfo(1510)] = 1510,		-- Volley
	[GetSpellInfo(2120)] = 2120,		-- Flamestrike
	[GetSpellInfo(12654)] = 12654,		-- Ignite
	[GetSpellInfo(10)] = 10,			-- Blizzard
	[GetSpellInfo(122)] = 122,			-- Frost Nova
	[GetSpellInfo(1449)] = 1449,		-- Arcane Explosion
	[GetSpellInfo(120)] = 120,			-- Cone of Cold
	[GetSpellInfo(7268)] = 7268,		-- Arcane Missiles
	[GetSpellInfo(11113)] = 11113,		-- Blast Wave
	[GetSpellInfo(26573)] = 26573,		-- Consecration
	-- [GetSpellInfo(15237)] = 15237,		-- Holy Nova
	[GetSpellInfo(589)] = 589,		-- Shadow Word: Pain
	[GetSpellInfo(2818)] = 2818,		-- Deadly Poison
	[GetSpellInfo(703)] = 703,			-- Garrote
	[GetSpellInfo(8680)] = 8680,		-- Instant Poison
	[GetSpellInfo(421)] = 421,			-- Chain Lightning
	[GetSpellInfo(8349)] = 8349,		-- Fire Nova
	[GetSpellInfo(8187)] = 8187,		-- Magma Totem
	[GetSpellInfo(8050)] = 8050,		-- Flame Shock
	[GetSpellInfo(10444)] = 10444,		-- Flametongue Attack
	-- [GetSpellInfo(3606)] = 3606,		-- Attack (Searing Bolt)
	[GetSpellInfo(17364)] = 17364,		-- Stormstrike
	[GetSpellInfo(172)] = 172,			-- Corruption
	[GetSpellInfo(348)] = 348,			-- Immolate
	[GetSpellInfo(980)] = 980,			-- Curse of Agony
	[GetSpellInfo(18265)] = 18265,		-- Siphon Life
	[GetSpellInfo(5740)] = 5740,		-- Rain of Fire
	[GetSpellInfo(1949)] = 1949,		-- Hellfire
	[GetSpellInfo(845)] = 845,			-- Cleave
	[GetSpellInfo(5308)] = 5308,		-- Execute
	[GetSpellInfo(7384)] = 7384,		-- Overpower
	[GetSpellInfo(1464)] = 1464,		-- Slam
	[GetSpellInfo(12294)] = 12294,		-- Mortal Strike
	[GetSpellInfo(12162)] = 12162,		-- Deep Wounds
	[GetSpellInfo(1680)] = 1680,		-- Whirlwind
	[GetSpellInfo(6343)] = 6343,		-- Thunder Clap
	[GetSpellInfo(6572)] = 6572,		-- Revenge
	[GetSpellInfo(772)] = 772,			-- Rend
	-- [GetSpellInfo(23881)] = 23881,		-- Bloodthirst
}

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
		local spellID = spellLookup[spellName]
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
