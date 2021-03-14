local T, C, L, _ = unpack(select(2, ...))
if not T.classic then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Well Fed -> http://www.wowhead.com/spell=104280
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name, _, icon = GetSpellInfo(id)
	if name then
		return {name, icon}
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to EsreverWoW.|r")
		return {"Empty", ""}
	end
end

if C.reminder.raid_buffs_enable == true or C.announcements.flask_food == true then
	T.ReminderBuffs = {
		Flask = {
			SpellName(17628),	-- Flask of Supreme Power (+150 Spell Damage)
			SpellName(17627),	-- Flask of Distilled Wisdom (+2000 Mana)
			SpellName(17629),	-- Flask of Chromatic Resistance (+25 Magic Resistance)
			SpellName(17626),	-- Flask of the Titans (+400 Health)
		},
		Other = {
			Agility = {
				SpellName(11334),	-- Elixir of Greater Agility (+25 Agility)
				SpellName(17538),	-- Elixir of the Mongoose (+25 Agility / +2% Crit Chance)
			},
			Alcohol = {
				SpellName(25804),	-- Rumsey Rum Black Label (+15 Stamina)
				SpellName(22789),	-- Gordok Green Grog (+10 Stamina)
				SpellName(22790),	-- Kreeg's Stout Beatdown (+25 Spirit / -5 Intellect)
			},
			AP = {
				SpellName(16329),	-- Juju Might (+40 Attack Power)
				SpellName(17038),	-- Winterfall Firewater (+35 Attack Power)
			},
			BlastedLands = {
				SpellName(10667),	-- R.O.I.D.S. (+25 Strength)
				SpellName(10668),	-- Lung Juice Cocktail (+25 Stamina)
				SpellName(10669),	-- Ground Scorpok Assay (+25 Agility)
				SpellName(10692),	-- Cerebral Cortex Compound (+25 Intellect)
				SpellName(10693),	-- Gizzard Gum (+25 Spirit)
			},
			SpellDamage = {
				SpellName(17539),	-- Greater Arcane Elixir (+35 Spell Damage)
				SpellName(11474),	-- Elixir of Shadow Power (+40 Shadow Spell Damage)
				SpellName(26276),	-- Elixir of Greater Firepower (+40 Fire Spell Damage)
				SpellName(21920),	-- Elixir of Frost Power (+15 Frost Spell Damage)
			},
			Strength = {
				SpellName(16323),	-- Juju Power (+30 Strength)
				SpellName(11405),	-- Elixir of Giants (+25 Strength)
			},
			Tanking = {
				-- Armor
				SpellName(11348),	-- Elixir of Superior Defense (+450 Armor)
				SpellName(11349),	-- Elixir of Greater Defense (+250 Armor)

				-- Gift of Arthas
				SpellName(11371),	-- Gift of Arthas (+10 Shadow Resistance / Disease Proc)

				-- Health
				SpellName(3593),	-- Elixir of Fortitude (+120 Health)

				-- Health Regeneration
				-- SpellName(24361),	-- Major Troll's Blood Potion (+20 Hp5)
				-- SpellName(3223),	-- Mighty Troll's Blood Potion (+12 Hp5)
			},
			Zanzas = {
				SpellName(24382),	-- Spirit of Zanza (+50 Spirit / +50 Stamina)
				SpellName(24383),	-- Swiftness of Zanza (+20% Run Speed)
				SpellName(24417),	-- Sheen of Zanza (+3% Spell Reflect Chance)
			},
			Resistance = {
				SpellName(16325),	-- Juju Chill
				SpellName(16326),	-- Juju Ember
			},
			Misc = {
				-- Demonslaying
				SpellName(11406),	-- Elixir of Demonslaying (+265 Attack Power to Demons)

				-- Mana Regeneration
				SpellName(24363),	-- Mageblood Potion (+12 Mp5)
			},
		},
		Food = {
			SpellName(24799),	-- Well Fed (+20 Strength) [Smoked Desert Dumplings]
			-- SpellName(18194),	-- Mana Regeneration (+8 Mp5) [Nightfin Soup]
			SpellName(15852),	-- Dragonbreath Chili (Special) [Dragonbreath Chili]
			SpellName(18125),	-- Blessed Sunfruit (+10 Strength) [Blessed Sunfruit]
			SpellName(18192),	-- Increased Agility (+10 Agility) [Grilled Squid]
			SpellName(18141),	-- Blessed Sunfruit Juice (+10 Spirit) [Blessed Sunfruit Juice]
			SpellName(22730),	-- Increased Intellect (+10 Intellect) [Runn Tum Tuber Surprise]
			SpellName(25661),	-- Increased Stamina (+25 Stamina) [Dirge's Kickin' Chimaerok Chops]
		},
		Alliance = {
			Mp5 = {
				SpellName(25894),	-- Greater Blessing of Wisdom
				SpellName(19742),	-- Blessing of Wisdom
			},
			Physical = {
				SpellName(25782),	-- Greater Blessing of Might
				SpellName(19740),	-- Blessing of Might
			},
			Threat = {
				SpellName(25895),	-- Greater Blessing of Salvation
				SpellName(1038),	-- Blessing of Salvation
			},
		},
		Horde = {
			Mp5 = {
				SpellName(5677),	-- Mana Spring
			},
			Physical = {
				SpellName(8076),	-- Strength of Earth
				SpellName(8072),	-- Stoneskin
				SpellName(8836),	-- Grace of Air
			},
			
			Threat = {
				SpellName(25909)	-- Tranquil Air
			},
		},
		AP = {
			SpellName(6673),	-- Battle Shout
		},
		Intellect = {
			SpellName(23028),	-- Arcane Brilliance
			SpellName(1459),	-- Arcane Intellect
		},
		Kings = {
			SpellName(25898),	-- Greater Blessing of Kings
			SpellName(20217),	-- Blessing of Kings
		},
		Mark = {
			SpellName(21849),	-- Gift of the Wild
			SpellName(1126),	-- Mark of the Wild
		},
		Spirit = {
			SpellName(27681),	-- Prayer of Spirit
			SpellName(14752),	-- Divine Spirit
		},
		Stamina = {
			SpellName(21562),	-- Prayer of Fortitude
			SpellName(1243),	-- Power Word: Fortitude
		},
		Custom = {
			-- SpellName(spellID),	-- Spell name
		},
	}

	T.ReminderBuffs.Spell3Buff = T.ReminderBuffs["Stamina"]
	T.ReminderBuffs.Spell7Buff = T.ReminderBuffs["Mark"]

	-- Amount of "other" buffs to consider a fulfillment of the Flask reminder
	function T.ReminderFlaskRequirements()
		local requireFlask = true
		local otherBuffsRequired = 0

		return requireFlask, otherBuffsRequired
	end

	-- Caster buffs
	function T.ReminderCasterBuffs()
		local faction = UnitFactionGroup("player")
		if not faction or faction == "Neutral" then faction = "Alliance" end

		T.ReminderBuffs.Spell4Buff = T.ReminderBuffs["Intellect"]
		T.ReminderBuffs.Spell5Buff = T.ReminderBuffs["Spirit"]
		T.ReminderBuffs.Spell6Buff = T.ReminderBuffs[faction]["Mp5"]
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		local faction = UnitFactionGroup("player")
		if not faction or faction == "Neutral" then faction = "Alliance" end

		T.ReminderBuffs.Spell4Buff = faction == "Alliance" and T.ReminderBuffs["Kings"] or T.ReminderBuffs["Horde"]["Threat"]
		T.ReminderBuffs.Spell5Buff = T.ReminderBuffs["AP"]
		T.ReminderBuffs.Spell6Buff = T.ReminderBuffs[faction]["Physical"]
	end
