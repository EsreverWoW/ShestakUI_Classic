local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{115175, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Soothing Mist
		{191840, "TOPLEFT", {0.1, 0.4, 0.9}},				-- Essence Font
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Faith
		{200025, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Virtue
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		{204018, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Blessing of Spellwarding
		{287280, "BOTTOMLEFT", {0.9, 0.5, 0.1}},			-- Glimmer of Light
	},
	PRIEST = {
		{194384, "TOPRIGHT", {0.8, 0.4, 0.2}},				-- Atonement
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}},				-- Renew
		{6788, "BOTTOMLEFT", {1, 0, 0}},					-- Weakened Soul
		{17, "TOPLEFT", {0.81, 0.85, 0.1}},					-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{204288, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Earth Shield
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	ROGUE = {
		{57934, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true},					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true},					-- Netherstorm Flag
	},
}

T.RaidBuffsIgnore = {
	--[spellID] = true,			-- Spell name
}

local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Castle Nathria
-----------------------------------------------------------------
	-- Shriekwing
	[SpellName(328897)] = 3,	-- Exsanguinated
	[SpellName(330713)] = 3,	-- Reverberating Pain
	[SpellName(342923)] = 3,	-- Deadly Descent
	[SpellName(342863)] = 3,	-- Echo Screech
	-- Huntsman Altimor
	[SpellName(335304)] = 3,	-- Sinseeker
	[SpellName(334971)] = 3,	-- Jagged Claws
	[SpellName(335111)] = 3,	-- Huntsman's Mark
	[SpellName(334945)] = 3,	-- Vicious Lunge
	[SpellName(334852)] = 3,	-- Petrifying Howl
	-- Hungering Destroyer
	[SpellName(334228)] = 3,	-- Volatile Ejection
	[SpellName(329298)] = 3,	-- Gluttonous Miasma
	-- Lady Inerva Darkvein
	[SpellName(325936)] = 3,	-- Shared Cognition
	[SpellName(335396)] = 3,	-- Hidden Desire
	[SpellName(324983)] = 3,	-- Shared Suffering
	[SpellName(324982)] = 3,	-- Shared Suffering (Partner)
	[SpellName(332664)] = 3,	-- Concentrate Anima
	[SpellName(325382)] = 3,	-- Warped Desires
	-- Sun King's Salvation
	[SpellName(333002)] = 3,	-- Vulgar Brand
	[SpellName(326078)] = 3,	-- Infuser's Boon
	[SpellName(325251)] = 3,	-- Sin of Pride
	[SpellName(341475)] = 3,	-- Crimson Flurry
	[SpellName(328479)] = 3,	-- Eyes on Target
	[SpellName(328889)] = 3,	-- Greater Castigation
	-- Artificer Xy'mox
	[SpellName(327902)] = 3,	-- Fixate
	[SpellName(326302)] = 3,	-- Stasis Trap
	[SpellName(325236)] = 3,	-- Glyph of Destruction
	[SpellName(327414)] = 3,	-- Possession
	[SpellName(328468)] = 3,	-- Dimensional Tear
	-- The Council of Blood
	[SpellName(327052)] = 3,	-- Drain Essence
	[SpellName(346651)] = 3,	-- Drain Essence Mythic
	[SpellName(328334)] = 3,	-- Tactical Advance
	[SpellName(330848)] = 3,	-- Wrong Moves
	[SpellName(331706)] = 3,	-- Scarlet Letter
	[SpellName(331636)] = 3,	-- Dark Recital
	-- Sludgefist
	[SpellName(335470)] = 3,	-- Chain Slam
	[SpellName(339181)] = 3,	-- Chain Slam (Root)
	[SpellName(331209)] = 3,	-- Hateful Gaze
	[SpellName(335293)] = 3,	-- Chain Link
	[SpellName(342420)] = 3,	-- Chain Them!
	[SpellName(335295)] = 3,	-- Shattering Chain
	-- Stone Legion Generals
	[SpellName(334498)] = 3,	-- Seismic Upheaval
	[SpellName(337643)] = 3,	-- Unstable Footing
	[SpellName(334765)] = 3,	-- Heart Rend
	[SpellName(333377)] = 3,	-- Wicked Mark
	[SpellName(334616)] = 3,	-- Petrified
	[SpellName(334541)] = 3,	-- Curse of Petrification
	[SpellName(339690)] = 3,	-- Crystalize
	[SpellName(342655)] = 3,	-- Volatile Anima Infusion
	[SpellName(342698)] = 3,	-- Volatile Anima Infection
	[SpellName(343881)] = 3,	-- Serrated Tear
	-- Sire Denathrius
	[SpellName(326851)] = 3,	-- Blood Price
	[SpellName(327796)] = 3,	-- Night Hunter
	[SpellName(327992)] = 3,	-- Desolation
	[SpellName(328276)] = 3,	-- March of the Penitent
	[SpellName(326699)] = 3,	-- Burden of Sin
	[SpellName(329181)] = 3,	-- Wracking Pain
	[SpellName(335873)] = 3,	-- Rancor
	[SpellName(329951)] = 3,	-- Impale
	[SpellName(327039)] = 3,	-- Feeding Time
	[SpellName(332794)] = 3,	-- Fatal Finesse

