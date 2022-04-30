local T, C, L, _ = unpack(select(2, ...))

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
			SpellName(67019),	-- Flask of the North (+47 Spell Power OR +80 Attack Power OR +40 Strength)
			SpellName(17627),	-- Flask of Distilled Wisdom (+65 Intellect)
			SpellName(28518),	-- Flask of Fortification (+500 Health / +10 Defense)
			SpellName(41609),	-- Shattrath Flask of Fortification (+500 Health / +10 Defense)
			SpellName(42735),	-- Flask of Chromatic Wonder (+35 Magic Resistance / +18 Stats)
			SpellName(53752),	-- Lesser Flask of Toughness (+50 Resilience Rating)
			SpellName(53755),	-- Flask of the Frost Wyrm (+125 Spell Power)
			SpellName(53758),	-- Flask of Stoneblood (+1300 Health)
			SpellName(53760),	-- Flask of Endless Rage (+180 Attack Power)
			SpellName(54212),	-- Flask of Pure Mojo (+45 Mp5)
			SpellName(62380),	-- Lesser Flask of Resistance (+50 Magic Resistance)
		},
		BattleElixir = {
			SpellName(33721),	-- Spellpower Elixir (+58 Spell Power)
			SpellName(11406),	-- Elixir of Demonslaying (+105 Attack Power to Demons)
			SpellName(28497),	-- Elixir of Mighty Agility (+45 Agility)
			SpellName(53746),	-- Wrath Elixir (+90 Attack Power)
			SpellName(53748),	-- Elixir of Mighty Strength (+50 Strength)
			SpellName(53749),	-- Guru's Elixir (+20 Stats)
			SpellName(54452),	-- Adept's Elixir (+24 Spell Power / +24 Critical Rating)
			SpellName(60340),	-- Elixir of Accuracy (+45 Hit Rating)
			SpellName(60341),	-- Elixir of Deadly Strikes (+45 Critical Rating)
			SpellName(60344),	-- Elixir of Expertise (+45 Expertise Rating)
			SpellName(60345),	-- Elixir of Armor Piercing (+45 Armor Penetration Rating)
			SpellName(60346),	-- Elixir of Lightning Speed (+45 Haste Rating)
		},
		GuardianElixir = {
			SpellName(60347),	-- Elixir of Mighty Thoughts (+45 Intellect)
			SpellName(28514),	-- Elixir of Empowerment (+30 Spell Penetration)
			SpellName(39626),	-- Earthen Elixir (+20 Damage Reduction)
			SpellName(39627),	-- Elixir of Draenic Wisdom (+30 Intellect / +30 Spirit)
			SpellName(39628),	-- Elixir of Ironskin (+30 Resilience Rating)
			SpellName(53747),	-- Elixir of Spirit (+50 Spirit)
			SpellName(53751),	-- Elixir of Mighty Fortitude (+350 Health / +20 Hp5)
			SpellName(53763),	-- Elixir of Protection (+800 Armor)
			SpellName(53764),	-- Elixir of Mighty Mana Regeneration (+30 Mp5)
			SpellName(60343),	-- Elixir of Mighty Defense (+45 Defense Rating)
		},
		Other = {
			-- SpellName(spellID),	-- Spell name
		},
		Food = {
			SpellName(57399),	-- Well Fed (+40 Attack Power / 46 Spell Power / +40 Stamina) [Fish Feast]
			SpellName(15852),	-- Dragonbreath Chili (Special) [Dragonbreath Chili]
			SpellName(22730),	-- Increased Intellect (+10 Intellect) [Runn Tum Tuber Surprise]
			SpellName(33263),	-- Well Fed (+23 Spell Power / +20 Spirit) [Blackened Basilisk / Crunchy Serpent / Poached Bluefish]
			SpellName(33268),	-- Well Fed (+23 Spell Power / +20 Spirit) [Golden Fish Sticks]
			SpellName(43722),	-- Enlightened (+20 Spell Critical Strike / +20 Spirit) [Skullfish Soup]
			SpellName(43730),	-- Electrified (Special) [Stormchops]
			SpellName(45619),	-- Well Fed (+8 Magic Resistance) [Broiled Bloodfin]
			SpellName(57325),	-- Well Fed (+80 Attack Power / +40 Stamina) [Poached Northern Sculpin / Mega Mammoth Meal]
			SpellName(57327),	-- Well Fed (+46 Spell Power / +40 Stamina) [Firecracker Salmon / Tender Shoveltusk Steak]
			SpellName(57329),	-- Well Fed (+40 Critial Rating / +40 Stamina) [Spicy Blue Nettlefish / Spiced Worm Burger]
			SpellName(57332),	-- Well Fed (+40 Haste Rating / +40 Stamina) [Imperial Manta Steak / Very Burnt Worg]
			SpellName(57334),	-- Well Fed (+20 Mp5 / +40 Stamina) [Spicy Fried Herring / Mighty Rhino Dogs]
			SpellName(57356),	-- Well Fed (+40 Expertise Rating / +40 Stamina) [Rhinolicious Wormsteak]
			SpellName(57358),	-- Well Fed (+40 Armor Penetration Rating / +40 Stamina) [Hearty Rhino]
			SpellName(57360),	-- Well Fed (+40 Hit Rating / +40 Stamina) [Snapper Extreme / Worg Tartare]
			SpellName(57365),	-- Well Fed (+40 Spirit / +40 Stamina) [Cuttlesteak]
			SpellName(57367),	-- Well Fed (+40 Agility / +40 Stamina) [Blackened Dragonfin]
			SpellName(57371),	-- Well Fed (+40 Strength / +40 Stamina) [Dragonfin Filet]
			SpellName(66623),	-- Well Fed (+40 Attack Power / 47 Spell Power / +40 Stamina) [Bountiful Feast]
		},
		Mp5 = {
			SpellName(25894),	-- Greater Blessing of Wisdom
			SpellName(19742),	-- Blessing of Wisdom
			SpellName(5677),	-- Mana Spring
		},
		AP = {
			SpellName(25782),	-- Greater Blessing of Might
			SpellName(19740),	-- Blessing of Might
			SpellName(6673),	-- Battle Shout
		},
		Intellect = {
			SpellName(23028),	-- Arcane Brilliance
			SpellName(1459),	-- Arcane Intellect
			SpellName(61316),	-- Dalaran Brilliance
			SpellName(61024),	-- Dalaran Intellect
			SpellName(8096),	-- Intellect [Scroll of Intellect]
		},
		Kings = {
			SpellName(25898),	-- Greater Blessing of Kings
			SpellName(20217),	-- Blessing of Kings
			SpellName(69378),	-- Blessing of Forgotten Kings [Drums of Forgotten Kings]
		},
		Mark = {
			SpellName(21849),	-- Gift of the Wild
			SpellName(1126),	-- Mark of the Wild
			SpellName(69381),	-- Gift of the Wild [Drums of the Wild]
		},
		Spirit = {
			SpellName(27681),	-- Prayer of Spirit
			SpellName(14752),	-- Divine Spirit
		},
		Stamina = {
			SpellName(21562),	-- Prayer of Fortitude
			SpellName(1243),	-- Power Word: Fortitude
			SpellName(69377),	-- Fortitude [Runescroll of Fortitude]
		},
		Custom = {
			-- SpellName(spellID),	-- Spell name
		},
	}

	T.ReminderBuffs.Spell3Buff = T.ReminderBuffs["Kings"]
	T.ReminderBuffs.Spell4Buff = T.ReminderBuffs["Mark"]

	-- Amount of "other" buffs to consider a fulfillment of the Flask reminder
	function T.ReminderFlaskRequirements()
		local requireFlask = true
		local otherBuffsRequired = 0

		return requireFlask, otherBuffsRequired
	end

	-- Caster buffs
	function T.ReminderCasterBuffs()
		T.ReminderBuffs.Spell5Buff = T.ReminderBuffs["Intellect"]
		T.ReminderBuffs.Spell6Buff = T.ReminderBuffs["Mp5"]
	end

	-- Physical buffs
	function T.ReminderPhysicalBuffs()
		T.ReminderBuffs.Spell5Buff = T.ReminderBuffs["Stamina"]
		T.ReminderBuffs.Spell6Buff = T.ReminderBuffs["AP"]
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
		DEATHKNIGHT = {
			[1] = {	-- Horn of Winter group
				["spells"] = {
					SpellName(57330),	-- Horn of Winter
					SpellName(8076),	-- Strength of Earth
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
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
					SpellName(61846),	-- Aspect of the Dragonhawk
					SpellName(13165),	-- Aspect of the Hawk
					SpellName(13161),	-- Aspect of the Beast
					SpellName(5118),	-- Aspect of the Cheetah
					SpellName(13163),	-- Aspect of the Monkey
					SpellName(13159),	-- Aspect of the Pack
					SpellName(34074),	-- Aspect of the Viper
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
					SpellName(30482),	-- Molten Armor
					SpellName(168),		-- Frost Armor
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
					SpellName(61316),	-- Dalaran Brilliance
					SpellName(61024),	-- Dalaran Intellect
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
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 16,
			},
			[2] = {	-- Auras group
				["spells"] = {
					SpellName(465),		-- Devotion Aura
					SpellName(7294),	-- Retribution Aura
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
					SpellName(20217),	-- Blessing of Kings
					SpellName(19740),	-- Blessing of Might
					SpellName(20911),	-- Blessing of Sanctuary
					SpellName(19742),	-- Blessing of Wisdom
					SpellName(25898),	-- Greater Blessing of Kings
					SpellName(25782),	-- Greater Blessing of Might
					SpellName(25899),	-- Greater Blessing of Sanctuary
					SpellName(25894),	-- Greater Blessing of Wisdom
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[4] = {	-- Seals group
				["spells"] = {
					SpellName(21084),		-- Seal of Righteousness
					SpellName(31892),		-- Seal of Blood
					SpellName(20375),		-- Seal of Command
					SpellName(348704),		-- Seal of Corruption
					SpellName(20164),		-- Seal of Justice
					SpellName(20165),		-- Seal of Light
					SpellName(31801),		-- Seal of Vengeance
					SpellName(20166),		-- Seal of Wisdom
					SpellName(348700),		-- Seal of the Martyr
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		PRIEST = {
			[1] = {	-- Inner Fire/Will group
				["spells"] = {
					SpellName(588),		-- Inner Fire
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
					SpellName(976),		-- Shadow Protection
					SpellName(27683),	-- Prayer of Shadow Protection
				},
				["combat"] = true,
				["instance"] = true,
				-- ["level"] = 30,
			},
			--[[
			[5] = {	-- Shadowform group
				["spells"] = {
					SpellName(15473),		-- Shadowform
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
		ROGUE = {
			[1] = {	-- Main Hand Weapon Enchant group
				["spells"] = {
					SpellName(8679),	-- Instant Poison
					SpellName(2823),	-- Deadly Poison
					SpellName(3408),	-- Crippling Poison
					SpellName(5761),	-- Mind-numbing Poison
					SpellName(13219),	-- Wound Poison
					SpellName(26785),	-- Anesthetic Poison
				},
				["mainhand"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 20,
			},
			[2] = {	-- Off-Hand Weapon Enchant group
				["spells"] = {
					SpellName(8679),	-- Instant Poison
					SpellName(2823),	-- Deadly Poison
					SpellName(3408),	-- Crippling Poison
					SpellName(5761),	-- Mind-numbing Poison
					SpellName(13219),	-- Wound Poison
					SpellName(26785),	-- Anesthetic Poison
				},
				["offhand"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				["level"] = 20,
			},
		},
		SHAMAN = {
			[1] = {	-- Shields group
				["spells"] = {
					SpellName(52127),	-- Water Shield
					SpellName(324),		-- Lightning Shield
					SpellName(974),		-- Earth Shield
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
				-- ["level"] = 8,
			},
			[2] = {	-- Main Hand Weapon Enchant group
				["spells"] = {
					SpellName(8232),	-- Windfury Weapon
					SpellName(8017),	-- Rockbiter Weapon
					SpellName(8024),	-- Flametongue Weapon
					SpellName(8033),	-- Frostbrand Weapon
					SpellName(51730),	-- Earthliving Weapon
				},
				["mainhand"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[3] = {	-- Off-Hand Weapon Enchant group
				["spells"] = {
					SpellName(8232),	-- Windfury Weapon
					SpellName(8017),	-- Rockbiter Weapon
					SpellName(8024),	-- Flametongue Weapon
					SpellName(8033),	-- Frostbrand Weapon
					SpellName(51730),	-- Earthliving Weapon
				},
				["offhand"] = true,
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARLOCK = {
			[1] = {	-- Armors group
				["spells"] = {
					SpellName(28176),	-- Fel Armor
					SpellName(706),		-- Demon Armor
					SpellName(687),		-- Demon Skin
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			[2] = {	-- Amplify Curse group
				["spells"] = {
					SpellName(18288),	-- Amplify Curse
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
		},
		WARRIOR = {
			[1] = {	-- Shout group
				["spells"] = {
					SpellName(6673),	-- Battle Shout
					SpellName(469),		-- Commanding Shout
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--[[
			[2] = {	-- Stance group
				["spells"] = {
					SpellName(2457),		-- Battle Stance
					SpellName(2458),		-- Berserker Stance
					SpellName(71),			-- Defensive Stance
				},
				["combat"] = true,
				["instance"] = true,
				["pvp"] = true,
			},
			--]]
		},
	}
end
