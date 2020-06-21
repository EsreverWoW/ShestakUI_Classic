--[[
-- A compatible implementation of GetTotemInfo() API for WoW Classic 1.13.3.
-- The code from <https://git.neuromancy.net/projects/RM/repos/rotationmaster/browse/fake.lua?until=a0a2fc3bdfb5fa8199f14d66bd22666258f67aa4&untilPath=fake.lua>
-- by PreZ and edited / fixed by SwimmingTiger.
]]
local MAJOR = "LibTotemInfo-1.0"
local MINOR = 10004 -- Should be manually increased
local LibStub = _G.LibStub

assert(LibStub, MAJOR .. " requires LibStub")

local lib, oldMinor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
	return
end -- No upgrade needed

local TotemItems = {
	[EARTH_TOTEM_SLOT] = 5175,
	[FIRE_TOTEM_SLOT] = 5176,
	[WATER_TOTEM_SLOT] = 5177,
	[AIR_TOTEM_SLOT] = 5178,
}

local RankTable = {
	"I", "II", "III", "IV", "V", "VI", "VII", "VIII"
}

-- Generate the table with this script:
-- <https://github.com/SwimmingTiger/LibTotemInfo/wiki/Generate-the-TotemSpells-table>
-- Note: The field "name" is for human reading only and the code does not use it.
--       Localized spell names will be obtained via GetSpellInfo().
local TotemSpells = {
	[10595] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Nature Resistance Totem I",
		["element"] = 4,
	},
	[5394] = {
		["rank"] = 1,
		["duration"] = 60,
		["name"] = "Healing Stream Totem I",
		["element"] = 3,
	},
	[10600] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Nature Resistance Totem II",
		["element"] = 4,
	},
	[8190] = {
		["rank"] = 1,
		["duration"] = 20,
		["name"] = "Magma Totem I",
		["element"] = 1,
	},
	[16190] = {
		["rank"] = 1,
		["duration"] = 12,
		["name"] = "Mana Tide Totem I",
		["element"] = 3,
	},
	[10478] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Frost Resistance Totem II",
		["element"] = 1,
	},
	[10479] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Frost Resistance Totem III",
		["element"] = 1,
	},
	[16387] = {
		["rank"] = 4,
		["duration"] = 120,
		["name"] = "Flametongue Totem IV",
		["element"] = 1,
	},
	[10613] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Windfury Totem II",
		["element"] = 4,
	},
	[10614] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Windfury Totem III",
		["element"] = 4,
	},
	[8071] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Stoneskin Totem I",
		["element"] = 2,
	},
	[10495] = {
		["rank"] = 2,
		["duration"] = 60,
		["name"] = "Mana Spring Totem II",
		["element"] = 3,
	},
	[10496] = {
		["rank"] = 3,
		["duration"] = 60,
		["name"] = "Mana Spring Totem III",
		["element"] = 3,
	},
	[10497] = {
		["rank"] = 4,
		["duration"] = 60,
		["name"] = "Mana Spring Totem IV",
		["element"] = 3,
	},
	[8075] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Strength of Earth Totem I",
		["element"] = 2,
	},
	[10627] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Grace of Air Totem II",
		["element"] = 4,
	},
	[6363] = {
		["rank"] = 2,
		["duration"] = 35,
		["name"] = "Searing Totem II",
		["element"] = 1,
	},
	[6364] = {
		["rank"] = 3,
		["duration"] = 40,
		["name"] = "Searing Totem III",
		["element"] = 1,
	},
	[6365] = {
		["rank"] = 4,
		["duration"] = 45,
		["name"] = "Searing Totem IV",
		["element"] = 1,
	},
	[8227] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Flametongue Totem I",
		["element"] = 1,
	},
	[22047] = {
		["rank"] = 1,
		["duration"] = 30,
		["name"] = "Testing Totem I",
		["element"] = 1,
	},
	[17354] = {
		["rank"] = 2,
		["duration"] = 12,
		["name"] = "Mana Tide Totem II",
		["element"] = 3,
	},
	[25359] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Grace of Air Totem III",
		["element"] = 4,
	},
	[25361] = {
		["rank"] = 5,
		["duration"] = 120,
		["name"] = "Strength of Earth Totem V",
		["element"] = 2,
	},
	[5675] = {
		["rank"] = 1,
		["duration"] = 60,
		["name"] = "Mana Spring Totem I",
		["element"] = 3,
	},
	[10526] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Flametongue Totem III",
		["element"] = 1,
	},
	[6375] = {
		["rank"] = 2,
		["duration"] = 60,
		["name"] = "Healing Stream Totem II",
		["element"] = 3,
	},
	[8154] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Stoneskin Totem II",
		["element"] = 2,
	},
	[8498] = {
		["rank"] = 2,
		["duration"] = 5,
		["name"] = "Fire Nova Totem II",
		["element"] = 1,
	},
	[6377] = {
		["rank"] = 3,
		["duration"] = 60,
		["name"] = "Healing Stream Totem III",
		["element"] = 3,
	},
	[10406] = {
		["rank"] = 4,
		["duration"] = 120,
		["name"] = "Stoneskin Totem IV",
		["element"] = 2,
	},
	[10407] = {
		["rank"] = 5,
		["duration"] = 120,
		["name"] = "Stoneskin Totem V",
		["element"] = 2,
	},
	[10408] = {
		["rank"] = 6,
		["duration"] = 120,
		["name"] = "Stoneskin Totem VI",
		["element"] = 2,
	},
	[10537] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Fire Resistance Totem II",
		["element"] = 3,
	},
	[10538] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Fire Resistance Totem III",
		["element"] = 3,
	},
	[15111] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Windwall Totem II",
		["element"] = 4,
	},
	[15112] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Windwall Totem III",
		["element"] = 4,
	},
	[8160] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Strength of Earth Totem II",
		["element"] = 2,
	},
	[8161] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Strength of Earth Totem III",
		["element"] = 2,
	},
	[8512] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Windfury Totem I",
		["element"] = 4,
	},
	[8262] = {
		["rank"] = 1,
		["duration"] = 30,
		["name"] = "Elemental Protection Totem I",
		["element"] = 3,
	},
	[8264] = {
		["rank"] = 1,
		["duration"] = 20,
		["name"] = "Lava Spout Totem I",
		["element"] = 1,
	},
	[11314] = {
		["rank"] = 4,
		["duration"] = 5,
		["name"] = "Fire Nova Totem IV",
		["element"] = 1,
	},
	[8166] = {
		["duration"] = 120,
		["name"] = "Poison Cleansing Totem",
		["element"] = 3,
	},
	[10427] = {
		["rank"] = 5,
		["duration"] = 15,
		["name"] = "Stoneclaw Totem V",
		["element"] = 2,
	},
	[10428] = {
		["rank"] = 6,
		["duration"] = 15,
		["name"] = "Stoneclaw Totem VI",
		["element"] = 2,
	},
	[6390] = {
		["rank"] = 2,
		["duration"] = 15,
		["name"] = "Stoneclaw Totem II",
		["element"] = 2,
	},
	[6391] = {
		["rank"] = 3,
		["duration"] = 15,
		["name"] = "Stoneclaw Totem III",
		["element"] = 2,
	},
	[6392] = {
		["rank"] = 4,
		["duration"] = 15,
		["name"] = "Stoneclaw Totem IV",
		["element"] = 2,
	},
	[1535] = {
		["rank"] = 1,
		["duration"] = 5,
		["name"] = "Fire Nova Totem I",
		["element"] = 1,
	},
	[10438] = {
		["rank"] = 6,
		["duration"] = 55,
		["name"] = "Searing Totem VI",
		["element"] = 1,
	},
	[10442] = {
		["rank"] = 4,
		["duration"] = 120,
		["name"] = "Strength of Earth Totem IV",
		["element"] = 2,
	},
	[2484] = {
		["duration"] = 45,
		["name"] = "Earthbind Totem",
		["element"] = 2,
	},
	[25908] = {
		["duration"] = 120,
		["name"] = "Tranquil Air Totem",
		["element"] = 4,
	},
	[17359] = {
		["rank"] = 3,
		["duration"] = 12,
		["name"] = "Mana Tide Totem III",
		["element"] = 3,
	},
	[8184] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Fire Resistance Totem I",
		["element"] = 3,
	},
	[10437] = {
		["rank"] = 5,
		["duration"] = 50,
		["name"] = "Searing Totem V",
		["element"] = 1,
	},
	[8177] = {
		["duration"] = 45,
		["name"] = "Grounding Totem",
		["element"] = 4,
	},
	[15107] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Windwall Totem I",
		["element"] = 4,
	},
	[11315] = {
		["rank"] = 5,
		["duration"] = 5,
		["name"] = "Fire Nova Totem V",
		["element"] = 1,
	},
	[6495] = {
		["duration"] = 300,
		["name"] = "Sentry Totem",
		["element"] = 4,
	},
	[15786] = {
		["duration"] = 45,
		["name"] = "Earthbind Totem",
		["element"] = 2,
	},
	[15787] = {
		["duration"] = 5,
		["name"] = "Moonflare Totem",
		["element"] = 1,
	},
	[8835] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Grace of Air Totem I",
		["element"] = 4,
	},
	[10601] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Nature Resistance Totem III",
		["element"] = 4,
	},
	[8181] = {
		["rank"] = 1,
		["duration"] = 120,
		["name"] = "Frost Resistance Totem I",
		["element"] = 1,
	},
	[8170] = {
		["duration"] = 120,
		["name"] = "Disease Cleansing Totem",
		["element"] = 3,
	},
	[3599] = {
		["rank"] = 1,
		["duration"] = 30,
		["name"] = "Searing Totem I",
		["element"] = 1,
	},
	[10586] = {
		["rank"] = 3,
		["duration"] = 20,
		["name"] = "Magma Totem III",
		["element"] = 1,
	},
	[10587] = {
		["rank"] = 4,
		["duration"] = 20,
		["name"] = "Magma Totem IV",
		["element"] = 1,
	},
	[10585] = {
		["rank"] = 2,
		["duration"] = 20,
		["name"] = "Magma Totem II",
		["element"] = 1,
	},
	[10462] = {
		["rank"] = 4,
		["duration"] = 60,
		["name"] = "Healing Stream Totem IV",
		["element"] = 3,
	},
	[10463] = {
		["rank"] = 5,
		["duration"] = 60,
		["name"] = "Healing Stream Totem V",
		["element"] = 3,
	},
	[8155] = {
		["rank"] = 3,
		["duration"] = 120,
		["name"] = "Stoneskin Totem III",
		["element"] = 2,
	},
	[5730] = {
		["rank"] = 1,
		["duration"] = 15,
		["name"] = "Stoneclaw Totem I",
		["element"] = 2,
	},
	[8499] = {
		["rank"] = 3,
		["duration"] = 5,
		["name"] = "Fire Nova Totem III",
		["element"] = 1,
	},
	[8249] = {
		["rank"] = 2,
		["duration"] = 120,
		["name"] = "Flametongue Totem II",
		["element"] = 1,
	},
	[8143] = {
		["duration"] = 120,
		["name"] = "Tremor Totem",
		["element"] = 2,
	},
}