end

----------------------------------------------------------------------------------------
--[[------------------------------------------------------------------------------------
	Spell Reminder Arguments

	Type of Check:
		spells - List of spells in a group, if you have anyone of these spells the icon will hide.

	Spells only Requirements:
		negate_spells - List of spells in a group, if you have anyone of these spells the icon will immediately hide and stop running the spell check (these should be other peoples spells)
		personal - like a negate_spells but only for your spells
		reversecheck - only works if you provide a role or a spec, instead of hiding the frame when you have the buff, it shows the frame when you have the buff
		negate_reversecheck - if reversecheck is set you can set a spec to not follow the reverse check

	Requirements:
		role - you must be a certain role for it to display (Tank, Melee, Caster)
		spec - you must be active in a specific spec for it to display (1, 2, 3) note: spec order can be viewed from top to bottom when you open your talent pane
		level - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in some cases it may be useful)

	Additional Checks: (Note we always run a check when gaining/losing an aura)
		combat - check when entering combat
		instance - check when entering a party/raid instance
		pvp - check when entering a bg/arena

	For every group created a new frame is created, it's a lot easier this way.
]]--------------------------------------------------------------------------------------
if C.reminder.solo_buffs_enable == true then
	T.ReminderSelfBuffs = {
		--[[
		ROGUE = {
			[1] = {	-- Lethal Poisons group
				["spells"] = {
					SpellName(2823),	-- Deadly Poison
					SpellName(8679),	-- Wound Poison
				},
				["spec"] = 1,		-- Only Assassination have poisen now
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Non-Lethal Poisons group
				["spells"] = {
					SpellName(3408),	-- Crippling Poison
					SpellName(108211),	-- Leeching Poison
				},
				["spec"] = 1,		-- Only Assassination have poisen now
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		--]]
		DRUID = {
			[1] = {	-- Mark of the Wild group
				["spells"] = {
					SpellName(1126),	-- Mark of the Wild
					SpellName(21849),	-- Gift of the Wild
				},
				["combat"] = true,
				["instance"] = true,
			},
			[2] = {	-- Omen of Clarity group
				["spells"] = {
					SpellName(16864),	-- Omen of Clarity
				},
				["combat"] = true,
				["instance"] = true,
			},
		},
		HUNTER = {
			[1] = {	-- Aspects group
				["spells"] = {
					SpellName(13165),	-- Aspect of the Hawk
					SpellName(13161),	-- Aspect of the Beast
					SpellName(5118),	-- Aspect of the Cheetah
					SpellName(13163),	-- Aspect of the Monkey
					SpellName(13159),	-- Aspect of the Pack
					SpellName(20043),	-- Aspect of the Wild
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 10,
			},
			[2] = {	-- Trueshot group
				["spells"] = {
					SpellName(19506),	-- Trueshot Aura
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		MAGE = {
			[1] = {	-- Armors group
				["spells"] = {
					SpellName(168),	-- Frost Armor
					SpellName(6117),	-- Mage Armor
					SpellName(7302),	-- Ice Armor
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Intellect group
				["spells"] = {
					SpellName(1459),	-- Arcane Intellect
					SpellName(23028),	-- Arcane Brilliance
				},
				["combat"] = true,
				["instance"] = true,
			},
		},
		PALADIN = {
			[1] = {	-- Righteous Fury group
				["spells"] = {
					SpellName(25780),	-- Righteous Fury
				},
				["role"] = "Tank",
				["instance"] = true,
				["reversecheck"] = true,
				-- ["negate_reversecheck"] = 1,	-- Holy paladins use RF sometimes
				["negate_reversecheck"] = "Healer",	-- Holy paladins use RF sometimes
				-- ["level"] = 16,
			},
			[2] = {	-- Auras group
				["spells"] = {
					SpellName(465),		-- Devotion Aura
					SpellName(7294),	-- Retribution Aura
					SpellName(20218),	-- Sanctity Aura
					SpellName(19746),	-- Concentration Aura
					SpellName(19891),	-- Fire Resistance Aura
					SpellName(19888),	-- Frost Resistance Aura
					SpellName(19876),	-- Shadow Resistance Aura
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[3] = {	-- Blessings group
				["spells"] = {
					SpellName(1044),	-- Blessing of Freedom
					SpellName(20217),	-- Blessing of Kings
					SpellName(19977),	-- Blessing of Light
					SpellName(19740),	-- Blessing of Might
					SpellName(1022),	-- Blessing of Protection
					SpellName(6940),	-- Blessing of Sacrifice
					SpellName(1038),	-- Blessing of Salvation
					SpellName(20911),	-- Blessing of Sanctuary
					SpellName(19742),	-- Blessing of Wisdom
					SpellName(25898),	-- Greater Blessing of Kings
					SpellName(25890),	-- Greater Blessing of Light
					SpellName(25782),	-- Greater Blessing of Might
					SpellName(25895),	-- Greater Blessing of Salvation
					SpellName(25899),	-- Greater Blessing of Sanctuary
					SpellName(25894),	-- Greater Blessing of Wisdom
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--[[
			[4] = {	-- Seals group
				["spells"] = {
					SpellName(21084),	-- Seal of Righteousness
					SpellName(20375),	-- Seal of Command
					SpellName(20164),	-- Seal of Justice
					SpellName(20165),	-- Seal of Light
					SpellName(20166),	-- Seal of Wisdom
					SpellName(21082),	-- Seal of the Crusader
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
		PRIEST = {
			[1] = {	-- Inner Fire/Will group
				["spells"] = {
					SpellName(588),	-- Inner Fire
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 12,
			},
			[2] = {	-- Stamina Group
				["spells"] = {
					SpellName(1243),	-- Power Word: Fortitude
					SpellName(21562),	-- Prayer of Fortitude
				},
				["combat"] = true,
				["instance"] = true,
			},
			[3] = {	-- Spirit
				["spells"] = {
					SpellName(14752),	-- Divine Spirit
					SpellName(27681),	-- Prayer of Spirit
				},
				["combat"] = true,
				["instance"] = true,
				-- ["level"] = 30,
			},
			[4] = {	-- Shadow Resistance group
				["spells"] = {
					SpellName(976),	-- Shadow Protection
					SpellName(27683),	-- Prayer of Shadow Protection
				},
				["combat"] = true,
				["instance"] = true,
				-- ["level"] = 30,
			},
			--[[
			[5] = {	-- Shadowform group
				["spells"] = {
					SpellName(15473),	-- Shadowform
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
		ROGUE = {
			[1] = {	-- Weapon enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 20,
			},
		},
		SHAMAN = {
			[1] = {	-- Weapons enchants group
				["weapon"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARLOCK = {
			[1] = {	-- Armors group
				["spells"] = {
					SpellName(706),	-- Demon Armor
					SpellName(687),	-- Demon Skin
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARRIOR = {
			[1] = {	-- Battle Shout group
				["spells"] = {
					SpellName(6673),	-- Battle Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--[[
			[2] = {	-- Stance group
				["spells"] = {
					SpellName(2457),	-- Battle Stance
					SpellName(2458),	-- Berserker Stance
					SpellName(71),		-- Defensive Stance
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
	}
end
