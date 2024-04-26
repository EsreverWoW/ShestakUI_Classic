local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		{20484, 600},	-- Rebirth (600sec base / -300sec from 5pc AQ Set)
		{20707, 900},	-- Soulstone Resurrection
		{27740, 3600},	-- Reincarnation
		-- Jumper Cables
		-- {8342, 1800},	-- Goblin Jumper Cables
		-- {22999, 1800},	-- Goblin Jumper Cables XL
		-- {54732, 1800},	-- Gnomish Army Knife
		-- Heroism
		{90355, 360},	-- Ancient Hysteria (360sec base / -252sec from talents)
		{80353, 300},	-- Time Warp
		{2825, 300},	-- Bloodlust
		{32182, 300},	-- Heroism
		-- Healing
		{740, 480},		-- Tranquility (480sec base / -300sec from talents / -240sec from 8pc T1)
		{64843, 480},	-- Divine Hymn (480sec base / -300sec from talents)
		{724, 180},		-- Lightwell
		-- Defense
		{48707, 45},	-- Anti-Magic Shell
		{51052, 120},	-- Anti-Magic Zone
		{42650, 600},	-- Army of the Dead
		{49222, 60},	-- Bone Shield
		{48792, 120},	-- Icebound Fortitude
		{22812, 60},	-- Barkskin (60sec base / -12sec from 4pc T9)
		{61336, 180},	-- Survival Instincts
		{31850, 180},	-- Ardent Defender
		{31821, 120},	-- Aura Mastery
		{64205, 120},	-- Divine Sacrifice
		{498, 60},		-- Divine Protection (60sec base / -30sec from talents / -30sec from 4pc T9)
		{86659, 300},	-- Guardian of Ancient Kings (300sec base / -120sec from talents)
		{1022, 300},	-- Hand of Protection (300sec base / -120sec from talents)
		{6940, 120},	-- Hand of Sacrifice (120sec base / -30sec from talents / -24sec from talents)
		{633, 600},		-- Lay on Hands (600sec base / -180sec from glyph / -240sec from 4pc T3)
		{47788, 180},	-- Guardian Spirit
		{33206, 180},	-- Pain Suppression
		{62618, 180},	-- Power Word: Barrier
		{98008, 180},	-- Spirit Link Totem
		{12975, 180},	-- Last Stand
		{97462, 180},	-- Rallying Cry
		{2565, 60},		-- Shield Block (60sec base / -20sec from talents / -10sec from 4pc T9)
		{871, 300},		-- Shield Wall (300sec base / -180sec from talents)
		-- Taunts
		{5209, 180},	-- Challenging Roar (180sec base / -30sec from glyph)
		{1161, 180},	-- Challenging Shout
		-- Mana Regeneration
		{29166, 180},	-- Innervate (180sec base / -48sec from 4pc T4)
		{64901, 360},	-- Hymn of Hope
		{16190, 180},	-- Mana Tide Totem
		-- Other
		{49016, 180},	-- Hysteria / Unholy Frenzy
		{34477, 30},	-- Misdirection
		{1038, 120},	-- Hand of Salvation (120sec base / -24sec from talents)
		{6346, 120},	-- Fear Ward (180sec base / -60sec from glyph)
		{10060, 120},	-- Power Infusion
		{57934, 30},	-- Tricks of the Trade (30sec base / -10sec from talents)
		-- {29858, 120},	-- Soulshatter
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
		{47476, 60},	-- Strangulate (120sec base / -60sec from talents)
		{80965, 10},	-- Skull Bash (60sec base / -50sec from talents)
		{78675, 60},	-- Solar Beam
		{34490, 20},	-- Silencing Shot
		{2139, 24},		-- Counterspell (24sec base / -2sec from ZG neck)
		{96231, 10},	-- Rebuke
		{15487, 45},	-- Silence
		{1766, 8},		-- Kick (10sec base / -2sec from glyph / -0.5sec from ZG neck)
		{57994, 5},		-- Wind Shear (15sec base / -10sec from talents)
		{19647, 24},	-- Spell Lock (Felhunter)
		{6552, 10},		-- Pummel
		-- Crowd Controls
		{60192, 22},	-- Freezing Arrow (30sec base / -6sec from talents / -4sec from 2pc D3 / -2sec from 4pc PvP)
		{1499, 22},		-- Freezing Trap (30sec base / -6sec from talents / -4sec from 2pc D3 / -2sec from 4pc PvP)
		{19503, 30},	-- Scatter Shot
		{19386, 54},	-- Wyvern Sting (60sec base / -6sec from glyph)
		{31661, 20},	-- Dragon's Breath
		{11113, 15},	-- Blast Wave (30sec base / -4sec from 4pc T4)
		{853, 40},		-- Hammer of Justice (60sec base / -20sec from talents)
		{20066, 60},	-- Repentance
		{6789, 120},	-- Death Coil (120sec base / -30sec from 4pc PvP)
		{64044, 90},	-- Psychic Horror (120sec base / -30sec from glyph)
		{8122, 23},		-- Psychic Scream (30sec base / -3sec from gloves / -4sec from talents / +3sec from glyph)
		{2094, 120},	-- Blind (180sec base / -60sec from talents)
		{5484, 32},		-- Howl of Terror (40sec base / -8sec from glyph)
		{30283, 20},	-- Shadowfury
		{12809, 30},	-- Concussion Blow
		{46968, 17},	-- Shockwave (20sec base / -3sec from glyph)
		{85388, 45},	-- Throwdown
		-- Defense abilities
		{48707, 45},	-- Anti-Magic Shell
		{51052, 120},	-- Anti-Magic Zone
		{49222, 60},	-- Bone Shield
		{48792, 120},	-- Icebound Fortitude
		{51271, 60},	-- Pillar of Frost (60sec base / -10sec from 4pc T9)
		{55233, 60},	-- Vampiric Blood (60sec base / -10sec from 4pc T9)
		{22812, 60},	-- Barkskin (60sec base / -12sec from 4pc T9)
		{61336, 180},	-- Survival Instincts
		{19263, 120},	-- Deterrence (120sec base / -10sec from glyph)
		{45438, 240},	-- Ice Block (300sec base / -60sec from talents / -40sec from 4pc T4)
		{66, 135},		-- Invisibility (180sec base / -45sec from talents)
		{31850, 180},	-- Ardent Defender
		{1044, 20},		-- Hand of Freedom (25sec base / -5sec from talents)
		{6940, 90},		-- Hand of Sacrifice (120sec base / -30sec from talents / -24sec from talents)
		{1038, 96},		-- Hand of Salvation (120sec base / -24sec from talents)
		{1022, 180},	-- Hand of Protection (300sec base / -120sec from talents)
		{498, 30},		-- Divine Protection (60sec base / -30sec from talents / -30sec from 4pc T9)
		{86659, 300},	-- Guardian of Ancient Kings (300sec base / -120sec from talents)
		{642, 300},		-- Divine Shield
		{6346, 120},	-- Fear Ward (180sec base / -60sec from glyph)
		{47585, 75},	-- Dispersion (120sec base / -45sec from glyph)
		{47788, 180},	-- Guardian Spirit
		{33206, 180},	-- Pain Suppression
		{62618, 180},	-- Power Word: Barrier
		{31224, 90},	-- Cloak of Shadows (120sec base / -30sec from talents)
		{5277, 180},	-- Evasion (180sec base / -60sec from 3pc AQ Set)
		{1856, 120},	-- Vanish (180sec base / -60sec from talents / -30sec from 3pc T1)
		-- {8178, 22},	-- Grounding Totem Effect (25sec base / -2sec from talents / -3sec from 4pc PvP)
		{18499, 24},	-- Berserker Rage (30sec base / -6sec from talents)
		{46924, 75},	-- Bladestorm (90sec base / -15sec from glyph)
		{12975, 180},	-- Last Stand
		{2565, 40},		-- Shield Block (60sec base / -20sec from talents / -10sec from 4pc T9)
		{871, 120},		-- Shield Wall (300sec base / -180sec from talents)
		-- {23920, 20},		-- Spell Reflection (25sec base / -5sec from glyph)
		{59752, 120},	-- Every Man for Himself / Will to Survive
		{65116, 120},	-- Stoneform
		{7744, 120},	-- Will of the Forsaken
		-- Heals
		-- {28880, 180},	-- Gift of the Naaru
		-- Disarms
		{64346, 60},	-- Fiery Payback
		{51722, 60},	-- Dismantle
		{676, 60},		-- Disarm
		-- Mana Regeneration
		{29166, 180},	-- Innervate (180sec base / -48sec from 4pc T4)
		{64901, 360},	-- Hymn of Hope
		{16190, 180},	-- Mana Tide Totem
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
	local function SpellName(id)
		local name = GetSpellInfo(id)
		if name then
			return name
		else
			print("|cffff0000ShestakUI: Pulse cooldown spell ID ["..tostring(id).."] no longer exists!|r")
			return "Empty"
		end
	end

	T.pulse_ignored_spells = {
		-- SpellName(spellID),	-- Spell name
		-- SpellName(6807),		-- Maul
		-- SpellName(35395),	-- Crusader Strike
	}
	for _, spell in pairs(C.pulsecooldown.spells_list) do
		T.pulse_ignored_spells[SpellName(spell)] = true
	end
end