-----------------------------------------------------------------
-- Dungeons
-----------------------------------------------------------------
	-- Mythic+ Affixes
	[SpellName(226489)] = 5,	-- Sanguine Ichor
	[SpellName(209858)] = 4,	-- Necrotic Wound
	[SpellName(240559)] = 4,	-- Grievous Wound
	[SpellName(240443)] = 5,	-- Burst
	-- Halls of Atonement
	[SpellName(335338)] = 3,	-- Ritual of Woe
	[SpellName(326891)] = 3,	-- Anguish
	[SpellName(329321)] = 3,	-- Jagged Swipe
	[SpellName(319603)] = 3,	-- Curse of Stone
	[SpellName(319611)] = 3,	-- Turned to Stone
	[SpellName(325876)] = 3,	-- Curse of Obliteration
	[SpellName(326632)] = 3,	-- Stony Veins
	[SpellName(323650)] = 3,	-- Haunting Fixation
	[SpellName(326874)] = 3,	-- Ankle Bites
	[SpellName(340446)] = 3,	-- Mark of Envy
	[SpellName(323437)] = 3,	-- Stigma of Pride
	-- Mists of Tirna Scithe
	[SpellName(325027)] = 3,	-- Bramble Burst
	[SpellName(323043)] = 3,	-- Bloodletting
	[SpellName(322557)] = 3,	-- Soul Split
	[SpellName(331172)] = 3,	-- Mind Link
	[SpellName(322563)] = 3,	-- Marked Prey
	[SpellName(322487)] = 3,	-- Overgrowth
	[SpellName(328756)] = 3,	-- Repulsive Visage
	[SpellName(325021)] = 3,	-- Mistveil Tear
	[SpellName(321891)] = 3,	-- Freeze Tag Fixation
	[SpellName(325224)] = 3,	-- Anima Injection
	[SpellName(326092)] = 3,	-- Debilitating Poison
	[SpellName(325418)] = 3,	-- Volatile Acid
	-- Plaguefall
	[SpellName(336258)] = 3,	-- Solitary Prey
	[SpellName(331818)] = 3,	-- Shadow Ambush
	[SpellName(329110)] = 3,	-- Slime Injection
	[SpellName(325552)] = 3,	-- Cytotoxic Slash
	[SpellName(336301)] = 3,	-- Web Wrap
	[SpellName(322358)] = 3,	-- Burning Strain
	[SpellName(322410)] = 3,	-- Withering Filth
	[SpellName(328180)] = 3,	-- Gripping Infection
	[SpellName(320542)] = 3,	-- Wasting Blight
	[SpellName(340355)] = 3,	-- Rapid Infection
	[SpellName(328395)] = 3,	-- Venompiercer
	[SpellName(320512)] = 3,	-- Corroded Claws
	[SpellName(333406)] = 3,	-- Assassinate
	[SpellName(332397)] = 3,	-- Shroudweb
	[SpellName(330069)] = 2,	-- Concentrated Plague
	[SpellName(319070)] = 3,	-- Corrosive Gunk
	-- The Necrotic Wake
	[SpellName(321821)] = 3,	-- Disgusting Guts
	[SpellName(323365)] = 3,	-- Clinging Darkness
	[SpellName(338353)] = 3,	-- Goresplatter
	[SpellName(333485)] = 3,	-- Disease Cloud
	[SpellName(338357)] = 3,	-- Tenderize
	[SpellName(328181)] = 3,	-- Frigid Cold
	[SpellName(320170)] = 3,	-- Necrotic Bolt
	[SpellName(323464)] = 3,	-- Dark Ichor
	[SpellName(323198)] = 3,	-- Dark Exile
	[SpellName(343504)] = 3,	-- Dark Grasp
	[SpellName(343556)] = 3,	-- Morbid Fixation
	[SpellName(324381)] = 3,	-- Chill Scythe
	[SpellName(320573)] = 3,	-- Shadow Well
	[SpellName(333492)] = 3,	-- Necrotic Ichor
	[SpellName(334748)] = 3,	-- Drain FLuids
	[SpellName(333489)] = 3,	-- Necrotic Breath
	[SpellName(320717)] = 3,	-- Blood Hunger
	[SpellName(320788)] = 3,	-- Frozen Binds
	[SpellName(320200)] = 3,	-- Stitchneedle
	-- Theater of Pain
	[SpellName(333299)] = 3,	-- Curse of Desolation
	[SpellName(319539)] = 3,	-- Soulless
	[SpellName(326892)] = 3,	-- Fixate
	[SpellName(321768)] = 3,	-- On the Hook
	[SpellName(323825)] = 3,	-- Grasping Rift
	[SpellName(342675)] = 3,	-- Bone Spear
	[SpellName(323831)] = 3,	-- Death Grasp
	[SpellName(330608)] = 3,	-- Vile Eruption
	[SpellName(330868)] = 3,	-- Necrotic Bolt Volley
	[SpellName(323750)] = 3,	-- Vile Gas
	[SpellName(323406)] = 3,	-- Jagged Gash
	[SpellName(330700)] = 3,	-- Decaying Blight
	[SpellName(319626)] = 3,	-- Phantasmal Parasite
	[SpellName(324449)] = 3,	-- Manifest Death
	[SpellName(341949)] = 3,	-- Withering Blight
	[SpellName(333861)] = 3,	-- Ricocheting Blade
	-- Sanguine Depths
	[SpellName(326827)] = 3,	-- Dread Bindings
	[SpellName(326836)] = 3,	-- Curse of Suppression
	[SpellName(322554)] = 3,	-- Castigate
	[SpellName(321038)] = 3,	-- Burden Soul
	[SpellName(328593)] = 3,	-- Agonize
	[SpellName(325254)] = 3,	-- Iron Spikes
	[SpellName(335306)] = 3,	-- Barbed Shackles
	[SpellName(322429)] = 3,	-- Severing Slice
	[SpellName(334653)] = 3,	-- Engorge
	[SpellName(327814)] = 3,	-- Wicked Gash
	-- Spires of Ascension
	[SpellName(338729)] = 3,	-- Charged Stomp
	[SpellName(323195)] = 3,	-- Purifying Blast
	[SpellName(327481)] = 3,	-- Dark Lance
	[SpellName(322818)] = 3,	-- Lost Confidence
	[SpellName(322817)] = 3,	-- Lingering Doubt
	[SpellName(324205)] = 3,	-- Blinding Flash
	[SpellName(331251)] = 3,	-- Deep Connection
	[SpellName(328331)] = 3,	-- Forced Confession
	[SpellName(341215)] = 3,	-- Volatile Anima
	[SpellName(323792)] = 3,	-- Anima Field
	[SpellName(317661)] = 3,	-- Insidious Venom
	[SpellName(330683)] = 3,	-- Raw Anima
	[SpellName(328434)] = 3,	-- Intimidated
	[SpellName(324154)] = 3,	-- Dark Stride
	-- De Other Side
	[SpellName(320786)] = 3,	-- Power Overwhelming
	[SpellName(334913)] = 3,	-- Master of Death
	[SpellName(325725)] = 3,	-- Cosmic Artifice
	[SpellName(328987)] = 3,	-- Zealous
	[SpellName(334496)] = 3,	-- Soporific Shimmerdust
	[SpellName(339978)] = 3,	-- Pacifying Mists
	[SpellName(323692)] = 3,	-- Arcane Vulnerability
	[SpellName(333250)] = 3,	-- Reaver
	[SpellName(330434)] = 3,	-- Buzz-Saw
	[SpellName(331847)] = 3,	-- W-00F
	[SpellName(327649)] = 3,	-- Crushed Soul
	[SpellName(331379)] = 3,	-- Lubricate
	[SpellName(332678)] = 3,	-- Gushing Wound
	[SpellName(322746)] = 3,	-- Corrupted Blood
	[SpellName(323687)] = 3,	-- Arcane Lightning
	[SpellName(323877)] = 3,	-- Echo Finger Laser X-treme
	[SpellName(334535)] = 3,	-- Beak Slice
	[SpellName(333711)] = 3,	-- Decrepit Bite
	[SpellName(320147)] = 3,	-- Bleeding

