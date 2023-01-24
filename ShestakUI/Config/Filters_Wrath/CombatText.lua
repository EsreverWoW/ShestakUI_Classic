local T, C, L, _ = unpack(select(2, ...))
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
		T.aoespam[49217] = 3		-- Wandering Plague
		-- Merging mh/oh strikes
		T.aoespam[49020] = 0.5		-- Obliterate MH
		-- T.aoespam[66198] = 0		-- Obliterate OH
		T.aoespam[49998] = 0.5		-- Death Strike MH
		-- T.aoespam[66188] = 0		-- Death Strike OH
		T.aoespam[45462] = 0.5		-- Plague Strike MH
		-- T.aoespam[66216] = 0		-- Plague Strike OH
		T.aoespam[49143] = 0.5		-- Frost Strike MH
		-- T.aoespam[66196] = 0		-- Frost Strike OH
	end
	if C.combattext.healing then
		T.healfilter[50475] = true	-- Blood Presence
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[22842] = 3.5		-- Frenzied Regeneration
		T.aoespam[48504] = 3		-- Living Seed
		T.aoespam[774] = 4			-- Rejuvenation
		T.aoespam[8936] = 4			-- Regrowth
		T.aoespam[740] = 3			-- Tranquility
		T.aoespam[48438] = 4		-- Wild Growth
		-- Damaging spells
		T.aoespam[779] = 0			-- Swipe
		T.aoespam[8921] = 3			-- Moonfire
		T.aoespam[48505] = 3		-- Starfall
		T.aoespam[16914] = 3		-- Hurricane
		T.aoespam[1822] = 3			-- Rake
		T.aoespam[22570] = 0		-- Mangle
		T.aoespam[1079] = 3			-- Rip
		T.aoespam[50516] = 0		-- Typhoon
	end
	if C.combattext.healing then
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[1978] = 3			-- Serpent Sting
		T.aoespam[2643] = 0			-- Multi-Shot
		T.aoespam[13812] = 3		-- Explosive Trap
		T.aoespam[1510] = 1			-- Volley
		T.aoespam[63468] = 3		-- Piercing Shots
		-- Healing spells
		T.aoespam[136] = 9			-- Mend Pet
	end
	if C.combattext.healing then
		T.healfilter[19579] = true	-- Spirit Bond
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[44457] = 3.5		-- Living Bomb
		T.aoespam[2120] = 0			-- Flamestrike
		T.aoespam[12654] = 3		-- Ignite
		T.aoespam[31661] = 0		-- Dragon's Breath
		T.aoespam[10] = 3			-- Blizzard
		T.aoespam[122] = 0			-- Frost Nova
		T.aoespam[1449] = 0			-- Arcane Explosion
		T.aoespam[120] = 0			-- Cone of Cold
		T.aoespam[7268] = 1.6		-- Arcane Missiles
		T.aoespam[11113] = 0		-- Blast Wave
		T.aoespam[59637] = 3		-- Fire Blast (Mirror Image)
		T.aoespam[59638] = 3		-- Frostbolt (Mirror Image)
		T.aoespam[44425] = 1.2		-- Arcane Barrage
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[20267] = 6		-- Judgment of Light
		-- Damaging spells
		T.aoespam[53600] = 0.5		-- Shield of the Righteous
		T.aoespam[26573] = 3		-- Consecration
		T.aoespam[53385] = 0		-- Divine Storm
		T.aoespam[53595] = 1		-- Hammer of the Righteous
		T.aoespam[20911] = 3		-- Blessing of Sanctuary
		T.aoespam[20925] = 3		-- Holy Shield
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[34861] = 1		-- Circle of Healing
		T.aoespam[15290] = 4		-- Vampiric Embrace
		T.aoespam[47540] = 2.5		-- Penance
		T.aoespam[23455] = 0		-- Holy Nova
		T.aoespam[139] = 3			-- Renew
		T.aoespam[64844] = 3		-- Divine Hymn
		T.aoespam[32546] = 3		-- Binding Heal
		T.aoespam[596] = 0			-- Prayer of Healing
		-- Damaging spells
		T.aoespam[49821] = 3		-- Mind Sear
		T.aoespam[15237] = 0		-- Holy Nova
		T.aoespam[589] = 4			-- Shadow Word: Pain
		T.aoespam[15407] = 3		-- Mind Flay
		T.aoespam[14914] = 3		-- Holy Fire
	end
	if C.combattext.healing then
		T.healfilter[15290] = false	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[51723] = 1		-- Fan of Knives
		T.aoespam[2818] = 5			-- Deadly Poison
		T.aoespam[703] = 5			-- Garrote
		T.aoespam[8680] = 3			-- Wound Poison
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[57841] = 3		-- Killing Spree
		T.aoespam[5374] = 0			-- Mutilate
		T.aoespam[1943] = 5			-- Rupture
		T.merge[27576] = 5374		-- Mutilate Off-Hand
		T.merge[57842] = 57841		-- Killing Spree Off-Hand
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[5672] = 5			-- Healing Stream Totem
		T.aoespam[1064] = 3			-- Chain Heal
		T.aoespam[61295] = 6		-- Riptide
		T.aoespam[51945] = 3		-- Earthliving
		-- Damaging spells
		-- T.aoespam[324] = 3			-- Lightning Shield
		T.aoespam[421] = 1			-- Chain Lightning
		T.aoespam[8349] = 0			-- Fire Nova
		T.aoespam[51490] = 0		-- Thunderstorm
		T.aoespam[8187] = 3			-- Magma Totem
		T.aoespam[8050] = 4			-- Flame Shock
		T.aoespam[10444] = 3		-- Flametongue Attack
		T.aoespam[3606] = 3			-- Searing Bolt
		T.aoespam[32175] = 0		-- Stormstrike
		T.merge[32176] = 32175		-- Stormstrike Off-Hand
	end
elseif T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[172] = 3			-- Corruption
		T.aoespam[348] = 3			-- Immolate
		T.aoespam[980] = 3			-- Agony
		T.aoespam[5740] = 3			-- Rain of Fire
		T.aoespam[1949] = 3			-- Hellfire
		T.aoespam[20153] = 3		-- Immolation (Infernal)
		T.aoespam[22703] = 0		-- Infernal Awakening
	end
	if C.combattext.healing then
		T.healfilter[689] = true	-- Drain Life
		T.healfilter[63108] = true	-- Siphon Life
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[55694] = 3.5		-- Enraged Regeneration
		-- Damaging spells
		T.aoespam[845] = 0.5		-- Cleave
		T.aoespam[5308] = 0.5		-- Execute Arms (Sweeping Strikes)
		T.aoespam[7384] = 0.5		-- Overpower (Sweeping Strikes)
		T.aoespam[1464] = 0.5		-- Slam (Sweeping Strikes)
		T.aoespam[12294] = 0.5		-- Mortal Strike (Sweeping Strikes)
		T.aoespam[12162] = 3		-- Deep Wounds
		T.aoespam[1680] = 1.5		-- Whirlwind
		T.aoespam[6343] = 0			-- Thunder Clap
		T.aoespam[6572] = 0			-- Revenge
		T.aoespam[772] = 3			-- Rend
		T.aoespam[23881] = 0		-- Bloodthirst
	end
	if C.combattext.healing then
		T.healfilter[23880] = true	-- Bloodthirst Heal
	end
end
