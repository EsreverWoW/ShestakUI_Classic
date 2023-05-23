local T, C, L = unpack(ShestakUI)
if C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.RaidBuffs = {
	DRUID = {
		{774, "TOPRIGHT", {0.8, 0.4, 0.8}},					-- Rejuvenation
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},				-- Wild Growth
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}},				-- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}},				-- Lifebloom
		{391891, "TOP", {0.2, 0.7, 0.2}},					-- Adaptive Swarm
		{102351, "BOTTOM", {0.2, 0.7, 0.2}},				-- Cenarion Ward
		{102342, "LEFT", {0.45, 0.3, 0.2}, true},			-- Ironbark
		{155777, "RIGHT", {0.4, 0.9, 0.4}},					-- Rejuvenation (Germination)
	},
	EVOKER = {
		{355941, "TOPRIGHT", {0.20, 0.58, 0.50}},			-- Dream Breath
		{363502, "BOTTOMLEFT", {0.26, 0.73, 0.63}},			-- Dream Flight
		{366155, "RIGHT", {0.14, 1.00, 0.88}},				-- Reversion
		{364343, "TOP", {0.13, 0.87, 0.50}},				-- Echo
		{373267, "TOPLEFT", {0.82, 0.29, 0.24}},			-- Life Bind (Verdant Embrace)
		{357170, "BOTTOM", {0.11, 0.57, 0.71}},				-- Time Dilation
	},
	MONK = {
		{119611, "TOPRIGHT", {0.2, 0.7, 0.7}},				-- Renewing Mist
		{116841, "RIGHT", {0.12, 1.00, 0.53}},				-- Tiger's Lust (Freedom)
		{115175, "BOTTOMRIGHT", {0.7, 0.4, 0}},				-- Soothing Mist
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}},			-- Enveloping Mist
		{325209, "BOTTOM", {0.3, 0.6, 0.6}},				-- Enveloping Breath
		{191840, "TOPLEFT", {0.1, 0.4, 0.9}},				-- Essence Font
		{116849, "LEFT", {0.81, 0.85, 0.1}, true},			-- Life Cocoon
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Faith
		{200025, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Beacon of Virtue
		{157047, "TOP", {0.15, 0.58, 0.84}},				-- Saved by the Light (T25 Talent)
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},			-- Blessing of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},		-- Blessing of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},		-- Blessing of Sacrifice
		{204018, "BOTTOMRIGHT", {0.4, 0.6, 0.8}, true},		-- Blessing of Spellwarding
		{287280, "BOTTOMLEFT", {0.9, 0.5, 0.1}},			-- Glimmer of Light
		{223306, "TOPLEFT", {0.8, 0.8, 0.1}},				-- Bestow Faith
	},
	PRIEST = {
		{194384, "TOPRIGHT", {0.8, 0.4, 0.2}},				-- Atonement
		{139, "TOP", {0.4, 0.7, 0.2}},						-- Renew
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},			-- Prayer of Mending
		{6788, "BOTTOMLEFT", {1, 0, 0}},					-- Weakened Soul
		{17, "TOPLEFT", {0.81, 0.85, 0.1}},					-- Power Word: Shield
		{33206, "LEFT", {0.89, 0.1, 0.1}, true},			-- Pain Suppression
		{47788, "LEFT", {0.86, 0.52, 0}, true},				-- Guardian Spirit
	},
	SHAMAN = {
		{61295, "TOPRIGHT", {0.7, 0.3, 0.7}},				-- Riptide
		{974, "BOTTOMRIGHT", {0.91, 0.80, 0.44}},			-- Earth Shield
	},
	HUNTER = {
		{35079, "TOPRIGHT", {0.2, 0.2, 1}},					-- Misdirection
		{90361, "TOP", {0.34, 0.47, 0.31}},					-- Spirit Mend (HoT)
	},
	ROGUE = {
		{57934, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Tricks of the Trade
	},
	WARRIOR  = {
		{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},				-- Intervene
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
		print("|cffff0000ShestakUI: RaidAuraWatch spell ID ["..tostring(id).."] no longer exists!|r")
		return "Empty"
	end
end

T.RaidDebuffs = {
	---------------------------------------------------------
	-- Aberrus, the Shadowed Crucible
	---------------------------------------------------------
	-- Kazzara
	[SpellName(406530)] = 3,	-- Riftburn
	[SpellName(402420)] = 3,	-- Molten Scar
	[SpellName(402253)] = 3,	-- Ray of Anguish
	[SpellName(406525)] = 3,	-- Dread Rift
	[SpellName(404743)] = 3,	-- Terror Claws
	-- Molgoth
	[SpellName(405084)] = 3,	-- Lingering Umbra
	[SpellName(405645)] = 3,	-- Engulfing Heat
	[SpellName(405642)] = 3,	-- Blistering Twilight
	[SpellName(402617)] = 3,	-- Blazing Heat
	[SpellName(401809)] = 3,	-- Corrupting Shadow
	[SpellName(405394)] = 3,	-- Shadowflame
	-- Experimentation of Dracthyr
	[SpellName(406317)] = 3,	-- Rending Charge
	[SpellName(405392)] = 3,	-- Disintegrate
	[SpellName(406233)] = 3,	-- Deep Breath
	[SpellName(407327)] = 3,	-- Unstable Essence
	[SpellName(406313)] = 3,	-- Infused Strikes
	[SpellName(407302)] = 3,	-- Infused Explosion
	-- Zaqali Invasion
	[SpellName(408873)] = 3,	-- Heavy Cudgel
	[SpellName(410353)] = 3,	-- Flaming Cudgel
	[SpellName(407017)] = 3,	-- Vigorous Gale
	[SpellName(401452)] = 3,	-- Blazing Spear
	[SpellName(409275)] = 3,	-- Magma Flow
	-- Rashok
	[SpellName(407547)] = 3,	-- Flaming Upsurge
	[SpellName(407597)] = 3,	-- Earthen Crush
	[SpellName(405819)] = 3,	-- Searing Slam
	[SpellName(408857)] = 3,	-- Doom Flame
	-- Zskarn
	[SpellName(404955)] = 3,	-- Shrapnel Bomb
	[SpellName(404010)] = 3,	-- Unstable Embers
	[SpellName(404942)] = 3,	-- Searing Claws
	[SpellName(403978)] = 3,	-- Blast Wave
	[SpellName(405592)] = 3,	-- Salvage Parts
	[SpellName(405462)] = 3,	-- Dragonfire Traps
	[SpellName(409942)] = 3,	-- Elimination Protocol
	-- Magmorax
	[SpellName(408955)] = 3,	-- Incinerating Maws
	[SpellName(402994)] = 3,	-- Molten Spittle
	[SpellName(403747)] = 3,	-- Igniting Roar
	-- Echo of Neltharion
	[SpellName(409373)] = 3,	-- Disrupt Earth
	[SpellName(407182)] = 3,	-- Rushing Shadows
	[SpellName(405484)] = 3,	-- Surrendering to Corruption
	[SpellName(409058)] = 3,	-- Seeping Lava
	[SpellName(402120)] = 3,	-- Collapsed Earth
	[SpellName(407728)] = 3,	-- Sundered Shadow
	[SpellName(401998)] = 3,	-- Calamitous Strike
	[SpellName(408160)] = 3,	-- Shadow Strike
	[SpellName(403846)] = 3,	-- Sweeping Shadows
	[SpellName(401133)] = 3,	-- Wildshift (Druid)
	[SpellName(401131)] = 3,	-- Wild Summoning (Warlock)
	[SpellName(401130)] = 3,	-- Wild Magic (Mage)
	[SpellName(401135)] = 3,	-- Wild Breath (Evoker)
	[SpellName(408071)] = 3,	-- Shapeshifter's Fervor
	[SpellName(410953)] = 3,	-- Volcanic Heart
	-- Scalecommander Sarkareth
	[SpellName(403520)] = 3,	-- Embrace of Nothingness
	[SpellName(401383)] = 3,	-- Oppressing Howl
	[SpellName(401951)] = 3,	-- Oblivion
	[SpellName(407496)] = 3,	-- Infinite Duress
	[SpellName(401680)] = 3,	-- Mass Disintegrate

	-----------------------------------------------------------------
	-- Vault of the Incarnates
	-----------------------------------------------------------------
	-- Eranog
	[SpellName(370648)] = 5,	-- Primal Flow
	[SpellName(390715)] = 6,	-- Primal Rifts
	[SpellName(370597)] = 6,	-- Kill Order
	-- Terros
	[SpellName(381253)] = 5,	-- Awakened Earth
	[SpellName(386352)] = 3,	-- Rock Blast
	[SpellName(382458)] = 6,	-- Resonant Aftermath
	-- The Primal Council
	[SpellName(371624)] = 5,	-- Conductive Mark
	[SpellName(372027)] = 4,	-- Slashing Blaze
	[SpellName(374039)] = 4,	-- Meteor Axe
	-- Sennarth, the Cold Breath
	[SpellName(371976)] = 4,	-- Chilling Blast
	[SpellName(372082)] = 5,	-- Enveloping Webs
	[SpellName(374659)] = 4,	-- Rush
	[SpellName(374104)] = 5,	-- Wrapped in Webs
	[SpellName(373048)] = 3,	-- Suffocating Webs
	-- Dathea, Ascended
	[SpellName(391686)] = 5,	-- Conductive Mark
	[SpellName(378277)] = 2,	-- Elemental Equilbrium
	[SpellName(388290)] = 4,	-- Cyclone
	-- Kurog Grimtotem
	[SpellName(377780)] = 5,	-- Skeletal Fractures
	[SpellName(372514)] = 5,	-- Frost Bite
	[SpellName(374554)] = 4,	-- Lava Pool
	[SpellName(374023)] = 6,	-- Searing Carnage
	[SpellName(374427)] = 6,	-- Ground Shatter
	[SpellName(390920)] = 5,	-- Shocking Burst
	[SpellName(372458)] = 6,	-- Below Zero
	-- Broodkeeper Diurna
	[SpellName(388920)] = 6,	-- Frozen Shroud
	[SpellName(378782)] = 5,	-- Mortal Wounds
	[SpellName(378787)] = 5,	-- Crushing Stoneclaws
	[SpellName(375620)] = 6,	-- Ionizing Charge
	[SpellName(375578)] = 4,	-- Flame Sentry
	-- Raszageth the Storm-Eater
	[SpellName(381615)] = 4,	-- Static Charge
	[SpellName(399713)] = 4,	-- Magnetic Charge
	[SpellName(385073)] = 5,	-- Ball Lightning
	[SpellName(377467)] = 4,	-- Fulminating Charge
-----------------------------------------------------------------
-- Dungeons
-----------------------------------------------------------------
	-- Mythic+ Affixes
	[SpellName(226512)] = 3,	-- Sanguine
	[SpellName(240559)] = 3,	-- Grievous
	[SpellName(240443)] = 3,	-- Bursting
	-- Dragonflight Season 2
	[SpellName(408556)] = 6,	-- Entangling Debuff

	-----------------------------------------------------------------
	-- Dragonflight (Season 1)
	-----------------------------------------------------------------
	-- Court of Stars
	[SpellName(207278)] = 3,	-- Arcane Lockdown
	[SpellName(209516)] = 3,	-- Mana Fang
	[SpellName(209512)] = 3,	-- Disrupting Energy
	[SpellName(211473)] = 3,	-- Shadow Slash
	[SpellName(207979)] = 3,	-- Shockwave
	[SpellName(207980)] = 3,	-- Disintegration Beam
	[SpellName(211464)] = 3,	-- Fel Detonation
	[SpellName(208165)] = 3,	-- Withering Soul
	[SpellName(209413)] = 3,	-- Suppress
	[SpellName(209027)] = 3,	-- Quelling Strike
	-- Halls of Valor
	[SpellName(197964)] = 3,	-- Runic Brand
	[SpellName(193783)] = 3,	-- Aegis of Aggramar
	[SpellName(196838)] = 3,	-- Scent of Blood
	[SpellName(199674)] = 3,	-- Wicked Dagger
	[SpellName(193260)] = 3,	-- Static Field
	[SpellName(193743)] = 3,	-- Aegis of Aggramar Wielder
	[SpellName(199652)] = 3,	-- Sever
	[SpellName(198944)] = 3,	-- Breach Armor
	[SpellName(215430)] = 3,	-- Thunderstrike
	[SpellName(203963)] = 3,	-- Eye of the Storm
	[SpellName(196497)] = 3,	-- Ravenous Leap
	[SpellName(193660)] = 3,	-- Felblaze Rush
	-- Shadowmoon Burial Grounds
	[SpellName(156776)] = 3,	-- Rending Voidlash
	[SpellName(153692)] = 3,	-- Necrotic Pitch
	[SpellName(153524)] = 3,	-- Plague Spit
	[SpellName(154469)] = 3,	-- Ritual of Bones
	[SpellName(162652)] = 3,	-- Lunar Purity
	[SpellName(164907)] = 3,	-- Void Cleave
	[SpellName(152979)] = 3,	-- Soul Shred
	[SpellName(158061)] = 3,	-- Blessed Waters of Purity
	[SpellName(154442)] = 3,	-- Malevolence
	[SpellName(153501)] = 3,	-- Void Blast
	-- Temple of the Jade Serpent
	[SpellName(396150)] = 3,	-- Feeling of Superiority
	[SpellName(397878)] = 3,	-- Tainted Ripple
	[SpellName(106113)] = 3,	-- Touch of Nothingness
	[SpellName(397914)] = 3,	-- Defiling Mist
	[SpellName(397904)] = 3,	-- Setting Sun Kick
	[SpellName(397911)] = 3,	-- Touch of Ruin
	[SpellName(395859)] = 3,	-- Haunting Scream
	[SpellName(374037)] = 3,	-- Overwhelming Rage
	[SpellName(396093)] = 3,	-- Savage Leap
	[SpellName(106823)] = 3,	-- Serpent Strike
	[SpellName(396152)] = 3,	-- Feeling of Inferiority
	[SpellName(110125)] = 3,	-- Shattered Resolve
	[SpellName(397797)] = 3,	-- Corrupted Vortex
	-- Ruby Life Pools
	[SpellName(392406)] = 3,	-- Thunderclap
	[SpellName(372820)] = 3,	-- Scorched Earth
	[SpellName(384823)] = 3,	-- Inferno
	[SpellName(381862)] = 3,	-- Infernocore
	[SpellName(372860)] = 3,	-- Searing Wounds
	[SpellName(373869)] = 3,	-- Burning Touch
	[SpellName(385536)] = 3,	-- Flame Dance
	[SpellName(381518)] = 3,	-- Winds of Change
	[SpellName(372858)] = 3,	-- Searing Blows
	[SpellName(372682)] = 3,	-- Primal Chill
	[SpellName(373693)] = 3,	-- Living Bomb
	[SpellName(392924)] = 3,	-- Shock Blast
	[SpellName(381515)] = 3,	-- Stormslam
	[SpellName(396411)] = 3,	-- Primal Overload
	[SpellName(384773)] = 3,	-- Flaming Embers
	[SpellName(392451)] = 3,	-- Flashfire
	[SpellName(372697)] = 3,	-- Jagged Earth
	[SpellName(372047)] = 3,	-- Flurry
	[SpellName(372963)] = 3,	-- Chillstorm
	-- The Nokhud Offensive
	[SpellName(382628)] = 3,	-- Surge of Power
	[SpellName(386025)] = 3,	-- Tempest
	[SpellName(381692)] = 3,	-- Swift Stab
	[SpellName(387615)] = 3,	-- Grasp of the Dead
	[SpellName(387629)] = 3,	-- Rotting Wind
	[SpellName(386912)] = 3,	-- Stormsurge Cloud
	[SpellName(395669)] = 3,	-- Aftershock
	[SpellName(384134)] = 3,	-- Pierce
	[SpellName(388451)] = 3,	-- Stormcaller's Fury
	[SpellName(395035)] = 3,	-- Shatter Soul
	[SpellName(376899)] = 3,	-- Crackling Cloud
	[SpellName(384492)] = 3,	-- Hunter's Mark
	[SpellName(376730)] = 3,	-- Stormwinds
	[SpellName(376894)] = 3,	-- Crackling Upheaval
	[SpellName(388801)] = 3,	-- Mortal Strike
	[SpellName(376827)] = 3,	-- Conductive Strike
	[SpellName(376864)] = 3,	-- Static Spear
	[SpellName(375937)] = 3,	-- Rending Strike
	[SpellName(376634)] = 3,	-- Iron Spear
	-- The Azure Vault
	[SpellName(388777)] = 3,	-- Oppressive Miasma
	[SpellName(386881)] = 3,	-- Frost Bomb
	[SpellName(387150)] = 3,	-- Frozen Ground
	[SpellName(387564)] = 3,	-- Mystic Vapors
	[SpellName(385267)] = 3,	-- Crackling Vortex
	[SpellName(386640)] = 3,	-- Tear Flesh
	[SpellName(374567)] = 3,	-- Explosive Brand
	[SpellName(374523)] = 3,	-- Arcane Roots
	[SpellName(375596)] = 3,	-- Erratic Growth Channel
	[SpellName(375602)] = 3,	-- Erratic Growth
	[SpellName(370764)] = 3,	-- Piercing Shards
	[SpellName(384978)] = 3,	-- Dragon Strike
	[SpellName(375649)] = 3,	-- Infused Ground
	[SpellName(387151)] = 3,	-- Icy Devastator
	[SpellName(377488)] = 3,	-- Icy Bindings
	[SpellName(374789)] = 3,	-- Infused Strike
	[SpellName(371007)] = 3,	-- Splintering Shards
	[SpellName(375591)] = 3,	-- Sappy Burst
	[SpellName(385409)] = 3,	-- Ouch, ouch, ouch!
	[SpellName(386549)] = 3,	-- Waking Bane
	-- Algeth'ar Academy
	[SpellName(389033)] = 3,	-- Lasher Toxin
	[SpellName(391977)] = 3,	-- Oversurge
	[SpellName(386201)] = 3,	-- Corrupted Mana
	[SpellName(389011)] = 3,	-- Overwhelming Power
	[SpellName(387932)] = 3,	-- Astral Whirlwind
	[SpellName(396716)] = 3,	-- Splinterbark
	[SpellName(388866)] = 3,	-- Mana Void
	[SpellName(386181)] = 3,	-- Mana Bomb
	[SpellName(388912)] = 3,	-- Severing Slash
	[SpellName(377344)] = 3,	-- Peck
	[SpellName(376997)] = 3,	-- Savage Peck
	[SpellName(388984)] = 3,	-- Vicious Ambush
	[SpellName(388544)] = 3,	-- Barkbreaker
	[SpellName(377008)] = 3,	-- Deafening Screech

	-----------------------------------------------------------------
	-- Dragonflight (Season 2)
	-----------------------------------------------------------------
	-- Freehold
	[SpellName(258323)] = 3,	-- Infected Wound
	[SpellName(257775)] = 3,	-- Plague Step
	[SpellName(257908)] = 3,	-- Oiled Blade
	[SpellName(257436)] = 3,	-- Poisoning Strike
	[SpellName(274389)] = 3,	-- Rat Traps
	[SpellName(274555)] = 3,	-- Scabrous Bites
	[SpellName(258875)] = 4,	-- Blackout Barrel
	[SpellName(256363)] = 3,	-- Ripper Punch
	[SpellName(258352)] = 3,	-- Grapeshot
	[SpellName(413136)] = 3,	-- Whirling Dagger
	-- Neltharion's Lair
	[SpellName(199705)] = 3,	-- Devouring
	[SpellName(199178)] = 3,	-- Spiked Tongue
	[SpellName(210166)] = 3,	-- Toxic Retch
	[SpellName(193941)] = 3,	-- Impaling Shard
	[SpellName(183465)] = 3,	-- Viscid Bile
	[SpellName(226296)] = 3,	-- Piercing Shards
	[SpellName(226388)] = 3,	-- Rancid Ooze
	[SpellName(200154)] = 3,	-- Burning Hatred
	[SpellName(183407)] = 3,	-- Acid Splatter
	[SpellName(215898)] = 3,	-- Crystalline Ground
	[SpellName(188494)] = 3,	-- Rancid Maw
	[SpellName(192800)] = 3,	-- Choking Dust
	-- Underrot
	[SpellName(265468)] = 3,	-- Withering Curse
	[SpellName(278961)] = 3,	-- Decaying Mind
	[SpellName(259714)] = 3,	-- Decaying Spores
	[SpellName(272180)] = 3,	-- Death Bolt
	[SpellName(272609)] = 3,	-- Maddening Gaze
	[SpellName(269301)] = 3,	-- Putrid Blood
	[SpellName(265533)] = 3,	-- Blood Maw
	[SpellName(265019)] = 3,	-- Savage Cleave
	[SpellName(265377)] = 3,	-- Hooked Snare
	[SpellName(265625)] = 3,	-- Dark Omen
	[SpellName(260685)] = 3,	-- Taint of G'huun
	[SpellName(266107)] = 3,	-- Thirst for Blood
	[SpellName(260455)] = 3,	-- Serrated Fangs
	-- Vortex Pinnacle
	[SpellName(87618)] = 3,		-- Static Cling
	[SpellName(410870)] = 3,	-- Cyclone
	[SpellName(86292)] = 3,		-- Cyclone Shield
	[SpellName(88282)] = 3,		-- Upwind of Altairus
	[SpellName(88286)] = 3,		-- Downwind of Altairus
	[SpellName(410997)] = 3,	-- Rushing Wind
	[SpellName(411003)] = 3,	-- Turbulence
	[SpellName(87771)] = 3,		-- Crusader Strike
	[SpellName(87759)] = 3,		-- Shockwave
	[SpellName(88314)] = 3,		-- Twisting Winds
	[SpellName(76622)] = 3,		-- Sunder Armor
	[SpellName(88171)] = 3,		-- Hurricane
	[SpellName(88182)] = 3,		-- Lethargic Poison
	-- Brackenhide Hollow
	[SpellName(385361)] = 3,	-- Rotting Sickness
	[SpellName(378020)] = 3,	-- Gash Frenzy
	[SpellName(385356)] = 3,	-- Ensnaring Trap
	[SpellName(373917)] = 3,	-- Decaystrike
	[SpellName(377864)] = 3,	-- Infectious Spit
	[SpellName(376933)] = 3,	-- Grasping Vines
	[SpellName(384425)] = 3,	-- Smell Like Meat
	[SpellName(373896)] = 3,	-- Withering Rot
	[SpellName(377844)] = 3,	-- Bladestorm
	[SpellName(378229)] = 3,	-- Marked for Butchery
	[SpellName(376149)] = 3,	-- Choking Rotcloud
	[SpellName(384725)] = 3,	-- Feeding Frenzy
	[SpellName(385303)] = 3,	-- Teeth Trap
	[SpellName(368299)] = 3,	-- Toxic Trap
	[SpellName(384970)] = 3,	-- Scented Meat
	[SpellName(368091)] = 3,	-- Infected Bite
	[SpellName(385185)] = 3,	-- Disoriented
	[SpellName(387210)] = 3,	-- Decaying Strength
	[SpellName(382808)] = 3,	-- Withering Contagion
	[SpellName(382723)] = 3,	-- Crushing Smash
	[SpellName(382787)] = 3,	-- Decay Claws
	[SpellName(385058)] = 3,	-- Withering Poison
	[SpellName(383399)] = 3,	-- Rotting Surge
	[SpellName(367484)] = 3,	-- Vicious Clawmangle
	[SpellName(367521)] = 3,	-- Bone Bolt
	[SpellName(368081)] = 3,	-- Withering
	[SpellName(374245)] = 3,	-- Rotting Creek
	[SpellName(367481)] = 3,	-- Bloody Bite
	-- Halls of Infusion
	[SpellName(387571)] = 3,	-- Focused Deluge
	[SpellName(383935)] = 3,	-- Spark Volley
	[SpellName(385555)] = 3,	-- Gulp
	[SpellName(384524)] = 3,	-- Titanic Fist
	[SpellName(385963)] = 3,	-- Frost Shock
	[SpellName(374389)] = 3,	-- Gulp Swog Toxin
	[SpellName(386743)] = 3,	-- Polar Winds
	[SpellName(389179)] = 3,	-- Power Overload
	[SpellName(389181)] = 3,	-- Power Field
	[SpellName(257274)] = 3,	-- Vile Coating
	[SpellName(375384)] = 3,	-- Rumbling Earth
	[SpellName(374563)] = 3,	-- Dazzle
	[SpellName(389446)] = 3,	-- Nullifying Pulse
	[SpellName(374615)] = 3,	-- Cheap Shot
	[SpellName(391610)] = 3,	-- Blinding Winds
	[SpellName(374724)] = 3,	-- Molten Subduction
	[SpellName(385168)] = 3,	-- Thunderstorm
	[SpellName(387359)] = 3,	-- Waterlogged
	[SpellName(391613)] = 3,	-- Creeping Mold
	[SpellName(374706)] = 3,	-- Pyretic Burst
	[SpellName(389443)] = 3,	-- Purifying Blast
	[SpellName(374339)] = 3,	-- Demoralizing Shout
	[SpellName(374020)] = 3,	-- Containment Beam
	[SpellName(391634)] = 3,	-- Deep Chill
	[SpellName(393444)] = 3,	-- Gushing Wound
	-- Neltharus
	[SpellName(374534)] = 3,	-- Heated Swings
	[SpellName(373735)] = 3,	-- Dragon Strike
	[SpellName(377018)] = 3,	-- Molten Gold
	[SpellName(374842)] = 3,	-- Blazing Aegis
	[SpellName(375890)] = 3,	-- Magma Eruption
	[SpellName(396332)] = 3,	-- Fiery Focus
	[SpellName(389059)] = 3,	-- Slag Eruption
	[SpellName(376784)] = 3,	-- Flame Vulnerability
	[SpellName(377542)] = 3,	-- Burning Ground
	[SpellName(374451)] = 3,	-- Burning Chain
	[SpellName(372461)] = 3,	-- Imbued Magma
	[SpellName(378818)] = 3,	-- Magma Conflagration
	[SpellName(377522)] = 3,	-- Burning Pursuit
	[SpellName(375204)] = 3,	-- Liquid Hot Magma
	[SpellName(374482)] = 3,	-- Grounding Chain
	[SpellName(372971)] = 3,	-- Reverberating Slam
	[SpellName(384161)] = 3,	-- Mote of Combustion
	[SpellName(374854)] = 3,	-- Erupted Ground
	[SpellName(373089)] = 3,	-- Scorching Fusillade
	[SpellName(372224)] = 3,	-- Dragonbone Axe
	[SpellName(372570)] = 3,	-- Bold Ambush
	[SpellName(372459)] = 3,	-- Burning
	[SpellName(372208)] = 3,	-- Djaradin Lava
	[SpellName(414585)] = 3,	-- Fiery Demise
	-- Uldaman: Legacy of Tyr
	[SpellName(368996)] = 3,	-- Purging Flames
	[SpellName(369792)] = 3,	-- Skullcracker
	[SpellName(372718)] = 3,	-- Earthen Shards
	[SpellName(382071)] = 3,	-- Resonating Orb
	[SpellName(377405)] = 3,	-- Time Sink
	[SpellName(369006)] = 3,	-- Burning Heat
	[SpellName(369110)] = 3,	-- Unstable Embers
	[SpellName(375286)] = 3,	-- Searing Cannonfire
	[SpellName(372652)] = 3,	-- Resonating Orb
	[SpellName(377825)] = 3,	-- Burning Pitch
	[SpellName(369411)] = 3,	-- Sonic Burst
	[SpellName(382576)] = 3,	-- Scorn of Tyr
	[SpellName(369366)] = 3,	-- Trapped in Stone
	[SpellName(369365)] = 3,	-- Curse of Stone
	[SpellName(369419)] = 3,	-- Venomous Fangs
	[SpellName(377486)] = 3,	-- Time Blade
	[SpellName(369818)] = 3,	-- Diseased Bite
	[SpellName(377732)] = 3,	-- Jagged Bite
	[SpellName(369828)] = 3,	-- Chomp
	[SpellName(369811)] = 3,	-- Brutal Slam
	[SpellName(376325)] = 3,	-- Eternity Zone
	[SpellName(369337)] = 3,	-- Difficult Terrain
	[SpellName(376333)] = 3,	-- Temporal Zone
	[SpellName(377510)] = 3,	-- Stolen Time
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
	[SpellName(47476)] = 2,		-- Strangulate
	[SpellName(108194)] = 4,	-- Asphyxiate
	[SpellName(207171)] = 4,	-- Winter is Coming
	[SpellName(206961)] = 3,	-- Tremble Before Me
	[SpellName(207167)] = 4,	-- Blinding Sleet
	[SpellName(212540)] = 1,	-- Flesh Hook (Pet)
	[SpellName(91807)] = 1,		-- Shambling Rush (Pet)
	[SpellName(204085)] = 1,	-- Deathchill
	[SpellName(233395)] = 1,	-- Frozen Center
	[SpellName(212332)] = 4,	-- Smash (Pet)
	[SpellName(212337)] = 4,	-- Powerful Smash (Pet)
	[SpellName(91800)] = 4,		-- Gnaw (Pet)
	[SpellName(91797)] = 4,		-- Monstrous Blow (Pet)
	[SpellName(210141)] = 3,	-- Zombie Explosion
	-- Demon Hunter
	[SpellName(207685)] = 4,	-- Sigil of Misery
	[SpellName(217832)] = 3,	-- Imprison
	[SpellName(204490)] = 4,	-- Sigil of Silence
	[SpellName(179057)] = 3,	-- Chaos Nova
	[SpellName(211881)] = 4,	-- Fel Eruption
	[SpellName(205630)] = 3,	-- Illidan's Grasp
	[SpellName(213491)] = 4,	-- Demonic Trample
	-- Druid
	[SpellName(81261)] = 2,		-- Solar Beam
	[SpellName(5211)] = 4,		-- Mighty Bash
	[SpellName(163505)] = 4,	-- Rake
	[SpellName(203123)] = 4,	-- Maim
	[SpellName(202244)] = 4,	-- Overrun
	[SpellName(99)] = 4,		-- Incapacitating Roar
	[SpellName(33786)] = 5,		-- Cyclone
	[SpellName(45334)] = 1,		-- Immobilized
	[SpellName(102359)] = 1,	-- Mass Entanglement
	[SpellName(339)] = 1,		-- Entangling Roots
	[SpellName(2637)] = 1,		-- Hibernate
	[SpellName(102793)] = 1,	-- Ursol's Vortex
	-- Evoker
	[SpellName(355689)] = 4,	-- Landslide
	[SpellName(370898)] = 1,	-- Permeating Chill
	[SpellName(360806)] = 3,	-- Sleep Walk
	-- Hunter
	[SpellName(202933)] = 4,	-- Spider Sting
	[SpellName(213691)] = 4,	-- Scatter Shot
	[SpellName(19386)] = 3,		-- Wyvern Sting
	[SpellName(3355)] = 3,		-- Freezing Trap
	[SpellName(209790)] = 3,	-- Freezing Arrow
	[SpellName(24394)] = 4,		-- Intimidation
	[SpellName(117526)] = 4,	-- Binding Shot
	[SpellName(190927)] = 1,	-- Harpoon
	[SpellName(201158)] = 1,	-- Super Sticky Tar
	[SpellName(162480)] = 1,	-- Steel Trap
	[SpellName(212638)] = 1,	-- Tracker's Net
	[SpellName(200108)] = 1,	-- Ranger's Net
	-- Mage
	[SpellName(118)] = 3,		-- Polymorph
	[SpellName(82691)] = 3,		-- Ring of Frost
	[SpellName(31661)] = 3,		-- Dragon's Breath
	[SpellName(122)] = 1,		-- Frost Nova
	[SpellName(33395)] = 1,		-- Freeze
	[SpellName(157997)] = 1,	-- Ice Nova
	[SpellName(228600)] = 1,	-- Glacial Spike
	[SpellName(198121)] = 1,	-- Frostbite
	-- Monk
	[SpellName(119381)] = 4,	-- Leg Sweep
	[SpellName(202346)] = 4,	-- Double Barrel
	[SpellName(115078)] = 4,	-- Paralysis
	[SpellName(198909)] = 3,	-- Song of Chi-Ji
	[SpellName(202274)] = 3,	-- Incendiary Brew
	[SpellName(233759)] = 4,	-- Grapple Weapon
	[SpellName(123407)] = 1,	-- Spinning Fire Blossom
	[SpellName(116706)] = 1,	-- Disable
	[SpellName(232055)] = 4,	-- Fists of Fury
	-- Paladin
	[SpellName(853)] = 3,		-- Hammer of Justice
	[SpellName(20066)] = 3,		-- Repentance
	[SpellName(105421)] = 3,	-- Blinding Light
	[SpellName(31935)] = 2,		-- Avenger's Shield
	[SpellName(217824)] = 4,	-- Shield of Virtue
	[SpellName(205290)] = 3,	-- Wake of Ashes
	-- Priest
	[SpellName(9484)] = 3,		-- Shackle Undead
	[SpellName(200196)] = 4,	-- Holy Word: Chastise
	[SpellName(226943)] = 3,	-- Mind Bomb
	[SpellName(605)] = 5,		-- Mind Control
	[SpellName(8122)] = 3,		-- Psychic Scream
	[SpellName(15487)] = 2,		-- Silence
	[SpellName(64044)] = 1,		-- Psychic Horror
	[SpellName(453)] = 5,		-- Mind Soothe
	-- Rogue
	[SpellName(2094)] = 4,		-- Blind
	[SpellName(6770)] = 4,		-- Sap
	[SpellName(1776)] = 4,		-- Gouge
	[SpellName(1330)] = 2,		-- Garrote - Silence
	[SpellName(207777)] = 4,	-- Dismantle
	[SpellName(408)] = 4,		-- Kidney Shot
	[SpellName(1833)] = 4,		-- Cheap Shot
	[SpellName(207736)] = 5,	-- Shadowy Duel (Smoke effect)
	[SpellName(212182)] = 5,	-- Smoke Bomb
	-- Shaman
	[SpellName(51514)] = 3,		-- Hex
	[SpellName(118905)] = 3,	-- Static Charge
	[SpellName(77505)] = 4,		-- Earthquake (Knocking down)
	[SpellName(118345)] = 4,	-- Pulverize (Pet)
	[SpellName(204399)] = 3,	-- Earthfury
	[SpellName(204437)] = 3,	-- Lightning Lasso
	[SpellName(157375)] = 4,	-- Gale Force
	[SpellName(64695)] = 1,		-- Earthgrab
	-- Warlock
	[SpellName(710)] = 5,		-- Banish
	[SpellName(6789)] = 3,		-- Mortal Coil
	[SpellName(118699)] = 3,	-- Fear
	[SpellName(6358)] = 3,		-- Seduction (Succub)
	[SpellName(171017)] = 4,	-- Meteor Strike (Infernal)
	[SpellName(22703)] = 4,		-- Infernal Awakening (Infernal CD)
	[SpellName(30283)] = 3,		-- Shadowfury
	[SpellName(89766)] = 4,		-- Axe Toss
	[SpellName(233582)] = 1,	-- Entrenched in Flame
	-- Warrior
	[SpellName(5246)] = 4,		-- Intimidating Shout
	[SpellName(132169)] = 4,	-- Storm Bolt
	[SpellName(132168)] = 4,	-- Shockwave
	[SpellName(199085)] = 4,	-- Warpath
	[SpellName(105771)] = 1,	-- Charge
	[SpellName(199042)] = 1,	-- Thunderstruck
	[SpellName(236077)] = 4,	-- Disarm
	-- Racial
	[SpellName(20549)] = 4,		-- War Stomp
	[SpellName(107079)] = 4,	-- Quaking Palm
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