-----------------------------------------------------------------
-- Other
-----------------------------------------------------------------
	[SpellName(87023)] = 4,		-- Cauterize
	[SpellName(94794)] = 4,		-- Rocket Fuel Leak
	[SpellName(116888)] = 4,	-- Shroud of Purgatory
	[SpellName(121175)] = 2,	-- Orb of Power
}

-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
if C.raidframe.plugins_pvp_debuffs == true then
	local PvPDebuffs = {
		-- Death Knight
		[SpellName(108194)] = 4,	-- Asphyxiate
		[SpellName(91797)] = 4,		-- Monstrous Blow (Mutated Ghoul)
		[SpellName(91800)] = 4,		-- Gnaw (Ghoul)
		[SpellName(287254)] = 4,	-- Dead of Winter
		[SpellName(47476)] = 3,		-- Strangulate
		-- Demon Hunter
		[SpellName(217832)] = 4,	-- Imprison
		[SpellName(211881)] = 4,	-- Fel Eruption
		[SpellName(179057)] = 4,	-- Chaos Nova
		[SpellName(205630)] = 4,	-- Illidan's Grasp
		[SpellName(207685)] = 4,	-- Sigil of Misery
		[SpellName(204490)] = 3,	-- Sigil of Silence
		-- Druid
		[SpellName(33786)] = 4,		-- Cyclone
		[SpellName(5211)] = 4,		-- Mighty Bash
		[SpellName(22570)] = 4,		-- Maim
		[SpellName(78675)] = 3,		-- Solar Beam
		[SpellName(339)] = 2,		-- Entangling Roots
		-- Hunter
		[SpellName(3355)] = 4,		-- Freezing Trap
		[SpellName(24394)] = 4,		-- Intimidation
		[SpellName(213691)] = 4,	-- Scatter Shot
		[SpellName(117526)] = 2,	-- Binding Shot
		-- Mage
		[SpellName(61305)] = 4,		-- Polymorph
		[SpellName(82691)] = 4,		-- Ring of Frost
		[SpellName(31661)] = 4,		-- Dragon's Breath
		[SpellName(122)] = 2,		-- Frost Nova
		-- Monk
		[SpellName(115078)] = 4,	-- Paralysis
		[SpellName(119381)] = 4,	-- Leg Sweep
		[SpellName(120086)] = 4,	-- Fists of Fury
		-- Paladin
		[SpellName(20066)] = 4,		-- Repentance
		[SpellName(853)] = 4,		-- Hammer of Justice
		[SpellName(105421)] = 4,	-- Blinding Light
		-- Priest
		[SpellName(605)] = 4,		-- Dominate Mind
		[SpellName(8122)] = 4,		-- Psychic Scream
		[SpellName(64044)] = 4,		-- Psychic Horror
		[SpellName(205369)] = 4,	-- Mind Bomb
		[SpellName(87204)] = 4,		-- Sin and Punishment
		[SpellName(200196)] = 4,	-- Holy Word: Chastise
		[SpellName(15487)] = 3,		-- Silence
		-- Rogue
		[SpellName(6770)] = 4,		-- Sap
		[SpellName(2094)] = 4,		-- Blind
		[SpellName(1833)] = 4,		-- Cheap Shot
		[SpellName(408)] = 4,		-- Kidney Shot
		[SpellName(1776)] = 4,		-- Gouge
		[SpellName(1330)] = 3,		-- Garrote - Silence
		-- Shaman
		[SpellName(51514)] = 4,		-- Hex
		[SpellName(118905)] = 4,	-- Static Charge
		[SpellName(305485)] = 4,	-- Lightning Lasso
		-- Warlock
		[SpellName(118699)] = 4,	-- Fear
		[SpellName(6789)] = 4,		-- Mortal Coil
		[SpellName(5484)] = 4,		-- Howl of Terror
		[SpellName(6358)] = 4,		-- Seduction (Succubus)
		[SpellName(115268)] = 4,	-- Mesmerize (Shivarra)
		[SpellName(30283)] = 4,		-- Shadowfury
		-- Warrior
		[SpellName(46968)] = 4,		-- Shockwave
		[SpellName(132169)] = 4,	-- Storm Bolt
		[SpellName(194958)] = 4,	-- Intimidating Shout
	}

	tinsert(T.RaidBuffs["ALL"], {284402, "RIGHT", {1, 0, 0}, true})	-- Vampiric Touch (Don't dispel)
	tinsert(T.RaidBuffs["ALL"], {30108, "RIGHT", {1, 0, 0}, true})	-- Unstable Affliction (Don't dispel)

	for spell, prio in pairs(PvPDebuffs) do
		T.RaidDebuffs[spell] = prio
	end
end

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	[980] = true,			-- Agony
	[1943] = true,			-- Rupture
}

for _, spell in pairs(C.raidframe.plugins_aura_watch_list) do
	T.RaidDebuffs[SpellName(spell)] = 3
end