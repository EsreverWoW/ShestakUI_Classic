local T, C, L = unpack(ShestakUI)
if C.combattext.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Blizzard -> http://www.wowhead.com/spell=42208
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
-- General filter outgoing healing
if C.combattext.healing then
	T.healfilter = {}
end

-- General merge outgoing damage
if C.combattext.merge_aoe_spam then
	T.merge = {}
	T.aoespam = {}
	T.aoespam[6603] = 3				-- Auto Attack
end

-- Class config
if T.class == "DEATHKNIGHT" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[55095] = 3		-- Frost Fever
		T.aoespam[55078] = 3		-- Blood Plague
		T.aoespam[48721] = 3		-- Blood Boil
		T.aoespam[49184] = 3		-- Howling Blast
		T.aoespam[52212] = 3		-- Death and Decay
		T.aoespam[55050] = 2.5		-- Heart Strike
		T.aoespam[50401] = 3		-- Razor Frost
		-- Merging mh/oh strikes
		T.aoespam[49020] = 0.5		-- Obliterate MH
		T.merge[66198] = 49020		-- Obliterate OH
		T.aoespam[49998] = 0.5		-- Death Strike MH
		T.merge[66188] = 49998		-- Death Strike OH
		T.aoespam[45462] = 0.5		-- Plague Strike MH
		T.merge[66216] = 45462		-- Plague Strike OH
		T.aoespam[49143] = 0.5		-- Frost Strike MH
		T.merge[66196] = 49143		-- Frost Strike OH
		T.aoespam[45902] = 0.5		-- Blood Strike MH
		T.merge[66215] = 45902		-- Blood Strike OH
		T.aoespam[56815] = 0.5		-- Rune Strike MH
		T.merge[66217] = 56815		-- Rune Strike OH
		T.aoespam[85948] = 0.5		-- Festering Strike MH
		T.merge[86061] = 85948		-- Festering Strike OH
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[22842] = 3.5		-- Frenzied Regeneration
		T.aoespam[48504] = 3		-- Living Seed
		T.aoespam[774] = 4			-- Rejuvenation
		T.aoespam[8936] = 4			-- Regrowth
		T.aoespam[44203] = 3		-- Tranquility
		T.aoespam[81269] = 3		-- Efflorescence
		T.aoespam[48438] = 4		-- Wild Growth
		-- Damaging spells
		T.aoespam[779] = 0			-- Swipe (Bear)
		T.aoespam[62078] = 0		-- Swipe (Cat)
		T.aoespam[8921] = 3			-- Moonfire
		T.aoespam[93402] = 3		-- Sunfire
		T.aoespam[50286] = 3		-- Starfall
		T.aoespam[42231] = 3		-- Hurricane
		T.aoespam[1822] = 3			-- Rake
		T.aoespam[1079] = 3			-- Rip
		T.aoespam[61391] = 0		-- Typhoon
		T.aoespam[88751] = 3		-- Wild Mushroom
	end
	if C.combattext.healing then
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[1978] = 3			-- Serpent Sting
		T.aoespam[2643] = 0			-- Multi-Shot
		T.aoespam[13812] = 3		-- Explosive Trap
		T.aoespam[63468] = 3		-- Piercing Shots
		-- Healing spells
		T.aoespam[136] = 9			-- Mend Pet
	end
	if C.combattext.healing then
		T.healfilter[19579] = true	-- Spirit Bond r1
		T.healfilter[24529] = true	-- Spirit Bond r2
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[44457] = 3.5		-- Living Bomb
		T.aoespam[2120] = 0			-- Flamestrike
		T.merge[88148] = 2120		-- Flamestrike (Improved Flamestrike)
		T.aoespam[12654] = 3		-- Ignite
		T.merge[413841] = 12654		-- Ignite
		T.merge[413843] = 12654		-- Ignite
		T.aoespam[31661] = 0		-- Dragon's Breath
		T.aoespam[42208] = 3		-- Blizzard
		T.aoespam[122] = 0			-- Frost Nova
		T.aoespam[1449] = 0			-- Arcane Explosion
		T.aoespam[120] = 0			-- Cone of Cold
		T.aoespam[7268] = 1.6		-- Arcane Missiles
		T.aoespam[11113] = 0		-- Blast Wave
		T.aoespam[82731] = 1		-- Flame Orb
		T.aoespam[92283] = 1		-- Frostfire Orb
		T.aoespam[59637] = 3		-- Fire Blast (Mirror Image)
		T.aoespam[59638] = 3		-- Frostbolt (Mirror Image)
		T.aoespam[44425] = 1.2		-- Arcane Barrage
	end
	if C.combattext.healing then
		T.healfilter[91394] = true	-- Permafrost
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[85222] = 1		-- Light of Dawn
		-- Damaging spells
		T.aoespam[53600] = 0.5		-- Shield of the Righteous
		T.aoespam[26573] = 3		-- Consecration
		T.aoespam[53385] = 0		-- Divine Storm
		T.aoespam[53595] = 1		-- Hammer of the Righteous
		T.aoespam[20424] = 1		-- Seal of Command
		T.aoespam[20925] = 3		-- Holy Shield
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[34861] = 1		-- Circle of Healing
		T.aoespam[15290] = 4		-- Vampiric Embrace
		T.aoespam[47750] = 2.5		-- Penance
		T.aoespam[23455] = 0		-- Holy Nova
		T.aoespam[139] = 3			-- Renew
		T.aoespam[64844] = 3		-- Divine Hymn
		T.aoespam[32546] = 3		-- Binding Heal
		T.aoespam[596] = 0			-- Prayer of Healing
		T.aoespam[56161] = 0		-- Glyph of Prayer of Healing
		T.aoespam[33110] = 3		-- Prayer of Mending
		T.aoespam[81751] = 3		-- Atonement
		-- Damaging spells
		T.aoespam[49821] = 3		-- Mind Sear
		T.aoespam[589] = 4			-- Shadow Word: Pain
		T.aoespam[15407] = 3		-- Mind Flay
		T.aoespam[47666] = 2.5		-- Penance
		T.aoespam[14914] = 3		-- Holy Fire
		T.aoespam[87532] = 3		-- Shadowy Apparition
	end
	if C.combattext.healing then
		T.healfilter[15290] = false	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[51723] = 1		-- Fan of Knives
		T.aoespam[2818] = 5			-- Deadly Poison
		T.aoespam[703] = 5			-- Garrote
		T.aoespam[8680] = 3			-- Instant Poison
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[57841] = 3		-- Killing Spree
		T.merge[57842] = 57841		-- Killing Spree Off-Hand
		T.aoespam[5374] = 0			-- Mutilate
		T.aoespam[1943] = 5			-- Rupture
		T.merge[27576] = 5374		-- Mutilate Off-Hand
		T.merge[32321] = 5374		-- Mutilate Off-Hand
		T.aoespam[86392] = 3		-- Main Gauche
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[73921] = 5		-- Healing Rain
		T.aoespam[5672] = 5			-- Healing Stream Totem
		T.aoespam[1064] = 3			-- Chain Heal
		T.aoespam[61295] = 6		-- Riptide
		T.aoespam[51945] = 3		-- Earthliving
		T.aoespam[98021] = 3		-- Spirit Link
		-- Damaging spells
		-- T.aoespam[26545] = 3		-- Lightning Shield
		T.aoespam[421] = 1			-- Chain Lightning
		T.aoespam[8349] = 0			-- Fire Nova
		T.aoespam[51490] = 0		-- Thunderstorm
		T.aoespam[77478] = 3		-- Earthquake
		T.merge[86861] = 77478		-- Earthquake
		T.aoespam[8187] = 3			-- Magma Totem
		T.aoespam[8050] = 4			-- Flame Shock
		T.aoespam[10444] = 3		-- Flametongue Attack
		T.merge[65978] = 10444		-- Flametongue Attack
		T.aoespam[3606] = 3			-- Searing Bolt
		T.aoespam[32175] = 0		-- Stormstrike
		T.merge[32176] = 32175		-- Stormstrike Off-Hand
	end
