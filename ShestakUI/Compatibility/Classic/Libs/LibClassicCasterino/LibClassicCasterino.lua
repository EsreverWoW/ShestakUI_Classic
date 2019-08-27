if _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_CLASSIC then return end

--[================[
LibClassicCasterino
Author: d87
--]================]


local MAJOR, MINOR = "LibClassicCasterino", 5
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

lib.frame = lib.frame or CreateFrame("Frame")

local f = lib.frame
local callbacks = lib.callbacks

lib.casters = lib.casters or {} -- setmetatable({}, { __mode = "v" })
local casters = lib.casters

-- local guidsToPurge = {}

local UnitGUID = UnitGUID
local bit_band = bit.band
local GetTime = GetTime
local CastingInfo = CastingInfo
local ChannelInfo = ChannelInfo

local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local classCasts
local classChannels
local talentDecreased
local FireToUnits

f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)


local spellNameToID = {}
local NPCspellNameToID = {}
local NPCSpells

local castTimeCache = {}
local castTimeCacheStartTimes = setmetatable({}, { __mode = "v" })

-- local SpellMixin = _G.Spell
-- local AddSpellNameRecognition = function(lastRankID)
--     local spellObj = SpellMixin:CreateFromSpellID(lastRankID)
--     spellObj:ContinueOnSpellLoad(function()
--         local spellName = spellObj:GetSpellName()
--         spellNameToID[spellName] = lastRankID
--     end)
-- end

local refreshCastTable = function(tbl, ...)
    local numArgs = select("#", ...)
    for i=1, numArgs do
        tbl[i] = select(i, ...)
    end
end

local makeCastUID = function(guid, spellName)
    local _, _, _, _, _, npcID = strsplit("-", guid);
    return npcID..spellName
end

local function CastStart(srcGUID, castType, spellName, spellID, overrideCastTime )
    local _, _, icon, castTime = GetSpellInfo(spellID)
    if castType == "CHANNEL" then
        castTime = classChannels[spellID]*1000
        local decreased = talentDecreased[spellID]
        if decreased then
            castTime = castTime - decreased
        end
    end
    if overrideCastTime then
        castTime = overrideCastTime
    end
    local now = GetTime()*1000
    local startTime = now
    local endTime = now + castTime
    local currentCast = casters[srcGUID]

    if currentCast then
        refreshCastTable(currentCast, castType, spellName, icon, startTime, endTime, spellID )
    else
        casters[srcGUID] = { castType, spellName, icon, startTime, endTime, spellID }
    end


    if castType == "CAST" then
        FireToUnits("UNIT_SPELLCAST_START", srcGUID)
    else
        FireToUnits("UNIT_SPELLCAST_CHANNEL_START", srcGUID)
    end
end

local function CastStop(srcGUID, castType, suffix )
    local currentCast = casters[srcGUID]
    if currentCast then
        castType = castType or currentCast[1]

        casters[srcGUID] = nil

        if castType == "CAST" then
            local event = "UNIT_SPELLCAST_"..suffix
            FireToUnits(event, srcGUID)
        else
            FireToUnits("UNIT_SPELLCAST_CHANNEL_STOP", srcGUID)
        end
    end
end

