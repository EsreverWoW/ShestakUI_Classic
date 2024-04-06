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
		{408124, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom [Season of Discovery]
		{408120, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth [Season of Discovery]
		{428713, "LEFT", {0.45, 0.3, 0.2}, true},			-- Barkskin [Season of Discovery]
		-- {102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		-- {155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	MAGE = {
		{401417, "TOPRIGHT", {0.13, 0.87, 0.50}},			-- Regeneration [Season of Discovery]
		{401460, "TOPRIGHT", {0.8, 0.4, 0.8}},				-- Rapid Regeneration [Season of Discovery]
		{412510, "TOPRIGHT", {0.13, 0.87, 0.50}},			-- Mass Regeneration [Season of Discovery]
		{428895, "BOTTOMRIGHT", {0.19, 0.58, 0.85}},		-- Temporal Anomaly [Season of Discovery]
		{400735, "TOPLEFT", {0.82, 0.29, 0.24}},			-- Temporal Beacon [Season of Discovery]
		{436516, "BOTTOM", {0.11, 0.57, 0.71}},				-- Chronostatic Preservation [Season of Discovery]
	},
	PALADIN = {
															-- Lay on Hands (Armor Bonus)
		{407613, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light [Season of Discovery]
		-- {114163, "BOTTOMLEFT", {0.9, 0.6, 0.4}},			-- Eternal Flame
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		{412019, "TOPLEFT", {0.4, 0.7, 0.2}, true},			-- Sacred Shield [Season of Discovery]
	},
	PRIEST = {
															-- Abolish Disease (move to all?)
															-- Fear Ward
		{401859, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending [Season of Discovery]
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 				-- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},			-- Power Word: Shield
		{402004, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression [Season of Discovery]
		{6788, "TOPRIGHT", {1, 0, 0}, true},				-- Weakened Soul
		{10060, "RIGHT", {0.89, 0.1, 0.1}},					-- Power Infusion
	},
	SHAMAN = {
		{408521, "TOPRIGHT", {0.7, 0.3, 0.7}, true},		-- Riptide [Season of Discovery]
		{974, "BOTTOMLEFT", {0.2, 0.7, 0.2}, true},			-- Earth Shield [Season of Discovery]
		{29203, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Healing Way (Change Color?)
		{16177, "TOPLEFT", {0.4, 0.7, 0.2}},				-- Ancestral Fortitude
		{408696, "BOTTOM", {0.2, 0.2, 0.1}},				-- Spirit of the Alpha [Season of Discovery]
	},
	WARLOCK = {
		{20707, "TOPRIGHT", {0.7, 0.32, 0.75}},				-- Soulstone
	},
	WARRIOR = {
		{403338, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene [Season of Discovery]
		-- {59665, "TOPLEFT", {0.2, 0.2, 0.1}},				-- Vigilance
	},
	ALL = {
		{23333, "LEFT", {1, 0, 0}, true}, 					-- Warsong flag, Horde
		{23335, "LEFT", {0, 0, 1}, true},					-- Warsong flag, Alliance
		{2893, "RIGHT", {0, 1, 0}, true}, 					-- Abolish Poison
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
-- Season of Discovery
-----------------------------------------------------------------
-- Blackfathom Deeps
	-- Baron Aquanis
	[SpellName(404275)] = 3,	-- Aqua Strike
	[SpellName(404806)] = 4,	-- Depth Charge
	-- Ghamoo-ra
	[SpellName(407095)] = 3,	-- Crunch Armor
	-- Lady Sarevess
	[SpellName(407546)] = 3,	-- Freezing Arrow
	[SpellName(407653)] = 4,	-- Forked Lightning
	-- Gellhast
	-- Lorgus Jett
	-- Twilight Lord Kelris
	-- Aku'mai

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
		[SpellName(339)] = 2,		-- Entangling Roots
		[SpellName(19975)] = 2,		-- Entangling Roots (Nature's Grasp)
		[SpellName(19675)] = 2,		-- Feral Charge Effect
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(9005)] = 3,		-- Pounce
		-- Hunter
		[SpellName(409495)] = 2,	-- Chimera Shot - Scorpid [Season of Discovery]
		[SpellName(19306)] = 2,		-- Counterattack
		[SpellName(19185)] = 2,		-- Entrapment
		[SpellName(3355)] = 3,		-- Freezing Trap Effect
		[SpellName(2637)] = 3,		-- Hibernate
		[SpellName(19410)] = 3,		-- Improved Concussive Shot
		[SpellName(19229)] = 2,		-- Improved Wing Clip
		[SpellName(24394)] = 3,		-- Intimidation
		[SpellName(19503)] = 3,		-- Scatter Shot
		[SpellName(19386)] = 3,		-- Wyvern Sting
		-- Mage
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
		[SpellName(2878)] = 3,		-- Turn Undead
		-- Priest
		[SpellName(15269)] = 3,		-- Blackout
		[SpellName(605)] = 3,		-- Mind Control
		[SpellName(8122)] = 3,		-- Psychic Scream
		[SpellName(9484)] = 3,		-- Shackle Undead
		[SpellName(15487)] = 3,		-- Silence
		-- Rogue
		[SpellName(400009)] = 3,	-- Between the Eyes [Season of Discovery]
		[SpellName(2094)] = 3,		-- Blind
		[SpellName(1833)] = 3,		-- Cheap Shot
		[SpellName(1776)] = 3,		-- Gouge
		[SpellName(408)] = 3,		-- Kidney Shot
		[SpellName(14251)] = 3,		-- Riposte
		[SpellName(6770)] = 3,		-- Sap
		[SpellName(18425)] = 3,		-- Silenced - Improved Kick
		-- Warlock
		[SpellName(6789)] = 3,		-- Death Coil
		[SpellName(5782)] = 3,		-- Fear
		[SpellName(5484)] = 3,		-- Howl of Terror
		[SpellName(18093)] = 3,		-- Pyroclasm
		[SpellName(6358)] = 3,		-- Seduction (Succubus)
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