elseif T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[172] = 3			-- Corruption
		T.aoespam[348] = 3			-- Immolate
		T.aoespam[980] = 3			-- Agony
		T.aoespam[63108] = 3		-- Siphon Life
		T.aoespam[42223] = 3		-- Rain of Fire
		T.aoespam[5857] = 3			-- Hellfire Effect
		T.aoespam[20153] = 3		-- Immolation (Infernal)
		T.aoespam[22703] = 0		-- Infernal Awakening
	end
	if C.combattext.healing then
		T.healfilter[689] = true	-- Drain Life
		T.healfilter[89420] = true	-- Drain Life
		T.healfilter[63108] = true	-- Siphon Life
		T.healfilter[63106] = true	-- Siphon Life
		T.healfilter[54181] = true	-- Fel Synergy
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[55694] = 3.5		-- Enraged Regeneration
		-- Damaging spells
		T.aoespam[845] = 0.5		-- Cleave
		T.aoespam[5308] = 0.5		-- Execute (Sweeping Strikes)
		T.aoespam[7384] = 0.5		-- Overpower (Sweeping Strikes)
		T.aoespam[1464] = 0.5		-- Slam (Sweeping Strikes)
		T.merge[81101] = 1464		-- Slam Off-Hand
		T.merge[97992] = 1464		-- Slam Off-Hand
		T.aoespam[12294] = 0.5		-- Mortal Strike (Sweeping Strikes)
		T.aoespam[12162] = 3		-- Deep Wounds r1
		T.merge[12850] = 12162		-- Deep Wounds r2
		T.merge[12868] = 12162		-- Deep Wounds r3
		T.aoespam[1680] = 1.5		-- Whirlwind
		T.merge[44949] = 1680		-- Whirlwind Off-Hand
		T.merge[95738] = 1680		-- Whirlwind Off-Hand
		T.aoespam[52174] = 0		-- Heroic Leap
		T.aoespam[96103] = 0.5		-- Raging Blow (Sweeping Strikes)
		T.merge[85384] = 96103		-- Raging Blow Off-Hand
		T.aoespam[6343] = 0			-- Thunder Clap
		T.aoespam[6572] = 0			-- Revenge
		T.aoespam[772] = 3			-- Rend
		T.aoespam[23881] = 0		-- Bloodthirst
	end
	if C.combattext.healing then
		T.healfilter[23880] = true	-- Bloodthirst Heal
	end
end
