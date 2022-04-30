local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		{20484, 1200},	-- Rebirth r1 (1200sec base / -300sec from 5pc AQ Set)
		{20739, 1200},	-- Rebirth r2 (1200sec base / -300sec from 5pc AQ Set)
		{20742, 1200},	-- Rebirth r3 (1200sec base / -300sec from 5pc AQ Set)
		{20747, 1200},	-- Rebirth r4 (1200sec base / -300sec from 5pc AQ Set)
		{20748, 1200},	-- Rebirth r5 (1200sec base / -300sec from 5pc AQ Set)
		{26994, 1200},	-- Rebirth r6 (1200sec base / -300sec from 5pc AQ Set)
		{20707, 1800},	-- Soulstone Resurrection r1
		{20762, 1800},	-- Soulstone Resurrection r2
		{20763, 1800},	-- Soulstone Resurrection r3
		{20764, 1800},	-- Soulstone Resurrection r4
		{20765, 1800},	-- Soulstone Resurrection r5
		{27239, 1800},	-- Soulstone Resurrection r6
		{27740, 3600},	-- Reincarnation (3600sec base / -1200sec from talents / -600sec for Totem)
		-- Jumper Cables
		-- {8342, 1800},	-- Goblin Jumper Cables
		-- {22999, 1800},	-- Goblin Jumper Cables XL
		-- Heroism
		{2825, 600},	-- Bloodlust
		{32182, 600},	-- Heroism
		-- Healing
		{740, 600},		-- Tranquility r1 (600sec base / -300sec from 8pc T1)
		{8918, 600},	-- Tranquility r2 (600sec base / -300sec from 8pc T1)
		{9862, 600},	-- Tranquility r3 (600sec base / -300sec from 8pc T1)
		{9863, 600},	-- Tranquility r4 (600sec base / -300sec from 8pc T1)
		{26983, 600},	-- Tranquility r5 (600sec base / -300sec from 8pc T1)
		{724, 360},		-- Lightwell r1
		{27870, 360},	-- Lightwell r2
		{27871, 360},	-- Lightwell r3
		{28275, 360},	-- Lightwell r4
		-- Defense
		{1022, 300},	-- Blessing of Protection r1 (300sec base / -120sec from talents)
		{5599, 300},	-- Blessing of Protection r2 (300sec base / -120sec from talents)
		{10278, 300},	-- Blessing of Protection r3 (300sec base / -120sec from talents)
		-- {6940, 30},		-- Blessing of Sacrifice r1
		-- {20729, 30},		-- Blessing of Sacrifice r2
		-- {27147, 30},		-- Blessing of Sacrifice r3
		-- {27148, 30},		-- Blessing of Sacrifice r4
		{633, 3600},	-- Lay on Hands r1 (3600sec base / -1200sec from talents / -720sec from 4pc T3)
		{2800, 3600},	-- Lay on Hands r2 (3600sec base / -1200sec from talents / -720sec from 4pc T3)
		{10310, 3600},	-- Lay on Hands r3 (3600sec base / -1200sec from talents / -720sec from 4pc T3)
		{27154, 3600},	-- Lay on Hands r4 (3600sec base / -1200sec from talents / -720sec from 4pc T3)
		{33206, 120},	-- Pain Suppression
		{871, 1800},	-- Shield Wall (1800sec base / -600sec from talents)
		{12975, 480},	-- Last Stand
		-- Taunts
		{5209, 600},	-- Challenging Roar
		{1161, 600},	-- Challenging Shout
		{694, 120},		-- Mocking Blow r1
		{7400, 120},	-- Mocking Blow r2
		{7402, 120},	-- Mocking Blow r3
		{20559, 120},	-- Mocking Blow r4
		{20560, 120},	-- Mocking Blow r5
		{25266, 120},	-- Mocking Blow r6
		-- Mana Regeneration
		{29166, 360},	-- Innervate (360sec base / -48sec from 4pc T4)
		{16190, 300},	-- Mana Tide Totem
		-- Other
		{34477, 120},	-- Misdirection
		{6346, 30},		-- Fear Ward
		{10060, 180},	-- Power Infusion
		-- {29858, 300},	-- Soulshatter
	}

	if #C.raidcooldown.spells_list > 0 then
		T.raid_spells = C.raidcooldown.spells_list
	else
		if C.options.raidcooldown and C.options.raidcooldown.spells_list then
			C.options.raidcooldown.spells_list = nil
		end
	end
	T.RaidSpells = {}
	for _, spell in pairs(T.raid_spells) do
		T.RaidSpells[spell[1]] = spell[2]
	end
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		{34490, 20},	-- Silencing Shot
		{2139, 24},		-- Counterspell (24sec base / -2sec from ZG neck)
		{15487, 45},	-- Silence
		{1766, 10},		-- Kick (10sec base / -0.5sec from ZG neck)
		{8042, 5},		-- Earth Shock (6sec base / -1sec from talents)
		{19244, 24},	-- Spell Lock (Felhunter)
		{6552, 10},		-- Pummel
		-- Crowd Controls
		{1499, 24},		-- Freezing Trap (30sec base / -6sec from talents / -4sec from 2pc D3)
		{19503, 30},	-- Scatter Shot
		{19386, 120},	-- Wyvern Sting
		{31661, 20},	-- Dragon's Breath
		{11113, 30},	-- Blast Wave (30sec base / -4sec from 4pc T4)
		{853, 35},		-- Hammer of Justice (60sec base / -10sec from 4pc PvP / -15sec from talents / -0.5sec from ZG neck)
		{20066, 60},	-- Repentance
		{6789, 120},	-- Death Coil (120sec base / -18sec from 5pc ZG Set)
		{8122, 23},		-- Psychic Scream (30sec base / -3sec from gloves / -4sec from talents)
		{2094, 90},		-- Blind (180sec base / -90sec from talents)
		{5484, 40},		-- Howl of Terror
		{30283, 20},	-- Shadowfury
		{12809, 45},	-- Concussion Blow
		-- Defense abilities
		{22812, 60},	-- Barkskin
		{19263, 300},	-- Deterrence
		{45438, 240},	-- Ice Block (300sec base / -60sec from talents / -40sec from 4pc T4)
		{66, 300},		-- Invisibility
		{1044, 21},		-- Blessing of Freedom (25sec base / -4sec from talents)
		-- {6940, 30},		-- Blessing of Sacrifice
		{1022, 180},	-- Blessing of Protection (300sec base / -120sec from talents)
		{498, 300},		-- Divine Protection
		{642, 300},		-- Divine Shield
		{6346, 180},	-- Fear Ward
		{33206, 120},	-- Pain Suppression
		{31224, 60},	-- Cloak of Shadows
		{5277, 210},	-- Evasion (300sec base / -90sec from talents / -60sec from 3pc AQ Set)
		{1856, 210},	-- Vanish (300sec base / -90sec from talents / -30sec from 3pc T1)
		-- {8178, 11},	-- Grounding Totem (15sec base / -2sec from talents / -1.5sec from 4pc PvP)
		{18499, 30},	-- Berserker Rage
		-- {23920, 10},		-- Spell Reflection
		{20600, 180},	-- Perception
		{20594, 180},	-- Stoneform
		{7744, 120},	-- Will of the Forsaken
		-- Heals
		-- {28880, 180},	-- Gift of the Naaru
		-- Disarms
		-- {14251, 6},		-- Riposte
		{676, 60},		-- Disarm
		-- Mana Regeneration
		{29166, 360},	-- Innervate (360sec base / -48sec from 4pc T4)
		{32548, 300},	-- Symbol of Hope
		{16190, 300},	-- Mana Tide Totem
		-- Trinket (TEMPORARY)
		{42292, 120},	-- PvP Trinket
	}

	if #C.enemycooldown.spells_list > 0 then
		T.enemy_spells = C.enemycooldown.spells_list
	else
		if C.options.enemycooldown and C.options.enemycooldown.spells_list then
			C.options.enemycooldown.spells_list = nil
		end
	end
	T.EnemySpells = {}
	for _, spell in pairs(T.enemy_spells) do
		T.EnemySpells[spell[1]] = spell[2]
	end
end

if C.pulsecooldown.enable == true then
	T.pulse_ignored_spells = {
		-- GetSpellInfo(spellID),	-- Spell name
		-- GetSpellInfo(6807),		-- Maul
		-- GetSpellInfo(35395),		-- Crusader Strike
	}
end
