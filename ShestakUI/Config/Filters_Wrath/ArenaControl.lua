local T, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Cyclone -> http://www.wowhead.com/spell=33786
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

T.ArenaControl = {
	-- Crowd Controls
	-- Death Knight
	[SpellName(47481)] = 5,		-- Gnaw (Ghoul)
	[SpellName(49203)] = 5,		-- Hungering Cold
	-- Druid
	[SpellName(5211)] = 5,		-- Bash
	[SpellName(16922)] = 5,		-- Celestial Focus
	[SpellName(33786)] = 5,		-- Cyclone
	[SpellName(2637)] = 5,		-- Hibernate
	[SpellName(22570)] = 5,		-- Maim
	[SpellName(9005)] = 5,		-- Pounce
	-- Hunter
	[SpellName(60210)] = 5,		-- Freezing Arrow Effect
	[SpellName(3355)] = 5,		-- Freezing Trap
	[SpellName(24394)] = 5,		-- Intimidation
	[SpellName(1513)] = 5,		-- Scare Beast
	[SpellName(19503)] = 5,		-- Scatter Shot
	[SpellName(19386)] = 5,		-- Wyvern Sting
	-- Mage
	[SpellName(31661)] = 5,		-- Dragon's Breath
	[SpellName(12355)] = 5,		-- Impact
	[SpellName(118)] = 5,		-- Polymorph
	-- [SpellName(61305)] = 5,		-- Polymorph: Black Cat
	-- [SpellName(28272)] = 5,		-- Polymorph: Pig
	-- [SpellName(61721)] = 5,		-- Polymorph: Rabbit
	-- [SpellName(61025)] = 5,		-- Polymorph: Serpent
	-- [SpellName(61780)] = 5,		-- Polymorph: Turkey
	-- [SpellName(28271)] = 5,		-- Polymorph: Turtle
	[SpellName(59634)] = 5,		-- Polymorph - Penguin
	-- Paladin
	[SpellName(853)] = 5,		-- Hammer of Justice
	[SpellName(20066)] = 5,		-- Repentance
	[SpellName(20170)] = 5,		-- Stun (Seal of Justice Proc)
	[SpellName(10326)] = 5,		-- Turn Evil
	-- Priest
	[SpellName(605)] = 5,		-- Mind Control
	[SpellName(64044)] = 5,		-- Psychic Horror
	[SpellName(8122)] = 5,		-- Psychic Scream
	[SpellName(9484)] = 5,		-- Shackle Undead
	-- Rogue
	[SpellName(2094)] = 5,		-- Blind
	[SpellName(1833)] = 5,		-- Cheap Shot
	[SpellName(1776)] = 5,		-- Gouge
	[SpellName(408)] = 5,		-- Kidney Shot
	[SpellName(6770)] = 5,		-- Sap
	-- Shaman
	[SpellName(58861)] = 5,		-- Bash (Spirit Wolf)
	[SpellName(51514)] = 5,		-- Hex
	[SpellName(39796)] = 5,		-- Stoneclaw Totem
	-- Warlock
	[SpellName(6789)] = 5,		-- Death Coil
	[SpellName(5782)] = 5,		-- Fear
	[SpellName(5484)] = 5,		-- Howl of Terror
	[SpellName(6358)] = 5,		-- Seduction (Succubus)
	[SpellName(30283)] = 5,		-- Shadowfury
	-- Warrior
	[SpellName(7922)] = 5,		-- Charge Stun
	[SpellName(12809)] = 5,		-- Concussion Blow
	[SpellName(20253)] = 5,		-- Intercept Stun
	[SpellName(5246)] = 5,		-- Intimidating Shout
	[SpellName(46968)] = 5,		-- Shockwave
	-- Racial
	[SpellName(20549)] = 5,		-- War Stomp

	-- Silences
	[SpellName(47476)] = 4,		-- Strangulate
	[SpellName(34490)] = 4,		-- Silencing Shot
	[SpellName(18469)] = 4,		-- Counterspell - Silenced
	[SpellName(63529)] = 4,		-- Silenced - Shield of the Templar
	[SpellName(15487)] = 4,		-- Silence
	[SpellName(1330)] = 4,		-- Garrote - Silence
	[SpellName(18425)] = 4,		-- Silenced - Improved Kick
	[SpellName(24259)] = 4,		-- Spell Lock (Felhunter)
	[SpellName(18498)] = 4,		-- Silenced - Gag Order
	[SpellName(28730)] = 4,		-- Arcane Torrent (Mana)
	-- [SpellName(25046)] = 4,		-- Arcane Torrent (Energy)
	-- [SpellName(50613)] = 4,		-- Arcane Torrent (Runic Power)
	-- [SpellName(44835)] = 4,		-- Maim Interrupt (incorrect spellID)
	[SpellName(32747)] = 4,		-- Deadly Throw Interrupt

	-- Roots
	[SpellName(53534)] = 3,		-- Chains of Ice
	[SpellName(45334)] = 3,		-- Feral Charge Effect
	[SpellName(339)] = 3,		-- Entangling Roots
	[SpellName(19975)] = 3,		-- Entangling Roots (Nature's Grasp)
	[SpellName(19185)] = 3,		-- Entrapment
	[SpellName(33395)] = 3,		-- Freeze (Water Elemental)
	[SpellName(122)] = 3,		-- Frost Nova
	[SpellName(12494)] = 3,		-- Frostbite
	[SpellName(58373)] = 3,		-- Glyph of Hamstring
	[SpellName(23694)] = 3,		-- Improved Hamstring

	-- Disarms
	[SpellName(53359)] = 1,		-- Chimera Shot - Scorpid
	[SpellName(64346)] = 1,		-- Fiery Payback
	[SpellName(51722)] = 1,		-- Dismantle
	[SpellName(676)] = 1,		-- Disarm

	-- Immunities
	[SpellName(34471)] = 2,		-- The Beast Within
	[SpellName(45438)] = 2,		-- Ice Block
	[SpellName(642)] = 2,		-- Divine Shield

	-- Buffs
	-- Death Knight
	[SpellName(49028)] = 1,		-- Dancing Rune Weapon
	[SpellName(49796)] = 1,		-- Deathchill
	[SpellName(63560)] = 1,		-- Ghoul Frenzy (Ghoul)
	[SpellName(49039)] = 1,		-- Lichborne
	[SpellName(61777)] = 1,		-- Summon Gargoyle
	[SpellName(51271)] = 1,		-- Unbreakable Armor
	-- Druid
	[SpellName(50334)] = 1,		-- Berserk
	[SpellName(29166)] = 1,		-- Innervate
	[SpellName(17116)] = 1,		-- Nature's Swiftness
	[SpellName(48505)] = 1,		-- Starfall
	[SpellName(61336)] = 1,		-- Survival Instincts
	[SpellName(740)] = 1,		-- Tranquility
	-- Hunter
	[SpellName(19574)] = 1,		-- Bestial Wrath
	[SpellName(3045)] = 1,		-- Rapid Fire
	[SpellName(35098)] = 1,		-- Rapid Killing
	[SpellName(34471)] = 1,		-- The Beast Within
	--Mage
	[SpellName(12042)] = 1,		-- Arcane Power
	[SpellName(28682)] = 1,		-- Combustion
	[SpellName(12472)] = 1,		-- Icy Veins
	[SpellName(55342)] = 1,		-- Mirror Image
	[SpellName(12043)] = 1,		-- Presence of Mind
	-- Paladin
	[SpellName(31884)] = 1,		-- Avenging Wrath
	[SpellName(1044)] = 1,		-- Hand of Freedom
	[SpellName(1022)] = 1,		-- Hand of Protection
	[SpellName(6940)] = 1,		-- Hand of Sacrifice
	[SpellName(1038)] = 1,		-- Hand of Salvation
	[SpellName(20216)] = 1,		-- Divine Favor
	[SpellName(31842)] = 1,		-- Divine Illumination
	-- Priest
	[SpellName(64843)] = 1,		-- Divine Hymn
	[SpellName(6346)] = 1,		-- Fear Ward
	[SpellName(47788)] = 1,		-- Guardian Spirit
	[SpellName(33206)] = 1,		-- Pain Suppression
	[SpellName(10060)] = 1,		-- Power Infusion
	[SpellName(64901)] = 1,		-- Hymn of Hope
	-- Rogue
	[SpellName(13877)] = 1,		-- Blade Flurry
	[SpellName(45182)] = 1,		-- Cheating Death
	[SpellName(51690)] = 1,		-- Killing Spree
	[SpellName(51713)] = 1,		-- Shadow Dance
	[SpellName(57933)] = 1,		-- Tricks of the Trade
	-- Shaman
	[SpellName(8178)] = 1,		-- Grounding Totem
	[SpellName(16190)] = 1,		-- Mana Tide Totem
	[SpellName(55198)] = 1,		-- Tidal Force
	-- Warlock
	[SpellName(18708)] = 1,		-- Fel Domination
	[SpellName(47241)] = 1,		-- Metamorphosis
	-- Warrior
	[SpellName(18499)] = 1,		-- Berserker Rage
	[SpellName(12292)] = 1,		-- Death Wish
	[SpellName(1719)] = 1,		-- Recklessness
	[SpellName(20230)] = 1,		-- Retaliation
	[SpellName(12328)] = 1,		-- Sweeping Strikes
	-- Racial
	[SpellName(26297)] = 1,		-- Berserking
	-- [SpellName(20572)] = 1,		-- Blood Fury (Physical)
	[SpellName(33697)] = 1,		-- Blood Fury (Both)
	-- [SpellName(33702)] = 1,		-- Blood Fury (Spell)
	[SpellName(28880)] = 1,		-- Gift of the Naaru
	[SpellName(65116)] = 1,		-- Stoneform
	[SpellName(7744)] = 1,		-- Will of the Forsaken

	-- Defense abilities
	[SpellName(48707)] = 1,		-- Anti-Magic Shell
	[SpellName(51052)] = 1,		-- Anti-Magic Zone
	[SpellName(49222)] = 1,		-- Bone Shield
	[SpellName(48792)] = 1,		-- Icebound Fortitude
	[SpellName(55233)] = 1,		-- Vampiric Blood
	[SpellName(22812)] = 1,		-- Barkskin
	[SpellName(19263)] = 1,		-- Deterrence
	[SpellName(66)] = 1,		-- Invisibility
	[SpellName(31821)] = 1,		-- Aura Mastery
	[SpellName(70940)] = 1,		-- Divine Guardian
	[SpellName(64205)] = 1,		-- Divine Sacrifice
	[SpellName(47585)] = 1,		-- Dispersion
	[SpellName(31224)] = 1,		-- Cloak of Shadows
	[SpellName(5277)] = 1,		-- Evasion
	[SpellName(1856)] = 1,		-- Vanish
	[SpellName(30823)] = 1,		-- Shamanistic Rage
	[SpellName(46924)] = 1,		-- Bladestorm
	[SpellName(12976)] = 1,		-- Last Stand
	[SpellName(2565)] = 1,		-- Shield Block
	[SpellName(871)] = 1,		-- Shield Wall
	[SpellName(23920)] = 1,		-- Spell Reflection
}