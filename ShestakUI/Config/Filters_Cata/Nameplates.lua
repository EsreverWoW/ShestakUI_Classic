local T, C, L = unpack(ShestakUI)
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000ShestakUI: spell ID ["..tostring(id).."] no longer exists!|r")
		return "Empty"
	end
end

T.DebuffWhiteList = {
	-- Death Knight
	[SpellName(55078)] = true,	-- Blood Plague
	[SpellName(53534)] = true,	-- Chains of Ice
	[SpellName(56222)] = true,	-- Dark Command
	[SpellName(43265)] = true,	-- Death and Decay
	[SpellName(57603)] = true,	-- Death Grip
	[SpellName(55741)] = true,	-- Desecration
	[SpellName(65142)] = true,	-- Ebon Plague
	[SpellName(55095)] = true,	-- Frost Fever
	[SpellName(47481)] = true,	-- Gnaw (Ghoul)
	[SpellName(49203)] = true,	-- Hungering Cold
	[SpellName(50434)] = true,	-- Icy Clutch (Chilblains)
	[SpellName(73975)] = true,	-- Necrotic Strike
	[SpellName(96265)] = true,	-- Scarlet Fever
	[SpellName(47476)] = true,	-- Strangulate
	[SpellName(49206)] = true,	-- Summon Gargoyle
	[SpellName(50536)] = true,	-- Unholy Blight
	-- Druid
	[SpellName(5211)] = true,	-- Bash
	[SpellName(5209)] = true,	-- Challenging Roar
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(99)] = true,		-- Demoralizing Roar
	[SpellName(60433)] = true,	-- Earth and Moon
	[SpellName(339)] = true,	-- Entangling Roots
	-- [SpellName(19975)] = true,	-- Entangling Roots (Nature's Grasp)
	[SpellName(770)] = true,	-- Faerie Fire
	[SpellName(16857)] = true,	-- Faerie Fire (Feral)
	[SpellName(45334)] = true,	-- Feral Charge Effect
	[SpellName(50259)] = true,	-- Feral Charge - Cat / Dazed
	-- [SpellName(81288)] = true,	-- Fungal Growth
	[SpellName(6795)] = true,	-- Growl
	[SpellName(2637)] = true,	-- Hibernate
	-- [SpellName(16914)] = true,	-- Hurricane
	[SpellName(58179)] = true,	-- Infected Wounds
	[SpellName(5570)] = true,	-- Insect Swarm
	[SpellName(33745)] = true,	-- Lacerate
	[SpellName(22570)] = true,	-- Maim
	[SpellName(33878)] = true,	-- Mangle (Bear)
	[SpellName(33876)] = true,	-- Mangle (Cat)
	[SpellName(8921)] = true,	-- Moonfire
	[SpellName(9005)] = true,	-- Pounce
	[SpellName(9007)] = true,	-- Pounce Bleed
	[SpellName(1822)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	[SpellName(80964)] = true,	-- Skull Bash (Bear)
	[SpellName(80965)] = true,	-- Skull Bash (Cat)
	-- [SpellName(82364)] = true,	-- Skull Bash (Increased Mana Cost)
	[SpellName(2908)] = true,	-- Soothe Animal
	[SpellName(93402)] = true,	-- Sunfire
	[SpellName(77758)] = true,	-- Thrash
	[SpellName(61391)] = true,	-- Typhoon

	-- Hunter
	-- [SpellName(1462)] = true,	-- Beast Lore
	[SpellName(3674)] = true,	-- Black Arrow
	[SpellName(25999)] = true,	-- Charge (Boar)
	[SpellName(35101)] = true,	-- Concussive Barrage
	[SpellName(5116)] = true,	-- Concussive Shot
	[SpellName(19306)] = true,	-- Counterattack
	[SpellName(24423)] = true,	-- Demoralizing Screech (Bat / Bird of Prey / Carrion Bird)
	[SpellName(20736)] = true,	-- Distracting Shot
	[SpellName(19185)] = true,	-- Entrapment
	[SpellName(53301)] = true,	-- Explosive Shot
	[SpellName(13812)] = true,	-- Explosive Trap Effect
	[SpellName(34889)] = true,	-- Fire Breath (Dragonhawk)
	[SpellName(1543)] = true,	-- Flare
	[SpellName(3355)] = true,	-- Freezing Trap Effect
	[SpellName(61394)] = true,	-- Glyph of Freezing Trap
	[SpellName(1130)] = true,	-- Hunter's Mark
	[SpellName(13810)] = true,	-- Ice Trap
	[SpellName(13797)] = true,	-- Immolation Trap
	[SpellName(24394)] = true,	-- Intimidation
	[SpellName(88691)] = true,	-- Marked for Death
	[SpellName(63468)] = true,	-- Piercing Shots
	[SpellName(35387)] = true,	-- Poison Spit (Serpent)
	[SpellName(1513)] = true,	-- Scare Beast
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(24640)] = true,	-- Scorpid Poison (Scorpid)
	[SpellName(1978)] = true,	-- Serpent Sting
	[SpellName(34490)] = true,	-- Silencing Shot
	[SpellName(82654)] = true,	-- Widow Venom
	[SpellName(2974)] = true,	-- Wing Clip
	[SpellName(19386)] = true,	-- Wyvern Sting

	-- Mage
	[SpellName(11113)] = true,	-- Blast Wave
	-- [SpellName(10)] = true,	-- Blizzard
	-- [SpellName(12484)] = true,	-- Chilled (Blizzard)
	[SpellName(7321)] = true,	-- Chilled (Frost Armor)
	-- [SpellName(7321)] = true,	-- Chilled (Ice Armor)
	[SpellName(120)] = true,	-- Cone of Cold
	[SpellName(22959)] = true,	-- Critical Mass
	[SpellName(44572)] = true,	-- Deep Freeze
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(64346)] = true,	-- Fiery Payback
	[SpellName(133)] = true,	-- Fireball
	[SpellName(2120)] = true,	-- Flamestrike
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(116)] = true,	-- Frostbolt
	[SpellName(44614)] = true,	-- Frostfire Bolt
	[SpellName(84721)] = true,	-- Frostfire Orb
	[SpellName(12654)] = true,	-- Ignite
	[SpellName(12355)] = true,	-- Impact
	[SpellName(44457)] = true,	-- Living Bomb
	[SpellName(68391)] = true,	-- Permafrost
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(11366)] = true,	-- Pyroblast
	[SpellName(92315)] = true,	-- Pyroblast!
	[SpellName(55080)] = true,	-- Shattered Barrier
	[SpellName(18469)] = true,	-- Silenced - Improved Counterspell
	[SpellName(31589)] = true,	-- Slow
	[SpellName(12579)] = true,	-- Winter's Chill

	-- Paladin
	[SpellName(31935)] = true,	-- Avenger's Shield
	[SpellName(356110)] = true,	-- Blood Corruption
	[SpellName(31803)] = true,	-- Censure
	[SpellName(26573)] = true,	-- Consecration
	[SpellName(63529)] = true,	-- Dazed - Avenger's Shield
	[SpellName(85509)] = true,	-- Denounce
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(62124)] = true,	-- Hand of Reckoning
	[SpellName(2812)] = true,	-- Holy Wrath
	[SpellName(68055)] = true,	-- Judgements of the Just
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(20170)] = true,	-- Seal of Justice (Stun)
	[SpellName(10326)] = true,	-- Turn Evil

	-- Priest
	[SpellName(2944)] = true,	-- Devouring Plague
	[SpellName(14914)] = true,	-- Holy Fire
	[SpellName(88625)] = true,	-- Holy Word: Chastise
	[SpellName(605)] = true,	-- Mind Control
	[SpellName(15407)] = true,	-- Mind Flay
	[SpellName(48045)] = true,	-- Mind Sear
	[SpellName(453)] = true,	-- Mind Soothe
	[SpellName(2096)] = true,	-- Mind Vision
	[SpellName(33196)] = true,	-- Misery
	[SpellName(87193)] = true,	-- Paralysis
	[SpellName(64044)] = true,	-- Psychic Horror
	[SpellName(8122)] = true,	-- Psychic Scream
	[SpellName(9484)] = true,	-- Shackle Undead
	[SpellName(589)] = true,	-- Shadow Word: Pain
	[SpellName(15487)] = true,	-- Silence
	[SpellName(15286)] = true,	-- Vampiric Embrace
	[SpellName(34914)] = true,	-- Vampiric Touch

	-- Rogue
	[SpellName(31125)] = true,	-- Blade Twisting (Dazed)
	[SpellName(2094)] = true,	-- Blind
	[SpellName(1833)] = true,	-- Cheap Shot
	[SpellName(3409)] = true,	-- Crippling Poison
	[SpellName(2818)] = true,	-- Deadly Poison
	[SpellName(26679)] = true,	-- Deadly Throw
	[SpellName(51722)] = true,	-- Dismantle
	[SpellName(8647)] = true,	-- Expose Armor
	[SpellName(91021)] = true,	-- Find Weakness
	[SpellName(703)] = true,	-- Garrote
	[SpellName(1330)] = true,	-- Garrote - Silence
	[SpellName(1776)] = true,	-- Gouge
	[SpellName(79124)] = true,	-- Groggy
	[SpellName(16511)] = true,	-- Hemorrhage
	-- [SpellName(89775)] = true,	-- Hemorrhage (Glyph of Hemorrhage)
	[SpellName(32747)] = true,	-- Interrupt
	[SpellName(408)] = true,	-- Kidney Shot
	[SpellName(5760)] = true,	-- Mind-numbing Poison
	[SpellName(14251)] = true,	-- Riposte
	[SpellName(1943)] = true,	-- Rupture
	[SpellName(6770)] = true,	-- Sap
	[SpellName(58684)] = true,	-- Savage Combat
	[SpellName(18425)] = true,	-- Silenced - Improved Kick
	[SpellName(79140)] = true,	-- Vendetta
	[SpellName(51693)] = true,	-- Waylay
	[SpellName(13218)] = true,	-- Wound Poison

	-- Shaman
	[SpellName(58861)] = true,	-- Bash (Spirit Wolf)
	[SpellName(76780)] = true,	-- Bind Elemental
	[SpellName(53019)] = true,	-- Earth's Grasp
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(86861)] = true,	-- Earthquake
	[SpellName(64930)] = true,	-- Electrified (Worldbreaker Garb)
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8034)] = true,	-- Frostbrand Attack
	[SpellName(51514)] = true,	-- Hex
	[SpellName(77661)] = true,	-- Searing Flames
	[SpellName(39796)] = true,	-- Stoneclaw Totem
	[SpellName(17364)] = true,	-- Stormstrike
	[SpellName(58857)] = true,	-- Twin Howl
	[SpellName(73682)] = true,	-- Unleash Frost

	-- Warlock
	[SpellName(18118)] = true,	-- Aftermath
	[SpellName(93975)] = true,	-- Aura of Foreboding
	[SpellName(980)] = true,	-- Bane of Agony
	[SpellName(603)] = true,	-- Bane of Doom
	[SpellName(80240)] = true,	-- Bane of Havoc
	[SpellName(710)] = true,	-- Banish
	[SpellName(85421)] = true,	-- Burning Embers
	[SpellName(17962)] = true,	-- Conflagrate
	[SpellName(172)] = true,	-- Corruption
	[SpellName(20812)] = true,	-- Cripple (Doomguard)
	[SpellName(18223)] = true,	-- Curse of Exhaustion
	[SpellName(86000)] = true,	-- Curse of Gul'dan
	[SpellName(1714)] = true,	-- Curse of Tongues
	[SpellName(702)] = true,	-- Curse of Weakness
	[SpellName(1490)] = true,	-- Curse of the Elements
	[SpellName(6789)] = true,	-- Death Coil
	[SpellName(60995)] = true,	-- Demon Leap (Metamorphosis)
	[SpellName(689)] = true,	-- Drain Life
	[SpellName(1120)] = true,	-- Drain Soul
	[SpellName(1098)] = true,	-- Enslave Demon
	[SpellName(5782)] = true,	-- Fear
	[SpellName(63311)] = true,	-- Glyph of Shadowflame
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(348)] = true,	-- Immolate
	[SpellName(30153)] = true,	-- Intercept (Felguard)
	-- [SpellName(5740)] = true,	-- Rain of Fire
	[SpellName(27243)] = true,	-- Seed of Corruption
	[SpellName(6358)] = true,	-- Seduction (Succubus)
	-- [SpellName(29341)] = true,	-- Shadowburn
	[SpellName(47960)] = true,	-- Shadowflame
	[SpellName(30283)] = true,	-- Shadowfury
	[SpellName(32386)] = true,	-- Shadow Embrace
	[SpellName(17794)] = true,	-- Shadow Vulnerability (Improved Shadow Bolt)
	[SpellName(24259)] = true,	-- Spell Lock (Felhunter)
	[SpellName(21949)] = true,	-- Rend (Doomguard)
	[SpellName(30108)] = true,	-- Unstable Affliction
	-- [SpellName(31117)] = true,	-- Unstable Affliction (Silence)

	-- Warrior
	[SpellName(30069)] = true,	-- Blood Frenzy
	[SpellName(1161)] = true,	-- Challenging Shout
	[SpellName(7922)] = true,	-- Charge Stun
	[SpellName(86346)] = true,	-- Colossus Smash
	[SpellName(12809)] = true,	-- Concussion Blow
	[SpellName(1160)] = true,	-- Demoralizing Shout
	[SpellName(676)] = true,	-- Disarm
	[SpellName(56112)] = true,	-- Furious Attacks
	[SpellName(58373)] = true,	-- Glyph of Hamstring
	[SpellName(1715)] = true,	-- Hamstring
	[SpellName(23694)] = true,	-- Improved Hamstring
	[SpellName(20253)] = true,	-- Intercept
	[SpellName(20511)] = true,	-- Intimidating Shout (Cower)
	[SpellName(5246)] = true,	-- Intimidating Shout (Fear)
	[SpellName(12294)] = true,	-- Mortal Strike
	[SpellName(12323)] = true,	-- Piercing Howl
	[SpellName(772)] = true,	-- Rend
	[SpellName(64382)] = true,	-- Shattering Throw
	[SpellName(46968)] = true,	-- Shockwave
	[SpellName(18498)] = true,	-- Silenced - Gag Order
	[SpellName(7386)] = true,	-- Sunder Armor
	[SpellName(355)] = true,	-- Taunt
	[SpellName(85388)] = true,	-- Throwdown
	[SpellName(6343)] = true,	-- Thunder Clap
	[SpellName(46856)] = true,	-- Trauma

	-- Racial
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
}