local ActiveTotems = {}

function lib.HandleTotemSpell(id)
	local totem = TotemSpells[id]
	if totem then
		local name, _, icon = GetSpellInfo(id)
		name = name or ""
		icon = icon or 0

		if totem.rank and RankTable[totem.rank] then
			name = name..' '..RankTable[totem.rank]
		end

		ActiveTotems[totem.element] = {
			spellid = id,
			name = name,
			rank = totem.rank,
			icon = icon,
			duration = totem.duration,
			cast = GetTime(),
			acknowledged = false,
		}
	end
end

function lib.HandleTotemEvent(elem)
	if ActiveTotems[elem] then
		if not ActiveTotems[elem].acknowledged then
			ActiveTotems[elem].acknowledged = true
		else
			ActiveTotems[elem] = nil
		end
	end
end

function lib.UNIT_SPELLCAST_SUCCEEDED(event, unit, castguid, spellid)
	lib.HandleTotemSpell(spellid)
end

function lib.PLAYER_TOTEM_UPDATE(event, elem)
	lib.HandleTotemEvent(elem)
end

lib.EventFrame = CreateFrame('Frame')
lib.EventFrame:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
lib.EventFrame:RegisterEvent('PLAYER_TOTEM_UPDATE')

lib.EventFrame:SetScript("OnEvent", function(_, event, ...)
	if type(lib[event]) == 'function' then
		lib[event](event, ...)
	end
end)


