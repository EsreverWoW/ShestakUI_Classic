local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Specialization Functions
----------------------------------------------------------------------------------------
function T.GetSpecialization(isInspect, isPet, specGroup)
	if (isInspect or isPet) then
		return
	end
	local specIndex
	local max = 0
	for tabIndex = 1, GetNumTalentTabs() do
		local spent = select(3, GetTalentTabInfo(tabIndex, "player", T.Wrath and specGroup))
		if spent > max then
			specIndex = tabIndex
			max = spent
		end
	end
	return specIndex
end

local isCaster = {
	DEATHKNIGHT = {nil, nil, nil},
	DRUID = {true},					-- Balance
	HUNTER = {nil, nil, nil},
	MAGE = {true, true, true},
	PALADIN = {nil, nil, nil},
	PRIEST = {nil, nil, true},		-- Shadow
	ROGUE = {nil, nil, nil},
	SHAMAN = {true},				-- Elemental
	WARLOCK = {true, true, true},
	WARRIOR = {nil, nil, nil}
}

function T.GetSpecializationRole()
	local tree = T.GetSpecialization()
	-- eventually check for tank stats in case a tanking in a non-traditional spec (mostly for warriors)
	if (T.class == "PALADIN" and tree == 2) or (T.class == "WARRIOR" and (tree == 3 or GetBonusBarOffset() == 2)) or (T.class == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) or (T.class == "DEATHKNIGHT" and T.CheckPlayerBuff(GetSpellInfo(48263))) then
		return "TANK"
	elseif (T.class == "PALADIN" and tree == 1) or (T.class == "DRUID" and tree == 3) or (T.class == "SHAMAN" and tree == 3) or (T.class == "PRIEST" and tree ~= 3) then
		return "HEALER"
	else
		local base, posBuff, negBuff = UnitAttackPower("player")

		local current = {}
		local best = 1
		for i = 1, 7 do
			current[i] = GetSpellBonusDamage(i)
			if current[i] > current[best] then
				best = i
			end
		end

		local ap = base + posBuff + negBuff
		local spell = GetSpellBonusDamage(best)
		local heal = GetSpellBonusHealing()

		if T.class ~= "HUNTER" and heal >= ap and heal >= spell then
			return "HEALER" -- healing gear without having the majority of talents in a healing tree
		elseif T.class ~= "HUNTER" and (isCaster[T.class][tree] or spell >= ap) then
			return "CASTER" -- ordinarily "DAMAGER"
		else
			return "MELEE" -- ordinarily "DAMAGER"
		end
	end
end

-- Add later
if not GetAverageItemLevel then
	GetAverageItemLevel = function()
		local slotName = {
			"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "WristSlot",
			"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot",
			"Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot"
		}

		local total, slot, itn, level = 0, 0, 0, 0

		for i in pairs(slotName) do
			slot = GetInventoryItemLink("player", GetInventorySlotInfo(slotName[i]))
			if slot then
				itn = itn + 1
				level = select(4, GetItemInfo(slot)) or 0
				total = total + level
			end
		end

		if total < 1 or itn < 1 then return 0 end

		return floor(total / itn), floor(total / itn)
	end
end

----------------------------------------------------------------------------------------
--	Check if Classic or Burning Crusade Classic / Wrath of the Lich King Classic
----------------------------------------------------------------------------------------
if not T.Vanilla then return end

