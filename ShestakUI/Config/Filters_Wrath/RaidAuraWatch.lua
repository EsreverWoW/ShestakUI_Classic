local T, C, L, _ = unpack(select(2, ...))
if C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
															-- Abolish Poison (in all)
															-- Innervate
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		-- {102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		-- {155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	HUNTER = {
		{34477, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	PALADIN = {
															-- Lay on Hands (Physical Damage Reduction)
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		-- {114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Hand of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Hand of Sacrifice
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},		-- Hand of Salvation
		{53601, "TOPLEFT", {0.4, 0.7, 0.2}, true},			-- Sacred Shield
	},
	PRIEST = {
															-- Abolish Disease (move to all?)
															-- Fear Ward
															-- Guardian Spirit
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{10060, "RIGHT", {0.89, 0.1, 0.1}},					-- Power Infusion
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}, true},			-- Riptide
		{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},			-- Earth Shield
		{16177, "TOPLEFT", {0.4, 0.7, 0.2}},				-- Ancestral Fortitude
		{51945, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Earthliving
	},
	ROGUE = {
		{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
	},
	DEATHKNIGHT = {
		{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},				-- Hysteria / Unholy Frenzy
	},
	MAGE = {
															-- Curse Immunity
		{54646, "TOPRIGHT", {0.2, 0.2, 0.1}},				-- Focus Magic
	},
	WARRIOR = {
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
		{59665, "TOPLEFT", {0.2, 0.2, 0.1}},				-- Vigilance
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{34976, "LEFT", {1, 0, 0}, true}, 					-- Netherstorm Flag
		{2893, "RIGHT", {0, 1, 0}, true}, 					-- Abolish Poison
		{36488, "RIGHT", {0.89, 0.1, 0.1}, true},			-- Infernal Protection [Cosmic Infuser]
		{26470, "RIGHT", {0.8, 0.2, 0}, true},				-- Persistent Shield [Scarab Brooch]
		{64413, "RIGHT", {0.8, 0.2, 0}, true},				-- Protection of Ancient Kings [Val'anyr, Hammer of Ancient Kings]
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
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to EsreverWoW.|r")
		return "Empty"
	end
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Classic Raid
-----------------------------------------------------------------
-- World Bosses
	-- Azuregos
	-- Lord Kazzak
	-- Emeriss
	-- Lethon
	-- Ysondre
	-- Taerar

-- Molten Core (40)
	-- Trash
	-- Lucifron
	-- Magmadar
	-- Gehennas
	-- Garr
	-- Shazzrah
	-- Baron Geddon
	-- Golemagg
	-- Sulfuron
	-- Majordomo
	-- Ragnaros

-- Onyxia's Lair (40)
	-- Onyxia

-- Blackwing Lair (40)
	-- Trash
	-- Razorgore
	-- Vaelastrasz
	-- Broodlord
	-- Firemaw
	-- Ebonroc
	-- Flamegor
	-- Chromaggus
	-- Nefarian

-- Zul'Gurub (20)
	-- Trash
	-- Jeklik
	-- Venoxis
	-- Mar'li
	-- Bloodlord
	-- Gahz'ranka
	-- Thekal
	-- Arlokk
	-- Jin'do
	-- Hakkar

-- Ruins of Ahn'Qiraj (20)
	-- Trash
	-- Kurinnaxx
	-- Rajaxx
	-- Moam
	-- Buru
	-- Ayamiss
	-- Ossirian

-- Temple of Ahn'Qiraj (40)
	-- Trash
	-- Skeram
	-- Royalty
	-- Sartura
	-- Fankriss
	-- Viscidus
	-- Huhuran
	-- Twin Emperors
	-- Ouro
	-- C'Thun

-- Naxxramas (40)
	-- Trash
	-- Anub'Rekhan
	-- Faerlina
	-- Maexxna
	-- Patchwerk
	-- Grobbulus
	-- Gluth
	-- Thaddius
	-- Noth
	-- Heigan
	-- Loatheb
	-- Razuvious
	-- Gothik
	-- Four Horsemen
	-- Sapphiron
	-- Kel'Thuzad

-----------------------------------------------------------------
-- Classic Dungeons
-----------------------------------------------------------------
-- Ragefire Chasm
-- Wailing Caverns
-- The Deadmines
-- Shadowfang Keep
-- Blackfathom Deeps
-- The Stockade
-- Gnomeregan
-- Razorfen Kraul
-- The Scarlet Monastery
-- Razorfen Downs
-- Uldaman
-- Zul'Farrak
-- Maraudon
-- Temple of Atal'Hakkar
-- Blackrock Depths
-- Lower Blackrock Spire
-- Upper Blackrock Spire
-- Dire Maul
-- Stratholme
-- Scholomance

-----------------------------------------------------------------
-- The Burning Crusade Raid
-----------------------------------------------------------------
-- World Bosses
-- Doom Lord Kazzak
-- Doomwalker

-- Karazhan
	-- Trash
		[SpellName(29679)] = 4,		-- Bad Poetry
		[SpellName(29505)] = 3,		-- Banshee Shriek
		[SpellName(32441)] = 4,		-- Brittle Bones
		[SpellName(29690)] = 5,		-- Drunken Skull Crack
		[SpellName(29321)] = 4,		-- Fear
		[SpellName(29935)] = 4,		-- Gaping Maw
		[SpellName(29670)] = 5,		-- Ice Tomb
		[SpellName(29491)] = 4,		-- Impending Betrayal
		[SpellName(41580)] = 3,		-- Net
		[SpellName(29676)] = 5,		-- Rolling Pin
		[SpellName(29490)] = 5,		-- Seduction
		[SpellName(29684)] = 5,		-- Shield Slam
		[SpellName(29300)] = 5,		-- Sonic Blast
		[SpellName(29900)] = 5,		-- Unstable Magic (Good Debuff)
	-- Attumen the Huntsman
		[SpellName(29833)] = 3,		-- Intangible Presence
		[SpellName(29711)] = 4,		-- Knockdown
	-- Moroes
		[SpellName(34694)] = 4,		-- Blind
		[SpellName(37066)] = 5,		-- Garrote
		[SpellName(29425)] = 4,		-- Gouge
		[SpellName(13005)] = 3,		-- Hammer of Justice (Baron Rafe Dreuger)
		[SpellName(29572)] = 3,		-- Mortal Strike (Lord Robin Daris)
	-- Maiden of Virtue
		[SpellName(29522)] = 3,		-- Holy Fire
		[SpellName(29511)] = 4,		-- Repentance
	-- Animal Bosses
	-- Hyakiss the Lurker
		[SpellName(29901)] = 3,		-- Acidic Fang
		[SpellName(29896)] = 4,		-- Hyakiss' Web
	-- Rokad the Ravager
		[SpellName(29906)] = 3,		-- Ravage
	-- Shadikith the Glider
		[SpellName(29903)] = 4,		-- Dive
		[SpellName(29904)] = 3,		-- Sonic Burst
	-- Opera Event
		-- Wizard of Oz
			-- [SpellName(31015)] = 3,		-- Annoying Yipping
			-- [SpellName(31013)] = 3,		-- Frightened Scream
			[SpellName(31042)] = 5,		-- Shred Armor
			[SpellName(31046)] = 4,		-- Brain Bash
		-- The Big Bad Wolf
			[SpellName(30753)] = 5,		-- Red Riding Hood
			[SpellName(30752)] = 3,		-- Terrifying Howl
			[SpellName(30761)] = 4,		-- Wide Swipe
		-- Romulo and Julianne
			[SpellName(30890)] = 3,		-- Blinding Passion
			[SpellName(30822)] = 4,		-- Poisoned Thrust
			[SpellName(30889)] = 5,		-- Powerful Attraction
	-- The Curator
	-- Shade of Aran
		[SpellName(29991)] = 5,		-- Chains of Ice
		[SpellName(29954)] = 3,		-- Frostbolt
		-- [SpellName(29963)] = 3,		-- Mass Polymorph
		[SpellName(30035)] = 4,		-- Mass Slow
		[SpellName(29990)] = 5,		-- Slow
	-- Terestian Illhoof
		[SpellName(30053)] = 3,		-- Amplify Flames
		[SpellName(30115)] = 4,		-- Sacrifice
	-- Netherspite
		[SpellName(37063)] = 3,		-- Void Zone
	-- Chess Event
	-- Prince Malchezaar
		[SpellName(39095)] = 3,		-- Amplify Damage
		[SpellName(30843)] = 5,		-- Enfeeble
		[SpellName(30854)] = 4,		-- Shadow Word: Pain (Tank)
		[SpellName(30898)] = 4,		-- Shadow Word: Pain (Raid)
		[SpellName(30901)] = 3,		-- Sunder Armor
	-- Nightbane
		[SpellName(36922)] = 5,		-- Bellowing Roar
		[SpellName(30129)] = 4,		-- Charred Earth
		[SpellName(30130)] = 3,		-- Distracting Ash
		[SpellName(37098)] = 5,		-- Rain of Bones
		[SpellName(30127)] = 4,		-- Searing Cinders
		[SpellName(30210)] = 3,		-- Smoldering Breath
		[SpellName(25653)] = 3,		-- Tail Sweep

-- Gruul's Lair
	-- Trash
		[SpellName(22884)] = 4,		-- Psychic Scream
	-- High King Maulgar
	-- Blindeye the Seer
	-- Kiggler the Crazed
		[SpellName(33175)] = 3,		-- Arcane Shock
		[SpellName(33173)] = 5,		-- Greater Polymorph
	-- Krosh Firehand
		[SpellName(33061)] = 3,		-- Blast Wave
	-- Olm the Summoner
		[SpellName(33129)] = 4,		-- Dark Decay
		[SpellName(33130)] = 5,		-- Death Coil
	-- High King Maulgar
		[SpellName(16508)] = 5,		-- Intimidating Roar
	-- Gruul the Dragonkiller
		[SpellName(36240)] = 4,		-- Cave In
		-- [SpellName(36297)] = 3,		-- Reverberation

-- Magtheridon's Lair
	-- Trash
		[SpellName(34437)] = 4,		-- Death Coil
		[SpellName(34435)] = 3,		-- Rain of Fire
		[SpellName(34439)] = 5,		-- Unstable Affliction
	-- Magtheridon
		[SpellName(30410)] = 3,		-- Shadow Grasp

-- Serpentshrine Cavern
	-- Trash
		[SpellName(38634)] = 3,		-- Arcane Lightning
		[SpellName(39032)] = 4,		-- Initial Infection
		[SpellName(38572)] = 3,		-- Mortal Cleave
		[SpellName(38635)] = 3,		-- Rain of Fire
		[SpellName(39042)] = 5,		-- Rampent Infection
		[SpellName(39044)] = 4,		-- Serpentshrine Parasite
		[SpellName(38591)] = 4,		-- Shatter Armor
		[SpellName(38491)] = 3,		-- Silence
	-- Hydross the Unstable
		[SpellName(38246)] = 3,		-- Vile Sludge
		[SpellName(38235)] = 4,		-- Water Tomb
	-- The Lurker Below
	-- Morogrim Tidewalker
		-- [SpellName(37730)] = 3,		-- Tidal Wave
		[SpellName(38049)] = 4,		-- Watery Grave
		[SpellName(37850)] = 4,		-- Watery Grave
	-- Fathom-Lord Karathress
		-- [SpellName(38517)] = 3,		-- Cyclone
		[SpellName(39261)] = 3,		-- Gusting Winds
		[SpellName(29436)] = 4,		-- Leeching Throw
	-- Leotheras the Blind
		-- Inner Demon
		-- Shadow of Leotheras
	-- Leotheras the Blind
		[SpellName(37675)] = 3,		-- Chaos Blast
		[SpellName(37749)] = 5,		-- Consuming Madness
		[SpellName(37676)] = 4,		-- Insidious Whisper
		[SpellName(37641)] = 3,		-- Whirlwind
	-- Lady Vashj
		[SpellName(38316)] = 3,		-- Entangle
		-- [SpellName(38262)] = 3,		-- Hamstring
		-- [SpellName(38258)] = 4,		-- Panic
		-- [SpellName(38253)] = 3,		-- Poison Bolt
		-- [SpellName(38509)] = 4,		-- Shock Blast
		[SpellName(38280)] = 5,		-- Static Charge

-- Tempest Keep: The Eye
	-- Trash
		[SpellName(37133)] = 4,		-- Arcane Buffet
		[SpellName(37132)] = 3,		-- Arcane Shock
		[SpellName(37122)] = 5,		-- Domination
		[SpellName(37135)] = 5,		-- Domination
		[SpellName(37120)] = 4,		-- Fragmentation Bomb
		[SpellName(13005)] = 3,		-- Hammer of Justice
		[SpellName(39077)] = 3,		-- Hammer of Justice
		[SpellName(37279)] = 3,		-- Rain of Fire
		[SpellName(37123)] = 4,		-- Saw Blade
		[SpellName(37118)] = 5,		-- Shell Shock
		[SpellName(37160)] = 3,		-- Silence
	-- Al'ar
		-- [SpellName(34121)] = 3,		-- Flame Buffet
		[SpellName(35410)] = 4,		-- Melt Armor
	-- Void Reaver
	-- High Astromancer Solarian
		-- [SpellName(33023)] = 3,		-- Mark of Solarian
		[SpellName(34322)] = 4,		-- Psychic Scream
		-- [SpellName(33045)] = 5,		-- Wrath of the Astromancer (DoT Patch 2.0.3 - 2.1.3)
		-- [SpellName(33044)] = 5,		-- Wrath of the Astromancer (-AR Debuff Patch 2.0.3 - 2.1.3)
		[SpellName(42783)] = 5,		-- Wrath of the Astromancer (Patch 2.2.0)
	-- Kael'thas Sunstrider
		-- Thaladred the Darkener
			[SpellName(36965)] = 4,		-- Rend
			[SpellName(30225)] = 4,		-- Silence
		-- Lord Sanguinar
			[SpellName(44863)] = 5,		-- Bellowing Roar
		-- Grand Astromancer Capernian
			-- [SpellName(36970)] = 3,		-- Arcane Burst
			[SpellName(37018)] = 4,		-- Conflagration
		-- Master Engineer Telonicus
			[SpellName(37027)] = 5,		-- Remote Toy
		-- Weapons
			-- [SpellName(36989)] = 3,		-- Frost Nova
			-- [SpellName(36990)] = 3,		-- Frostbolt
			[SpellName(36991)] = 4,		-- Rend
		-- Kael'thas Sunstrider
			-- [SpellName(36834)] = 3,		-- Arcane Disruption
			[SpellName(36797)] = 5,		-- Mind Control

-- The Battle for Mount Hyjal
	-- Trash
		-- [SpellName(31651)] = 3,		-- Banshee Curse
		[SpellName(31610)] = 5,		-- Knockdown
		[SpellName(28991)] = 4,		-- Web
	-- Rage Winterchill
		-- [SpellName(31257)] = 3,		-- Chilled
		[SpellName(31250)] = 4,		-- Frost Nova
		[SpellName(31249)] = 5,		-- Icebolt
	-- Anetheron
		[SpellName(31306)] = 5,		-- Carrion Swarm
		[SpellName(31298)] = 4,		-- Sleep
		[SpellName(31302)] = 3,		-- Inferno Effect
	-- Kaz'rogal
		-- [SpellName(31477)] = 4,		-- Cripple
		-- [SpellName(31447)] = 3,		-- Mark of Kaz'rogal
		-- [SpellName(31480)] = 5,		-- War Stomp
	-- Azgalor
		[SpellName(31347)] = 5,		-- Doom
		-- [SpellName(31344)] = 3,		-- Howl of Azgalor
		[SpellName(31340)] = 3,		-- Rain of Fire
		[SpellName(31341)] = 4,		-- Unquenchable Flames
	-- Archimonde
		[SpellName(31944)] = 4,		-- Doomfire
		[SpellName(31970)] = 3,		-- Fear
		[SpellName(31972)] = 5,		-- Grip of the Legion
		-- [SpellName(32053)] = 3,		-- Soul Charge (Silence)
		-- [SpellName(32054)] = 3,		-- Soul Charge (+50% Damage Taken)
		-- [SpellName(32057)] = 3,		-- Soul Charge (Nature DoT)

-- Black Temple
	-- Trash
		[SpellName(34654)] = 4,		-- Blind
		[SpellName(39674)] = 4,		-- Banish
		[SpellName(41150)] = 4,		-- Fear
		-- [SpellName(41274)] = 5,		-- Fel Stomp
		[SpellName(24698)] = 4,		-- Gouge
		[SpellName(40082)] = 3,		-- Hooked Net
		[SpellName(39544)] = 3,		-- Ignored
		[SpellName(39580)] = 3,		-- Lightning Cloud
		[SpellName(41338)] = 5,		-- Love Tap
		[SpellName(25646)] = 3,		-- Mortal Wound
		[SpellName(41334)] = 4,		-- Polymorph
		[SpellName(39671)] = 3,		-- Rain of Chaos
		[SpellName(41171)] = 5,		-- Skeleton Shot
		[SpellName(41197)] = 5,		-- Shield Bash
		[SpellName(41084)] = 3,		-- Silencing Shot
		[SpellName(41396)] = 4,		-- Sleep
		[SpellName(41168)] = 3,		-- Sonic Strike
		[SpellName(13444)] = 4,		-- Sunder Armor
		[SpellName(39584)] = 3,		-- Sweeping Wing Clip
		[SpellName(40864)] = 5,		-- Throbbing Stun
		[SpellName(41213)] = 5,		-- Throw Shield
		-- [SpellName(40936)] = 5,		-- War Stomp
	-- High Warlord Naj'entus
		[SpellName(39837)] = 3,		-- Impaling Spine
	-- Supremus
		-- [SpellName(41951)] = 4,		-- Fixate (Gaze Aura Not in TBC)
		[SpellName(40253)] = 3,		-- Molten Flame
	-- Shade of Akama
		[SpellName(42023)] = 3,		-- Rain of Fire
	-- Teron Gorefiend
		-- [SpellName(40327)] = 3,		-- Atrophy
		[SpellName(40243)] = 4,		-- Crushing Shadows
		[SpellName(40239)] = 5,		-- Incinerate
		[SpellName(40251)] = 3,		-- Shadow of Death
	-- Gurtogg Bloodboil
		[SpellName(40481)] = 5,		-- Acidic Wound
		[SpellName(40599)] = 4,		-- Arcing Smash
		[SpellName(40491)] = 6,		-- Bewildering Strike
		[SpellName(42005)] = 3,		-- Bloodboil
		[SpellName(40508)] = 4,		-- Fel-Acid Breath
		[SpellName(40604)] = 5,		-- Fel Rage
		-- [SpellName(40618)] = 3,		-- Insignificance
	-- Reliquary of Souls
		[SpellName(41303)] = 4,		-- Soul Drain
		[SpellName(41410)] = 4,		-- Deaden
		[SpellName(41426)] = 3,		-- Spirit Shock
		[SpellName(41294)] = 3,		-- Fixate
		[SpellName(41376)] = 4,		-- Spite
	-- Mother Shahraz
		[SpellName(41001)] = 5,		-- Fatal Attraction
		[SpellName(40823)] = 3,		-- Interrupting Shriek
		[SpellName(40860)] = 4,		-- Vile Beam
	-- llidari Council
		-- Gathios the Shatterer
			[SpellName(41541)] = 3,		-- Consecration
			[SpellName(41468)] = 4,		-- Hammer of Justice
			[SpellName(41461)] = 5,		-- Judgement of Blood
		-- High Nethermancer Zerevor
			[SpellName(41482)] = 3,		-- Blizzard
			[SpellName(41481)] = 4,		-- Flamestrike
		-- Lady Malande
			[SpellName(41472)] = 5,		-- Divine Wrath
		-- Veras Darkshadow
			[SpellName(41485)] = 5,		-- Deadly Poison
	-- Illidan Stormrage
		[SpellName(40932)] = 6,		-- Agonizing Flames
		[SpellName(41142)] = 3,		-- Aura of Dread
		[SpellName(40585)] = 5,		-- Dark Barrage
		[SpellName(41914)] = 4,		-- Parasitic Shadowfiend
		-- [SpellName(41917)] = 4,		-- Parasitic Shadowfiend (Secondary)
		-- [SpellName(40647)] = 3,		-- Shadow Prison
		[SpellName(41032)] = 5,		-- Shear

-- Zul'Aman
	-- Trash
	-- Nalorakk
		[SpellName(42398)] = 3,		-- Mangle
	-- Akil'zon
		[SpellName(43657)] = 3,		-- Electrical Storm
		[SpellName(43622)] = 3,		-- Static Distruption
	-- Jan'alai
		[SpellName(43299)] = 3,		-- Flame Buffet
	-- Halazzi
		[SpellName(43303)] = 3,		-- Flame Shock
	-- Hex Lord Malacrass
		[SpellName(43613)] = 3,		-- Cold Stare
		[SpellName(43501)] = 3,		-- Siphon Soul
	-- Zul'jin
		[SpellName(43093)] = 3,		-- Throw
		[SpellName(43095)] = 3,		-- Paralyze
		[SpellName(43150)] = 3,		-- Rage

-- Sunwell Plateau
	-- Trash
		[SpellName(46561)] = 3,		-- Fear
		[SpellName(46562)] = 3,		-- Mind Flay
		[SpellName(46266)] = 3,		-- Burn Mana
		[SpellName(46557)] = 3,		-- Slaying Shot
		[SpellName(46560)] = 3,		-- Shadow Word: Pain
		[SpellName(46543)] = 3,		-- Ignite Mana
		[SpellName(46427)] = 3,		-- Domination
	-- Kalecgos
		-- Kalecgos
			[SpellName(45018)] = 3,		-- Arcane Buffet
		-- Sathrovarr the Corruptor
			[SpellName(45032)] = 3,		-- Curse of Boundless Agony
	-- Brutallus
		[SpellName(46394)] = 4,		-- Burn
		[SpellName(45150)] = 3,		-- Meteor Slash
		[SpellName(45185)] = 5,		-- Stomp
	-- Felmyst
		-- Unyielding Dead
		-- Felmyst
			[SpellName(45855)] = 3,		-- Gas Nova
			[SpellName(45662)] = 5,		-- Encapsulate (No Combat Log Event)
			[SpellName(45402)] = 3,		-- Demonic Vapor
			[SpellName(45717)] = 4,		-- Fog of Corruption (Unit is Hostile in Combat Log Event)
	-- Eredar Twins
		[SpellName(45256)] = 4,		-- Confounding Blow
		[SpellName(45333)] = 4,		-- Conflagration
		[SpellName(46771)] = 4,		-- Flame Sear
		[SpellName(45270)] = 3,		-- Shadowfury
		[SpellName(45347)] = 3,		-- Dark Touched
		[SpellName(45348)] = 3,		-- Fire Touched
		-- Lady Sacrolash
		-- Grand Warlock Alythess
	-- M'uru
		[SpellName(45996)] = 3,		-- Darkness
		-- M'uru
		-- Entropius
	-- Kil'jaeden
		[SpellName(45442)] = 3,		-- Soul Flay
		[SpellName(45641)] = 4,		-- Fire Bloom
		[SpellName(45885)] = 3,		-- Shadow Spike
		[SpellName(45737)] = 3,		-- Flame Dart

-----------------------------------------------------------------
-- The Burning Crusade Dungeons
-----------------------------------------------------------------
-- Auchenai Crypts
	-- Shirrak the Dead Watcher
	-- Exarch Maladaar

-- Blood Furnace
	-- The Maker
	-- Broggok
	-- Keli'dan the Breaker

-- Escape from Durnholde Keep
	-- Lieutenant Drake
	-- Captain Skarloc
	-- Epoch Hunter

-- Hellfire Ramparts
	-- Watchkeeper Gargolmar
	-- Omor the Unscarred
	-- Nazan & Vazruden

-- Mana-Tombs
	-- Pandemonius
	-- Tavarok
	-- Nexus-Prince Shaffar
	-- Yor

-- Opening of the Dark Portal
	-- Chrono Lord Deja
	-- Temporus
	-- Aeonus

-- Sethekk Halls
	-- Darkweaver Syth
	-- Anzu
	-- Talon King Ikiss

-- Shadow Labyrinth
	-- Ambassador Hellmaw
	-- Blackheart the Inciter
	-- Grandmaster Vorpil
	-- Murmur

-- Shattered Halls
	-- Grand Warlock Nethekurse
	-- Blood Guard Porung
	-- Warbringer O'mrogg
	-- Warchief Kargath Bladefist

-- Slave Pens
	-- Mennu the Betrayer
	-- Rokmar the Crackler
	-- Quagmirran

-- The Arcatraz
	-- Zereketh the Unbound
	-- Dalliah the Doomsayer
	-- Wrath-Scryer Soccothrates
	-- Harbinger Skyriss

-- The Botanica
	-- Commander Sarannis
	-- High Botanist Freywinn
	-- Thorngrin the Tender
	-- Laj
	-- Warp Splinter

-- The Mechanar
	-- Gatewatcher Gyro-Kill
	-- Gatewatcher Iron-Hand
	-- Mechano-Lord Capacitus
	-- Nethermancer Sepethrea
	-- Pathaleon the Calculator

-- The Steamvault
	-- Hydromancer Thespia
	-- Mekgineer Steamrigger
	-- Warlord Kalithresh

-- Underbog
	-- Hungarfen, Ghaz'an
	-- Swamplord Musel'ek
	-- The Black Stalker

-- Magisters' Terrace
	-- Selin Fireheart
	-- Vexallus
	-- Priestess Delrissa
	-- Priestess Delrissa
	-- Kagani Nightstrike
	-- Ellrys Duskhallow
	-- Eramas Brightblaze
	-- Yazzai
	-- Warlord Salaris
	-- Garaxxas
	-- Apoko
	-- Zelfan
	-- Kael'thas Sunstrider

-----------------------------------------------------------------
-- Wrath of the Lich King Raid
-----------------------------------------------------------------
-- Vault of Archavon
	-- Trash
		[SpellName(72120)] = 3,		-- Frostbite
		[SpellName(60919)] = 3,		-- Rock Shower
		[SpellName(60897)] = 4,		-- Shield Crush
	-- Archavon the Stone Watcher
		[SpellName(58965)] = 3,		-- Choking Cloud
		[SpellName(58663)] = 4,		-- Stomp
	-- Emalon the Storm Watcher
	-- Koralon the Flame Watcher
		[SpellName(66665)] = 3,		-- Burning Breath
		[SpellName(66684)] = 3,		-- Flaming Cinder
	-- Toravon the Ice Watcher
		[SpellName(72004)] = 3,		-- Frostbite
		[SpellName(72034)] = 4,		-- Whiteout

-- Naxxramas
	-- Trash
		[SpellName(29325)] = 3,		-- Acid Volley
		[SpellName(33661)] = 3,		-- Crush Armor
		[SpellName(29849)] = 3,		-- Frost Nova
		[SpellName(30094)] = 3,		-- Frost Nova
		[SpellName(29407)] = 3,		-- Mind Flay
		[SpellName(54339)] = 3,		-- Mind Flay
		[SpellName(16856)] = 3,		-- Mortal Strike
		[SpellName(28467)] = 3,		-- Mortal Wound
		[SpellName(55318)] = 3,		-- Pierce Armor
		[SpellName(29848)] = 3,		-- Polymorph
		[SpellName(55314)] = 3,		-- Strangulate
		[SpellName(53803)] = 3,		-- Veil of Shadow
		[SpellName(27758)] = 3,		-- War Stomp
	-- Anub'Rekhan
		[SpellName(54022)] = 3,		-- Locust Swarm
	-- Faerlina
		[SpellName(28796)] = 3,		-- Poison Bolt Volley
		[SpellName(39024)] = 5,		-- Rain of Fire
		[SpellName(54093)] = 4,		-- Silence
	-- Maexxna
		[SpellName(28776)] = 3,		-- Necrotic Poison
		[SpellName(28622)] = 3,		-- Web Wrap
		-- [SpellName(29484)] = 3,		-- Web Spray
	-- Patchwerk
	-- Grobbulus
		[SpellName(28169)] = 4,		-- Mutating Injection
		[SpellName(28137)] = 3,		-- Slime Stream
	-- Gluth
		[SpellName(29306)] = 3,		-- Infected Wound
		[SpellName(54378)] = 4,		-- Mortal Wound
	-- Thaddius
		-- [SpellName(28084)] = 3,		-- Negative Charge
		-- [SpellName(28059)] = 3,		-- Positive Charge
	-- Noth
		[SpellName(29212)] = 3,		-- Cripple
		[SpellName(29213)] = 4,		-- Curse of the Plaguebringer
		[SpellName(32736)] = 3,		-- Mortal Strike
		[SpellName(29214)] = 5,		-- Wrath of the Plaguebringer
	-- Heigan
		[SpellName(29998)] = 4,		-- Decrepit Fever
		[SpellName(29310)] = 3,		-- Spell Disruption
	-- Loatheb
		[SpellName(29865)] = 3,		-- Deathbloom
		[SpellName(29204)] = 4,		-- Inevitable Doom
		-- [SpellName(55593)] = 3,		-- Necrotic Aura
	-- Razuvious
		[SpellName(55470)] = 3,		-- Unbalancing Strike
	-- Gothik
		[SpellName(27994)] = 4,		-- Drain Life
		[SpellName(27990)] = 3,		-- Fear
		-- [SpellName(28679)] = 3,		-- Harvest Soul
		[SpellName(27825)] = 5,		-- Shadow Mark
	-- Four Horsemen
		-- Baron Rivendare
			-- [SpellName(28834)] = 3,		-- Mark of Rivendare
			[SpellName(28882)] = 3,		-- Unholy Shadow
		-- Lady Blaumeux
			-- [SpellName(28833)] = 3,		-- Mark of Blaumeux
		-- Sir Zeliek
			-- [SpellName(28835)] = 3,		-- Mark of Zeliek
		-- Thane Korth'azz
			-- [SpellName(28832)] = 3,		-- Mark of Korth'azz
	-- Sapphiron
		[SpellName(28522)] = 4,		-- Icebolt
		[SpellName(28542)] = 3,		-- Life Drain
	-- Kel'Thuzad
		[SpellName(28410)] = 3,		-- Chains of Kel'Thuzad
		[SpellName(27819)] = 3,		-- Detonate Mana
		[SpellName(27808)] = 4,		-- Frost Blast

-- The Obsidian Sanctum
	-- Trash
		[SpellName(58948)] = 5,		-- Curse of Mending
		[SpellName(60708)] = 3,		-- Fade Armor
		[SpellName(39529)] = 3,		-- Flame Shock
		-- [SpellName(57759)] = 3,		-- Hammer Drop
		[SpellName(13737)] = 4,		-- Mortal Strike
		[SpellName(57757)] = 5,		-- Rain of Fire
	-- Twilight Drakes
		-- Tenebron
		-- Shadron
		-- Vesperon
	-- Sartharion
		[SpellName(57557)] = 3,		-- Pyrobuffet
		[SpellName(56910)] = 4,		-- Tail Lash

-- Eye of Eternity
	-- Malygos
		[SpellName(56272)] = 3,		-- Arcane Breath

-- Ulduar
	-- Trash
		[SpellName(64638)] = 3,		-- Acidic Bite
		-- [SpellName(64663)] = 3,		-- Arcane Burst
		[SpellName(64653)] = 3,		-- Blizzard
		[SpellName(65105)] = 4,		-- Compacted
		[SpellName(64781)] = 4,		-- Charged Leap
		-- [SpellName(64655)] = 3,		-- Cone of Cold
		[SpellName(65104)] = 3,		-- Cut Scrap Metal
		[SpellName(63755)] = 3,		-- Deadly Poison
		[SpellName(64942)] = 4,		-- Devastating Leap
		[SpellName(63713)] = 4,		-- Dominate Mind
		[SpellName(64160)] = 3,		-- Drain Life
		-- [SpellName(64697)] = 3,		-- Earthquake
		[SpellName(64740)] = 3,		-- Energy Sap
		[SpellName(63775)] = 3,		-- Flamestrike
		[SpellName(64649)] = 3,		-- Freezing Breath
		-- [SpellName(63913)] = 3,		-- Frostbolt
		-- [SpellName(63758)] = 3,		-- Frostbolt Volley
		[SpellName(63912)] = 3,		-- Frost Nova
		[SpellName(63550)] = 3,		-- Guardian's Lash
		-- [SpellName(62845)] = 3,		-- Hamstring
		[SpellName(63272)] = 3,		-- Hurricane
		[SpellName(63673)] = 4,		-- Lightning Brand
		[SpellName(63568)] = 3,		-- Living Tsunami
		[SpellName(64699)] = 3,		-- Magma Splash
		[SpellName(63551)] = 3,		-- Poison Breath
		[SpellName(13704)] = 3,		-- Psychic Scream
		[SpellName(63615)] = 4,		-- Ravage Armor
		-- [SpellName(64967)] = 3,		-- Rune Punch
		[SpellName(64847)] = 3,		-- Runed Flame Jets
		[SpellName(64988)] = 3,		-- Runed Flame Jets
		[SpellName(65102)] = 3,		-- Sawblades
		[SpellName(64654)] = 3,		-- Snow Blindness
		[SpellName(50370)] = 3,		-- Sunder Armor
		-- [SpellName(63757)] = 3,		-- Thunderclap
		[SpellName(64919)] = 3,		-- Ice Nova
		[SpellName(64698)] = 3,		-- Pyroblast
		[SpellName(62526)] = 4,		-- Rune Detonation
		[SpellName(64705)] = 4,		-- Unquenchable Flames
	-- Flame Leviathon
		[SpellName(62376)] = 3,		-- Battering Ram
		[SpellName(62374)] = 4,		-- Pursued
	-- Ignis the Furnace Master
		-- [SpellName(62680)] = 3,		-- Flame Jets
		[SpellName(62717)] = 4,		-- Slag Pot
	-- Razorscale
		[SpellName(64016)] = 4,		-- Flame Buffet
		[SpellName(64771)] = 5,		-- Fuse Armor
		[SpellName(64757)] = 3,		-- Stormstrike
	-- XT-002 Deconstructor
		-- [SpellName(62775)] = 3,		-- Tympanic Tantrum
		[SpellName(63018)] = 4,		-- Searing Light
		[SpellName(63024)] = 5,		-- Gravity Bomb
	-- Assembly of Iron
		-- Stormcaller Brundir
			[SpellName(61886)] = 3,		-- Lightning Tendrils
			[SpellName(61878)] = 4,		-- Overload
		-- Runemaster Molgeim
			[SpellName(62269)] = 3,		-- Rune of Death
		-- Steelbreaker
			[SpellName(61903)] = 5,		-- Fusion Punch
			[SpellName(61888)] = 4,		-- Overwhelming Power
			[SpellName(44008)] = 3,		-- Static Disruption
	-- Kologarn
		-- [SpellName(62055)] = 3,		-- Brittle Skin
		[SpellName(63355)] = 4,		-- Crunch Armor
		-- [SpellName(62030)] = 3,		-- Petrifying Breath
		[SpellName(64290)] = 5,		-- Stone Grip
		[SpellName(63978)] = 3,		-- Stone Nova
	-- Auriaya
		[SpellName(64669)] = 5,		-- Feral Pounce
		[SpellName(64496)] = 3,		-- Feral Rush
		[SpellName(64396)] = 5,		-- Guardian Swarm
		[SpellName(64667)] = 3,		-- Rip Flesh
		[SpellName(64666)] = 4,		-- Savage Pounce
		[SpellName(64389)] = 3,		-- Sentinel Blast
		-- [SpellName(64386)] = 4,		-- Terrifying Screech
	-- Freya
		-- Elder Brightleaf
			[SpellName(62243)] = 3,		-- Unstable Sun Beam
		-- Elder Ironbranch
			[SpellName(62310)] = 3,		-- Impale
			[SpellName(62438)] = 4,		-- Iron Roots
		-- Elder Stonebark
			[SpellName(62354)] = 4,		-- Broken Bones
		-- Freya
			-- [SpellName(62532)] = 3,		-- Conservator's Grip
			[SpellName(62283)] = 4,		-- Iron Roots
			[SpellName(63571)] = 3,		-- Nature's Fury
			-- [SpellName(62619)] = 3,		-- Pheromones
	-- Hodir
		[SpellName(62039)] = 3,		-- Biting Cold
		[SpellName(61969)] = 5,		-- Flash Freeze
		[SpellName(62469)] = 4,		-- Freeze
	-- Mimiron
		-- Leviathon Mk II
			[SpellName(63666)] = 3,		-- Napalm Shell
		-- VX-001
			-- [SpellName(65192)] = 3,		-- Flame Suppressant
			[SpellName(64533)] = 3,		-- Heat Wave
		-- Aerial Command Unit
			[SpellName(64616)] = 3,		-- Deafening Siren
			[SpellName(64668)] = 4,		-- Magnetic Field
	-- Thorim
		[SpellName(62415)] = 3,		-- Acid Breath
		[SpellName(62318)] = 3,		-- Barbed Shot
		[SpellName(62576)] = 3,		-- Blizzard
		[SpellName(32323)] = 3,		-- Charge
		[SpellName(64971)] = 3,		-- Electro Shock
		-- [SpellName(62601)] = 3,		-- Frostbolt
		-- [SpellName(62604)] = 3,		-- Frostbolt Volley
		[SpellName(62605)] = 3,		-- Frost Nova
		[SpellName(64970)] = 3,		-- Fuse Lightning
		-- [SpellName(48639)] = 3,		-- Hamstring
		[SpellName(62418)] = 5,		-- Impale
		-- [SpellName(62326)] = 3,		-- Low Blow
		[SpellName(35054)] = 3,		-- Mortal Strike
		[SpellName(62420)] = 4,		-- Shield Smash
		[SpellName(62042)] = 4,		-- Stormhammer
		[SpellName(57807)] = 3,		-- Sunder Armor
		[SpellName(62417)] = 3,		-- Sweep
		[SpellName(62130)] = 5,		-- Unbalancing Strike
		[SpellName(64151)] = 4,		-- Whirling Trip
		[SpellName(40652)] = 3,		-- Wing Clip
	-- General Vezax
		-- [SpellName(62692)] = 3,		-- Aura of Despair
		[SpellName(63276)] = 4,		-- Mark of the Faceless
		[SpellName(63420)] = 3,		-- Profound Darkness
		-- [SpellName(62661)] = 3,		-- Searing Flames
	-- Yogg-Saron
		-- [SpellName(64156)] = 3,		-- Apathy
		-- [SpellName(64153)] = 3,		-- Black Plague
		[SpellName(63802)] = 4,		-- Brain Link
		[SpellName(64157)] = 4,		-- Curse of Doom
		-- [SpellName(63038)] = 3,		-- Dark Volley
		-- [SpellName(64189)] = 3,		-- Deafening Roar
		-- [SpellName(64145)] = 3,		-- Diminish Power
		-- [SpellName(64152)] = 3,		-- Draining Poison
		[SpellName(63830)] = 3,		-- Malady of the Mind
		-- [SpellName(63050)] = 3,		-- Sanity
		[SpellName(63138)] = 4,		-- Sara's Fervor
		[SpellName(63134)] = 5,		-- Sara's Blessing
		[SpellName(64125)] = 5,		-- Squeeze
	-- Algalon the Observer
		[SpellName(64412)] = 3,		-- Phase Punch
		-- [SpellName(64417)] = 3,		-- Phase Punch

-- Trial of the Crusader
	-- The Northrend Beasts
		-- Gormok the Impaler
			[SpellName(66331)] = 5,		-- Impale
			[SpellName(66406)] = 4,		-- Snobolled!
			[SpellName(66407)] = 3,		-- Head Crack
		-- Acidmaw & Dreadscale
			[SpellName(66869)] = 3,		-- Burning Bile
			[SpellName(66823)] = 3,		-- Paralytic Toxin
		-- Icehowl
			[SpellName(66689)] = 3,		-- Arctic Breath
			[SpellName(66770)] = 4,		-- Ferocious Butt
			-- [SpellName(66683)] = 3,		-- Massive Crash
	-- Lord Jaraxxus
		[SpellName(66242)] = 4,		-- Burning Inferno
		[SpellName(66532)] = 3,		-- Fel Fireball
		[SpellName(66237)] = 5,		-- Incinerate Flesh
		[SpellName(66197)] = 3,		-- Legion Flame
	-- Faction Champions
	-- Twin Val'kyr
		-- [SpellName(65724)] = 3,		-- Empowered Darkness
		-- [SpellName(65748)] = 3,		-- Empowered Light
		-- [SpellName(67590)] = 3,		-- Powering Up
		-- [SpellName(66001)] = 4,		-- Touch of Darkness
		-- [SpellName(65950)] = 4,		-- Touch of Light
		-- [SpellName(66069)] = 5,		-- Twin Spike (Dark)
		-- [SpellName(66075)] = 5,		-- Twin Spike (Light)
	-- Anub'arak
		[SpellName(65775)] = 3,		-- Acid-Drenched Mandibles
		[SpellName(67721)] = 4,		-- Expose Weakness
		[SpellName(66012)] = 5,		-- Freezing Slash
		-- [SpellName(66118)] = 3,		-- Leeching Swarm
		-- [SpellName(66013)] = 3,		-- Penetrating Cold
		-- [SpellName(66193)] = 3,		-- Permafrost
		[SpellName(67574)] = 6,		-- Pursued by Anub'arak

-- Icecrown Citadel
	-- Trash
	-- Lord Marrowgar
	-- Lady Deathwhisper
	-- Gunship Battle
	-- Deathbringer Saurfang
	-- Blood Prince Council
	-- Blood-Queen Lana'thel
	-- Valithria Dreamwalker
	-- Sindragosa
	-- The Lich King

-- The Ruby Sanctum
	-- Trash
	-- Halion's Lieutenants
		-- Baltharus the Warborn
		-- General Zarithrian
		-- Saviana Ragefire
	-- Halion

-----------------------------------------------------------------
-- Wrath of the Lich King Dungeons
-----------------------------------------------------------------
-- Utgarde Keep
	-- Prince Keleseth
	-- Skarvald the Constructor / Dalronn the Controller
	-- Ingvar the Plunderer

-- The Nexus
	-- Grand Magus Telestra
	-- Commander Stoutbeard
	-- Commander Kolurg
	-- Anomalus
	-- Ormorok the Tree-Shaper
	-- Keristrasza

-- Azjol-Nerub
	-- Krik'thir the Gatewatcher
	-- Hadronox
	-- Anub'arak

-- Ahn'kahet: The Old Kingdom
	-- Elder Nadox
	-- Prince Taldaram
	-- Amanitar
	-- Jedoga Shadowseeker
	-- Herald Volazj

-- Drak'Tharon Keep
	-- Trollgore
	-- Novos the Summoner
	-- King Dred
	-- The Prophet Tharon'ja

-- The Violet Hold
	-- Erekem
	-- Moragg
	-- Ichoron
	-- Xevozz
	-- Lavanthor
	-- Zuramat the Obliterator
	-- Cyanigosa

-- Gundrak
	-- Slad'ran
	-- Anzu
	-- Drakkari Colossus / Drakkari Elemental
	-- Moorabi
	-- Eck the Ferocious
	-- Gal'darah

-- Halls of Stone
	-- Maiden of Grief
	-- Krystallus
	-- Tribunal of the Ages
	-- Sjonnir The Ironshaper

-- Halls of Lightning
	-- General Bjarngrim
	-- Volkhan
	-- Ionar
	-- Loken

-- The Culling of Stratholme
	-- Meathook
	-- Salramm the Fleshcrafter
	-- Chrono-Lord Epoch
	-- Infinite Corruptor
	-- Mal'Ganis

-- The Oculus
	-- Drakos the Interrogator
	-- Varos Cloudstrider
	-- Mage-Lord Urom
	-- Ley-Guardian Eregos

-- Utgarde Pinnacle
	-- Svala Sorrowgrave
	-- Gortok Palehoof
	-- Skadi the Ruthless
	-- King Ymiron

-- Trial of the Champion
	-- Grand Champions
	-- Eadric / Paletress
	-- The Black Knight

-- The Forge of Souls
	-- Bronjahm
	-- Devourer of Souls

-- Pit of Saron
	-- Forgemaster Garfrost
	-- Ick & Krick
	-- Scourgelord Tyrannus

-- Halls of Reflection
	-- Falric
	-- Marwyn
	-- Wrath of the Lich King

-----------------------------------------------------------------
-- Other
-----------------------------------------------------------------

}

-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
if C.raidframe.plugins_pvp_debuffs == true then
	local PvPDebuffs = {
		-- Death Knight
		[SpellName(53534)] = 2,		-- Chains of Ice
		[SpellName(47481)] = 3,		-- Gnaw (Ghoul)
		[SpellName(49203)] = 3,		-- Hungering Cold
		[SpellName(47476)] = 3,		-- Strangulate
		-- Druid
		[SpellName(5211)] = 3,		-- Bash
		[SpellName(16922)] = 3,		-- Celestial Focus
		[SpellName(33786)] = 3,		-- Cyclone
		[SpellName(339)] = 2,		-- Entangling Roots
		[SpellName(19975)] = 2,		-- Entangling Roots (Nature's Grasp)
		[SpellName(16979)] = 2,		-- Feral Charge - Bear
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(22570)] = 3,		-- Maim
		[SpellName(9005)] = 3,		-- Pounce
		-- Hunter
		[SpellName(53359)] = 2,		-- Chimera Shot - Scorpid
		[SpellName(19306)] = 2,		-- Counterattack
		[SpellName(19185)] = 2,		-- Entrapment
		[SpellName(60210)] = 3,		-- Freezing Arrow Effect
		[SpellName(3355)] = 3,		-- Freezing Trap Effect
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(24394)] = 3,		-- Intimidation
		[SpellName(19503)] = 3,		-- Scatter Shot
		[SpellName(34490)] = 3,		-- Silencing Shot
		[SpellName(4167)] = 2,		-- Web (Pet)
		[SpellName(19386)] = 3,		-- Wyvern Sting
		-- Mage
		[SpellName(31661)] = 3,		-- Dragon's Breath
		[SpellName(64346)] = 3,		-- Fiery Payback
		[SpellName(33395)] = 2,		-- Freeze (Water Elemental)
		[SpellName(12494)] = 2,		-- Frostbite
		[SpellName(122)] = 2,		-- Frost Nova
		[SpellName(12355)] = 3,		-- Impact
		[SpellName(118)] = 3,		-- Polymorph
		[SpellName(61305)] = 3,		-- Polymorph: Black Cat
		[SpellName(28272)] = 3,		-- Polymorph: Pig
		[SpellName(61721)] = 3,		-- Polymorph: Rabbit
		[SpellName(61025)] = 3,		-- Polymorph: Serpent
		[SpellName(61780)] = 3,		-- Polymorph: Turkey
		[SpellName(28271)] = 3,		-- Polymorph: Turtle
		[SpellName(59634)] = 3,		-- Polymorph - Penguin
		[SpellName(18469)] = 3,		-- Silenced - Improved Counterspell
		-- Paladin
		[SpellName(853)] = 3,		-- Hammer of Justice
		[SpellName(20066)] = 3,		-- Repentance
		[SpellName(63529)] = 3,		-- Silenced - Shield of the Templar
		[SpellName(20170)] = 3,		-- Stun (Seal of Justice Proc)
		[SpellName(10326)] = 3,		-- Turn Evil
		-- Priest
		[SpellName(605)] = 3,		-- Mind Control
		[SpellName(64044)] = 3,		-- Psychic Horror
		[SpellName(8122)] = 3,		-- Psychic Scream
		[SpellName(9484)] = 3,		-- Shackle Undead
		[SpellName(15487)] = 3,		-- Silence
		-- Rogue
		[SpellName(2094)] = 3,		-- Blind
		[SpellName(1833)] = 3,		-- Cheap Shot
		[SpellName(32747)] = 3,		-- Deadly Throw Interrupt
		[SpellName(51722)] = 3,		-- Dismantle
		[SpellName(1330)] = 3,		-- Garrote - Silence
		[SpellName(1776)] = 3,		-- Gouge
		[SpellName(408)] = 3,		-- Kidney Shot
		[SpellName(6770)] = 3,		-- Sap
		[SpellName(18425)] = 3,		-- Silenced - Improved Kick
		-- Shaman
		[SpellName(58861)] = 3,		-- Bash (Spirit Wolf)
		[SpellName(51514)] = 3,		-- Hex
		[SpellName(39796)] = 3,		-- Stoneclaw Totem
		-- Warlock
		[SpellName(6789)] = 3,		-- Death Coil
		[SpellName(60995)] = 3,		-- Demon Charge (Metamorphosis)
		[SpellName(5782)] = 3,		-- Fear
		[SpellName(5484)] = 3,		-- Howl of Terror
		[SpellName(30153)] = 3,		-- Intercept Stun (Felguard)
		[SpellName(6358)] = 3,		-- Seduction (Succubus)
		[SpellName(30283)] = 3,		-- Shadowfury
		[SpellName(24259)] = 3,		-- Spell Lock (Felhunter)
		-- Warrior
		[SpellName(7922)] = 3,		-- Charge Stun
		[SpellName(12809)] = 3,		-- Concussion Blow
		[SpellName(676)] = 3,		-- Disarm
		[SpellName(58373)] = 2,		-- Glyph of Hamstring
		[SpellName(23694)] = 2,		-- Improved Hamstring
		[SpellName(5246)] = 3,		-- Intimidating Shout
		[SpellName(20253)] = 3,		-- Intercept Stun
		[SpellName(12798)] = 3,		-- Revenge Stun
		[SpellName(46968)] = 3,		-- Shockwave
		[SpellName(18498)] = 3,		-- Silenced - Gag Order
		-- Racial
		[SpellName(28730)] = 3,		-- Arcane Torrent
		[SpellName(20549)] = 3,		-- War Stomp
	}

	for spell, prio in pairs(PvPDebuffs) do
		T.RaidDebuffs[spell] = prio
	end
end

T.RaidDebuffsReverse = {
	--[spellID] = true,			-- Spell name
}

T.RaidDebuffsIgnore = {
	--[spellID] = true,			-- Spell name
}

for _, spell in pairs(C.raidframe.plugins_aura_watch_list) do
	T.RaidDebuffs[SpellName(spell)] = 3
end