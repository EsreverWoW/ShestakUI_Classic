local T, C, L, _ = unpack(select(2, ...))
if not T.BCC then return end

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
			-- SpellName(17624),	-- Flask of Petrification (Immunity)
			SpellName(17628),	-- Flask of Supreme Power (+70 Spell Damage)
			SpellName(17627),	-- Flask of Distilled Wisdom (+2000 Mana)
			SpellName(17629),	-- Flask of Chromatic Resistance (+25 Magic Resistance)
			SpellName(17626),	-- Flask of the Titans (+400 Health)
			SpellName(28518),	-- Flask of Fortification (+500 Health / +10 Defense)
			SpellName(28519),	-- Flask of Mighty Restoration (+25 Mp5)
			SpellName(28520),	-- Flask of Relentless Assault (+120 Attack Power)
			SpellName(28521),	-- Flask of Blinding Light (+80 Arcane/Holy/Nature Spell Power)
			SpellName(28540),	-- Flask of Pure Death (+80 Shadow/Fire/Frost Spell Power)
			SpellName(40567),	-- Unstable Flask of the Bandit (+20 Agility / +40 Attack Power / +30 Stamina)
			SpellName(40568),	-- Unstable Flask of the Elder (+20 Intellect / +30 Stamina / +8 Mp5)
			SpellName(40572),	-- Unstable Flask of the Beast (+20 Agility / +20 Strength / +30 Stamina)
			SpellName(40573),	-- Unstable Flask of the Physician (+20 Intellect / +30 Stamina / +44 Healing Power)
			SpellName(40575),	-- Unstable Flask of the Soldier (+20 Critical Strike / +20 Strength / +30 Stamina)
			SpellName(40576),	-- Unstable Flask of the Sorcerer (+20 Intellect / +30 Stamina / +23 Spell Power)
			SpellName(41608),	-- Shattrath Flask of Relentless Assault (+120 Attack Power)
			SpellName(41609),	-- Shattrath Flask of Fortification (+500 Health / +10 Defense)
			SpellName(41610),	-- Shattrath Flask of Mighty Restoration (+25 Mp5)
			SpellName(41611),	-- Shattrath Flask of Supreme Power (+70 Spell Power)
			SpellName(42735),	-- Flask of Chromatic Wonder (+35 Magic Resistance / +18 Stats)
			SpellName(46837),	-- Shattrath Flask of Pure Death (+80 Shadow/Fire/Frost Spell Power)
			SpellName(46839),	-- Shattrath Flask of Blinding Light (+80 Arcane/Holy/Nature Spell Power)
		},
		BattleElixir = {
			SpellName(11406),	-- Elixir of Demonslaying (+265 Attack Power to Demons)
			SpellName(17539),	-- Greater Arcane Elixir (+35 Arcane Spell Power)
			SpellName(28490),	-- Elixir of Major Strength (+35 Strength)
			SpellName(28491),	-- Elixir of Healing Power (+50 Healing Power)
			SpellName(28493),	-- Elixir of Major Frost Power (+55 Frost Spell Power)
			SpellName(28497),	-- Elixir of Major Agility (+35 Agility / +20 Critical Strike)
			SpellName(28501),	-- Elixir of Major Firepower (+55 Fire Spell Power)
			SpellName(28503),	-- Elixir of Major Shadow Power (+55 Shadow Spell Power)
			SpellName(33720),	-- Onslaught Elixir (+60 Attack Power)
			SpellName(33721),	-- Adept's Elixir (+24 Spell Power / +24 Critical Strike)
			SpellName(33726),	-- Elixir of Mastery (+15 Stats)
			SpellName(38954),	-- Fel Strength Elixir (+90 Attack Power / -10 Stamina)
			SpellName(45373),	-- Bloodberry Elixir (+15 Stats)
		},
		GuardianElixir = {
			SpellName(28502),	-- Elixir of Major Defense (+550 Armor)
			SpellName(28509),	-- Elixir of Major Mageblood (+16 Mp5)
			SpellName(28514),	-- Elixir of Empowerment (+30 Spell Penetration)
			SpellName(39625),	-- Elixir of Major Fortitude (+250 Health / 10 Hp5)
			SpellName(39626),	-- Earthen Elixir (+20 Damage Reduction)
			SpellName(39627),	-- Elixir of Draenic Wisdom (+30 Intellect / +30 Spirit)
			SpellName(39628),	-- Elixir of Ironskin (+30 Resilience Rating)
		},
		Other = {
			-- SpellName(spellID),	-- Spell name
		},
		Food = {
			SpellName(33257),	-- Well Fed (+30 Stamina / +20 Spirit) [Fisherman's Feast / Spicy Crawdad]
			SpellName(15852),	-- Dragonbreath Chili (Special) [Dragonbreath Chili]
			SpellName(22730),	-- Increased Intellect (+10 Intellect) [Runn Tum Tuber Surprise]
			SpellName(24799),	-- Well Fed (+20 Strength) [Helboar Bacon / Smoked Desert Dumplings]
			SpellName(25661),	-- Increased Stamina (+25 Stamina) [Dirge's Kickin' Chimaerok Chops]
			-- SpellName(33254),	-- Well Fed (+20 Stamina / +20 Spirit) [Buzzard Bites / Clam Bar / Feltail Delight]
			SpellName(33256),	-- Well Fed (+20 Strength / +20 Spirit) [Roasted Clefthoof]
			SpellName(33259),	-- Well Fed (+40 Attack Power / +20 Spirit) [Ravager Dog]
			SpellName(33261),	-- Well Fed (+20 Agility / +20 Spirit) [Grilled Mudfish / Warp Burger]
			SpellName(33263),	-- Well Fed (+23 Spell Power / +20 Spirit) [Blackened Basilisk / Crunchy Serpent / Poached Bluefish]
			SpellName(33265),	-- Well Fed (+20 Stamina / +8 Mp5) [Blackened Sporefish]
			SpellName(33268),	-- Well Fed (+44 Healing Power / +20 Spirit) [Golden Fish Sticks]
			-- SpellName(35272),	-- Well Fed (+20 Stamina / +20 Spirit) [Mok'Nathal Shortribs / Talbuk Steak]
			SpellName(43722),	-- Enlightened (+20 Spell Critical Strike / +20 Spirit) [Skullfish Soup]
			SpellName(43730),	-- Electrified (Special) [Stormchops]
			SpellName(43764),	-- Well Fed (+20 Physical Hit Rating / +20 Spirit) [Spicy Hot Talbuk]
			-- SpellName(44104),	-- "Well Fed" (+20 Stamina / +20 Spirit) [Brewfest]
			-- SpellName(44105),	-- "Well Fed" (+20 Stamina / +20 Spirit) [Brewfest]
			SpellName(44106),	-- "Well Fed" (+20 Strength / +20 Spirit) [Brewfest]
			-- SpellName(45245),	-- Well Fed (+20 Stamina / +20 Spirit) [Hot Apple Cider]
			SpellName(45619),	-- Well Fed (+8 Magic Resistance) [Broiled Bloodfin]
		},
		Mp5 = {
			SpellName(25894),	-- Greater Blessing of Wisdom
			SpellName(19742),	-- Blessing of Wisdom
			SpellName(5677),	-- Mana Spring
		},
		Might = {
			SpellName(25782),	-- Greater Blessing of Might
			SpellName(19740),	-- Blessing of Might
		},
		Threat = {
			SpellName(25895),	-- Greater Blessing of Salvation
			SpellName(1038),	-- Blessing of Salvation
			SpellName(25909)	-- Tranquil Air
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

	T.ReminderBuffs.Spell3Buff = T.ReminderBuffs["Kings"]
	T.ReminderBuffs.Spell4Buff = T.ReminderBuffs["Mark"]
	T.ReminderBuffs.Spell7Buff = T.ReminderBuffs["Threat"]

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
		T.ReminderBuffs.Spell6Buff = T.ReminderBuffs["Might"]
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
					SpellName(21084),		-- Seal of Righteousness
					SpellName(31892),		-- Seal of Blood
					SpellName(27170),		-- Seal of Command
					SpellName(20164),		-- Seal of Justice
					SpellName(20165),		-- Seal of Light
					SpellName(31801),		-- Seal of Vengeance
					SpellName(20166),		-- Seal of Wisdom
					SpellName(21082),		-- Seal of the Crusader
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
					SpellName(21835),	-- Anesthetic Poison
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
					SpellName(21835),	-- Anesthetic Poison
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
					SpellName(24398),	-- Water Shield
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
					SpellName(8024),	-- Flametongue Weapon
					SpellName(28013),	-- Superior Mana Oil
					SpellName(25123),	-- Brilliant Mana Oil
					SpellName(28017),	-- Superior Wizard Oil
					SpellName(25122),	-- Brilliant Wizard Oil
					SpellName(28898),	-- Blessed Wizard Oil
					SpellName(25121),	-- Wizard Oil
					SpellName(45395),	-- Blessed Weapon Coating
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
					SpellName(8024),	-- Flametongue Weapon
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
		},
		WARRIOR = {
			[1] = {	-- Commanding Shout group
				["spells"] = {
					SpellName(469),	-- Commanding Shout
				},
				["negate_spells"] = {
					SpellName(6673),	-- Battle Shout
				},
				["combat"] = true,
				["role"] = "Tank",
				-- ["level"] = 68,
			},
			[2] = {	-- Battle Shout group
				["spells"] = {
					SpellName(6673),	-- Battle Shout
				},
				["negate_spells"] = {
					SpellName(469),	-- Commanding Shout
				},
				["combat"] = true,
				["role"] = "Melee",
				["instance"] = true,
				["pvp"] = true,
			},
			--[[
			[3] = {	-- Stance group
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