----------------------------------------------------------------------------------------
--	TBC+ Shaman Coloring (config option later)
----------------------------------------------------------------------------------------
if not CUSTOM_CLASS_COLORS then
	local r, g, b, colorStr = 0, 0.44, 0.98, "ff0070de"

	-- for ShestakUI coloring
	if T.class == "SHAMAN" then
		T.color = {}
		T.color.r = r
		T.color.g = g
		T.color.b = b
		T.color.colorStr = colorStr

		C.media.classborder_color = {T.color.r, T.color.g, T.color.b, 1}
	end

	-- for Blizzard UI elements
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(_, _, addon)
		if addon == "Blizzard_RaidUI" then
			hooksecurefunc("RaidGroupFrame_Update", function()
				local isRaid = IsInRaid()
				if not isRaid then return end
				for i = 1, min(GetNumGroupMembers(), MAX_RAID_MEMBERS) do
					local _, _, subgroup, _, _, class, _, online, dead = GetRaidRosterInfo(i)
					if online and not dead and _G["RaidGroup"..subgroup].nextIndex <= MEMBERS_PER_RAID_GROUP and class and class == "SHAMAN" then
						local button = _G["RaidGroupButton"..i]
						button.subframes.name:SetTextColor(r, g, b)
						button.subframes.class.text:SetTextColor(r, g, b)
						button.subframes.level:SetTextColor(r, g, b)
					end
				end
			end)

			hooksecurefunc("RaidGroupFrame_UpdateHealth", function(i)
				local _, _, _, _, _, class, _, online, dead = GetRaidRosterInfo(i)
				if online and not dead and class and class == "SHAMAN" then
					_G["RaidGroupButton"..i.."Name"]:SetTextColor(r, g, b)
					_G["RaidGroupButton"..i.."Class"]:SetTextColor(r, g, b)
					_G["RaidGroupButton"..i.."Level"]:SetTextColor(r, g, b)
				end
			end)

			hooksecurefunc("RaidPullout_UpdateTarget", function(frame, button, unit, which)
				if _G[frame]["show"..which] and UnitCanCooperate("player", unit) then
					local _, class = UnitClass(unit)
					if class and class == "SHAMAN" then
						_G[button..which.."Name"]:SetTextColor(r, g, b)
					end
				end
			end)

			local petowners = {}
			for i = 1, 40 do
				petowners["raidpet"..i] = "raid"..i
			end
			hooksecurefunc("RaidPulloutButton_UpdateDead", function(button, dead, class)
				if not dead and class and class == "SHAMAN" then
					if class == "PETS" then
						class, class = UnitClass(petowners[button.unit])
					end
					button.nameLabel:SetVertexColor(r, g, b)
				end
			end)
		end
	end)

	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame) -- 371
		local opts = frame.optionTable
		if opts.healthBarColorOverride or not opts.useClassColors
				or not (opts.allowClassColorsForNPCs or UnitIsPlayer(frame.unit))
				or not UnitIsConnected(frame.unit) then
			return
		end

		local _, class = UnitClass(frame.unit)
		if not class or class ~= "SHAMAN" then return end

		frame.healthBar:SetStatusBarColor(r, g, b)
		if frame.optionTable.colorHealthWithExtendedColors then
			frame.selectionHighlight:SetVertexColor(r, g, b)
		end
	end)

	hooksecurefunc("MasterLooterFrame_UpdatePlayers", function()
		for k, playerFrame in pairs(MasterLooterFrame) do
			if type(k) == "string" and strmatch(k, "^player%d+$") and type(playerFrame) == "table" and playerFrame.id and playerFrame.Name then
				local i = playerFrame.id
				local _, class
				if IsInRaid() then
					_, class = UnitClass("raid"..i)
				elseif i > 1 then
					_, class = UnitClass("party"..i)
				else
					_, class = UnitClass("player")
				end

				if class and class == "SHAMAN" then
					playerFrame.Name:SetTextColor(r, g, b)
				end
			end
		end
	end)

	hooksecurefunc("LootHistoryFrame_UpdateItemFrame", function(self, itemFrame)
		local itemID = itemFrame.itemIdx
		local rollID, _, _, done, winnerID = C_LootHistory.GetItem(itemID)
		local expanded = self.expandedRolls[rollID]
		if done and winnerID and not expanded then
			local _, class = C_LootHistory.GetPlayerInfo(itemID, winnerID)
			if class and class == "SHAMAN" then
				itemFrame.WinnerName:SetVertexColor(r, g, b)
			end
		end
	end)

	hooksecurefunc("LootHistoryFrame_UpdatePlayerFrame", function(self, playerFrame)
		if playerFrame.playerIdx then
			local name, class = C_LootHistory.GetPlayerInfo(playerFrame.itemIdx, playerFrame.playerIdx)
			if class and class == "SHAMAN" then
				playerFrame.PlayerName:SetVertexColor(r, g, b)
			end
		end
	end)

	function LootHistoryDropDown_Initialize(self)
		local info = UIDropDownMenu_CreateInfo()
		info.text = MASTER_LOOTER
		info.fontObject = GameFontNormalLeft
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)

		local name, class = C_LootHistory.GetPlayerInfo(self.itemIdx, self.playerIdx)
		local color = RAID_CLASS_COLORS[class]

		info = UIDropDownMenu_CreateInfo()
		if class == "SHAMAN" then
			info.text = format(MASTER_LOOTER_GIVE_TO, format("|c%s%s|r", colorStr, name))
		else
			info.text = format(MASTER_LOOTER_GIVE_TO, format("|c%s%s|r", color.colorStr, name))
		end
		info.func = LootHistoryDropDown_OnClick
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	end
end

----------------------------------------------------------------------------------------
--	Check if Classic 1.14 and below or Classic 1.15 and greater
----------------------------------------------------------------------------------------
if not T.Vanilla115 then return end

----------------------------------------------------------------------------------------
--	LibClassicDurations (by d87)
----------------------------------------------------------------------------------------
local LibClassicDurations = LibStub("LibClassicDurations")
if LibClassicDurations then
	LibClassicDurations:Register("ShestakUI")
end

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
	8921,		-- Moonfire
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
		print("|cffff0000ShestakUI: spell ID ["..tostring(spellLookup[i]).."] no longer exists!|r")
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
