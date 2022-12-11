local T, C, L, _ = unpack(select(2, ...))
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
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to EsreverWoW.|r")
		return "Empty"
	end
end

T.DebuffWhiteList = {
	-- Death Knight
	[SpellName(55078)] = true,	-- Blood Plague
	[SpellName(53534)] = true,	-- Chains of Ice
	[SpellName(50508)] = true,	-- Crypt Fever
	[SpellName(56222)] = true,	-- Dark Command
	[SpellName(43265)] = true,	-- Death and Decay
	[SpellName(57603)] = true,	-- Death Grip
	[SpellName(55741)] = true,	-- Desecration
	[SpellName(51726)] = true,	-- Ebon Plague
	[SpellName(55095)] = true,	-- Frost Fever
	[SpellName(47481)] = true,	-- Gnaw (Ghoul)
	[SpellName(49203)] = true,	-- Hungering Cold
	[SpellName(50434)] = true,	-- Icy Clutch (Chilblains)
	[SpellName(49005)] = true,	-- Mark of Blood
	[SpellName(47476)] = true,	-- Strangulate
	[SpellName(49206)] = true,	-- Summon Gargoyle
	[SpellName(50536)] = true,	-- Unholy Blight
	[SpellName(3439)] = true,	-- Wandering Plague
	-- Druid
	[SpellName(5211)] = true,	-- Bash
	[SpellName(16922)] = true,	-- Celestial Focus (Starfire Stun)
	[SpellName(5209)] = true,	-- Challenging Roar
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(99)] = true,		-- Demoralizing Roar
	[SpellName(60431)] = true,	-- Earth and Moon
	[SpellName(339)] = true,	-- Entangling Roots
	-- [SpellName(19975)] = true,	-- Entangling Roots (Nature's Grasp)
	[SpellName(770)] = true,	-- Faerie Fire
	[SpellName(16857)] = true,	-- Faerie Fire (Feral)
	[SpellName(45334)] = true,	-- Feral Charge Effect
	[SpellName(50259)] = true,	-- Feral Charge - Cat / Dazed
	[SpellName(54820)] = true,	-- Glyph of Rake
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
	[SpellName(2908)] = true,	-- Soothe Animal
	[SpellName(61391)] = true,	-- Typhoon

	-- Hunter
	[SpellName(19434)] = true,	-- Aimed Shot
	-- [SpellName(1462)] = true,	-- Beast Lore
	[SpellName(3674)] = true,	-- Black Arrow
	[SpellName(25999)] = true,	-- Charge (Boar)
	[SpellName(53359)] = true,	-- Chimera Shot - Scorpid
	[SpellName(35101)] = true,	-- Concussive Barrage
	[SpellName(5116)] = true,	-- Concussive Shot
	[SpellName(19306)] = true,	-- Counterattack
	[SpellName(24423)] = true,	-- Demoralizing Screech (Bat / Bird of Prey / Carrion Bird)
	[SpellName(20736)] = true,	-- Distracting Shot
	[SpellName(19185)] = true,	-- Entrapment
	[SpellName(53301)] = true,	-- Explosive Shot
	[SpellName(13812)] = true,	-- Explosive Trap Effect
	[SpellName(34501)] = true,	-- Expose Weakness
	[SpellName(34889)] = true,	-- Fire Breath (Dragonhawk)
	[SpellName(1543)] = true,	-- Flare
	[SpellName(60210)] = true,	-- Freezing Arrow Effect
	[SpellName(3355)] = true,	-- Freezing Trap Effect
	[SpellName(13810)] = true,	-- Frost Trap Aura
	[SpellName(61394)] = true,	-- Glyph of Freezing Trap
	[SpellName(1130)] = true,	-- Hunter's Mark
	[SpellName(13797)] = true,	-- Immolation Trap
	[SpellName(24394)] = true,	-- Intimidation
	[SpellName(63468)] = true,	-- Piercing Shots
	[SpellName(35387)] = true,	-- Poison Spit (Serpent)
	[SpellName(1513)] = true,	-- Scare Beast
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(24640)] = true,	-- Scorpid Poison (Scorpid)
	[SpellName(3043)] = true,	-- Scorpid Sting
	[SpellName(1978)] = true,	-- Serpent Sting
	[SpellName(34490)] = true,	-- Silencing Shot
	[SpellName(3034)] = true,	-- Viper Sting
	[SpellName(2974)] = true,	-- Wing Clip
	[SpellName(19386)] = true,	-- Wyvern Sting

	-- Mage
	[SpellName(11113)] = true,	-- Blast Wave
	-- [SpellName(10)] = true,	-- Blizzard
	-- [SpellName(12484)] = true,	-- Chilled (Blizzard)
	[SpellName(6136)] = true,	-- Chilled (Frost Armor)
	-- [SpellName(7321)] = true,	-- Chilled (Ice Armor)
	[SpellName(120)] = true,	-- Cone of Cold
	[SpellName(18469)] = true,	-- Counterspell - Silenced
	[SpellName(44572)] = true,	-- Deep Freeze
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(64346)] = true,	-- Fiery Payback
	[SpellName(133)] = true,	-- Fireball
	[SpellName(22959)] = true,	-- Fire Vulnerability (Improved Scorch)
	[SpellName(2120)] = true,	-- Flamestrike
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(12494)] = true,	-- Frostbite
	[SpellName(116)] = true,	-- Frostbolt
	[SpellName(44614)] = true,	-- Frostfire Bolt
	[SpellName(12654)] = true,	-- Ignite
	[SpellName(12355)] = true,	-- Impact
	[SpellName(44457)] = true,	-- Living Bomb
	[SpellName(68391)] = true,	-- Permafrost
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(11366)] = true,	-- Pyroblast
	[SpellName(31589)] = true,	-- Slow
	[SpellName(12579)] = true,	-- Winter's Chill

	-- Paladin
	[SpellName(31935)] = true,	-- Avenger's Shield
	[SpellName(53742)] = true,	-- Blood Corruption
	-- [SpellName(26573)] = true,	-- Consecration
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(21183)] = true,	-- Heart of the Crusader
	[SpellName(31803)] = true,	-- Holy Vengeance
	[SpellName(2812)] = true,	-- Holy Wrath
	[SpellName(20184)] = true,	-- Judgement of Justice
	[SpellName(20185)] = true,	-- Judgement of Light
	[SpellName(68055)] = true,	-- Judgements of the Just
	[SpellName(20186)] = true,	-- Judgement of Wisdom
	[SpellName(21183)] = true,	-- Judgement of the Crusader
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(61840)] = true,	-- Righteous Vengeance
	[SpellName(53659)] = true,	-- Sacred Cleansing
	[SpellName(20170)] = true,	-- Seal of Justice (Stun)
	[SpellName(63529)] = true,	-- Silenced - Shield of the Templar
	[SpellName(10326)] = true,	-- Turn Evil
	[SpellName(67)] = true,		-- Vindication

	-- Priest
	[SpellName(2944)] = true,	-- Devouring Plague
	[SpellName(14914)] = true,	-- Holy Fire
	[SpellName(605)] = true,	-- Mind Control
	[SpellName(15407)] = true,	-- Mind Flay
	[SpellName(48045)] = true,	-- Mind Sear
	[SpellName(453)] = true,	-- Mind Soothe
	[SpellName(2096)] = true,	-- Mind Vision
	[SpellName(33196)] = true,	-- Misery
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
	[SpellName(32747)] = true,	-- Deadly Throw Interrupt
	[SpellName(51722)] = true,	-- Dismantle
	[SpellName(8647)] = true,	-- Expose Armor
	[SpellName(703)] = true,	-- Garrote
	[SpellName(1330)] = true,	-- Garrote - Silence
	[SpellName(1776)] = true,	-- Gouge
	[SpellName(16511)] = true,	-- Hemorrhage
	[SpellName(18425)] = true,	-- Silenced - Improved Kick
	[SpellName(408)] = true,	-- Kidney Shot
	[SpellName(5760)] = true,	-- Mind-numbing Poison
	[SpellName(14251)] = true,	-- Riposte
	[SpellName(1943)] = true,	-- Rupture
	[SpellName(6770)] = true,	-- Sap
	[SpellName(58684)] = true,	-- Savage Combat
	[SpellName(51693)] = true,	-- Waylay
	[SpellName(13218)] = true,	-- Wound Poison

	-- Shaman
	[SpellName(58861)] = true,	-- Bash (Spirit Wolf)
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(64930)] = true,	-- Electrified (Worldbreaker Garb)
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8034)] = true,	-- Frostbrand Attack
	[SpellName(39796)] = true,	-- Stoneclaw Totem
	[SpellName(17364)] = true,	-- Stormstrike
	[SpellName(58857)] = true,	-- Twin Howl

	-- Warlock
	[SpellName(18118)] = true,	-- Aftermath
	[SpellName(710)] = true,	-- Banish
	[SpellName(59671)] = true,	-- Challenging Howl (Metamorphosis)
	[SpellName(17962)] = true,	-- Conflagrate
	[SpellName(172)] = true,	-- Corruption
	[SpellName(20812)] = true,	-- Cripple (Doomguard)
	[SpellName(980)] = true,	-- Curse of Agony
	[SpellName(603)] = true,	-- Curse of Doom
	[SpellName(18223)] = true,	-- Curse of Exhaustion
	[SpellName(1010)] = true,	-- Curse of Idiocy
	[SpellName(1714)] = true,	-- Curse of Tongues
	[SpellName(702)] = true,	-- Curse of Weakness
	[SpellName(1490)] = true,	-- Curse of the Elements
	[SpellName(6789)] = true,	-- Death Coil
	[SpellName(60995)] = true,	-- Demon Charge (Metamorphosis)
	[SpellName(689)] = true,	-- Drain Life
	[SpellName(5138)] = true,	-- Drain Mana
	[SpellName(1120)] = true,	-- Drain Soul
	[SpellName(1098)] = true,	-- Enslave Demon
	[SpellName(5782)] = true,	-- Fear
	[SpellName(63311)] = true,	-- Glyph of Shadowflame
	[SpellName(48181)] = true,	-- Haunt
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(348)] = true,	-- Immolate
	[SpellName(30153)] = true,	-- Intercept Stun (Felguard)
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
	[SpellName(12809)] = true,	-- Concussion Blow
	[SpellName(1160)] = true,	-- Demoralizing Shout
	[SpellName(676)] = true,	-- Disarm
	[SpellName(56112)] = true,	-- Furious Attacks
	[SpellName(58373)] = true,	-- Glyph of Hamstring
	[SpellName(1715)] = true,	-- Hamstring
	[SpellName(23694)] = true,	-- Improved Hamstring
	[SpellName(20253)] = true,	-- Intercept Stun
	[SpellName(20511)] = true,	-- Intimidating Shout (Cower)
	[SpellName(5246)] = true,	-- Intimidating Shout (Fear)
	[SpellName(694)] = true,	-- Mocking Blow
	[SpellName(12294)] = true,	-- Mortal Strike
	[SpellName(12323)] = true,	-- Piercing Howl
	[SpellName(772)] = true,	-- Rend
	[SpellName(64382)] = true,	-- Shattering Throw
	[SpellName(46968)] = true,	-- Shockwave
	[SpellName(18498)] = true,	-- Silenced - Gag Order
	[SpellName(7386)] = true,	-- Sunder Armor
	[SpellName(6343)] = true,	-- Thunder Clap
	[SpellName(46856)] = true,	-- Trauma
	[SpellName(64849)] = true,	-- Unrelenting Assault

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
	-- [SpellName(51789)] = true,	-- Blade Barrier
	[SpellName(45529)] = true,	-- Blood Tap
	[SpellName(50447)] = true,	-- Bloody Vengeance
	[SpellName(49222)] = true,	-- Bone Shield
	[SpellName(49028)] = true,	-- Dancing Rune Weapon
	[SpellName(49796)] = true,	-- Deathchill
	[SpellName(63583)] = true,	-- Desolation
	[SpellName(59052)] = true,	-- Freezing Fog (Rime)
	[SpellName(63560)] = true,	-- Ghoul Frenzy (Ghoul)
	[SpellName(57330)] = true,	-- Horn of Winter
	[SpellName(48792)] = true,	-- Icebound Fortitude
	-- [SpellName(50882)] = true,	-- Icy Talons
	-- [SpellName(55610)] = true,	-- Improved Icy Talons
	[SpellName(51124)] = true,	-- Killing Machine
	[SpellName(49039)] = true,	-- Lichborne
	[SpellName(50421)] = true,	-- Scent of Blood
	[SpellName(61777)] = true,	-- Summon Gargoyle
	[SpellName(51271)] = true,	-- Unbreakable Armor
	[SpellName(55233)] = true,	-- Vampiric Blood

	-- Druid
	[SpellName(2893)] = true,	-- Abolish Poison
	[SpellName(22812)] = true,	-- Barkskin
	[SpellName(50334)] = true,	-- Berserk
	[SpellName(1850)] = true,	-- Dash
	[SpellName(5229)] = true,	-- Enrage
	[SpellName(22842)] = true,	-- Frenzied Regeneration
	[SpellName(29166)] = true,	-- Innervate
	-- [SpellName(24932)] = true,	-- Leader of the Pack
	[SpellName(33763)] = true,	-- Lifebloom
	[SpellName(48504)] = true,	-- Living Seed
	-- [SpellName(45281)] = true,	-- Natural Perfection
	-- [SpellName(16886)] = true,	-- Nature's Grace
	[SpellName(16689)] = true,	-- Nature's Grasp
	[SpellName(17116)] = true,	-- Nature's Swiftness
	-- [SpellName(16870)] = true,	-- Omen of Clarity / Nightsong Battlegear (Clearcasting)
	-- [SpellName(69369)] = true,	-- Predator's Swiftness
	-- [SpellName(48391)] = true,	-- Owlkin Frenzy
	-- [SpellName(5215)] = true,	-- Prowl
	[SpellName(8936)] = true,	-- Regrowth
	[SpellName(774)] = true,	-- Rejuvenation
	[SpellName(52610)] = true,	-- Savage Roar
	[SpellName(48505)] = true,	-- Starfall
	[SpellName(61336)] = true,	-- Survival Instincts
	-- [SpellName(34123)] = true,	-- Tree of Life
	[SpellName(5217)] = true,	-- Tiger's Fury
	-- [SpellName(5225)] = true,	-- Track Humanoids
	[SpellName(740)] = true,	-- Tranquility
	[SpellName(48438)] = true,	-- Wild Growth

	-- Hunter
	-- [SpellName(13161)] = true,	-- Aspect of the Beast
	[SpellName(5118)] = true,	-- Aspect of the Cheetah
	-- [SpellName(13165)] = true,	-- Aspect of the Hawk
	-- [SpellName(13163)] = true,	-- Aspect of the Monkey
	[SpellName(13159)] = true,	-- Aspect of the Pack
	[SpellName(34074)] = true,	-- Aspect of the Viper
	-- [SpellName(20043)] = true,	-- Aspect of the Wild
	[SpellName(19574)] = true,	-- Bestial Wrath
	[SpellName(25077)] = true,	-- Cobra Reflexes (Pet)
	[SpellName(53257)] = true,	-- Cobra Strikes (Pet)
	[SpellName(61684)] = true,	-- Dash (Pet)
	[SpellName(19263)] = true,	-- Deterrence
	[SpellName(23145)] = true,	-- Dive (Pet)
	[SpellName(6197)] = true,	-- Eagle Eye
	[SpellName(1002)] = true,	-- Eyes of the Beast
	-- [SpellName(1539)] = true,	-- Feed Pet
	[SpellName(5384)] = true,	-- Feign Death
	-- [SpellName(34456)] = true,	-- Ferocious Inspiration
	[SpellName(19615)] = true,	-- Frenzy Effect
	[SpellName(24604)] = true,	-- Furious Howl (Wolf)
	[SpellName(53220)] = true,	-- Improved Steady Shot
	[SpellName(58914)] = true,	-- Kill Command (Pet)
	[SpellName(56453)] = true,	-- Lock and Load
	[SpellName(34833)] = true,	-- Master Tactician
	[SpellName(136)] = true,	-- Mend Pet
	-- [SpellName(24450)] = true,	-- Prowl (Cat)
	[SpellName(6150)] = true,	-- Quick Shots
	[SpellName(3045)] = true,	-- Rapid Fire
	[SpellName(35098)] = true,	-- Rapid Killing
	[SpellName(53230)] = true,	-- Rapid Recuperation Effect
	[SpellName(63087)] = true,	-- Raptor Strike (Glyph of Raptor Strike)
	[SpellName(26064)] = true,	-- Shell Shield (Turtle)
	[SpellName(64420)] = true,	-- Sniper Training
	-- [SpellName(19579)] = true,	-- Spirit Bond
	-- [SpellName(1515)] = true,	-- Tame Beast
	[SpellName(34471)] = true,	-- The Beast Within
	-- [SpellName(1494)] = true,	-- Track Beasts
	-- [SpellName(19878)] = true,	-- Track Demons
	-- [SpellName(19879)] = true,	-- Track Dragonkin
	-- [SpellName(19880)] = true,	-- Track Elementals
	-- [SpellName(19882)] = true,	-- Track Giants
	-- [SpellName(19885)] = true,	-- Track Hidden
	-- [SpellName(19883)] = true,	-- Track Humanoids
	-- [SpellName(19884)] = true,	-- Track Undead
	-- [SpellName(19506)] = true,	-- Trueshot Aura
	[SpellName(35346)] = true,	-- Warp (Warp Stalker)

	-- Mage
	-- [SpellName(36032)] = true,	-- Arcane Blast
	-- [SpellName(12536)] = true,	-- Arcane Concentration (Clearcasting)
	-- [SpellName(57529)] = true,	-- Arcane Potency
	[SpellName(12042)] = true,	-- Arcane Power
	[SpellName(31643)] = true,	-- Blazing Speed
	[SpellName(54748)] = true,	-- Burning Determination
	[SpellName(28682)] = true,	-- Combustion
	[SpellName(60803)] = true,	-- Curse Immunity (Glyph of Remove Curse)
	[SpellName(44544)] = true,	-- Fingers of Frost
	-- [SpellName(57761)] = true,	-- Fireball!
	[SpellName(543)] = true,	-- Fire Ward
	[SpellName(54741)] = true,	-- Firestarter
	-- [SpellName(54648)] = true,	-- Focus Magic
	[SpellName(6143)] = true,	-- Frost Ward
	[SpellName(48108)] = true,	-- Hot Streak
	[SpellName(11426)] = true,	-- Ice Barrier
	[SpellName(45438)] = true,	-- Ice Block
	[SpellName(12472)] = true,	-- Icy Veins
	[SpellName(47000)] = true,	-- Improved Blink
	[SpellName(44413)] = true,	-- Incanter's Absorption
	-- [SpellName(66)] = true,		-- Invisibility
	[SpellName(1463)] = true,	-- Mana Shield
	[SpellName(55342)] = true,	-- Mirror Image
	[SpellName(44401)] = true,	-- Missile Barrage
	[SpellName(130)] = true,	-- Slow Fall
	[SpellName(12043)] = true,	-- Presence of Mind

	-- Paladin
	[SpellName(31884)] = true,	-- Avenging Wrath
	[SpellName(53563)] = true,	-- Beacon of Light
	-- [SpellName(19746)] = true,	-- Concentration Aura
	-- [SpellName(32223)] = true,	-- Crusader Aura
	-- [SpellName(465)] = true,	-- Devotion Aura
	[SpellName(20216)] = true,	-- Divine Favor
	[SpellName(31842)] = true,	-- Divine Illumination
	-- [SpellName(19752)] = true,	-- Divine Intervention
	[SpellName(498)] = true,	-- Divine Protection
	[SpellName(642)] = true,	-- Divine Shield
	-- [SpellName(19891)] = true,	-- Fire Resistance Aura
	-- [SpellName(19888)] = true,	-- Frost Resistance Aura
	[SpellName(1044)] = true,	-- Hand of Freedom
	[SpellName(1022)] = true,	-- Hand of Protection
	[SpellName(6940)] = true,	-- Hand of Sacrifice
	[SpellName(1038)] = true,	-- Hand of Salvation
	[SpellName(64891)] = true,	-- Holy Mending
	[SpellName(20925)] = true,	-- Holy Shield
	-- [SpellName(53672)] = true,	-- Infusion of Light
	-- [SpellName(53655)] = true,	-- Judgements of the Pure
	[SpellName(20233)] = true,	-- Lay on Hands (Physical Damage Reduction)
	-- [SpellName(31834)] = true,	-- Light's Grace
	-- [SpellName(20178)] = true,	-- Reckoning
	-- [SpellName(20128)] = true,	-- Redoubt
	-- [SpellName(7294)] = true,	-- Retribution Aura
	[SpellName(53601)] = true,	-- Sacred Shield
	-- [SpellName(31892)] = true,	-- Seal of Blood
	-- [SpellName(27170)] = true,	-- Seal of Command
	-- [SpellName(348704)] = true,	-- Seal of Corruption
	-- [SpellName(20164)] = true,	-- Seal of Justice
	-- [SpellName(20165)] = true,	-- Seal of Light
	-- [SpellName(21084)] = true,	-- Seal of Righteousness
	-- [SpellName(31801)] = true,	-- Seal of Vengeance
	-- [SpellName(20166)] = true,	-- Seal of Wisdom
	-- [SpellName(348700)] = true,	-- Seal of the Martyr
	-- [SpellName(5502)] = true,	-- Sense Undead
	-- [SpellName(19876)] = true,	-- Shadow Resistance Aura
	[SpellName(54203)] = true,	-- Sheath of Light
	[SpellName(53489)] = true,	-- The Art of War
	[SpellName(20050)] = true,	-- Vengeance

	-- Priest
	[SpellName(552)] = true,	-- Abolish Disease
	[SpellName(27813)] = true,	-- Blessed Recovery
	[SpellName(33143)] = true,	-- Blessed Resilience
	[SpellName(64128)] = true,	-- Body and Soul
	-- [SpellName(59887)] = true,	-- Borrowed Time
	[SpellName(47585)] = true,	-- Dispersion
	[SpellName(47753)] = true,	-- Divine Aegis
	[SpellName(64843)] = true,	-- Divine Hymn
	-- [SpellName(586)] = true,		-- Fade
	[SpellName(6346)] = true,	-- Fear Ward
	-- [SpellName(45237)] = true,	-- Focused Will
	[SpellName(47930)] = true,	-- Grace
	[SpellName(47788)] = true,	-- Guardian Spirit
	-- [SpellName(34754)] = true,	-- Holy Concentration
	[SpellName(49694)] = true,	-- Improved Spirit Tap
	[SpellName(588)] = true,	-- Inner Fire
	[SpellName(14751)] = true,	-- Inner Focus
	[SpellName(14893)] = true,	-- Inspiration
	[SpellName(1706)] = true,	-- Levitate
	[SpellName(7001)] = true,	-- Lightwell Renew
	-- [SpellName(14743)] = true,	-- Martyrdom (Focused Casting)
	[SpellName(10060)] = true,	-- Power Infusion
	[SpellName(33206)] = true,	-- Pain Suppression
	[SpellName(17)] = true,		-- Power Word: Shield
	[SpellName(41635)] = true,	-- Prayer of Mending
	[SpellName(139)] = true,	-- Renew
	-- [SpellName(63944)] = true,	-- Renewed Hope
	-- [SpellName(63731)] = true,	-- Serendipity
	-- [SpellName(15473)] = true,	-- Shadowform
	[SpellName(61792)] = true,	-- Shadowy Insight (Glyph of Shadow)
	[SpellName(27827)] = true,	-- Spirit of Redemption
	[SpellName(15271)] = true,	-- Spirit Tap
	-- [SpellName(33151)] = true,	-- Surge of Light
	[SpellName(64901)] = true,	-- Hymn of Hope
	[SpellName(15258)] = true,	-- Shadow Weaving
	-- [SpellName(15290)] = true,	-- Vampiric Embrace
	-- [SpellName(34919)] = true,	-- Vampiric Touch

	-- Rogue
	[SpellName(13750)] = true,	-- Adrenaline Rush
	[SpellName(13877)] = true,	-- Blade Flurry
	[SpellName(45182)] = true,	-- Cheating Death
	[SpellName(31224)] = true,	-- Cloak of Shadows
	[SpellName(14177)] = true,	-- Cold Blood
	[SpellName(5277)] = true,	-- Evasion
	[SpellName(31234)] = true,	-- Find Weakness
	[SpellName(14278)] = true,	-- Ghostly Strike
	[SpellName(63848)] = true,	-- Hunger For Blood
	[SpellName(51690)] = true,	-- Killing Spree
	[SpellName(31665)] = true,	-- Master of Subtlety
	[SpellName(58427)] = true,	-- Overkill
	[SpellName(14143)] = true,	-- Remorseless Attacks
	[SpellName(51713)] = true,	-- Shadow Dance
	[SpellName(36563)] = true,	-- Shadowstep
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
	[SpellName(30165)] = true,	-- Elemental Devastation
	-- [SpellName(16246)] = true,	-- Elemental Focus (Clearcasting)
	[SpellName(16166)] = true,	-- Elemental Mastery
	-- [SpellName(51466)] = true,	-- Elemental Oath
	[SpellName(6196)] = true,	-- Far Sight
	-- [SpellName(8185)] = true,	-- Fire Resistance Totem
	[SpellName(16257)] = true,	-- Flurry
	-- [SpellName(8182)] = true,	-- Frost Resistance Totem
	-- [SpellName(2645)] = true,	-- Ghost Wolf
	-- [SpellName(8836)] = true,	-- Grace of Air
	[SpellName(8178)] = true,	-- Grounding Totem Effect
	-- [SpellName(5672)] = true,	-- Healing Stream
	[SpellName(32182)] = true,	-- Heroism
	[SpellName(324)] = true,	-- Lightning Shield
	[SpellName(53817)] = true,	-- Maelstrom Weapon
	-- [SpellName(5677)] = true,	-- Mana Spring Totem
	[SpellName(16191)] = true,	-- Mana Tide Totem
	[SpellName(31616)] = true,	-- Nature's Guardian
	[SpellName(16188)] = true,	-- Nature's Swiftness
	-- [SpellName(10596)] = true,	-- Nature Resistance Totem
	[SpellName(61295)] = true,	-- Riptide
	-- [SpellName(6495)] = true,	-- Sentry Totem
	-- [SpellName(43339)] = true,	-- Shamanistic Focus (Focused)
	[SpellName(30823)] = true,	-- Shamanistic Rage
	[SpellName(58875)] = true,	-- Spirit Walk (Spirit Wolf)
	-- [SpellName(8072)] = true,	-- Stoneskin Totem
	-- [SpellName(8076)] = true,	-- Strength of Earth
	[SpellName(55198)] = true,	-- Tidal Force
	[SpellName(53390)] = true,	-- Tidal Waves
	-- [SpellName(30708)] = true,	-- Totem of Wrath
	-- [SpellName(30802)] = true,	-- Unleashed Rage
	[SpellName(52127)] = true,	-- Water Shield
	-- [SpellName(15108)] = true,	-- Windwall Totem
	-- [SpellName(2895)] = true,	-- Wrath of Air Totem

	-- Warlock
	[SpellName(18288)] = true,	-- Amplify Curse
	[SpellName(54274)] = true,	-- Backdraft
	[SpellName(34936)] = true,	-- Backlash
	-- [SpellName(6307)] = true,	-- Blood Pact (Imp)
	[SpellName(17767)] = true,	-- Consume Shadows (Voidwalker)
	[SpellName(63165)] = true,	-- Decimation
	[SpellName(54444)] = true,	-- Demonic Empowerment (Imp - Increased Critical Strike)
	[SpellName(54443)] = true,	-- Demonic Empowerment (Voidwalker - Increased Health/Increased Threat Generation)
	[SpellName(54436)] = true,	-- Demonic Empowerment (Succubus - Improved Invisibility)
	[SpellName(54508)] = true,	-- Demonic Empowerment (Felguard - Increased Attack Speed/CC Immunity)
	-- [SpellName(48090)] = true,	-- Demonic Pact
	[SpellName(47283)] = true,	-- Empowered Imp
	[SpellName(64368)] = true,	-- Eradication
	[SpellName(126)] = true,	-- Eye of Kilrogg
	[SpellName(2947)] = true,	-- Fire Shield (Imp)
	[SpellName(755)] = true,	-- Health Funnel
	[SpellName(1949)] = true,	-- Hellfire
	[SpellName(50589)] = true,	-- Immolation Aura (Metamorphosis)
	-- [SpellName(7870)] = true,	-- Lesser Invisibility (Succubus)
	[SpellName(63321)] = true,	-- Life Tap (Glyph of Life Tap)
	-- [SpellName(23759)] = true,	-- Master Demonologist (Imp - Increased Fire Damage)
	-- [SpellName(23760)] = true,	-- Master Demonologist (Voidwalker - Physical Damage Reduction)
	-- [SpellName(23761)] = true,	-- Master Demonologist (Succubus - Increased Shadow Damage)
	-- [SpellName(23762)] = true,	-- Master Demonologist (Felhunter - Spell Damage Reduction)
	-- [SpellName(35702)] = true,	-- Master Demonologist (Felguard - Increased Damage/Damage Reduction)
	[SpellName(47241)] = true,	-- Metamorphosis
	[SpellName(47383)] = true,	-- Molten Core
	[SpellName(30299)] = true,	-- Nether Protection
	-- [SpellName(19480)] = true,	-- Paranoia (Felhunter)
	-- [SpellName(4511)] = true,	-- Phase Shift (Imp)
	[SpellName(18093)] = true,	-- Pyroclasm
	[SpellName(7812)] = true,	-- Sacrifice (Voidwalker)
	-- [SpellName(5500)] = true,	-- Sense Demons
	[SpellName(17941)] = true,	-- Shadow Trance
	[SpellName(6229)] = true,	-- Shadow Ward
	[SpellName(20707)] = true,	-- Soulstone Resurrection
	[SpellName(25228)] = true,	-- Soul Link

	-- Warrior
	[SpellName(6673)] = true,	-- Battle Shout
	[SpellName(18499)] = true,	-- Berserker Rage
	[SpellName(46924)] = true,	-- Bladestorm
	[SpellName(29131)] = true,	-- Bloodrage
	[SpellName(23885)] = true,	-- Bloodthirst
	[SpellName(16488)] = true,	-- Blood Craze
	[SpellName(469)] = true,	-- Commanding Shout
	[SpellName(12292)] = true,	-- Death Wish
	[SpellName(12880)] = true,	-- Enrage
	[SpellName(57514)] = true,	-- Enrage (Improved Defensive Stance)
	[SpellName(57518)] = true,	-- Enrage (Wrecking Crew)
	[SpellName(55694)] = true,	-- Enraged Regeneration
	[SpellName(12966)] = true,	-- Flurry
	[SpellName(58374)] = true,	-- Glyph of Blocking
	[SpellName(58363)] = true,	-- Glyph of Revenge
	[SpellName(3411)] = true,	-- Intervene
	[SpellName(65156)] = true,	-- Juggernaut
	[SpellName(12975)] = true,	-- Last Stand
	[SpellName(68051)] = true,	-- Overpower Ready! (Glyph of Overpower)
	-- [SpellName(29801)] = true,	-- Rampage
	[SpellName(1719)] = true,	-- Recklessness
	[SpellName(20230)] = true,	-- Retaliation
	[SpellName(46946)] = true,	-- Safeguard
	[SpellName(29841)] = true,	-- Second Wind
	[SpellName(2565)] = true,	-- Shield Block
	[SpellName(871)] = true,	-- Shield Wall
	[SpellName(46916)] = true,	-- Slam!
	[SpellName(23920)] = true,	-- Spell Reflection
	[SpellName(52437)] = true,	-- Sudden Death
	[SpellName(12328)] = true,	-- Sweeping Strikes
	[SpellName(60503)] = true,	-- Taste for Blood
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

T.InterruptCast = {
	-- [SpellID] = true,	-- Spell Name
}

T.ImportantCast = {
	-- [SpellID] = true,	-- Spell Name
}

local color = C.nameplate.mob_color
local color2 = {0, 0.7, 0.6}
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
		["20343"] = color2,		-- Charming Totem
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
		-- Ulduar
		["33836"] = color,		-- Bomb Bot
}
