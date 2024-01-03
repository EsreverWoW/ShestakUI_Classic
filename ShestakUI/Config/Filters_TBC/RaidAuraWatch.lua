local T, C, L = unpack(ShestakUI)
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
		-- {48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		-- {102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		-- {155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	HUNTER = {
		{34477, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
	},
	PALADIN = {
															-- Lay on Hands (Armor Bonus)
		-- {53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		-- {114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		-- {53601, "TOPLEFT", {0.4, 0.7, 0.2}, true},			-- Sacred Shield
	},
	PRIEST = {
															-- Abolish Disease (move to all?)
															-- Fear Ward
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{10060, "RIGHT", {0.89, 0.1, 0.1}},					-- Power Infusion
	},
	SHAMAN = {
		{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},			-- Earth Shield
		{29203, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Healing Way (Change Color?)
		{16177, "TOPLEFT", {0.4, 0.7, 0.2}},				-- Ancestral Fortitude
	},
	WARRIOR = {
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
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
		print("|cffff0000ShestakUI: spell ID ["..tostring(id).."] no longer exists!|r")
		return "Empty"
	end
end

T.RaidDebuffs = {
-----------------------------------------------------------------
-- Racials
-----------------------------------------------------------------
	[SpellName(23230)] = 1,		-- Blood Fury

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
		[SpellName(19703)] = 3,		-- Lucifron's Curse
	-- Magmadar
		[SpellName(19408)] = 3,		-- Panic
	-- Gehennas
		[SpellName(20277)] = 4,		-- Fist of Ragnaros
		[SpellName(19716)] = 3,		-- Gehennas' Curse
		[SpellName(19717)] = 5,		-- Rain of Fire
	-- Garr
	-- Shazzrah
		[SpellName(19713)] = 3,		-- Shazzrah's Curse
	-- Baron Geddon
		[SpellName(19659)] = 3,		-- Ignite Mana
		[SpellName(19695)] = 3,		-- Inferno
		[SpellName(20475)] = 3,		-- Living Bomb
	-- Golemagg
		[SpellName(13880)] = 3,		-- Magma Splash
	-- Sulfuron
		[SpellName(19780)] = 3,		-- Hand of Ragnaros
	-- Majordomo
	-- Ragnaros

	-- Onyxia's Lair (40)
		-- Onyxia
			[SpellName(18431)] = 3,		-- Bellowing Roar

-- Blackwing Lair (40)
	-- Trash
		[SpellName(22274)] = 3,		-- Greater Polymorph
	-- Razorgore
		-- [SpellName(23023)] = 3,		-- Conflagration
		[SpellName(24375)] = 3,		-- War Stomp
	-- Vaelastrasz
		[SpellName(18173)] = 4,		-- Burning Adrenaline
		-- [SpellName(23461)] = 3,		-- Flame Breath
	-- Broodlord
		[SpellName(24573)] = 3,		-- Mortal Strike
	-- Firemaw
		[SpellName(23341)] = 3,		-- Flame Buffet
		-- [SpellName(22682)] = 3,		-- Shadow Flame
	-- Ebonroc
		-- [SpellName(22682)] = 3,		-- Shadow Flame
		[SpellName(23340)] = 3,		-- Shadow of Ebonroc
	-- Flamegor
		-- [SpellName(22682)] = 3,		-- Shadow Flame
	-- Chromaggus
		[SpellName(23154)] = 3,		-- Brood Affliction: Black
		[SpellName(23153)] = 3,		-- Brood Affliction: Blue
		[SpellName(23170)] = 5,		-- Brood Affliction: Bronze
		[SpellName(23169)] = 3,		-- Brood Affliction: Green
		[SpellName(23155)] = 3,		-- Brood Affliction: Red
		[SpellName(23313)] = 4,		-- Corrosive Acid
		-- [SpellName(23189)] = 4,		-- Frost Burn
		-- [SpellName(23315)] = 4,		-- Ignite Flesh
		-- [SpellName(23312)] = 4,		-- Time Lapse
	-- Nefarian
		[SpellName(22686)] = 3,		-- Bellowing Roar
		[SpellName(23414)] = 4,		-- Paralyze
		-- [SpellName(22682)] = 3,		-- Shadow Flame
		[SpellName(23364)] = 4,		-- Tail Lash
		[SpellName(22687)] = 5,		-- Veil of Shadow
		[SpellName(23603)] = 3,		-- Wild Polymorph

-- Zul'Gurub (20)
	-- Trash
	-- Jeklik
		[SpellName(22884)] = 3,		-- Psychic Scream
		[SpellName(23952)] = 3,		-- Shadow Word: Pain
		[SpellName(23918)] = 3,		-- Sonic Burst
	-- Venoxis
		[SpellName(23860)] = 4,		-- Holy Fire
		-- [SpellName(23865)] = 3,		-- Parasitic Serpent
		[SpellName(23861)] = 3,		-- Poison Cloud
	-- Mar'li
		[SpellName(24111)] = 4,		-- Corrosive Poison
		[SpellName(24300)] = 3,		-- Drain Life
	-- Bloodlord
		-- Mandokir
			[SpellName(16856)] = 3,		-- Mortal Strike
			[SpellName(24314)] = 3,		-- Threatening Gaze
		-- Ohgan
			[SpellName(24317)] = 3,		-- Sunder Armor
	-- Gahz'ranka
	-- Thekal
		[SpellName(21060)] = 3,		-- Blind
		[SpellName(12540)] = 3,		-- Gouge
	-- Arlokk
		[SpellName(24210)] = 4,		-- Mark of Arlokk
		[SpellName(24212)] = 3,		-- Shadow Word: Pain
	-- Jin'do
		[SpellName(24261)] = 5,		-- Brain Wash
		[SpellName(24306)] = 3,		-- Delusions of Jin'do
		[SpellName(17172)] = 4,		-- Hex
	-- Hakkar
		[SpellName(17172)] = 4,		-- Aspect of Arlokk
		[SpellName(24687)] = 3,		-- Aspect of Jeklik
		[SpellName(24686)] = 4,		-- Aspect of Mar'li
		[SpellName(24688)] = 3,		-- Aspect of Venoxis
		[SpellName(24327)] = 5,		-- Cause Insanity
		-- [SpellName(24328)] = 3,		-- Corrupted Blood
	-- Edge of Madness
		-- Gri'lek
			[SpellName(6524)] = 3,		-- Ground Tremor
		-- Hazza'rah
			[SpellName(24664)] = 3,		-- Sleep
		-- Renataki
			[SpellName(24698)] = 3,		-- Gouge
		-- Wushoolay

-- Ruins of Ahn'Qiraj (20)
	-- Trash
	-- Kurinnaxx
		[SpellName(25646)] = 3,		-- Mortal Wound
		[SpellName(25656)] = 4,		-- Sand Trap
	-- Rajaxx
		[SpellName(25471)] = 4,		-- Attack Order
		[SpellName(25471)] = 3,		-- Disarm
	-- Moam
	-- Buru
		[SpellName(20512)] = 3,		-- Creeping Plague
		[SpellName(96)] = 4,		-- Dismember
	-- Ayamiss
		[SpellName(25852)] = 3,		-- Lash
		[SpellName(25725)] = 4,		-- Paralyze
		-- [SpellName(25748)] = 3,		-- Poison Stinger
	-- Ossirian
		[SpellName(25195)] = 3,		-- Curse of Tongues
		[SpellName(25189)] = 4,		-- Enveloping Winds

-- Temple of Ahn'Qiraj (40)
	-- Trash
	-- Skeram
		[SpellName(785)] = 3,		-- True Fulfillment
	-- Royalty
		[SpellName(26580)] = 3,		-- Fear
		[SpellName(19128)] = 5,		-- Knockdown
		[SpellName(3242)] = 5,		-- Ravage
		[SpellName(25989)] = 3,		-- Toxin
		[SpellName(25786)] = 4,		-- Toxic Vapors
		[SpellName(25812)] = 3,		-- Toxic Volley
	-- Sartura
		[SpellName(25174)] = 3,		-- Sundering Cleave
	-- Fankriss
		[SpellName(720)] = 3,		-- Entangle
		[SpellName(25646)] = 3,		-- Mortal Wound
	-- Viscidus
		[SpellName(25991)] = 3,		-- Poison Bolt Volley
	-- Huhuran
		-- [SpellName(26050)] = 3,		-- Acid Spit
		[SpellName(26053)] = 3,		-- Noxious Poison
		[SpellName(26180)] = 3,		-- Wyvern Sting
	-- Twin Emperors
		[SpellName(26607)] = 3,		-- Blizzard
		[SpellName(26613)] = 3,		-- Unbalancing Strike
	-- Ouro
		[SpellName(26102)] = 3,		-- Sand Blast
		[SpellName(26093)] = 3,		-- Quake
	-- C'Thun
		[SpellName(26476)] = 3,		-- Digestive Acid

-- Naxxramas (40)
	-- Trash
		[SpellName(29325)] = 3,		-- Acid Volley
		[SpellName(29849)] = 3,		-- Frost Nova
		[SpellName(30094)] = 3,		-- Frost Nova
		[SpellName(29407)] = 3,		-- Mind Flay
		[SpellName(16856)] = 3,		-- Mortal Strike
		[SpellName(28467)] = 3,		-- Mortal Wound
		[SpellName(29848)] = 3,		-- Polymorph
		[SpellName(27758)] = 3,		-- War Stomp
	-- Anub'Rekhan
		[SpellName(28786)] = 3,		-- Locust Swarm
	-- Faerlina
		[SpellName(28796)] = 3,		-- Poison Bolt Volley
		[SpellName(28794)] = 5,		-- Rain of Fire
		[SpellName(30225)] = 4,		-- Silence
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
		[SpellName(25646)] = 4,		-- Mortal Wound
		[SpellName(29685)] = 3,		-- Terrifying Roar
	-- Thaddius
		-- [SpellName(28084)] = 3,		-- Negative Charge
		-- [SpellName(28059)] = 3,		-- Positive Charge
	-- Noth
		[SpellName(29212)] = 3,		-- Cripple
		[SpellName(29213)] = 4,		-- Curse of the Plaguebringer
		[SpellName(29214)] = 5,		-- Wrath of the Plaguebringer
	-- Heigan
		[SpellName(29998)] = 4,		-- Decrepit Fever
	-- Loatheb
		[SpellName(29195)] = 3,		-- Corrupted Mind (Druid)
		[SpellName(29197)] = 3,		-- Corrupted Mind (Paladin)
		[SpellName(29184)] = 3,		-- Corrupted Mind (Priest)
		[SpellName(29199)] = 3,		-- Corrupted Mind (Shaman)
		[SpellName(29865)] = 3,		-- Deathbloom
		[SpellName(29204)] = 4,		-- Inevitable Doom
	-- Razuvious
		[SpellName(26613)] = 3,		-- Unbalancing Strike
	-- Gothik
		[SpellName(27994)] = 4,		-- Drain Life
		[SpellName(27990)] = 3,		-- Fear
		-- [SpellName(28679)] = 3,		-- Harvest Soul
		[SpellName(27825)] = 5,		-- Shadow Mark
	-- Four Horsemen
		-- Highlord Mograine
			-- [SpellName(28834)] = 3,		-- Mark of Rivendare
			[SpellName(28882)] = 3,		-- Righteous Fire
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
		[SpellName(28410)] = 5,		-- Chains of Kel'Thuzad
		[SpellName(27819)] = 3,		-- Detonate Mana
		[SpellName(27808)] = 4,		-- Frost Blast
		[SpellName(31117)] = 3,		-- Unstable Affliction

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
-- Other
-----------------------------------------------------------------

}

-----------------------------------------------------------------
-- PvP
-----------------------------------------------------------------
if C.raidframe.plugins_pvp_debuffs == true then
	local PvPDebuffs = {
		-- Druid
		[SpellName(5211)] = 3,		-- Bash
		[SpellName(16922)] = 3,		-- Celestial Focus
		[SpellName(33786)] = 3,		-- Cyclone
		[SpellName(339)] = 2,		-- Entangling Roots
		[SpellName(19975)] = 2,		-- Entangling Roots (Nature's Grasp)
		[SpellName(45334)] = 2,		-- Feral Charge Effect
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(22570)] = 3,		-- Maim
		[SpellName(9005)] = 3,		-- Pounce
		-- Hunter
		[SpellName(19306)] = 2,		-- Counterattack
		[SpellName(19185)] = 2,		-- Entrapment
		[SpellName(3355)] = 3,		-- Freezing Trap Effect
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(19410)] = 3,		-- Improved Concussive Shot
		[SpellName(19229)] = 2,		-- Improved Wing Clip
		[SpellName(24394)] = 3,		-- Intimidation
		[SpellName(19503)] = 3,		-- Scatter Shot
		[SpellName(34490)] = 3,		-- Silencing Shot
		[SpellName(4167)] = 2,		-- Web (Pet)
		[SpellName(19386)] = 3,		-- Wyvern Sting
		-- Mage
		[SpellName(31661)] = 3,		-- Dragon's Breath
		[SpellName(33395)] = 2,		-- Freeze (Water Elemental)
		[SpellName(12494)] = 2,		-- Frostbite
		[SpellName(122)] = 2,		-- Frost Nova
		[SpellName(12355)] = 3,		-- Impact
		[SpellName(118)] = 3,		-- Polymorph
		[SpellName(28272)] = 3,		-- Polymorph: Pig
		[SpellName(28271)] = 3,		-- Polymorph: Turtle
		[SpellName(18469)] = 3,		-- Silenced - Improved Counterspell
		-- Paladin
		[SpellName(853)] = 3,		-- Hammer of Justice
		[SpellName(20066)] = 3,		-- Repentance
		[SpellName(20170)] = 3,		-- Stun (Seal of Justice Proc)
		[SpellName(10326)] = 3,		-- Turn Evil
		[SpellName(2878)] = 3,		-- Turn Undead
		-- Priest
		[SpellName(15269)] = 3,		-- Blackout
		[SpellName(44041)] = 3,		-- Chastise
		[SpellName(605)] = 3,		-- Mind Control
		[SpellName(8122)] = 3,		-- Psychic Scream
		[SpellName(9484)] = 3,		-- Shackle Undead
		[SpellName(15487)] = 3,		-- Silence
		-- Rogue
		[SpellName(2094)] = 3,		-- Blind
		[SpellName(1833)] = 3,		-- Cheap Shot
		[SpellName(32747)] = 3,		-- Deadly Interrupt Effect
		[SpellName(1330)] = 3,		-- Garrote - Silence
		[SpellName(1776)] = 3,		-- Gouge
		[SpellName(408)] = 3,		-- Kidney Shot
		[SpellName(14251)] = 3,		-- Riposte
		[SpellName(6770)] = 3,		-- Sap
		[SpellName(18425)] = 3,		-- Silenced - Improved Kick
		-- Shaman
		[SpellName(39796)] = 3,		-- Stoneclaw Totem
		-- Warlock
		[SpellName(6789)] = 3,		-- Death Coil
		[SpellName(5782)] = 3,		-- Fear
		[SpellName(5484)] = 3,		-- Howl of Terror
		[SpellName(30153)] = 3,		-- Intercept Stun (Felguard)
		[SpellName(18093)] = 3,		-- Pyroclasm
		[SpellName(6358)] = 3,		-- Seduction (Succubus)
		[SpellName(30283)] = 3,		-- Shadowfury
		[SpellName(24259)] = 3,		-- Spell Lock (Felhunter)
		-- Warrior
		[SpellName(7922)] = 3,		-- Charge Stun
		[SpellName(12809)] = 3,		-- Concussion Blow
		[SpellName(676)] = 3,		-- Disarm
		[SpellName(23694)] = 2,		-- Improved Hamstring
		[SpellName(5246)] = 3,		-- Intimidating Shout
		[SpellName(20253)] = 3,		-- Intercept Stun
		[SpellName(12798)] = 3,		-- Revenge Stun
		[SpellName(18498)] = 3,		-- Shield Bash - Silenced
		-- Racial
		[SpellName(28730)] = 3,		-- Arcane Torrent
		[SpellName(20549)] = 3,		-- War Stomp
		-- Other
		[SpellName(5530)] = 3,		-- Mace Specialization
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