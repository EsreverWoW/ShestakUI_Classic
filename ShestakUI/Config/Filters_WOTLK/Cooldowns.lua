local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		{20484, 600},	-- Rebirth r1 (600sec base / -300sec from 5pc AQ Set)
		{20739, 600},	-- Rebirth r2 (600sec base / -300sec from 5pc AQ Set)
		{20742, 600},	-- Rebirth r3 (600sec base / -300sec from 5pc AQ Set)
		{20747, 600},	-- Rebirth r4 (600sec base / -300sec from 5pc AQ Set)
		{20748, 600},	-- Rebirth r5 (600sec base / -300sec from 5pc AQ Set)
		{26994, 600},	-- Rebirth r6 (600sec base / -300sec from 5pc AQ Set)
		{48477, 600},	-- Rebirth r7 (600sec base / -300sec from 5pc AQ Set)
		{20707, 900},	-- Soulstone Resurrection r1
		{20762, 900},	-- Soulstone Resurrection r2
		{20763, 900},	-- Soulstone Resurrection r3
		{20764, 900},	-- Soulstone Resurrection r4
		{20765, 900},	-- Soulstone Resurrection r5
		{27239, 900},	-- Soulstone Resurrection r6
		{47883, 900},	-- Soulstone Resurrection r7
		{27740, 3600},	-- Reincarnation (3600sec base / -900sec from talents / -300sec for Totem)
		-- Jumper Cables
		-- {8342, 1800},	-- Goblin Jumper Cables
		-- {22999, 1800},	-- Goblin Jumper Cables XL
		-- {54732, 1800},	-- Gnomish Army Knife
		-- Heroism
		{2825, 300},	-- Bloodlust
		{32182, 300},	-- Heroism
		-- Healing
		{740, 480},		-- Tranquility r1 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{8918, 480},	-- Tranquility r2 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{9862, 480},	-- Tranquility r3 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{9863, 480},	-- Tranquility r4 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{26983, 480},	-- Tranquility r5 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{48446, 480},	-- Tranquility r6 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{48447, 480},	-- Tranquility r7 (480sec base / -288sec from talents / -240sec from 8pc T1)
		{64843, 480},	-- Hymn of Hope
		{724, 180},		-- Lightwell r1
		{27870, 180},	-- Lightwell r2
		{27871, 180},	-- Lightwell r3
		{28275, 180},	-- Lightwell r4
		{48086, 180},	-- Lightwell r5
		{48087, 180},	-- Lightwell r6
		-- Defense
		{48707, 45},	-- Anti-Magic Shell
		{51052, 180},	-- Anti-Magic Zone
		{42650, 600},	-- Army of the Dead
		{49222, 60},	-- Bone Shield (60sec base / -10sec from 4pc T9)
		{48792, 120},	-- Icebound Fortitude
		{61336, 180},	-- Survival Instincts
		{31821, 120},	-- Aura Mastery
		{64205, 120},	-- Divine Sacrifice
		{1022, 300},	-- Hand of Protection r1 (300sec base / -120sec from talents)
		{5599, 300},	-- Hand of Protection r2 (300sec base / -120sec from talents)
		{10278, 300},	-- Hand of Protection r3 (300sec base / -120sec from talents)
		{6940, 120},	-- Hand of Sacrifice
		{633, 1200},	-- Lay on Hands r1 (1200sec base / -240sec from talents / -300sec from glyph / -240sec from 4pc T3)
		{2800, 1200},	-- Lay on Hands r2 (1200sec base / -240sec from talents / -300sec from glyph / -240sec from 4pc T3)
		{10310, 1200},	-- Lay on Hands r3 (1200sec base / -240sec from talents / -300sec from glyph / -240sec from 4pc T3)
		{27154, 1200},	-- Lay on Hands r4 (1200sec base / -240sec from talents / -300sec from glyph / -240sec from 4pc T3)
		{48788, 1200},	-- Lay on Hands r5 (1200sec base / -240sec from talents / -300sec from glyph / -240sec from 4pc T3)
		{47788, 180},	-- Guardian Spirit
		{33206, 180},	-- Pain Suppression (180sec base / -36sec from talents)
		{12975, 180},	-- Last Stand (180sec base / -60sec from glyph)
		{2565, 60},		-- Shield Block (60sec base / -20sec from talents / -10sec from 4pc T9)
		{871, 300},		-- Shield Wall (300sec base / -60sec from talents / -120sec from glyph)
		-- Taunts
		{5209, 180},	-- Challenging Roar (180sec base / -30sec from glyph)
		{1161, 180},	-- Challenging Shout
		{694, 120},		-- Mocking Blow r1
		{7400, 120},	-- Mocking Blow r2
		{7402, 120},	-- Mocking Blow r3
		{20559, 120},	-- Mocking Blow r4
		{20560, 120},	-- Mocking Blow r5
		{25266, 120},	-- Mocking Blow r6
		{47504, 120},	-- Mocking Blow r7
		-- Mana Regeneration
		{29166, 180},	-- Innervate (180sec base / -48sec from 4pc T4)
		{16190, 300},	-- Mana Tide Totem
		-- Other
		{34477, 30},	-- Misdirection
		{1038, 120},	-- Hand of Salvation
		{6346, 180},	-- Fear Ward (180sec base / -60sec from glyph)
		{10060, 120},	-- Power Infusion (120sec base / -24sec from talents)
		{57934, 30},	-- Tricks of the Trade (30sec base / -10sec from talents)
		-- {29858, 180},	-- Soulshatter
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
		{47476, 100},	-- Strangulate (120sec base / -20sec from glyph)
		{34490, 20},	-- Silencing Shot
		{2139, 24},		-- Counterspell (24sec base / -2sec from ZG neck)
		{63529, 30},	-- Silenced - Shield of the Templar
		{15487, 45},	-- Silence
		{1766, 10},		-- Kick (10sec base / -0.5sec from ZG neck)
		{57994, 5},		-- Wind Shear (6sec base / -1sec from talents)
		{19244, 24},	-- Spell Lock (Felhunter)
		{6552, 10},		-- Pummel
		-- Crowd Controls
		{60192, 22},	-- Freezing Arrow (30sec base / -6sec from talents / -4sec from 2pc D3 / -2sec from 4pc PvP)
		{1499, 22},		-- Freezing Trap (30sec base / -6sec from talents / -4sec from 2pc D3 / -2sec from 4pc PvP)
		{19503, 30},	-- Scatter Shot
		{19386, 54},	-- Wyvern Sting (60sec base / -6sec from glyph)
		{31661, 20},	-- Dragon's Breath
		{11113, 30},	-- Blast Wave (30sec base / -4sec from 4pc T4)
		{853, 40},		-- Hammer of Justice (60sec base / -20sec from talents / -10sec from talents / -0.5sec from ZG neck)
		{20066, 60},	-- Repentance
		{6789, 120},	-- Death Coil (120sec base / -18sec from 5pc ZG Set)
		{64044, 120},	-- Psychic Horror
		{8122, 23},		-- Psychic Scream (30sec base / -3sec from gloves / -4sec from talents / +8sec from glyph)
		{2094, 90},		-- Blind (180sec base / -90sec from talents)
		{5484, 32},		-- Howl of Terror (40sec base / -8sec from glyph)
		{30283, 20},	-- Shadowfury
		{12809, 30},	-- Concussion Blow
		{46968, 17},	-- Shockwave (20sec base / -3sec from glyph)
		-- Defense abilities
		{48707, 45},	-- Anti-Magic Shell
		{51052, 180},	-- Anti-Magic Zone
		{49222, 60},	-- Bone Shield (60sec base / -10sec from 4pc T9)
		{48792, 120},	-- Icebound Fortitude
		{51271, 60},	-- Unbreakable Armor (60sec base / -10sec from 4pc T9)
		{55233, 60},	-- Vampiric Blood (60sec base / -10sec from 4pc T9)
		{22812, 60},	-- Barkskin (60sec base / -12sec from 4pc T9)
		{19263, 50},	-- Deterrence (60sec base / -10sec from glyph)
		{45438, 240},	-- Ice Block (300sec base / -60sec from talents / -40sec from 4pc T4)
		{66, 60},		-- Invisibility (180sec base / -120sec from talents)
		{1044, 25},		-- Hand of Freedom (25sec base / -4sec from talents)
		{6940, 120},	-- Hand of Sacrifice
		{1038, 120},	-- Hand of Salvation
		{1022, 180},	-- Hand of Protection (300sec base / -120sec from talents)
		{498, 180},		-- Divine Protection (180sec base / -60sec from talents / -30sec from 4pc T9)
		{642, 300},		-- Divine Shield (300sec base / -60sec from talents)
		{6346, 120},	-- Fear Ward (180sec base / -60sec from glyph)
		{47585, 75},	-- Dispersion (120sec base / -45sec from glyph)
		{47788, 144},	-- Guardian Spirit
		{33206, 144},	-- Pain Suppression (180sec base / -36sec from talents)
		{31224, 30},	-- Cloak of Shadows (60sec base / -30sec from talents)
		{5277, 120},	-- Evasion (180sec base / -60sec from talents / -60sec from 3pc AQ Set)
		{1856, 120},	-- Vanish (180sec base / -60sec from talents / -30sec from 3pc T1)
		-- {8178, 11},	-- Grounding Totem (15sec base / -2sec from talents / -1.5sec from 4pc PvP)
		{18499, 20},	-- Berserker Rage (30sec base / -10sec from talents)
		{46924, 45},	-- Bladestorm (60sec base / -15sec from glyph)
		{12975, 120},	-- Last Stand (180sec base / -60sec from glyph)
		{2565, 40},		-- Shield Block (60sec base / -20sec from talents / -10sec from 4pc T9)
		{871, 180},		-- Shield Wall (300sec base / -60sec from talents / -120sec from glyph)
		-- {23920, 9},		-- Spell Reflection (10sec base / -1sec from glyph)
		{59752, 120},	-- Every Man for Himself / Will to Survive
		{65116, 120},	-- Stoneform
		{7744, 120},	-- Will of the Forsaken
		-- Heals
		-- {28880, 180},	-- Gift of the Naaru
		-- Disarms
		{53359, 60},	-- Chimera Shot - Scorpid
		{64346, 60},	-- Fiery Payback
		{51722, 60},	-- Dismantle
		{676, 40},		-- Disarm (60sec base / -20sec from talents)
		-- Mana Regeneration
		{29166, 180},	-- Innervate (180sec base / -48sec from 4pc T4)
		{64901, 360},	-- Hymn of Hope
		{16190, 300},	-- Mana Tide Totem
		-- Trinket (TEMPORARY)
		{42292, 120},	-- PvP Trinket
		{65547, 120},	-- PvP Trinket
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