for _, spell in pairs(C.nameplate.debuffs_list) do
	T.DebuffWhiteList[SpellName(spell)] = true
end

T.DebuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.BuffWhiteList = {
	-- Death Knight
	-- [SpellName(53137)] = true,	-- Abomination's Might
	[SpellName(48707)] = true,	-- Anti-Magic Shell
	[SpellName(50461)] = true,	-- Anti-Magic Zone
	[SpellName(42650)] = true,	-- Army of the Dead
	[SpellName(77535)] = true,	-- Blood Shield
	[SpellName(45529)] = true,	-- Blood Tap
	[SpellName(49222)] = true,	-- Bone Shield
	[SpellName(49028)] = true,	-- Dancing Rune Weapon
	[SpellName(77606)] = true,	-- Dark Simulacrum
	[SpellName(63560)] = true,	-- Dark Transformation (Ghoul)
	[SpellName(63583)] = true,	-- Desolation
	[SpellName(59052)] = true,	-- Freezing Fog (Rime)
	[SpellName(57330)] = true,	-- Horn of Winter
	[SpellName(48792)] = true,	-- Icebound Fortitude
	-- [SpellName(50882)] = true,	-- Icy Talons
	-- [SpellName(55610)] = true,	-- Improved Icy Talons
	[SpellName(51124)] = true,	-- Killing Machine
	[SpellName(49039)] = true,	-- Lichborne
	[SpellName(51271)] = true,	-- Pillar of Frost
	[SpellName(51460)] = true,	-- Runic Corruption
	[SpellName(50421)] = true,	-- Scent of Blood
	[SpellName(91342)] = true,	-- Shadow Infusion
	[SpellName(81340)] = true,	-- Sudden Doom
	[SpellName(61777)] = true,	-- Summon Gargoyle
	[SpellName(55233)] = true,	-- Vampiric Blood

	-- Druid
	[SpellName(22812)] = true,	-- Barkskin
	[SpellName(50334)] = true,	-- Berserk
	[SpellName(1850)] = true,	-- Dash
	[SpellName(5229)] = true,	-- Enrage
	[SpellName(22842)] = true,	-- Frenzied Regeneration
	[SpellName(81093)] = true,	-- Fury of Stormrage
	[SpellName(29166)] = true,	-- Innervate
	-- [SpellName(24932)] = true,	-- Leader of the Pack
	[SpellName(33763)] = true,	-- Lifebloom
	[SpellName(48504)] = true,	-- Living Seed
	-- [SpellName(81006)] = true,	-- Lunar Shower
	-- [SpellName(45281)] = true,	-- Natural Perfection
	-- [SpellName(96206)] = true,	-- Nature's Bounty
	-- [SpellName(16886)] = true,	-- Nature's Grace
	[SpellName(16689)] = true,	-- Nature's Grasp
	[SpellName(17116)] = true,	-- Nature's Swiftness
	-- [SpellName(16870)] = true,	-- Omen of Clarity / Malfurion's Gift / Nightsong Battlegear (Clearcasting)
	-- [SpellName(69369)] = true,	-- Predator's Swiftness
	-- [SpellName(48391)] = true,	-- Owlkin Frenzy
	-- [SpellName(5215)] = true,	-- Prowl
	-- [SpellName(80951)] = true,	-- Pulverize
	[SpellName(8936)] = true,	-- Regrowth
	[SpellName(774)] = true,	-- Rejuvenation
	[SpellName(62606)] = true,	-- Savage Defense
	[SpellName(52610)] = true,	-- Savage Roar
	-- [SpellName(93400)] = true,	-- Shooting Stars
	[SpellName(48505)] = true,	-- Starfall
	[SpellName(61336)] = true,	-- Survival Instincts
	[SpellName(33891)] = true,	-- Tree of Life
	[SpellName(5217)] = true,	-- Tiger's Fury
	-- [SpellName(5225)] = true,	-- Track Humanoids
	[SpellName(740)] = true,	-- Tranquility
	-- [SpellName(81016)] = true,	-- Stampede
	[SpellName(77761)] = true,	-- Stampeding Roar (Bear)
	[SpellName(77764)] = true,	-- Stampeding Roar (Cat)
	[SpellName(48438)] = true,	-- Wild Growth

	-- Hunter
	[SpellName(5118)] = true,	-- Aspect of the Cheetah
	-- [SpellName(82661)] = true,	-- Aspect of the Fox
	-- [SpellName(13165)] = true,	-- Aspect of the Hawk
	[SpellName(13159)] = true,	-- Aspect of the Pack
	-- [SpellName(20043)] = true,	-- Aspect of the Wild
	[SpellName(19574)] = true,	-- Bestial Wrath
	[SpellName(82921)] = true,	-- Bombardment
	-- [SpellName(51755)] = true,	-- Camouflage
	[SpellName(25077)] = true,	-- Cobra Reflexes (Pet)
	[SpellName(53257)] = true,	-- Cobra Strikes (Pet)
	[SpellName(61684)] = true,	-- Dash (Pet)
	[SpellName(19263)] = true,	-- Deterrence
	[SpellName(23145)] = true,	-- Dive (Pet)
	[SpellName(6197)] = true,	-- Eagle Eye
	-- [SpellName(1539)] = true,	-- Feed Pet
	[SpellName(5384)] = true,	-- Feign Death
	-- [SpellName(34456)] = true,	-- Ferocious Inspiration
	[SpellName(82692)] = true,	-- Focus Fire
	[SpellName(19615)] = true,	-- Frenzy Effect
	[SpellName(24604)] = true,	-- Furious Howl (Wolf)
	-- [SpellName(53290)] = true,	-- Hunting Party
	[SpellName(53220)] = true,	-- Improved Steady Shot
	[SpellName(56453)] = true,	-- Lock and Load
	[SpellName(34833)] = true,	-- Master Tactician
	[SpellName(62305)] = true,	-- Master's Call
	[SpellName(136)] = true,	-- Mend Pet
	[SpellName(83559)] = true,	-- Posthaste
	-- [SpellName(24450)] = true,	-- Prowl (Cat)
	[SpellName(6150)] = true,	-- Quick Shots
	[SpellName(3045)] = true,	-- Rapid Fire
	[SpellName(35098)] = true,	-- Rapid Killing
	[SpellName(53230)] = true,	-- Rapid Recuperation Effect
	[SpellName(63087)] = true,	-- Raptor Strike (Glyph of Raptor Strike)
	[SpellName(82925)] = true,	-- Ready, Set, Aim...
	[SpellName(82897)] = true,	-- Resistance is Futile!
	[SpellName(26064)] = true,	-- Shell Shield (Turtle)
	[SpellName(83359)] = true,	-- Sic 'Em!
	[SpellName(64420)] = true,	-- Sniper Training
	-- [SpellName(19579)] = true,	-- Spirit Bond
	-- [SpellName(1515)] = true,	-- Tame Beast
	[SpellName(34471)] = true,	-- The Beast Within
	[SpellName(35346)] = true,	-- Time Warp (Warp Stalker)
	-- [SpellName(1494)] = true,	-- Track Beasts
	-- [SpellName(19878)] = true,	-- Track Demons
	-- [SpellName(19879)] = true,	-- Track Dragonkin
	-- [SpellName(19880)] = true,	-- Track Elementals
	-- [SpellName(19882)] = true,	-- Track Giants
	-- [SpellName(19885)] = true,	-- Track Hidden
	-- [SpellName(19883)] = true,	-- Track Humanoids
	-- [SpellName(19884)] = true,	-- Track Undead
	[SpellName(77769)] = true,	-- Trap Launcher
	-- [SpellName(19506)] = true,	-- Trueshot Aura

	-- Mage
	-- [SpellName(36032)] = true,	-- Arcane Blast
	-- [SpellName(12536)] = true,	-- Arcane Concentration (Clearcasting)
	-- [SpellName(57529)] = true,	-- Arcane Potency
	[SpellName(12042)] = true,	-- Arcane Power
	[SpellName(31643)] = true,	-- Blazing Speed
	-- [SpellName(57761)] = true,	-- Brain Freeze
	[SpellName(60803)] = true,	-- Curse Immunity (Glyph of Remove Curse)
	[SpellName(44544)] = true,	-- Fingers of Frost
	[SpellName(54741)] = true,	-- Firestarter
	-- [SpellName(54648)] = true,	-- Focus Magic
	[SpellName(48108)] = true,	-- Hot Streak
	[SpellName(11426)] = true,	-- Ice Barrier
	[SpellName(45438)] = true,	-- Ice Block
	[SpellName(12472)] = true,	-- Icy Veins
	[SpellName(47000)] = true,	-- Improved Blink
	[SpellName(44413)] = true,	-- Incanter's Absorption
	-- [SpellName(66)] = true,		-- Invisibility
	[SpellName(87098)] = true,	-- Invocation
	[SpellName(543)] = true,	-- Mage Ward
	[SpellName(1463)] = true,	-- Mana Shield
	[SpellName(55342)] = true,	-- Mirror Image
	[SpellName(12043)] = true,	-- Presence of Mind
	[SpellName(83582)] = true,	-- Pyromaniac
	[SpellName(130)] = true,	-- Slow Fall
	[SpellName(80353)] = true,	-- Time Warp

	-- Paladin
	[SpellName(31884)] = true,	-- Avenging Wrath
	[SpellName(53563)] = true,	-- Beacon of Light
	-- [SpellName(19746)] = true,	-- Concentration Aura
	[SpellName(20050)] = true,	-- Conviction
	[SpellName(94686)] = true,	-- Crusader
	-- [SpellName(32223)] = true,	-- Crusader Aura
	[SpellName(88819)] = true,	-- Daybreak
	-- [SpellName(465)] = true,	-- Devotion Aura
	[SpellName(31842)] = true,	-- Divine Favor
	[SpellName(498)] = true,	-- Divine Protection
	[SpellName(90174)] = true,	-- Divine Purpose
	[SpellName(642)] = true,	-- Divine Shield
	[SpellName(85416)] = true,	-- Grand Crusader
	[SpellName(86659)] = true,	-- Guardian of Ancient Kings (Avenger's Shield)
	-- [SpellName(86669)] = true,	-- Guardian of Ancient Kings (Holy Shock)
	-- [SpellName(86698)] = true,	-- Guardian of Ancient Kings (Templar's Verdict)
	[SpellName(1044)] = true,	-- Hand of Freedom
	[SpellName(1022)] = true,	-- Hand of Protection
	[SpellName(6940)] = true,	-- Hand of Sacrifice
	[SpellName(1038)] = true,	-- Hand of Salvation
	[SpellName(64891)] = true,	-- Holy Mending
	[SpellName(82327)] = true,	-- Holy Radiance
	[SpellName(20925)] = true,	-- Holy Shield
	-- [SpellName(53672)] = true,	-- Infusion of Light
	[SpellName(86273)] = true,	-- Illuminated Healing
	-- [SpellName(89906)] = true,	-- Judgements of the Bold
	-- [SpellName(53655)] = true,	-- Judgements of the Pure
	-- [SpellName(31930)] = true,	-- Judgements of the Wise
	[SpellName(87173)] = true,	-- Long Arm of the Law
	-- [SpellName(20178)] = true,	-- Reckoning
	-- [SpellName(20128)] = true,	-- Redoubt
	-- [SpellName(19891)] = true,	-- Resistance Aura
	-- [SpellName(7294)] = true,	-- Retribution Aura
	[SpellName(85433)] = true,	-- Sacred Duty
	[SpellName(96263)] = true,	-- Sacred Shield
	-- [SpellName(348704)] = true,	-- Seal of Corruption
	-- [SpellName(20165)] = true,	-- Seal of Insight
	-- [SpellName(20164)] = true,	-- Seal of Justice
	-- [SpellName(20154)] = true,	-- Seal of Righteousness
	-- [SpellName(31801)] = true,	-- Seal of Truth
	[SpellName(90811)] = true,	-- Selfless
	-- [SpellName(5502)] = true,	-- Sense Undead
	[SpellName(85497)] = true,	-- Speed of Light
	[SpellName(59578)] = true,	-- The Art of War
	[SpellName(85696)] = true,	-- Zealotry

	-- Priest
	[SpellName(81700)] = true,	-- Archangel
	[SpellName(27813)] = true,	-- Blessed Recovery
	[SpellName(33143)] = true,	-- Blessed Resilience
	[SpellName(64128)] = true,	-- Body and Soul
	-- [SpellName(59887)] = true,	-- Borrowed Time
	[SpellName(14751)] = true,	-- Chakra
	[SpellName(81209)] = true,	-- Chakra: Chastise
	[SpellName(81206)] = true,	-- Chakra: Sanctuary
	[SpellName(81208)] = true,	-- Chakra: Serenity
	[SpellName(87153)] = true,	-- Dark Archangel
	-- [SpellName(87117)] = true,	-- Dark Evangelism
	[SpellName(47585)] = true,	-- Dispersion
	[SpellName(47753)] = true,	-- Divine Aegis
	[SpellName(64843)] = true,	-- Divine Hymn
	[SpellName(77489)] = true,	-- Echo of Light
	-- [SpellName(95799)] = true,	-- Empowered Shadow
	-- [SpellName(81660)] = true,	-- Evangelism
	-- [SpellName(586)] = true,		-- Fade
	[SpellName(6346)] = true,	-- Fear Ward
	-- [SpellName(45241)] = true,	-- Focused Will
	-- [SpellName(90785)] = true,	-- Glyph of Power Word: Barrier
	[SpellName(56161)] = true,	-- Glyph of Prayer of Healing
	[SpellName(81301)] = true,	-- Glyph of Spirit Tap
	[SpellName(47930)] = true,	-- Grace
	[SpellName(47788)] = true,	-- Guardian Spirit
	[SpellName(88684)] = true,	-- Holy Word: Serenity
	-- [SpellName(588)] = true,	-- Inner Fire
	[SpellName(89485)] = true,	-- Inner Focus
	-- [SpellName(73413)] = true,	-- Inner Will
	[SpellName(14893)] = true,	-- Inspiration
	[SpellName(1706)] = true,	-- Levitate
	[SpellName(7001)] = true,	-- Lightwell Renew
	[SpellName(81292)] = true,	-- Mind Melt
	-- [SpellName(49868)] = true,	-- Mind Quickening
	-- [SpellName(87178)] = true,	-- Mind Spike
	[SpellName(10060)] = true,	-- Power Infusion
	[SpellName(33206)] = true,	-- Pain Suppression
	[SpellName(81782)] = true,	-- Power Word: Barrier
	[SpellName(17)] = true,		-- Power Word: Shield
	[SpellName(41635)] = true,	-- Prayer of Mending
	[SpellName(139)] = true,	-- Renew
	-- [SpellName(63944)] = true,	-- Renewed Hope
	-- [SpellName(63731)] = true,	-- Serendipity
	-- [SpellName(15473)] = true,	-- Shadowform
	-- [SpellName(77487)] = true,	-- Shadow Orb
	[SpellName(27827)] = true,	-- Spirit of Redemption
	[SpellName(96266)] = true,	-- Strength of Soul
	-- [SpellName(88688)] = true,	-- Surge of Light
	[SpellName(64901)] = true,	-- Hymn of Hope
	-- [SpellName(15290)] = true,	-- Vampiric Embrace
	-- [SpellName(34919)] = true,	-- Vampiric Touch

	-- Rogue
	[SpellName(13750)] = true,	-- Adrenaline Rush
	[SpellName(13877)] = true,	-- Blade Flurry
	[SpellName(45182)] = true,	-- Cheating Death
	[SpellName(31224)] = true,	-- Cloak of Shadows
	[SpellName(14177)] = true,	-- Cold Blood
	[SpellName(74002)] = true,	-- Combat Insight
	[SpellName(74001)] = true,	-- Combat Readiness
	[SpellName(84590)] = true,	-- Deadly Momentum
	[SpellName(84747)] = true,	-- Deep Insight [Bandit's Guile]
	[SpellName(5277)] = true,	-- Evasion
	[SpellName(51690)] = true,	-- Killing Spree
	[SpellName(31665)] = true,	-- Master of Subtlety
	[SpellName(84746)] = true,	-- Moderate Insight [Bandit's Guile]
	[SpellName(58427)] = true,	-- Overkill
	[SpellName(73651)] = true,	-- Recuperate
	[SpellName(14143)] = true,	-- Remorseless Attacks
	[SpellName(84617)] = true,	-- Revealing Strike
	[SpellName(51713)] = true,	-- Shadow Dance
	[SpellName(36563)] = true,	-- Shadowstep
	[SpellName(84745)] = true,	-- Shallow Insight [Bandit's Guile]
	[SpellName(5171)] = true,	-- Slice and Dice
	[SpellName(2983)] = true,	-- Sprint
	-- [SpellName(1784)] = true,	-- Stealth
	-- [SpellName(31621)] = true,	-- Stealth (Vanish)
	[SpellName(57933)] = true,	-- Tricks of the Trade
	[SpellName(52914)] = true,	-- Turn the Tables

	-- Shaman
	[SpellName(52179)] = true,	-- Astral Shift
	[SpellName(2825)] = true,	-- Bloodlust
	[SpellName(51945)] = true,	-- Earthliving
	[SpellName(974)] = true,	-- Earth Shield
	[SpellName(29178)] = true,	-- Elemental Devastation
	-- [SpellName(16246)] = true,	-- Elemental Focus (Clearcasting)
	[SpellName(16166)] = true,	-- Elemental Mastery
	-- [SpellName(51466)] = true,	-- Elemental Oath
	[SpellName(6196)] = true,	-- Far Sight
	-- [SpellName(8185)] = true,	-- Fire Resistance Totem
	[SpellName(16257)] = true,	-- Flurry
	[SpellName(77800)] = true,	-- Focused Insight
	-- [SpellName(8182)] = true,	-- Frost Resistance Totem
	-- [SpellName(2645)] = true,	-- Ghost Wolf
	-- [SpellName(8836)] = true,	-- Grace of Air
	[SpellName(8178)] = true,	-- Grounding Totem Effect
	-- [SpellName(5672)] = true,	-- Healing Stream
	[SpellName(32182)] = true,	-- Heroism
	[SpellName(65264)] = true,	-- Lava Flows
	[SpellName(324)] = true,	-- Lightning Shield
	[SpellName(53817)] = true,	-- Maelstrom Weapon
	-- [SpellName(5677)] = true,	-- Mana Spring Totem
	[SpellName(16191)] = true,	-- Mana Tide Totem
	[SpellName(31616)] = true,	-- Nature's Guardian
	[SpellName(16188)] = true,	-- Nature's Swiftness
	-- [SpellName(10596)] = true,	-- Nature Resistance Totem
	[SpellName(61295)] = true,	-- Riptide
	[SpellName(97621)] = true,	-- Seasoned Winds (Arcane)
	-- [SpellName(97618)] = true,	-- Seasoned Winds (Fire)
	-- [SpellName(97619)] = true,	-- Seasoned Winds (Frost)
	-- [SpellName(97620)] = true,	-- Seasoned Winds (Nature)
	-- [SpellName(97622)] = true,	-- Seasoned Winds (Shadow)
	-- [SpellName(6495)] = true,	-- Sentry Totem
	-- [SpellName(43339)] = true,	-- Shamanistic Focus (Focused)
	[SpellName(30823)] = true,	-- Shamanistic Rage
	[SpellName(58875)] = true,	-- Spirit Walk (Spirit Wolf)
	[SpellName(79206)] = true,	-- Spiritwalker's Grace
	-- [SpellName(8072)] = true,	-- Stoneskin Totem
	-- [SpellName(8076)] = true,	-- Strength of Earth
	[SpellName(55198)] = true,	-- Tidal Force
	[SpellName(53390)] = true,	-- Tidal Waves
	-- [SpellName(30708)] = true,	-- Totem of Wrath
	-- [SpellName(77746)] = true,	-- Totemic Wrath
	[SpellName(73683)] = true,	-- Unleash Flame
	[SpellName(73681)] = true,	-- Unleash Wind
	-- [SpellName(30802)] = true,	-- Unleashed Rage
	[SpellName(52127)] = true,	-- Water Shield
	-- [SpellName(15108)] = true,	-- Windwall Totem
	-- [SpellName(2895)] = true,	-- Wrath of Air Totem

	-- Warlock
	[SpellName(54274)] = true,	-- Backdraft
	[SpellName(34936)] = true,	-- Backlash
	-- [SpellName(6307)] = true,	-- Blood Pact (Imp)
	[SpellName(17767)] = true,	-- Consume Shadows (Voidwalker)
	[SpellName(85767)] = true,	-- Dark Intent
	[SpellName(63165)] = true,	-- Decimation
	[SpellName(79462)] = true,	-- Demon Soul: Felguard
	[SpellName(79460)] = true,	-- Demon Soul: Felhunter
	[SpellName(79459)] = true,	-- Demon Soul: Imp
	[SpellName(79463)] = true,	-- Demon Soul: Succubus
	[SpellName(79464)] = true,	-- Demon Soul: Voidwalker
	[SpellName(54443)] = true,	-- Demonic Empowerment (Voidwalker - Increased Health/Increased Threat Generation)
	[SpellName(54436)] = true,	-- Demonic Empowerment (Succubus - Improved Invisibility)
	[SpellName(54508)] = true,	-- Demonic Empowerment (Felguard - CC Immunity)
	-- [SpellName(48090)] = true,	-- Demonic Pact
	[SpellName(88448)] = true,	-- Demonic Rebirth
	[SpellName(47283)] = true,	-- Empowered Imp
	[SpellName(64368)] = true,	-- Eradication
	[SpellName(126)] = true,	-- Eye of Kilrogg
	[SpellName(755)] = true,	-- Health Funnel
	[SpellName(1949)] = true,	-- Hellfire
	[SpellName(50589)] = true,	-- Immolation Aura (Metamorphosis)
	-- [SpellName(7870)] = true,	-- Lesser Invisibility (Succubus)
	[SpellName(47241)] = true,	-- Metamorphosis
	[SpellName(47383)] = true,	-- Molten Core
	[SpellName(54373)] = true,	-- Nether Protection (Arcane)
	[SpellName(54371)] = true,	-- Nether Protection (Fire)
	[SpellName(54372)] = true,	-- Nether Protection (Frost)
	[SpellName(54370)] = true,	-- Nether Protection (Holy)
	[SpellName(54375)] = true,	-- Nether Protection (Nature)
	[SpellName(54374)] = true,	-- Nether Protection (Shadow)
	[SpellName(91711)] = true,	-- Nether Ward
	-- [SpellName(19480)] = true,	-- Paranoia (Felhunter)
	-- [SpellName(4511)] = true,	-- Phase Shift (Imp)
	[SpellName(7812)] = true,	-- Sacrifice (Voidwalker)
	-- [SpellName(5500)] = true,	-- Sense Demons
	[SpellName(17941)] = true,	-- Shadow Trance
	[SpellName(6229)] = true,	-- Shadow Ward
	[SpellName(79268)] = true,	-- Soul Harvest
	[SpellName(25228)] = true,	-- Soul Link
	[SpellName(74434)] = true,	-- Soulburn
	[SpellName(79438)] = true,	-- Soulburn: Demonic Circle
	[SpellName(79437)] = true,	-- Soulburn: Healthstone
	[SpellName(79440)] = true,	-- Soulburn: Searing Pain
	[SpellName(20707)] = true,	-- Soulstone Resurrection

	-- Warrior
	[SpellName(6673)] = true,	-- Battle Shout
	[SpellName(12964)] = true,	-- Battle Trance
	[SpellName(18499)] = true,	-- Berserker Rage
	[SpellName(46924)] = true,	-- Bladestorm
	[SpellName(23885)] = true,	-- Bloodthirst
	[SpellName(16488)] = true,	-- Blood Craze
	[SpellName(469)] = true,	-- Commanding Shout
	[SpellName(85730)] = true,	-- Deadly Calm
	[SpellName(12292)] = true,	-- Death Wish
	[SpellName(85386)] = true,	-- Die by the Sword
	[SpellName(12880)] = true,	-- Enrage
	[SpellName(57514)] = true,	-- Enrage (Improved Defensive Stance)
	[SpellName(57518)] = true,	-- Enrage (Wrecking Crew)
	[SpellName(55694)] = true,	-- Enraged Regeneration
	[SpellName(12966)] = true,	-- Flurry
	[SpellName(58374)] = true,	-- Glyph of Blocking
	[SpellName(84619)] = true,	-- Hold the Line
	[SpellName(86627)] = true,	-- Incite
	[SpellName(1134)] = true,	-- Inner Rage
	[SpellName(3411)] = true,	-- Intervene
	[SpellName(65156)] = true,	-- Juggernaut
	[SpellName(12975)] = true,	-- Last Stand
	[SpellName(85738)] = true,	-- Meat Cleaver
	-- [SpellName(29801)] = true,	-- Rampage
	[SpellName(1719)] = true,	-- Recklessness
	[SpellName(20230)] = true,	-- Retaliation
	[SpellName(86662)] = true,	-- Rude Interruption
	[SpellName(46946)] = true,	-- Safeguard
	[SpellName(29841)] = true,	-- Second Wind
	[SpellName(2565)] = true,	-- Shield Block
	[SpellName(871)] = true,	-- Shield Wall
	[SpellName(46916)] = true,	-- Slam!
	[SpellName(84584)] = true,	-- Slaughter
	[SpellName(23920)] = true,	-- Spell Reflection
	[SpellName(52437)] = true,	-- Sudden Death
	[SpellName(12328)] = true,	-- Sweeping Strikes
	[SpellName(60503)] = true,	-- Taste for Blood
	[SpellName(87095)] = true,	-- Thunderstruck
	[SpellName(82368)] = true,	-- Victorious
	[SpellName(50720)] = true,	-- Vigilance

	-- Racial
	[SpellName(26297)] = true,	-- Berserking
	-- [SpellName(20572)] = true,	-- Blood Fury (Physical)
	[SpellName(33697)] = true,	-- Blood Fury (Both)
	-- [SpellName(33702)] = true,	-- Blood Fury (Spell)
	-- [SpellName(2481)] = true,	-- Find Treasure
	[SpellName(28880)] = true,	-- Gift of the Naaru
	-- [SpellName(58984)] = true,	-- Shadowmeld
	[SpellName(65116)] = true,	-- Stoneform
	[SpellName(7744)] = true,	-- Will of the Forsaken
}

for _, spell in pairs(C.nameplate.buffs_list) do
	T.BuffWhiteList[SpellName(spell)] = true
end

T.BuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.PlateBlacklist = {
	-- Hunter Trap
	["19833"] = true,		-- Venomous Snake
	["19921"] = true,		-- Viper
	-- Raid
}

T.InterruptCast = { -- Yellow border for interruptible cast
	-- [SpellID] = true,	-- Spell Name
}

T.ImportantCast = { -- Red border for non-interruptible cast
	-- [SpellID] = true,	-- Spell Name
}

local color = C.nameplate.mob_color
local color_alt = {0, 0.7, 0.6}
T.ColorPlate = {
	-- PvP
		["5925"] = color,		-- Grounding Totem
	-- Raid
		-- Karazhan
		["15547"] = color,		-- Spectral Charger
		["16461"] = color,		-- Concubine
		["16471"] = color,		-- Skeletal Usher
		-- Gruul's Lair
		["21350"] = color,		-- Gronn-Priest
		-- Serpentshrine Cavern
		["22236"] = color,		-- Water Elemental Totem
		["22091"] = color,		-- Spitfire Totem
		-- Tempest Keep
		-- Battle for Mount Hyjal
		-- Black Temple
		["22894"] = color,		-- Cyclone Totem
		-- Zul'Aman
		-- Sunwell
		["25772"] = color,		-- Void Sentinel
		["25370"] = color,		-- Sunblade Dusk Priest
		-- Naxxramas
		["16385"] = color,		-- Lightning Totem
		-- Ulduar
		["33836"] = color,		-- Bomb Bot
		-- TOC / TOGC
		["5925"] = color,		-- Grounding Totem
		["34686"] = color,		-- Healing Stream Totem
		["34687"] = color,		-- Searing Totem
		["31129"] = color,		-- Strength of Earth Totem VIII
		["5913"] = color,		-- Tremor Totem
		["6112"] = color,		-- Windfury Totem
	-- Dungeons
		-- Hellfire Ramparts
		["17478"] = color,		-- Bleeding Hollow Scryer
		-- The Blood Furnace
		["17399"] = color,		-- Seductress
		["17401"] = color,		-- Felhound Manastalker
		-- The Slave Pens
		["17957"] = color,		-- Coilfang Champion
		["17960"] = color,		-- Coilfang Soothsayer
		["21128"] = color,		-- Coilfang Ray
		-- The Underbog
		["17731"] = color,		-- Fen Ray
		-- Mana-Tombs
		["18315"] = color,		-- Ethereal Theurgist
		["18331"] = color,		-- Ethereal Darkcaster
		-- ["19306"] = color,		-- Mana Leech
		["19307"] = color,		-- Nexus Terror
		-- Auchenai Crypts
		["18503"] = color,		-- Phantasmal Possessor
		["18506"] = color,		-- Raging Soul
		-- Sethekk Halls
		["18325"] = color,		-- Sethekk Prophet
		["18327"] = color,		-- Time-Lost Controller
		["20343"] = color_alt,		-- Charming Totem
		-- Old Hillsbrad Foothills
		["17833"] = color,		-- Durnholde Warden
		["18934"] = color,		-- Durnholde Mage
		-- The Black Morass
		["21104"] = color,		-- Rift Keeper
		["21148"] = color,		-- Rift Keeper
		-- The Mechanar
		["20990"] = color,		-- Bloodwarder Physician
		-- Shadow Labyrinth
		["18639"] = color,		-- Cabal Spellbinder
		["18663"] = color,		-- Maiden of Discipline
		["18796"] = color,		-- Fel Overseer
		-- The Shattered Halls
		["17694"] = color,		-- Shadowmoon Darkcaster
		-- The Steamvault
		["17801"] = color,		-- Coilfang Siren
		-- The Arcatraz
		["20883"] = color,		-- Spiteful Temptress
		["20897"] = color,		-- Ethereum Wave-Caster
		-- The Botanica
		["18419"] = color,		-- Bloodwarder Greenkeeper
		["19509"] = color,		-- Sunseeker Harvester
		["19633"] = color,		-- Bloodwarder Mender
		-- Magisters' Terrace
}