function f:COMBAT_LOG_EVENT_UNFILTERED(event)

    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    spellID, spellName, arg3, arg4, arg5 = CombatLogGetCurrentEventInfo()

    local isSrcPlayer = bit_band(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0
    if isSrcPlayer and spellID == 0 then
        spellID = spellNameToID[spellName]
    end
    if eventType == "SPELL_CAST_START" then
        if isSrcPlayer then
            local isCasting = classCasts[spellID]
            if isCasting then
                CastStart(srcGUID, "CAST", spellName, spellID)
            end
        else
            local castUID = makeCastUID(srcGUID, spellName)
            local cachedTime = castTimeCache[castUID]
            local spellID = NPCspellNameToID[spellName] -- just for the icon
            if not spellID then
                spellID = 2050
            end
            if cachedTime then
                CastStart(srcGUID, "CAST", spellName, spellID, cachedTime*1000)
            else
                castTimeCacheStartTimes[srcGUID..castUID] = GetTime()
                CastStart(srcGUID, "CAST", spellName, spellID, 1500) -- using default 1.5s cast time for now
            end
        end
    elseif eventType == "SPELL_CAST_FAILED" then

            CastStop(srcGUID, "CAST", "FAILED")

    elseif eventType == "SPELL_CAST_SUCCESS" then
            if isSrcPlayer and classChannels[spellID] then
                -- SPELL_CAST_SUCCESS can come right after AURA_APPLIED, so ignoring it
                return
            end
            if not isSrcPlayer then
                local castUID = makeCastUID(srcGUID, spellName)
                local cachedTime = castTimeCache[castUID]
                if not cachedTime then
                    local restoredStartTime = castTimeCacheStartTimes[srcGUID..castUID]
                    if restoredStartTime then
                        local now = GetTime()
                        local castTime = now - restoredStartTime
                        if castTime < 10 then
                            castTimeCache[castUID] = castTime
                        end
                    end
                end
            end
            CastStop(srcGUID, nil, "STOP")

    elseif eventType == "SPELL_INTERRUPT" then

            CastStop(dstGUID, nil, "INTERRUPTED")

    elseif  eventType == "SPELL_AURA_APPLIED" or
            eventType == "SPELL_AURA_REFRESH" or
            eventType == "SPELL_AURA_APPLIED_DOSE"
    then
        if isSrcPlayer then
            local isChanneling = classChannels[spellID]
            if isChanneling then
                CastStart(srcGUID, "CHANNEL", spellName, spellID)
            end
        end
    elseif eventType == "SPELL_AURA_REMOVED" then
        if isSrcPlayer then
            local isChanneling = classChannels[spellID]
            if isChanneling then
                CastStop(srcGUID, "CHANNEL", "STOP")
            end
        end
    end

end

-- local castTimeIncreases = {
--     [1714] = 60,    -- Curse of Tongues (60%)
--     [5760] = 60,    -- Mind-Numbing Poison (60%)
-- }
local function IsSlowedDown(unit)
    for i=1,16 do
        local name, _, _, _, _, _, _, _, _, spellID = UnitAura(unit, i, "HARMFUL")
        if not name then return end
        if spellID == 1714 or spellID == 5760 then
            return true
        end
    end
end

function lib:UnitCastingInfo(unit)
    if unit == "player" then return CastingInfo() end
    local guid = UnitGUID(unit)
    local cast = casters[guid]
    if cast then
        local castType, name, icon, startTimeMS, endTimeMS, spellID = unpack(cast)
        if IsSlowedDown(unit) then
            local duration = endTimeMS - startTimeMS
            endTimeMS = startTimeMS + duration * 1.6
        end
        if castType == "CAST" and endTimeMS > GetTime()*1000 then
            local castID = nil
            return name, nil, icon, startTimeMS, endTimeMS, nil, castID, false, spellID
        end
    end
end

function lib:UnitChannelInfo(unit)
    if unit == "player" then return ChannelInfo() end
    local guid = UnitGUID(unit)
    local cast = casters[guid]
    if cast then
        local castType, name, icon, startTimeMS, endTimeMS, spellID = unpack(cast)
        -- Curse of Tongues doesn't matter that much for channels, skipping
        if castType == "CHANNEL" and endTimeMS > GetTime()*1000 then
            return name, nil, icon, startTimeMS, endTimeMS, nil, false, spellID
        end
    end
end


local Passthrough = function(self, event, unit)
    if unit == "player" then
        callbacks:Fire(event, unit)
    end
end
f.UNIT_SPELLCAST_START = Passthrough
f.UNIT_SPELLCAST_DELAYED = Passthrough
f.UNIT_SPELLCAST_STOP = Passthrough
f.UNIT_SPELLCAST_FAILED = Passthrough
f.UNIT_SPELLCAST_INTERRUPTED = Passthrough
f.UNIT_SPELLCAST_CHANNEL_START = Passthrough
f.UNIT_SPELLCAST_CHANNEL_UPDATE = Passthrough
f.UNIT_SPELLCAST_CHANNEL_STOP = Passthrough

function callbacks.OnUsed()
    f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

    f:RegisterEvent("UNIT_SPELLCAST_START")
    f:RegisterEvent("UNIT_SPELLCAST_DELAYED")
    f:RegisterEvent("UNIT_SPELLCAST_STOP")
    f:RegisterEvent("UNIT_SPELLCAST_FAILED")
    f:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

    -- for unit lookup
    f:RegisterEvent("GROUP_ROSTER_UPDATE")
    f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    f:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
end

function callbacks.OnUnused()
    f:UnregisterAllEvents()
end

talentDecreased = {
    [25311] = 0.8,    -- Corruption (while leveling)
    [17924] = 2,       -- Soul Fire
    [25307] = 0.5,      -- Shadow Bolt
    [25309] = 0.5,      -- Immolate
    [691] = 4,        -- Summon Felhunter
    [688] = 4,        -- Summon Imp
    [697] = 4,        -- Summon Voidwalker
    [712] = 4,        -- Summon Succubus

    [15208] = 1,        -- Lightning Bolt
    [10605] = 1,        -- Chain Lightning
    [25357] = 0.5,      -- Healing Wave
    [2645] = 2,       -- Ghost Wolf

    [25304] = 0.5,      -- Frostbolt
    [25306] = 0.5,      -- Fireball


    [10934] = 0.5,      -- Smite
    [15261] = 0.5,    -- Holy Fire
    [6064] = 0.5,     -- Heal
    [25314] = 0.5,    -- Greater Heal
    [10876] = 0.5,     -- Mana Burn

    [9912] = 0.5,     -- Wrath
    [25298] = 0.5,     -- Starfire
    [25297] = 0.5,     -- Healing Touch
}

classCasts = {
    [25311] = 2, -- Corruption
    [6215] = 1.5, -- Fear
    [17928] = 2, -- Howl of Terror
    [18647] = 1.5, -- Banish
    [6366] = 3, -- Create Firestone (Lesser)
    [17951] = 3, -- Create Firestone
    [17952] = 3, -- Create Firestone (Greater)
    [17953] = 3, -- Create Firestone (Major)
    [28023] = 3, -- Create Healthstone
    [11729] = 3, -- Create Healthstone (Greater)
    [6202] = 3, -- Create Healthstone (Lesser)
    [11730] = 3, -- Create Healthstone (Major)
    [6201] = 3, -- Create Healthstone (Minor)
    [20755] = 3, -- Create Soulstone
    [20756] = 3, -- Create Soulstone (Greater)
    [20752] = 3, -- Create Soulstone (Lesser)
    [20757] = 3, -- Create Soulstone (Major)
    [693] = 3, -- Create Soulstone (Minor)
    [2362] = 5, -- Create Spellstone
    [17727] = 5, -- Create Spellstone (Greater)
    [17728] = 5, -- Create Spellstone (Major)
    [11726] = 3, -- Enslave Demon
    [126] = 5, -- Eye of Kilrogg
    [1122] = 2, -- Inferno
    [23161] = 3, -- Summon Dreadsteed
    [5784] = 3, -- Summon Felsteed
    [691] = 10, -- Summon Felhunter
    [688] = 10, -- Summon Imp
    [697] = 10, -- Summon Voidwalker
    [712] = 10, -- Summon Succubus
    [25309] = 2, -- Immolate
    [17923] = 1.5, -- Searing Pain
    [25307] = 3, -- Shadow Bolt
    [17924] = 4, -- Soul Fire

    [9853] = 1.5, -- Entangling Roots
    [18658] = 1.5, -- Hibernate
    [9901] = 1.5, -- Soothe Animal
    [25298] = 3.5, -- Starfire
    [18960] = 10, -- Teleport: Moonglade
    [9912] = 2, -- Wrath
    [25297] = 3.5, -- Healing Touch
    [20748] = 2, -- Rebirth
    [9858] = 2, -- Regrowth

    [28612] = 3, -- Conjure Food
    [759] = 3, -- Conjure Mana Agate
    [10053] = 3, -- Conjure Mana Citrine
    [3552] = 3, -- Conjure Mana Jade
    [10054] = 3, -- Conjure Mana Ruby
    [10140] = 3, -- Conjure Water
    [12826] = 1.5, -- Polymorph
    [28270] = 1.5, -- Polymorph: Cow
    [25306] = 3.5, -- Fireball
    [10216] = 3, -- Flamestrike
    [10207] = 1.5, -- Scorch
    [25304] = 3, -- Frostbolt

    [10876] = 3, -- Mana Burn
    [10955] = 1.5, -- Shackle Undead
    [10917] = 1.5, -- Flash Heal
    [25314] = 3, -- Greater Heal
    [6064] = 3, -- Heal
    [15261] = 3.5, -- Holy Fire
    [2053] = 2.5, -- Lesser Heal
    [25316] = 3, -- Prayer of Healing
    [20770] = 10, -- Resurrection
    [10934] = 2.5, -- Smite
    [10947] = 1.5, -- Mind Blast
    [10912] = 3, -- Mind Control

    [19943] = 1.5, -- Flash of Light
    [24239] = 1, -- Hammer of Wrath
    [25292] = 2.5, -- Holy Light
    [10318] = 2, -- Holy Wrath
    [20773] = 10, -- Redemption
    [23214] = 3, -- Summon Charger
    [13819] = 3, -- Summon Warhorse
    [10326] = 1.5, -- Turn Undead

    [10605] = 2.5, -- Chain Lightning
    [15208] = 3, -- Lightning Bolt
    [556] = 10, -- Astral Recall
    [6196] = 2, -- Far Sight
    [2645] = 3, -- Ghost Wolf
    [20777] = 10, -- Ancestral Spirit
    [10623] = 2.5, -- Chain Heal
    [25357] = 3, -- Healing Wave
    [10468] = 1.5, -- Lesser Healing Wave

    [1842] = 2, -- Disarm Trap
    -- missing poison creation

    [11605] = 1.5, -- Slam

    [20904] = 3, -- Aimed Shot
    [1002] = 2, -- Eyes of the Beast
    [2641] = 5, -- Dismiss pet
    [982] = 10, -- Revive Pet
    [14327] = 1.5, -- Scare Beast

    [8690] = 10, -- Hearthstone
    [4068] = 1, -- Iron Grenade

    -- Munts do not generate SPELL_CAST_START
    -- [8394] = 3, -- Striped Frostsaber
    -- [10793] = 3, -- Striped Nightsaber
}

classChannels = {
    -- [18807] = 3, -- Mind Flay

    [746] = 7,      -- First Aid
    [13278] = 4,    -- Gnomish Death Ray
    [20577] = 10,   -- Cannibalize
    [19305] = 6,    -- Starshards

    -- DRUID
    [17402] = 9.5,  -- Hurricane
    [9863] = 9.5,      -- Tranquility

    -- HUNTER
    [6197] = 60,     -- Eagle Eye
    [13544] = 5,     -- Mend Pet
    [1515] = 20,     -- Tame Beast
    [1002] = 60,     -- Eyes of the Beast
    [14295] = 6,     -- Volley

    -- MAGE
    [25345] = 5,     -- Arcane Missiles
    [10187] = 8,     -- Blizzard
    [12051] = 8,     -- Evocation

    -- PRIEST
    [18807] = 3,    -- Mind Flay
    [2096] = 60,    -- Mind Vision
    [10912] = 3,    -- Mind Control

    -- WARLOCK
    [126] = 45,       -- Eye of Kilrogg
    [11700] = 4.5,    -- Drain Life
    [11704] = 4.5,    -- Drain Mana
    [11675] = 14.5,   -- Drain Soul
    [11678] = 7.5,    -- Rain of Fire
    [11684] = 15,     -- Hellfire
    [11695] = 10,     -- Health Funnel
}

for id in pairs(classCasts) do
    spellNameToID[GetSpellInfo(id)] = id
    -- AddSpellNameRecognition(id)
end
for id in pairs(classChannels) do
    spellNameToID[GetSpellInfo(id)] = id
    -- AddSpellNameRecognition(id)
end

local partyGUIDtoUnit = {}
local raidGUIDtoUnit = {}
local nameplateUnits = {}
local commonUnits = {
    -- "player",
    "target",
    "targettarget",
    "pet",
}

function f:NAME_PLATE_UNIT_ADDED(event, unit)
    nameplateUnits[unit] = true
end


function f:NAME_PLATE_UNIT_REMOVED(event, unit)
    nameplateUnits[unit] = nil
end

function f:GROUP_ROSTER_UPDATE()
    table.wipe(partyGUIDtoUnit)
    table.wipe(raidGUIDtoUnit)
    if IsInGroup() then
        for i=1,4 do
            local unit = "party"..i
            local guid = UnitGUID(unit)
            if guid then
                partyGUIDtoUnit[guid] = unit
            end
        end
    end
    if IsInRaid() then
        for i=1,40 do
            local unit = "raid"..i
            local guid = UnitGUID(unit)
            if guid then
                raidGUIDtoUnit[guid] = unit
            end
        end
    end
end

FireToUnits = function(event, guid, ...)
    for _, unit in ipairs(commonUnits) do
        if UnitGUID(unit) == guid then
            callbacks:Fire(event, unit, ...)
        end
    end

    local partyUnit = partyGUIDtoUnit[guid]
    if partyUnit then
        callbacks:Fire(event, partyUnit, ...)
    end

    local raidUnit = raidGUIDtoUnit[guid]
    if raidUnit then
        callbacks:Fire(event, raidUnit, ...)
    end

    for unit in pairs(nameplateUnits) do
        if UnitGUID(unit) == guid then
            callbacks:Fire(event, unit, ...)
        end
    end
end


if lib.NPCSpellsTimer then
    lib.NPCSpellsTimer:Cancel()
end

local prevID
local counter = 0
local function processNPCSpellTable()
    counter = 0
    local id = next(NPCSpells, prevID)
    while (id and counter < 150) do
        NPCspellNameToID[GetSpellInfo(id)] = id

        counter = counter + 1
        prevID = id
        id = next(NPCSpells, prevID)
    end
    if (id) then
        C_Timer.After(1, processNPCSpellTable)
    end
end
lib.NPCSpellsTimer = C_Timer.NewTimer(6.5, processNPCSpellTable)

NPCSpells = {
    [4097] = true,
    [18451] = true,
    [8238] = true,
    [20626] = true,
    [8286] = true,
    [8334] = true,
    [8366] = true,
    [3129] = true,
    [10509] = true,
    [10525] = true,
    [6296] = true,
    [19059] = true,
    [12620] = true,
    [23249] = true,
    [10621] = true,
    [12684] = true,
    [3177] = true,
    [12716] = true,
    [10685] = true,
    [10701] = true,
    [10717] = true,
    [8686] = true,
    [6416] = true,
    [14891] = true,
    [8766] = true,
    [8782] = true,
    [12908] = true,
    [19795] = true,
    [15067] = true,
    [28207] = true,
    [3277] = true,
    [6576] = true,
    [9070] = true,
    [3297] = true,
    [26416] = true,
    [13228] = true,
    [6624] = true,
    [3321] = true,
    [6648] = true,
    [6656] = true,
    [3333] = true,
    [3337] = true,
    [6688] = true,
    [11341] = true,
    [6704] = true,
    [16661] = true,
    [3373] = true,
    [3377] = true,
    [13548] = true,
    [15611] = true,
    [3397] = true,
    [19060] = true,
    [19092] = true,
    [3421] = true,
    [6896] = true,
    [3453] = true,
    [27632] = true,
    [17461] = true,
    [15915] = true,
    [23666] = true,
    [3477] = true,
    [19668] = true,
    [3493] = true,
    [3497] = true,
    [3501] = true,
    [9918] = true,
    [9950] = true,
    [9966] = true,
    [12045] = true,
    [12061] = true,
    [12077] = true,
    [3537] = true,
    [24242] = true,
    [26417] = true,
    [3569] = true,
    [18421] = true,
    [10254] = true,
    [14380] = true,
    [5169] = true,
    [7224] = true,
    [16662] = true,
    [7256] = true,
    [20916] = true,
    [5265] = true,
    [458] = true,
    [10558] = true,
    [459] = true,
    [23219] = true,
    [23251] = true,
    [8607] = true,
    [12717] = true,
    [10686] = true,
    [10702] = true,
    [7408] = true,
    [8687] = true,
    [17462] = true,
    [10798] = true,
    [23667] = true,
    [21652] = true,
    [8799] = true,
    [468] = true,
    [19701] = true,
    [3753] = true,
    [470] = true,
    [8895] = true,
    [471] = true,
    [3769] = true,
    [472] = true,
    [3777] = true,
    [28209] = true,
    [7624] = true,
    [3817] = true,
    [13229] = true,
    [15292] = true,
    [3841] = true,
    [3845] = true,
    [3849] = true,
    [3857] = true,
    [3861] = true,
    [11358] = true,
    [3869] = true,
    [3873] = true,
    [7752] = true,
    [22868] = true,
    [11454] = true,
    [27058] = true,
    [5761] = true,
    [15628] = true,
    [16983] = true,
    [3921] = true,
    [3925] = true,
    [5809] = true,
    [3933] = true,
    [3937] = true,
    [3941] = true,
    [3945] = true,
    [7896] = true,
    [3953] = true,
    [3957] = true,
    [7920] = true,
    [7928] = true,
    [3969] = true,
    [3973] = true,
    [3977] = true,
    [23636] = true,
    [17527] = true,
    [17559] = true,
    [8016] = true,
    [16060] = true,
    [9935] = true,
    [9983] = true,
    [12046] = true,
    [10015] = true,
    [12078] = true,
    [18423] = true,
    [18455] = true,
    [8240] = true,
    [8256] = true,
    [20630] = true,
    [16664] = true,
    [6233] = true,
    [20854] = true,
    [6257] = true,
    [10511] = true,
    [12590] = true,
    [17016] = true,
    [12622] = true,
    [23221] = true,
    [2158] = true,
    [10687] = true,
    [10703] = true,
    [10719] = true,
    [8688] = true,
    [6417] = true,
    [10799] = true,
    [8768] = true,
    [6441] = true,
    [8880] = true,
    [19831] = true,
    [6521] = true,
    [28243] = true,
    [9072] = true,
    [26420] = true,
    [6617] = true,
    [15293] = true,
    [13262] = true,
    [9200] = true,
    [18424] = true,
    [578] = true,
    [579] = true,
    [580] = true,
    [581] = true,
    [11343] = true,
    [6705] = true,
    [2334] = true,
    [26868] = true,
    [16665] = true,
    [16729] = true,
    [20855] = true,
    [6777] = true,
    [13582] = true,
    [16985] = true,
    [2386] = true,
    [21143] = true,
    [2394] = true,
    [23254] = true,
    [2402] = true,
    [2406] = true,
    [6897] = true,
    [15853] = true,
    [17465] = true,
    [23638] = true,
    [15933] = true,
    [17561] = true,
    [23862] = true,
    [19800] = true,
    [9920] = true,
    [14030] = true,
    [9952] = true,
    [9968] = true,
    [12047] = true,
    [12063] = true,
    [12079] = true,
    [2538] = true,
    [2542] = true,
    [2546] = true,
    [5106] = true,
    [8209] = true,
    [20536] = true,
    [22711] = true,
    [7257] = true,
    [22967] = true,
    [8465] = true,
    [5266] = true,
    [10544] = true,
    [12607] = true,
    [19097] = true,
    [23223] = true,
    [2658] = true,
    [2662] = true,
    [2666] = true,
    [12719] = true,
    [10688] = true,
    [10704] = true,
    [10720] = true,
    [10768] = true,
    [23639] = true,
    [17562] = true,
    [12895] = true,
    [2738] = true,
    [2742] = true,
    [26102] = true,
    [5514] = true,
    [7633] = true,
    [15294] = true,
    [9201] = true,
    [18458] = true,
    [2838] = true,
    [7753] = true,
    [16731] = true,
    [11456] = true,
    [11472] = true,
    [7817] = true,
    [23096] = true,
    [16987] = true,
    [7841] = true,
    [19098] = true,
    [23224] = true,
    [7929] = true,
    [7953] = true,
    [17563] = true,
    [27830] = true,
    [9921] = true,
    [9937] = true,
    [16094] = true,
    [9985] = true,
    [12048] = true,
    [12064] = true,
    [12080] = true,
    [10097] = true,
    [26423] = true,
    [8153] = true,
    [18363] = true,
    [24696] = true,
    [8322] = true,
    [16732] = true,
    [8386] = true,
    [20890] = true,
    [10529] = true,
    [16988] = true,
    [19067] = true,
    [12624] = true,
    [23225] = true,
    [3170] = true,
    [3174] = true,
    [10673] = true,
    [21370] = true,
    [10705] = true,
    [10721] = true,
    [6418] = true,
    [8770] = true,
    [8786] = true,
    [8802] = true,
    [3230] = true,
    [17820] = true,
    [26072] = true,
    [6530] = true,
    [818] = true,
    [24121] = true,
    [3278] = true,
    [28311] = true,
    [9058] = true,
    [3294] = true,
    [26424] = true,
    [6618] = true,
    [15295] = true,
    [9202] = true,
    [3330] = true,
    [3334] = true,
    [6690] = true,
    [22810] = true,
    [3370] = true,
    [11457] = true,
    [11473] = true,
    [3398] = true,
    [16989] = true,
    [19068] = true,
    [19100] = true,
    [21371] = true,
    [3450] = true,
    [3454] = true,
    [19452] = true,
    [15935] = true,
    [17565] = true,
    [27832] = true,
    [15999] = true,
    [3494] = true,
    [3498] = true,
    [3502] = true,
    [3506] = true,
    [9954] = true,
    [9970] = true,
    [9986] = true,
    [12049] = true,
    [12065] = true,
    [12081] = true,
    [10098] = true,
    [7106] = true,
    [22331] = true,
    [18397] = true,
    [8243] = true,
    [8275] = true,
    [8339] = true,
    [7258] = true,
    [25018] = true,
    [10482] = true,
    [3650] = true,
    [8467] = true,
    [8483] = true,
    [10546] = true,
    [10562] = true,
    [19101] = true,
    [23227] = true,
    [10674] = true,
    [10706] = true,
    [8691] = true,
    [5395] = true,
    [5403] = true,
    [17566] = true,
    [12897] = true,
    [3758] = true,
    [3762] = true,
    [3766] = true,
    [59] = true,
    [3774] = true,
    [3778] = true,
    [24091] = true,
    [24123] = true,
    [26234] = true,
    [9059] = true,
    [3818] = true,
    [28505] = true,
    [15296] = true,
    [3842] = true,
    [3850] = true,
    [3854] = true,
    [3858] = true,
    [3862] = true,
    [3866] = true,
    [3870] = true,
    [16639] = true,
    [7754] = true,
    [11458] = true,
    [5763] = true,
    [7818] = true,
    [3914] = true,
    [3918] = true,
    [3922] = true,
    [3926] = true,
    [3930] = true,
    [3934] = true,
    [3938] = true,
    [3942] = true,
    [3946] = true,
    [3950] = true,
    [3954] = true,
    [3958] = true,
    [3962] = true,
    [3966] = true,
    [3978] = true,
    [9811] = true,
    [19646] = true,
    [9939] = true,
    [9987] = true,
    [12050] = true,
    [12066] = true,
    [12082] = true,
    [24252] = true,
    [18239] = true,
    [4094] = true,
    [22717] = true,
    [16640] = true,
    [22813] = true,
    [10499] = true,
    [23069] = true,
    [10531] = true,
    [12594] = true,
    [19071] = true,
    [19103] = true,
    [23229] = true,
    [10675] = true,
    [2163] = true,
    [10707] = true,
    [6419] = true,
    [8772] = true,
    [23709] = true,
    [8804] = true,
    [8820] = true,
    [6499] = true,
    [8980] = true,
    [24125] = true,
    [4508] = true,
    [24189] = true,
    [9060] = true,
    [15249] = true,
    [18240] = true,
    [6619] = true,
    [6627] = true,
    [22430] = true,
    [6651] = true,
    [20543] = true,
    [18560] = true,
    [2331] = true,
    [2335] = true,
    [16641] = true,
    [11459] = true,
    [25085] = true,
    [15633] = true,
    [16993] = true,
    [2387] = true,
    [19104] = true,
    [2395] = true,
    [2399] = true,
    [2403] = true,
    [9636] = true,
    [6899] = true,
    [6907] = true,
    [23710] = true,
    [11923] = true,
    [16081] = true,
    [9956] = true,
    [9972] = true,
    [12067] = true,
    [12083] = true,
    [2539] = true,
    [2543] = true,
    [2547] = true,
    [12243] = true,
    [12259] = true,
    [18401] = true,
    [7179] = true,
    [16450] = true,
    [2575] = true,
    [22719] = true,
    [16642] = true,
    [22815] = true,
    [7259] = true,
    [22975] = true,
    [5244] = true,
    [10516] = true,
    [5268] = true,
    [10548] = true,
    [10564] = true,
    [7355] = true,
    [2659] = true,
    [2663] = true,
    [2667] = true,
    [2671] = true,
    [2675] = true,
    [10708] = true,
    [8693] = true,
    [10788] = true,
    [26055] = true,
    [12720] = true,
    [8789] = true,
    [12899] = true,
    [17634] = true,
    [30152] = true,
    [23252] = true,
    [30047] = true,
    [19086] = true,
    [2739] = true,
    [29059] = true,
    [28995] = true,
    [21099] = true,
    [19052] = true,
    [23220] = true,
    [28221] = true,
    [28732] = true,
    [28615] = true,
    [19064] = true,
    [28487] = true,
    [28482] = true,
    [28481] = true,
    [28480] = true,
    [2795] = true,
    [7643] = true,
    [28474] = true,
    [28473] = true,
    [28472] = true,
    [18402] = true,
    [18434] = true,
    [2823] = true,
    [28463] = true,
    [9269] = true,
    [5668] = true,
    [28462] = true,
    [22720] = true,
    [28461] = true,
    [16643] = true,
    [7755] = true,
    [24801] = true,
    [17564] = true,
    [11460] = true,
    [11476] = true,
    [22976] = true,
    [23008] = true,
    [28324] = true,
    [28244] = true,
    [7827] = true,
    [16995] = true,
    [19074] = true,
    [11604] = true,
    [28242] = true,
    [28224] = true,
    [28223] = true,
    [17187] = true,
    [28222] = true,
    [1464] = true,
    [28220] = true,
    [28219] = true,
    [28210] = true,
    [28208] = true,
    [12619] = true,
    [21537] = true,
    [7955] = true,
    [28086] = true,
    [2963] = true,
    [9813] = true,
    [27829] = true,
    [17635] = true,
    [27794] = true,
    [27725] = true,
    [12621] = true,
    [15648] = true,
    [6909] = true,
    [16082] = true,
    [9957] = true,
    [3007] = true,
    [27658] = true,
    [12052] = true,
    [12068] = true,
    [12084] = true,
    [19095] = true,
    [27589] = true,
    [21940] = true,
    [23013] = true,
    [27586] = true,
    [27585] = true,
    [18243] = true,
    [27241] = true,
    [27059] = true,
    [27057] = true,
    [12260] = true,
    [1536] = true,
    [24576] = true,
    [1540] = true,
    [25664] = true,
    [26616] = true,
    [10550] = true,
    [26442] = true,
    [22721] = true,
    [26428] = true,
    [4165] = true,
    [26427] = true,
    [3115] = true,
    [26426] = true,
    [26425] = true,
    [26422] = true,
    [3131] = true,
    [26421] = true,
    [26418] = true,
    [3143] = true,
    [10533] = true,
    [12596] = true,
    [19075] = true,
    [19107] = true,
    [19073] = true,
    [26403] = true,
    [3171] = true,
    [3175] = true,
    [19081] = true,
    [10677] = true,
    [12740] = true,
    [10709] = true,
    [23489] = true,
    [8694] = true,
    [21538] = true,
    [6412] = true,
    [10789] = true,
    [8758] = true,
    [8774] = true,
    [17572] = true,
    [8806] = true,
    [17636] = true,
    [19083] = true,
    [20535] = true,
    [21729] = true,
    [3765] = true,
    [6500] = true,
    [26056] = true,
    [13028] = true,
    [30174] = true,
    [20549] = true,
    [26011] = true,
    [3275] = true,
    [26010] = true,
    [25954] = true,
    [25953] = true,
    [9062] = true,
    [3295] = true,
    [25849] = true,
    [24848] = true,
    [13220] = true,
    [6620] = true,
    [25704] = true,
    [3319] = true,
    [3323] = true,
    [9206] = true,
    [3331] = true,
    [26656] = true,
    [25662] = true,
    [25659] = true,
    [6692] = true,
    [19094] = true,
    [22722] = true,
    [3359] = true,
    [3363] = true,
    [25347] = true,
    [3371] = true,
    [16741] = true,
    [11461] = true,
    [11477] = true,
    [25247] = true,
    [25162] = true,
    [1698] = true,
    [3399] = true,
    [16965] = true,
    [25146] = true,
    [19076] = true,
    [11605] = true,
    [12900] = true,
    [24914] = true,
    [17157] = true,
    [24913] = true,
    [15779] = true,
    [24912] = true,
    [19667] = true,
    [3447] = true,
    [3451] = true,
    [20903] = true,
    [22724] = true,
    [24851] = true,
    [24850] = true,
    [23650] = true,
    [24849] = true,
    [9814] = true,
    [25793] = true,
    [17637] = true,
    [3491] = true,
    [3495] = true,
    [24847] = true,
    [3503] = true,
    [9926] = true,
    [9942] = true,
    [3515] = true,
    [9974] = true,
    [24846] = true,
    [12053] = true,
    [12069] = true,
    [7068] = true,
    [24194] = true,
    [7084] = true,
    [28352] = true,
    [16077] = true,
    [24703] = true,
    [16663] = true,
    [18245] = true,
    [24418] = true,
    [10552] = true,
    [24399] = true,
    [7156] = true,
    [3583] = true,
    [18437] = true,
    [9198] = true,
    [3961] = true,
    [12198] = true,
    [24706] = true,
    [1804] = true,
    [3611] = true,
    [22869] = true,
    [16646] = true,
    [4164] = true,
    [17618] = true,
    [16742] = true,
    [14532] = true,
    [20900] = true,
    [22979] = true,
    [23703] = true,
    [3651] = true,
    [10518] = true,
    [7918] = true,
    [12597] = true,
    [10566] = true,
    [24140] = true,
    [16984] = true,
    [24138] = true,
    [1842] = true,
    [24137] = true,
    [24136] = true,
    [10678] = true,
    [24124] = true,
    [10710] = true,
    [8679] = true,
    [24122] = true,
    [24093] = true,
    [24092] = true,
    [10790] = true,
    [24011] = true,
    [23708] = true,
    [8791] = true,
    [16992] = true,
    [17638] = true,
    [23811] = true,
    [23707] = true,
    [3755] = true,
    [3759] = true,
    [3763] = true,
    [3767] = true,
    [3771] = true,
    [3775] = true,
    [3779] = true,
    [23706] = true,
    [23705] = true,
    [23704] = true,
    [24195] = true,
    [23665] = true,
    [11202] = true,
    [12760] = true,
    [15533] = true,
    [23653] = true,
    [7636] = true,
    [23429] = true,
    [23637] = true,
    [23633] = true,
    [6703] = true,
    [9207] = true,
    [3843] = true,
    [3847] = true,
    [3851] = true,
    [3855] = true,
    [3859] = true,
    [3863] = true,
    [18630] = true,
    [3871] = true,
    [16647] = true,
    [23629] = true,
    [7222] = true,
    [17229] = true,
    [23530] = true,
    [11478] = true,
    [22980] = true,
    [23012] = true,
    [23510] = true,
    [23509] = true,
    [7828] = true,
    [7836] = true,
    [3923] = true,
    [23507] = true,
    [3931] = true,
    [23486] = true,
    [3939] = true,
    [19106] = true,
    [7892] = true,
    [23431] = true,
    [3955] = true,
    [1980] = true,
    [3963] = true,
    [3967] = true,
    [3971] = true,
    [21945] = true,
    [3979] = true,
    [23652] = true,
    [23428] = true,
    [17575] = true,
    [15972] = true,
    [23399] = true,
    [23392] = true,
    [23391] = true,
    [18408] = true,
    [19814] = true,
    [30081] = true,
    [16084] = true,
    [9959] = true,
    [23250] = true,
    [2159] = true,
    [10007] = true,
    [12070] = true,
    [12086] = true,
    [10001] = true,
    [23246] = true,
    [12883] = true,
    [23242] = true,
    [18629] = true,
    [24356] = true,
    [4075] = true,
    [20853] = true,
    [23238] = true,
    [16340] = true,
    [23228] = true,
    [18407] = true,
    [18439] = true,
    [23222] = true,
    [28738] = true,
    [23190] = true,
    [23129] = true,
    [16552] = true,
    [8296] = true,
    [22757] = true,
    [16648] = true,
    [23082] = true,
    [10787] = true,
    [16744] = true,
    [19649] = true,
    [20902] = true,
    [23079] = true,
    [10487] = true,
    [22567] = true,
    [23077] = true,
    [23071] = true,
    [19047] = true,
    [12614] = true,
    [23070] = true,
    [23068] = true,
    [23067] = true,
    [23066] = true,
    [2152] = true,
    [2156] = true,
    [10679] = true,
    [10695] = true,
    [10711] = true,
    [27587] = true,
    [22985] = true,
    [10684] = true,
    [6413] = true,
    [20897] = true,
    [8760] = true,
    [8776] = true,
    [17576] = true,
    [12902] = true,
    [6461] = true,
    [6469] = true,
    [6477] = true,
    [22723] = true,
    [19815] = true,
    [6501] = true,
    [22977] = true,
    [6517] = true,
    [22928] = true,
    [2672] = true,
    [22926] = true,
    [22923] = true,
    [22922] = true,
    [22921] = true,
    [4526] = true,
    [9064] = true,
    [22902] = true,
    [22870] = true,
    [24357] = true,
    [22867] = true,
    [22866] = true,
    [22808] = true,
    [22797] = true,
    [22795] = true,
    [6653] = true,
    [6661] = true,
    [22793] = true,
    [28739] = true,
    [21050] = true,
    [6693] = true,
    [22732] = true,
    [2332] = true,
    [2336] = true,
    [16649] = true,
    [22727] = true,
    [24901] = true,
    [16745] = true,
    [6757] = true,
    [11479] = true,
    [22982] = true,
    [22718] = true,
    [22704] = true,
    [23078] = true,
    [16969] = true,
    [19048] = true,
    [19080] = true,
    [2392] = true,
    [2396] = true,
    [22480] = true,
    [14008] = true,
    [17709] = true,
    [15781] = true,
    [15797] = true,
    [23430] = true,
    [21943] = true,
    [27588] = true,
    [15861] = true,
    [6917] = true,
    [6925] = true,
    [17481] = true,
    [3865] = true,
    [21923] = true,
    [17577] = true,
    [15973] = true,
    [21913] = true,
    [20629] = true,
    [4942] = true,
    [4950] = true,
    [2480] = true,
    [9928] = true,
    [21787] = true,
    [21730] = true,
    [26085] = true,
    [21728] = true,
    [12055] = true,
    [12071] = true,
    [12087] = true,
    [21651] = true,
    [26277] = true,
    [18406] = true,
    [21175] = true,
    [19567] = true,
    [20873] = true,
    [2540] = true,
    [2544] = true,
    [2548] = true,
    [7149] = true,
    [21144] = true,
    [18409] = true,
    [10248] = true,
    [7181] = true,
    [28740] = true,
    [2576] = true,
    [11355] = true,
    [16554] = true,
    [7221] = true,
    [22759] = true,
    [16650] = true,
    [20901] = true,
    [24902] = true,
    [16746] = true,
    [20872] = true,
    [20904] = true,
    [22983] = true,
    [20876] = true,
    [20874] = true,
    [10520] = true,
    [8489] = true,
    [12599] = true,
    [12615] = true,
    [21160] = true,
    [23239] = true,
    [20849] = true,
    [10632] = true,
    [2664] = true,
    [8617] = true,
    [10680] = true,
    [10696] = true,
    [10712] = true,
    [8681] = true,
    [2670] = true,
    [20717] = true,
    [17450] = true,
    [10792] = true,
    [12758] = true,
    [20709] = true,
    [10840] = true,
    [12903] = true,
    [19054] = true,
    [20649] = true,
    [20648] = true,
    [21832] = true,
    [20627] = true,
    [2740] = true,
    [20589] = true,
    [26054] = true,
    [26086] = true,
    [11016] = true,
    [19799] = true,
    [19833] = true,
    [19830] = true,
    [19825] = true,
    [18453] = true,
    [9065] = true,
    [20201] = true,
    [19796] = true,
    [7629] = true,
    [10699] = true,
    [9145] = true,
    [12754] = true,
    [15118] = true,
    [9193] = true,
    [18410] = true,
    [18442] = true,
    [2824] = true,
    [6626] = true,
    [9273] = true,
    [12718] = true,
    [2840] = true,
    [19788] = true,
    [19772] = true,
    [11400] = true,
    [19669] = true,
    [24903] = true,
    [11448] = true,
    [11464] = true,
    [11480] = true,
    [22984] = true,
    [19657] = true,
    [19651] = true,
    [23080] = true,
    [9513] = true,
    [7837] = true,
    [7845] = true,
    [21161] = true,
    [23240] = true,
    [18456] = true,
    [25351] = true,
    [2167] = true,
    [7893] = true,
    [7901] = true,
    [23432] = true,
    [19102] = true,
    [27590] = true,
    [19434] = true,
    [19093] = true,
    [19091] = true,
    [15910] = true,
    [10570] = true,
    [2964] = true,
    [17579] = true,
    [19089] = true,
    [19088] = true,
    [19087] = true,
    [17707] = true,
    [30021] = true,
    [19085] = true,
    [18415] = true,
    [9945] = true,
    [9961] = true,
    [26087] = true,
    [9993] = true,
    [12056] = true,
    [12072] = true,
    [12088] = true,
    [19082] = true,
    [26279] = true,
    [19079] = true,
    [19078] = true,
    [19077] = true,
    [26407] = true,
    [19072] = true,
    [19070] = true,
    [19066] = true,
    [19065] = true,
    [28614] = true,
    [18411] = true,
    [19063] = true,
    [19062] = true,
    [19061] = true,
    [7364] = true,
    [16644] = true,
    [20650] = true,
    [19053] = true,
    [22761] = true,
    [16652] = true,
    [17460] = true,
    [3116] = true,
    [19050] = true,
    [8394] = true,
    [19049] = true,
    [3132] = true,
    [3513] = true,
    [16645] = true,
    [23081] = true,
    [12584] = true,
    [19051] = true,
    [12616] = true,
    [18711] = true,
    [23241] = true,
    [18457] = true,
    [3172] = true,
    [3176] = true,
    [8618] = true,
    [10681] = true,
    [10697] = true,
    [10713] = true,
    [8682] = true,
    [19435] = true,
    [3204] = true,
    [6414] = true,
    [10793] = true,
    [8762] = true,
    [8778] = true,
    [10841] = true,
    [12904] = true,
    [10873] = true,
    [6470] = true,
    [6478] = true,
    [18454] = true,
    [19819] = true,
    [18452] = true,
    [10969] = true,
    [6518] = true,
    [12603] = true,
    [3761] = true,
    [3449] = true,
    [3276] = true,
    [2164] = true,
    [18446] = true,
    [28327] = true,
    [3292] = true,
    [3296] = true,
    [18441] = true,
    [3304] = true,
    [3308] = true,
    [9146] = true,
    [6630] = true,
    [3320] = true,
    [3324] = true,
    [3328] = true,
    [18444] = true,
    [3336] = true,
    [18440] = true,
    [6686] = true,
    [18438] = true,
    [6702] = true,
    [18436] = true,
    [18422] = true,
    [16653] = true,
    [18420] = true,
    [3372] = true,
    [3376] = true,
    [11465] = true,
    [18419] = true,
    [12609] = true,
    [9489] = true,
    [16072] = true,
    [3400] = true,
    [13608] = true,
    [3408] = true,
    [19084] = true,
    [18414] = true,
    [3420] = true,
    [17567] = true,
    [18412] = true,
    [23338] = true,
    [3436] = true,
    [21355] = true,
    [18405] = true,
    [3448] = true,
    [3452] = true,
    [15863] = true,
    [18404] = true,
    [17453] = true,
    [18403] = true,
    [18247] = true,
    [18246] = true,
    [9818] = true,
    [18244] = true,
    [3488] = true,
    [3492] = true,
    [3496] = true,
    [3500] = true,
    [3504] = true,
    [3508] = true,
    [18242] = true,
    [18241] = true,
    [18238] = true,
    [22027] = true,
    [7054] = true,
    [12073] = true,
    [12089] = true,
    [17708] = true,
    [17632] = true,
    [24266] = true,
    [16247] = true,
    [17580] = true,
    [17578] = true,
    [3564] = true,
    [17574] = true,
    [17573] = true,
    [17571] = true,
    [17570] = true,
    [18413] = true,
    [18445] = true,
    [17560] = true,
    [17557] = true,
    [17556] = true,
    [5159] = true,
    [3326] = true,
    [10346] = true,
    [20716] = true,
    [16654] = true,
    [17553] = true,
    [8363] = true,
    [17552] = true,
    [8395] = true,
    [11397] = true,
    [17464] = true,
    [10490] = true,
    [17463] = true,
    [18989] = true,
    [12585] = true,
    [10554] = true,
    [12617] = true,
    [17459] = true,
    [23243] = true,
    [17456] = true,
    [11357] = true,
    [10650] = true,
    [17204] = true,
    [10682] = true,
    [10698] = true,
    [10714] = true,
    [11340] = true,
    [23531] = true,
    [7430] = true,
    [17454] = true,
    [17169] = true,
    [17158] = true,
    [16994] = true,
    [8795] = true,
    [12905] = true,
    [23787] = true,
    [16991] = true,
    [16990] = true,
    [3756] = true,
    [3760] = true,
    [3764] = true,
    [3768] = true,
    [3772] = true,
    [3776] = true,
    [3780] = true,
    [16986] = true,
    [24139] = true,
    [16980] = true,
    [16978] = true,
    [16973] = true,
    [16971] = true,
    [5567] = true,
    [16970] = true,
    [3816] = true,
    [13225] = true,
    [9147] = true,
    [16967] = true,
    [13219] = true,
    [9195] = true,
    [3840] = true,
    [3844] = true,
    [3848] = true,
    [3852] = true,
    [3856] = true,
    [3860] = true,
    [3864] = true,
    [3868] = true,
    [3872] = true,
    [16655] = true,
    [13227] = true,
    [7133] = true,
    [11450] = true,
    [11466] = true,
    [16866] = true,
    [7153] = true,
    [2162] = true,
    [9483] = true,
    [18990] = true,
    [9271] = true,
    [3920] = true,
    [3924] = true,
    [3928] = true,
    [3932] = true,
    [3936] = true,
    [3940] = true,
    [3944] = true,
    [7213] = true,
    [3952] = true,
    [3956] = true,
    [3960] = true,
    [3964] = true,
    [3968] = true,
    [3972] = true,
    [17455] = true,
    [23628] = true,
    [19566] = true,
    [17551] = true,
    [2660] = true,
    [16730] = true,
    [3117] = true,
    [11453] = true,
    [16728] = true,
    [19790] = true,
    [16056] = true,
    [9931] = true,
    [16725] = true,
    [16724] = true,
    [9979] = true,
    [9995] = true,
    [10011] = true,
    [12074] = true,
    [12090] = true,
    [3507] = true,
    [4056] = true,
    [16667] = true,
    [5267] = true,
    [16960] = true,
    [10542] = true,
    [26443] = true,
    [10574] = true,
    [12591] = true,
    [3173] = true,
    [2160] = true,
    [4096] = true,
    [18447] = true,
    [2166] = true,
    [2168] = true,
    [10718] = true,
    [15048] = true,
    [16659] = true,
    [10347] = true,
    [15664] = true,
    [16656] = true,
    [8784] = true,
    [14930] = true,
    [24940] = true,
    [6458] = true,
    [16055] = true,
    [16651] = true,
    [6510] = true,
    [10507] = true,
    [18991] = true,
    [12586] = true,
    [19055] = true,
    [12618] = true,
    [12085] = true,
    [12093] = true,
    [10619] = true,
    [2149] = true,
    [8604] = true,
    [2157] = true,
    [10683] = true,
    [2165] = true,
    [2169] = true,
    [16099] = true,
    [3293] = true,
    [27659] = true,
    [6415] = true,
    [10795] = true,
    [8764] = true,
    [8780] = true,
    [16590] = true,
    [12906] = true,
    [6463] = true,
    [6471] = true,
    [3307] = true,
    [19791] = true,
    [3325] = true,
    [15049] = true,
    [6650] = true,
    [6654] = true,
    [11342] = true,
    [2330] = true,
    [3365] = true,
    [24141] = true,
    [16153] = true,
    [4520] = true,
    [16083] = true,
    [9068] = true,
    [12589] = true,
    [16080] = true,
    [24365] = true,
    [13226] = true,
    [9148] = true,
    [13258] = true,
    [10647] = true,
    [9196] = true,
    [18416] = true,
    [18448] = true,
    [6671] = true,
    [16059] = true,
    [10003] = true,
    [6695] = true,
    [2329] = true,
    [2333] = true,
    [2337] = true,
    [16657] = true,
    [15906] = true,
    [16531] = true,
    [11451] = true,
    [11467] = true,
    [8793] = true,
    [3505] = true,
    [15609] = true,
    [3511] = true,
    [18992] = true,
    [21071] = true,
    [2385] = true,
    [2389] = true,
    [2393] = true,
    [2397] = true,
    [2401] = true,
    [9612] = true,
    [15856] = true,
    [15855] = true,
    [11356] = true,
    [12062] = true,
    [15833] = true,
    [15780] = true,
    [15865] = true,
    [27660] = true,
    [7126] = true,
    [27724] = true,
    [23662] = true,
    [6951] = true,
    [9820] = true,
    [15495] = true,
    [6898] = true,
    [15255] = true,
    [15119] = true,
    [19792] = true,
    [9916] = true,
    [16073] = true,
    [21935] = true,
    [9964] = true,
    [9980] = true,
    [11399] = true,
    [12059] = true,
    [12075] = true,
    [12091] = true,
    [16660] = true,
    [14932] = true,
    [5208] = true,
    [11447] = true,
    [14379] = true,
    [24366] = true,
    [2541] = true,
    [2545] = true,
    [2549] = true,
    [7151] = true,
    [22479] = true,
    [18417] = true,
    [18449] = true,
    [7183] = true,
    [24654] = true,
    [10560] = true,
    [10568] = true,
    [12759] = true,
    [7223] = true,
    [5669] = true,
    [16658] = true,
    [2668] = true,
    [7255] = true,
    [20848] = true,
    [22927] = true,
    [2674] = true,
    [13240] = true,
    [13230] = true,
    [3757] = true,
    [5264] = true,
    [12587] = true,
    [2641] = true,
    [10572] = true,
    [3773] = true,
    [23247] = true,
    [2657] = true,
    [2661] = true,
    [2665] = true,
    [12715] = true,
    [2673] = true,
    [10700] = true,
    [10716] = true,
    [10009] = true,
    [9074] = true,
    [3813] = true,
    [17458] = true,
    [10796] = true,
    [23663] = true,
    [17554] = true,
    [8797] = true,
    [12907] = true,
    [12755] = true,
    [9194] = true,
    [3839] = true,
    [19793] = true,
    [2737] = true,
    [2741] = true,
    [12722] = true,
    [30156] = true,
    [16726] = true,
    [15612] = true,
    [28205] = true,
    [3915] = true,
    [3919] = true,
    [3929] = true,
    [3947] = true,
    [3949] = true,
    [3959] = true,
    [7623] = true,
    [24367] = true,
    [7639] = true,
    [9149] = true,
    [3965] = true,
    [7954] = true,
    [9197] = true,
    [18418] = true,
    [18450] = true,
    [12595] = true,
    [24655] = true,
    [2153] = true,
    [2837] = true,
    [2841] = true,
    [3018] = true,
    [2835] = true,
    [7751] = true,
    [10715] = true,
    [7135] = true,
    [11452] = true,
    [11468] = true,
    [7147] = true,
    [12044] = true,
    [2881] = true,
    [11643] = true,
    [7359] = true,
    [11449] = true,
    [19058] = true,
    [19090] = true,
    [7630] = true,
    [23248] = true,
    [2161] = true,
    [3188] = true,
    [19250] = true,
    [17235] = true,
    [11339] = true,
    [10850] = true,
    [7919] = true,
    [10844] = true,
    [7935] = true,
    [8368] = true,
    [7951] = true,
    [23632] = true,
    [23664] = true,
    [17555] = true,
    [11338] = true,
    [19666] = true,
    [10556] = true,
    [10676] = true,
    [10630] = true,
    [19794] = true,
    [16058] = true,
    [9933] = true,
    [9997] = true,
    [26063] = true,
    [9208] = true,
    [3013] = true,
    [12060] = true,
    [12076] = true,
    [12092] = true,
    [8613] = true,
    [3770] = true,
    [10005] = true,
    [10013] = true,
    [7934] = true,
    [24368] = true,
    [8367] = true,
    [6717] = true,
    [3015] = true,
}