-- haveTotem, totemName, startTime, duration, icon, spellid, rank = GetTotemInfo(1 through 4)
-- <https://wow.gamepedia.com/API_GetTotemInfo>
-- Added return value by the lib (not in Blizzard old interface):
--     spellid - int, the totem's spell id.
--     rank    - int (1 to 8) or nil, the rank of the totem spell.
--               nil indicates that there is no rank for this totem.
function lib.GetTotemInfo(elem)
	local haveTotem, spellName, startTime, duration, icon, spellid, rank = false, "", 0, 0, 0, 0, nil

	if (TotemItems[elem]) then
		local totemItem = GetItemCount(TotemItems[elem])
		haveTotem = (totemItem and totemItem > 0) and true or false
	end

	if ActiveTotems[elem] then
		totemInfo = ActiveTotems[elem]
		spellName = totemInfo.name
		startTime = totemInfo.cast
		duration = totemInfo.duration
		icon = totemInfo.icon
		spellid = totemInfo.spellid
		rank = totemInfo.rank
	end

	return haveTotem, spellName, startTime, duration, icon, spellid, rank
end

-- Exposing GetTotemInfo() to other addons
if type(GetTotemInfo) ~= 'function' then
	GetTotemInfo = lib.GetTotemInfo
end


-- timeLeft = GetTotemTimeLeft(1 through 4)
-- From: <https://github.com/SwimmingTiger/LibTotemInfo/issues/2>
-- Author: Road-block
function lib.GetTotemTimeLeft(elem)
	local _, _, startTime, duration = lib.GetTotemInfo(elem)
	local now = GetTime()
	local expiration = startTime and duration and (startTime + duration)
	if expiration and now < expiration then
		return expiration - now
	end
	return 0
end

-- Exposing GetTotemTimeLeft() to other addons
if type(GetTotemTimeLeft) ~= 'function' then
	GetTotemTimeLeft = lib.GetTotemTimeLeft
end
