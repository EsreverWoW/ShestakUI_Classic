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
		T.aoespam[49217] = 3		-- Wandering Plague
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
	end
	if C.combattext.healing then
		T.healfilter[50475] = true	-- Blood Presence
	end
elseif T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[22842] = 3.5		-- Frenzied Regeneration
		T.aoespam[48504] = 3		-- Living Seed
		T.aoespam[774] = 4			-- Rejuvenation r1
		T.merge[1058] = 774			-- Rejuvenation r2
		T.merge[1430] = 774			-- Rejuvenation r3
		T.merge[2090] = 774			-- Rejuvenation r4
		T.merge[2091] = 774			-- Rejuvenation r5
		T.merge[3627] = 774			-- Rejuvenation r6
		T.merge[8910] = 774			-- Rejuvenation r7
		T.merge[9839] = 774			-- Rejuvenation r8
		T.merge[9840] = 774			-- Rejuvenation r9
		T.merge[9841] = 774			-- Rejuvenation r10
		T.merge[25299] = 774		-- Rejuvenation r11
		T.merge[26981] = 774		-- Rejuvenation r12
		T.merge[26982] = 774		-- Rejuvenation r13
		T.merge[48440] = 774		-- Rejuvenation r14
		T.merge[48441] = 774		-- Rejuvenation r15
		T.aoespam[8936] = 4			-- Regrowth r1
		T.merge[8938] = 8936		-- Regrowth r2
		T.merge[8939] = 8936		-- Regrowth r3
		T.merge[8940] = 8936		-- Regrowth r4
		T.merge[8941] = 8936		-- Regrowth r5
		T.merge[9750] = 8936		-- Regrowth r6
		T.merge[9856] = 8936		-- Regrowth r7
		T.merge[9857] = 8936		-- Regrowth r8
		T.merge[9858] = 8936		-- Regrowth r9
		T.merge[26980] = 8936		-- Regrowth r10
		T.merge[48442] = 8936		-- Regrowth r11
		T.merge[48443] = 8936		-- Regrowth r12
		T.aoespam[44203] = 3		-- Tranquility r1
		T.merge[44205] = 44203		-- Tranquility r2
		T.merge[44206] = 44203		-- Tranquility r3
		T.merge[44207] = 44203		-- Tranquility r4
		T.merge[44208] = 44203		-- Tranquility r5
		T.merge[48444] = 44203		-- Tranquility r6
		T.merge[48445] = 44203		-- Tranquility r7
		T.aoespam[48438] = 4		-- Wild Growth r1
		T.merge[53248] = 48438		-- Wild Growth r2
		T.merge[53249] = 48438		-- Wild Growth r3
		T.merge[53251] = 48438		-- Wild Growth r4
		-- Damaging spells
		T.aoespam[779] = 0			-- Swipe (Bear) r1
		T.merge[780] = 779			-- Swipe (Bear) r2
		T.merge[769] = 779			-- Swipe (Bear) r3
		T.merge[9754] = 779			-- Swipe (Bear) r4
		T.merge[9908] = 779			-- Swipe (Bear) r5
		T.merge[26997] = 779		-- Swipe (Bear) r6
		T.merge[48561] = 779		-- Swipe (Bear) r7
		T.merge[48562] = 779		-- Swipe (Bear) r8
		T.aoespam[62078] = 0		-- Swipe (Cat)
		T.aoespam[8921] = 3			-- Moonfire r1
		T.merge[8924] = 8921		-- Moonfire r2
		T.merge[8925] = 8921		-- Moonfire r3
		T.merge[8926] = 8921		-- Moonfire r4
		T.merge[8927] = 8921		-- Moonfire r5
		T.merge[8928] = 8921		-- Moonfire r6
		T.merge[8929] = 8921		-- Moonfire r7
		T.merge[9833] = 8921		-- Moonfire r8
		T.merge[9834] = 8921		-- Moonfire r9
		T.merge[9835] = 8921		-- Moonfire r10
		T.merge[26987] = 8921		-- Moonfire r11
		T.merge[26988] = 8921		-- Moonfire r12
		T.merge[48462] = 8921		-- Moonfire r13
		T.merge[48463] = 8921		-- Moonfire r14
		T.aoespam[50286] = 3		-- Starfall r1
		T.merge[53196] = 50286		-- Starfall r2
		T.merge[53197] = 50286		-- Starfall r3
		T.merge[53198] = 50286		-- Starfall r4
		T.aoespam[42231] = 3		-- Hurricane r1
		T.merge[42232] = 42231		-- Hurricane r2
		T.merge[42233] = 42231		-- Hurricane r3
		T.merge[42230] = 42231		-- Hurricane r4
		T.merge[48466] = 42231		-- Hurricane r5
		T.aoespam[1822] = 3			-- Rake r1
		T.merge[1823] = 1822		-- Rake r2
		T.merge[1824] = 1822		-- Rake r3
		T.merge[9904] = 1822		-- Rake r4
		T.merge[27003] = 1822		-- Rake r5
		T.merge[48573] = 1822		-- Rake r6
		T.merge[48574] = 1822		-- Rake r7
		T.aoespam[1079] = 3			-- Rip r1
		T.merge[9492] = 1079		-- Rip r2
		T.merge[9493] = 1079		-- Rip r3
		T.merge[9752] = 1079		-- Rip r4
		T.merge[9894] = 1079		-- Rip r5
		T.merge[9896] = 1079		-- Rip r6
		T.merge[27008] = 1079		-- Rip r7
		T.merge[49799] = 1079		-- Rip r8
		T.merge[49800] = 1079		-- Rip r9
		T.aoespam[61391] = 0		-- Typhoon r1
		T.merge[61390] = 61391		-- Typhoon r2
		T.merge[61388] = 61391		-- Typhoon r3
		T.merge[61387] = 61391		-- Typhoon r4
		T.merge[53227] = 61391		-- Typhoon r5
	end
	if C.combattext.healing then
	end
elseif T.class == "HUNTER" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[1978] = 3			-- Serpent Sting r1
		T.merge[13549] = 1978		-- Serpent Sting r2
		T.merge[13550] = 1978		-- Serpent Sting r3
		T.merge[13551] = 1978		-- Serpent Sting r4
		T.merge[13552] = 1978		-- Serpent Sting r5
		T.merge[13553] = 1978		-- Serpent Sting r6
		T.merge[13554] = 1978		-- Serpent Sting r7
		T.merge[13555] = 1978		-- Serpent Sting r8
		T.merge[25295] = 1978		-- Serpent Sting r9
		T.merge[27016] = 1978		-- Serpent Sting r10
		T.merge[49000] = 1978		-- Serpent Sting r11
		T.merge[49001] = 1978		-- Serpent Sting r12
		T.aoespam[2643] = 0			-- Multi-Shot r1
		T.merge[14288] = 2643		-- Multi-Shot r2
		T.merge[14289] = 2643		-- Multi-Shot r3
		T.merge[14290] = 2643		-- Multi-Shot r4
		T.merge[25294] = 2643		-- Multi-Shot r5
		T.merge[27021] = 2643		-- Multi-Shot r6
		T.merge[49047] = 2643		-- Multi-Shot r7
		T.merge[49048] = 2643		-- Multi-Shot r8
		T.aoespam[13812] = 3		-- Explosive Trap r1
		T.merge[14314] = 13812		-- Explosive Trap r2
		T.merge[14315] = 13812		-- Explosive Trap r3
		T.merge[27026] = 13812		-- Explosive Trap r4
		T.merge[49064] = 13812		-- Explosive Trap r5
		T.merge[49065] = 13812		-- Explosive Trap r6
		T.aoespam[42243] = 1		-- Volley r1
		T.merge[42244] = 42243		-- Volley r2
		T.merge[42245] = 42243		-- Volley r3
		T.merge[42234] = 42243		-- Volley r4
		T.merge[58432] = 42243		-- Volley r5
		T.merge[58433] = 42243		-- Volley r6
		T.aoespam[63468] = 3		-- Piercing Shots
		-- Healing spells
		T.aoespam[136] = 9			-- Mend Pet r1
		T.merge[3111] = 136			-- Mend Pet r2
		T.merge[3661] = 136			-- Mend Pet r3
		T.merge[3662] = 136			-- Mend Pet r4
		T.merge[13542] = 136		-- Mend Pet r5
		T.merge[13543] = 136		-- Mend Pet r6
		T.merge[13544] = 136		-- Mend Pet r7
		T.merge[27046] = 136		-- Mend Pet r8
		T.merge[48989] = 136		-- Mend Pet r9
		T.merge[48990] = 136		-- Mend Pet r10
	end
	if C.combattext.healing then
		T.healfilter[19579] = true	-- Spirit Bond r1
		T.healfilter[24529] = true	-- Spirit Bond r2
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[44457] = 3.5		-- Living Bomb r1
		T.merge[55359] = 44457		-- Living Bomb r2
		T.merge[55360] = 44457		-- Living Bomb r3
		T.aoespam[2120] = 0			-- Flamestrike r1
		T.merge[2121] = 2120		-- Flamestrike r2
		T.merge[8422] = 2120		-- Flamestrike r3
		T.merge[8423] = 2120		-- Flamestrike r4
		T.merge[10215] = 2120		-- Flamestrike r5
		T.merge[10216] = 2120		-- Flamestrike r6
		T.merge[27086] = 2120		-- Flamestrike r7
		T.merge[42925] = 2120		-- Flamestrike r8
		T.merge[42926] = 2120		-- Flamestrike r9
		T.aoespam[12654] = 3		-- Ignite
		T.aoespam[31661] = 0		-- Dragon's Breath r1
		T.merge[33041] = 31661		-- Dragon's Breath r2
		T.merge[33042] = 31661		-- Dragon's Breath r3
		T.merge[33043] = 31661		-- Dragon's Breath r4
		T.merge[42949] = 31661		-- Dragon's Breath r5
		T.merge[42950] = 31661		-- Dragon's Breath r6
		T.aoespam[42208] = 3		-- Blizzard r1
		T.merge[42209] = 42208		-- Blizzard r2
		T.merge[42210] = 42208		-- Blizzard r3
		T.merge[42211] = 42208		-- Blizzard r4
		T.merge[42212] = 42208		-- Blizzard r5
		T.merge[42213] = 42208		-- Blizzard r6
		T.merge[42198] = 42208		-- Blizzard r7
		T.merge[42937] = 42208		-- Blizzard r8
		T.merge[42938] = 42208		-- Blizzard r9
		T.aoespam[122] = 0			-- Frost Nova r1
		T.merge[865] = 122			-- Frost Nova r2
		T.merge[6131] = 122			-- Frost Nova r3
		T.merge[10230] = 122		-- Frost Nova r4
		T.merge[27088] = 122		-- Frost Nova r5
		T.merge[42917] = 122		-- Frost Nova r6
		T.aoespam[1449] = 0			-- Arcane Explosion r1
		T.merge[8437] = 1449		-- Arcane Explosion r2
		T.merge[8438] = 1449		-- Arcane Explosion r3
		T.merge[8439] = 1449		-- Arcane Explosion r4
		T.merge[10201] = 1449		-- Arcane Explosion r5
		T.merge[10202] = 1449		-- Arcane Explosion r6
		T.merge[27080] = 1449		-- Arcane Explosion r7
		T.merge[27082] = 1449		-- Arcane Explosion r8
		T.merge[42920] = 1449		-- Arcane Explosion r9
		T.merge[42921] = 1449		-- Arcane Explosion r10
		T.aoespam[120] = 0			-- Cone of Cold r1
		T.merge[8492] = 120			-- Cone of Cold r2
		T.merge[10159] = 120		-- Cone of Cold r3
		T.merge[10160] = 120		-- Cone of Cold r4
		T.merge[10161] = 120		-- Cone of Cold r5
		T.merge[27087] = 120		-- Cone of Cold r6
		T.merge[42930] = 120		-- Cone of Cold r7
		T.merge[42931] = 120		-- Cone of Cold r8
		T.aoespam[7268] = 1.6		-- Arcane Missiles r1
		T.merge[7269] = 7268		-- Arcane Missiles r2
		T.merge[7270] = 7268		-- Arcane Missiles r3
		T.merge[8419] = 7268		-- Arcane Missiles r4
		T.merge[8418] = 7268		-- Arcane Missiles r5
		T.merge[10273] = 7268		-- Arcane Missiles r6
		T.merge[10274] = 7268		-- Arcane Missiles r7
		T.merge[25346] = 7268		-- Arcane Missiles r8
		T.merge[27076] = 7268		-- Arcane Missiles r9
		T.merge[38700] = 7268		-- Arcane Missiles r10
		T.merge[38703] = 7268		-- Arcane Missiles r11
		T.merge[42844] = 7268		-- Arcane Missiles r12
		T.merge[42845] = 7268		-- Arcane Missiles r13
		T.aoespam[11113] = 0		-- Blast Wave r1
		T.merge[13018] = 11113		-- Blast Wave r2
		T.merge[13019] = 11113		-- Blast Wave r3
		T.merge[13020] = 11113		-- Blast Wave r4
		T.merge[13021] = 11113		-- Blast Wave r5
		T.merge[27133] = 11113		-- Blast Wave r6
		T.merge[33933] = 11113		-- Blast Wave r7
		T.merge[42944] = 11113		-- Blast Wave r8
		T.merge[42945] = 11113		-- Blast Wave r9
		T.aoespam[59637] = 3		-- Fire Blast (Mirror Image)
		T.aoespam[59638] = 3		-- Frostbolt (Mirror Image)
		T.aoespam[44425] = 1.2		-- Arcane Barrage r1
		T.merge[44780] = 44425		-- Arcane Barrage r2
		T.merge[44781] = 44425		-- Arcane Barrage r3
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[20267] = 6		-- Judgement of Light
		-- Damaging spells
		T.aoespam[53600] = 0.5		-- Shield of the Righteous r1
		T.merge[61411] = 53600		-- Shield of the Righteous r2
		T.aoespam[26573] = 3		-- Consecration r1
		T.merge[20116] = 26573		-- Consecration r2
		T.merge[20922] = 26573		-- Consecration r3
		T.merge[20923] = 26573		-- Consecration r4
		T.merge[20924] = 26573		-- Consecration r5
		T.merge[27173] = 26573		-- Consecration r6
		T.merge[48818] = 26573		-- Consecration r7
		T.merge[48819] = 26573		-- Consecration r8
		T.aoespam[53385] = 0		-- Divine Storm
		T.aoespam[53595] = 1		-- Hammer of the Righteous
		T.aoespam[20424] = 1		-- Seal of Command
		T.aoespam[20925] = 3		-- Holy Shield r1
		T.merge[20927] = 20925		-- Holy Shield r2
		T.merge[20928] = 20925		-- Holy Shield r3
		T.merge[27179] = 20925		-- Holy Shield r4
		T.merge[48951] = 20925		-- Holy Shield r5
		T.merge[48952] = 20925		-- Holy Shield r6
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[34861] = 1		-- Circle of Healing r1
		T.merge[34863] = 34861		-- Circle of Healing r2
		T.merge[34864] = 34861		-- Circle of Healing r3
		T.merge[34865] = 34861		-- Circle of Healing r4
		T.merge[34866] = 34861		-- Circle of Healing r5
		T.merge[48088] = 34861		-- Circle of Healing r6
		T.merge[48089] = 34861		-- Circle of Healing r7
		T.aoespam[15290] = 4		-- Vampiric Embrace
		T.aoespam[47750] = 2.5		-- Penance r1
		T.merge[52983] = 47750		-- Penance r2
		T.merge[52984] = 47750		-- Penance r3
		T.merge[52985] = 47750		-- Penance r4
		T.aoespam[23455] = 0		-- Holy Nova r1
		T.merge[23458] = 23455		-- Holy Nova r2
		T.merge[23459] = 23455		-- Holy Nova r3
		T.merge[27803] = 23455		-- Holy Nova r4
		T.merge[27804] = 23455		-- Holy Nova r5
		T.merge[27805] = 23455		-- Holy Nova r6
		T.merge[25329] = 23455		-- Holy Nova r7
		T.merge[48075] = 23455		-- Holy Nova r8
		T.merge[48076] = 23455		-- Holy Nova r9
		T.aoespam[139] = 3			-- Renew r1
		T.merge[6074] = 139			-- Renew r2
		T.merge[6075] = 139			-- Renew r3
		T.merge[6076] = 139			-- Renew r4
		T.merge[6077] = 139			-- Renew r5
		T.merge[6078] = 139			-- Renew r6
		T.merge[10927] = 139		-- Renew r7
		T.merge[10928] = 139		-- Renew r8
		T.merge[10929] = 139		-- Renew r9
		T.merge[25315] = 139		-- Renew r10
		T.merge[25221] = 139		-- Renew r11
		T.merge[25222] = 139		-- Renew r12
		T.merge[48067] = 139		-- Renew r13
		T.merge[48068] = 139		-- Renew r14
		T.aoespam[64844] = 3		-- Divine Hymn
		T.aoespam[32546] = 3		-- Binding Heal
		T.aoespam[596] = 0			-- Prayer of Healing r1
		T.merge[996] = 596			-- Prayer of Healing r2
		T.merge[10960] = 596		-- Prayer of Healing r3
		T.merge[10961] = 596		-- Prayer of Healing r4
		T.merge[25316] = 596		-- Prayer of Healing r5
		T.merge[25308] = 596		-- Prayer of Healing r6
		T.merge[48072] = 596		-- Prayer of Healing r7
		T.aoespam[33110] = 3		-- Prayer of Mending
		-- Damaging spells
		T.aoespam[49821] = 3		-- Mind Sear r1
		T.merge[53022] = 49821		-- Mind Sear r2
		T.aoespam[15237] = 0		-- Holy Nova r1
		T.merge[15430] = 15237		-- Holy Nova r2
		T.merge[15431] = 15237		-- Holy Nova r3
		T.merge[27799] = 15237		-- Holy Nova r4
		T.merge[27800] = 15237		-- Holy Nova r5
		T.merge[27801] = 15237		-- Holy Nova r6
		T.merge[25331] = 15237		-- Holy Nova r7
		T.merge[48077] = 15237		-- Holy Nova r8
		T.merge[48078] = 15237		-- Holy Nova r9
		T.aoespam[589] = 4			-- Shadow Word: Pain r1
		T.merge[594] = 589			-- Shadow Word: Pain r2
		T.merge[970] = 589			-- Shadow Word: Pain r3
		T.merge[992] = 589			-- Shadow Word: Pain r4
		T.merge[2767] = 589			-- Shadow Word: Pain r5
		T.merge[10892] = 589		-- Shadow Word: Pain r6
		T.merge[10893] = 589		-- Shadow Word: Pain r7
		T.merge[10894] = 589		-- Shadow Word: Pain r8
		T.merge[25367] = 589		-- Shadow Word: Pain r9
		T.merge[25368] = 589		-- Shadow Word: Pain r10
		T.merge[48124] = 589		-- Shadow Word: Pain r11
		T.merge[48125] = 589		-- Shadow Word: Pain r12
		T.aoespam[15407] = 3		-- Mind Flay r1
		T.merge[17311] = 15407		-- Mind Flay r2
		T.merge[17312] = 15407		-- Mind Flay r3
		T.merge[17313] = 15407		-- Mind Flay r4
		T.merge[17314] = 15407		-- Mind Flay r5
		T.merge[18807] = 15407		-- Mind Flay r6
		T.merge[25387] = 15407		-- Mind Flay r7
		T.merge[48155] = 15407		-- Mind Flay r8
		T.merge[48156] = 15407		-- Mind Flay r9
		T.aoespam[47666] = 2.5		-- Penance r1
		T.merge[52998] = 47666		-- Penance r2
		T.merge[52999] = 47666		-- Penance r3
		T.merge[53000] = 47666		-- Penance r4
		T.aoespam[14914] = 3		-- Holy Fire r1
		T.merge[15262] = 14914		-- Holy Fire r2
		T.merge[15263] = 14914		-- Holy Fire r3
		T.merge[15264] = 14914		-- Holy Fire r4
		T.merge[15265] = 14914		-- Holy Fire r5
		T.merge[15266] = 14914		-- Holy Fire r6
		T.merge[15267] = 14914		-- Holy Fire r7
		T.merge[15261] = 14914		-- Holy Fire r8
		T.merge[25384] = 14914		-- Holy Fire r9
		T.merge[48134] = 14914		-- Holy Fire r10
		T.merge[48135] = 14914		-- Holy Fire r11
	end
	if C.combattext.healing then
		T.healfilter[15290] = false	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[51723] = 1		-- Fan of Knives
		T.aoespam[2818] = 5			-- Deadly Poison
		T.merge[2819] = 2818		-- Deadly Poison II
		T.merge[11353] = 2818		-- Deadly Poison III
		T.merge[11354] = 2818		-- Deadly Poison IV
		T.merge[25349] = 2818		-- Deadly Poison V
		T.merge[26968] = 2818		-- Deadly Poison VI
		-- T.merge[26968] = 2818		-- Deadly Poison VII -- Note: What is the spell ID, if it even exists?
		T.merge[57969] = 2818		-- Deadly Poison VIII
		T.aoespam[703] = 5			-- Garrote r1
		T.merge[8631] = 703			-- Garrote r2
		T.merge[8632] = 703			-- Garrote r3
		T.merge[8633] = 703			-- Garrote r4
		T.merge[11289] = 703		-- Garrote r5
		T.merge[11290] = 703		-- Garrote r6
		T.merge[26839] = 703		-- Garrote r7
		T.merge[26884] = 703		-- Garrote r8
		T.merge[48675] = 703		-- Garrote r9
		T.merge[48676] = 703		-- Garrote r10
		T.aoespam[8680] = 3			-- Instant Poison
		T.merge[8685] = 8680		-- Instant Poison II
		T.merge[8688] = 8680		-- Instant Poison III
		T.merge[11338] = 8680		-- Instant Poison IV
		T.merge[11336] = 8680		-- Instant Poison V
		T.merge[11337] = 8680		-- Instant Poison VI
		T.merge[26890] = 8680		-- Instant Poison VII
		T.merge[57964] = 8680		-- Instant Poison VIII
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[57841] = 3		-- Killing Spree
		T.merge[57842] = 57841		-- Killing Spree Off-Hand
		T.aoespam[5374] = 0			-- Mutilate r1
		T.merge[34414] = 5374		-- Mutilate r2
		T.merge[34416] = 5374		-- Mutilate r3
		T.merge[34419] = 5374		-- Mutilate r4
		T.merge[48662] = 5374		-- Mutilate r5
		T.merge[48665] = 5374		-- Mutilate r6
		T.aoespam[1943] = 5			-- Rupture r1
		T.merge[8639] = 1943		-- Rupture r2
		T.merge[8640] = 1943		-- Rupture r3
		T.merge[11273] = 1943		-- Rupture r4
		T.merge[11274] = 1943		-- Rupture r5
		T.merge[11275] = 1943		-- Rupture r6
		T.merge[26867] = 1943		-- Rupture r7
		T.merge[48671] = 1943		-- Rupture r8
		T.merge[48672] = 1943		-- Rupture r9
		T.merge[27576] = 5374		-- Mutilate Off-Hand r1
		T.merge[34415] = 5374		-- Mutilate Off-Hand r2
		T.merge[34417] = 5374		-- Mutilate Off-Hand r3
		T.merge[34418] = 5374		-- Mutilate Off-Hand r4
		T.merge[48661] = 5374		-- Mutilate Off-Hand r5
		T.merge[48664] = 5374		-- Mutilate Off-Hand r6
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[5672] = 5			-- Healing Stream Totem r1
		T.merge[6371] = 5672		-- Healing Stream Totem r2
		T.merge[6372] = 5672		-- Healing Stream Totem r3
		T.merge[10460] = 5672		-- Healing Stream Totem r4
		T.merge[10461] = 5672		-- Healing Stream Totem r5
		T.merge[25566] = 5672		-- Healing Stream Totem r6
		T.merge[58763] = 5672		-- Healing Stream Totem r7
		T.merge[58764] = 5672		-- Healing Stream Totem r8
		T.merge[58765] = 5672		-- Healing Stream Totem r9
		T.aoespam[1064] = 3			-- Chain Heal r1
		T.merge[10622] = 1064		-- Chain Heal r2
		T.merge[10623] = 1064		-- Chain Heal r3
		T.merge[25422] = 1064		-- Chain Heal r4
		T.merge[25423] = 1064		-- Chain Heal r5
		T.merge[55458] = 1064		-- Chain Heal r6
		T.merge[55459] = 1064		-- Chain Heal r7
		T.aoespam[61295] = 6		-- Riptide r1
		T.merge[61299] = 61295		-- Riptide r2
		T.merge[61300] = 61295		-- Riptide r3
		T.merge[61301] = 61295		-- Riptide r4
		T.aoespam[51945] = 3		-- Earthliving r1
		T.merge[51990] = 51945		-- Earthliving r2
		T.merge[51997] = 51945		-- Earthliving r3
		T.merge[51998] = 51945		-- Earthliving r4
		T.merge[51999] = 51945		-- Earthliving r5
		T.merge[52000] = 51945		-- Earthliving r6
		-- Damaging spells
		-- T.aoespam[26545] = 3		-- Lightning Shield
		T.aoespam[421] = 1			-- Chain Lightning r1
		T.merge[930] = 421			-- Chain Lightning r2
		T.merge[2860] = 421			-- Chain Lightning r3
		T.merge[10605] = 421		-- Chain Lightning r4
		T.merge[25439] = 421		-- Chain Lightning r5
		T.merge[25442] = 421		-- Chain Lightning r6
		T.merge[49270] = 421		-- Chain Lightning r7
		T.merge[49271] = 421		-- Chain Lightning r8
		T.aoespam[8349] = 0			-- Fire Nova r1
		T.merge[8502] = 8349		-- Fire Nova r2
		T.merge[8503] = 8349		-- Fire Nova r3
		T.merge[11306] = 8349		-- Fire Nova r4
		T.merge[11307] = 8349		-- Fire Nova r5
		T.merge[25535] = 8349		-- Fire Nova r6
		T.merge[25537] = 8349		-- Fire Nova r7
		T.merge[61654] = 8349		-- Fire Nova r8
		T.merge[61650] = 8349		-- Fire Nova r9
		T.aoespam[51490] = 0		-- Thunderstorm r1
		T.merge[59156] = 51490		-- Thunderstorm r2
		T.merge[59158] = 51490		-- Thunderstorm r3
		T.merge[59159] = 51490		-- Thunderstorm r4
		T.aoespam[8187] = 3			-- Magma Totem r1
		T.merge[10579] = 8187		-- Magma Totem r2
		T.merge[10580] = 8187		-- Magma Totem r3
		T.merge[10581] = 8187		-- Magma Totem r4
		T.merge[25550] = 8187		-- Magma Totem r5
		T.merge[58732] = 8187		-- Magma Totem r6
		T.merge[58735] = 8187		-- Magma Totem r7
		T.aoespam[8050] = 4			-- Flame Shock r1
		T.merge[8052] = 8050		-- Flame Shock r2
		T.merge[8053] = 8050		-- Flame Shock r3
		T.merge[10447] = 8050		-- Flame Shock r4
		T.merge[10448] = 8050		-- Flame Shock r5
		T.merge[29228] = 8050		-- Flame Shock r6
		T.merge[25457] = 8050		-- Flame Shock r7
		T.merge[49232] = 8050		-- Flame Shock r8
		T.merge[49233] = 8050		-- Flame Shock r9
		T.aoespam[10444] = 3		-- Flametongue Attack
		T.merge[65978] = 10444		-- Flametongue Attack
		T.aoespam[3606] = 3			-- Searing Bolt r1
		T.merge[6350] = 3606		-- Searing Bolt r2
		T.merge[6351] = 3606		-- Searing Bolt r3
		T.merge[6352] = 3606		-- Searing Bolt r4
		T.merge[10435] = 3606		-- Searing Bolt r5
		T.merge[10436] = 3606		-- Searing Bolt r6
		T.merge[25530] = 3606		-- Searing Bolt r7
		T.merge[58700] = 3606		-- Searing Bolt r8
		T.merge[58701] = 3606		-- Searing Bolt r9
		T.merge[58702] = 3606		-- Searing Bolt r10
		T.aoespam[32175] = 0		-- Stormstrike
		T.merge[32176] = 32175		-- Stormstrike Off-Hand
	end
elseif T.class == "WARLOCK" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[172] = 3			-- Corruption r1
		T.merge[6222] = 172			-- Corruption r2
		T.merge[6223] = 172			-- Corruption r3
		T.merge[7648] = 172			-- Corruption r4
		T.merge[11671] = 172		-- Corruption r5
		T.merge[11672] = 172		-- Corruption r6
		T.merge[25311] = 172		-- Corruption r7
		T.merge[27216] = 172		-- Corruption r8
		T.merge[47812] = 172		-- Corruption r9
		T.merge[47813] = 172		-- Corruption r10
		T.aoespam[348] = 3			-- Immolate r1
		T.merge[707] = 348			-- Immolate r2
		T.merge[1094] = 348			-- Immolate r3
		T.merge[2941] = 348			-- Immolate r4
		T.merge[11665] = 348		-- Immolate r5
		T.merge[11667] = 348		-- Immolate r6
		T.merge[11668] = 348		-- Immolate r7
		T.merge[25309] = 348		-- Immolate r8
		T.merge[27215] = 348		-- Immolate r9
		T.merge[47810] = 348		-- Immolate r10
		T.merge[47811] = 348		-- Immolate r11
		T.aoespam[980] = 3			-- Agony r1
		T.merge[1014] = 980			-- Agony r2
		T.merge[6217] = 980			-- Agony r3
		T.merge[11711] = 980		-- Agony r4
		T.merge[11712] = 980		-- Agony r5
		T.merge[11713] = 980		-- Agony r6
		T.merge[27218] = 980		-- Agony r7
		T.merge[47863] = 980		-- Agony r8
		T.merge[47864] = 980		-- Agony r9
		T.aoespam[63108] = 3		-- Siphon Life
		T.aoespam[42223] = 3		-- Rain of Fire r1
		T.merge[42224] = 42223		-- Rain of Fire r2
		T.merge[42225] = 42223		-- Rain of Fire r3
		T.merge[42226] = 42223		-- Rain of Fire r4
		T.merge[42218] = 42223		-- Rain of Fire r5
		T.merge[47817] = 42223		-- Rain of Fire r6
		T.merge[47818] = 42223		-- Rain of Fire r7
		T.aoespam[5857] = 3			-- Hellfire Effect r1
		T.merge[11681] = 5857		-- Hellfire Effect r2
		T.merge[11682] = 5857		-- Hellfire Effect r3
		T.merge[27214] = 5857		-- Hellfire Effect r4
		T.merge[47822] = 5857		-- Hellfire Effect r5
		T.aoespam[20153] = 3		-- Immolation (Infernal)
		T.aoespam[22703] = 0		-- Infernal Awakening
	end
	if C.combattext.healing then
		T.healfilter[689] = true	-- Drain Life r1
		T.healfilter[699] = true	-- Drain Life r2
		T.healfilter[709] = true	-- Drain Life r3
		T.healfilter[7651] = true	-- Drain Life r4
		T.healfilter[11699] = true	-- Drain Life r5
		T.healfilter[11700] = true	-- Drain Life r6
		T.healfilter[27219] = true	-- Drain Life r7
		T.healfilter[27220] = true	-- Drain Life r8
		T.healfilter[47857] = true	-- Drain Life r9
		T.healfilter[63108] = true	-- Siphon Life
		T.healfilter[63106] = true	-- Siphon Life
		T.healfilter[54181] = true	-- Fel Synergy
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[55694] = 3.5		-- Enraged Regeneration
		-- Damaging spells
		T.aoespam[845] = 0.5		-- Cleave r1
		T.merge[7369] = 845			-- Cleave r2
		T.merge[11608] = 845		-- Cleave r3
		T.merge[11609] = 845		-- Cleave r4
		T.merge[20569] = 845		-- Cleave r5
		T.merge[25231] = 845		-- Cleave r6
		T.merge[47519] = 845		-- Cleave r7
		T.merge[47520] = 845		-- Cleave r8
		T.aoespam[5308] = 0.5		-- Execute r1 (Sweeping Strikes)
		T.merge[20658] = 5308		-- Execute r2 (Sweeping Strikes)
		T.merge[20660] = 5308		-- Execute r3 (Sweeping Strikes)
		T.merge[20661] = 5308		-- Execute r4 (Sweeping Strikes)
		T.merge[20662] = 5308		-- Execute r5 (Sweeping Strikes)
		T.merge[25234] = 5308		-- Execute r6 (Sweeping Strikes)
		T.merge[25236] = 5308		-- Execute r7 (Sweeping Strikes)
		T.merge[47470] = 5308		-- Execute r8 (Sweeping Strikes)
		T.merge[47471] = 5308		-- Execute r9 (Sweeping Strikes)
		T.aoespam[7384] = 0.5		-- Overpower r1 (Sweeping Strikes)
		T.merge[7887] = 7384		-- Overpower r2 (Sweeping Strikes)
		T.merge[11584] = 7384		-- Overpower r3 (Sweeping Strikes)
		T.merge[11585] = 7384		-- Overpower r4 (Sweeping Strikes)
		T.aoespam[1464] = 0.5		-- Slam r1 (Sweeping Strikes)
		T.merge[8820] = 1464		-- Slam r2 (Sweeping Strikes)
		T.merge[11604] = 1464		-- Slam r3 (Sweeping Strikes)
		T.merge[11605] = 1464		-- Slam r4 (Sweeping Strikes)
		T.merge[25241] = 1464		-- Slam r5 (Sweeping Strikes)
		T.merge[25242] = 1464		-- Slam r6 (Sweeping Strikes)
		T.merge[47474] = 1464		-- Slam r7 (Sweeping Strikes)
		T.merge[47475] = 1464		-- Slam r8 (Sweeping Strikes)
		T.aoespam[12294] = 0.5		-- Mortal Strike r1 (Sweeping Strikes)
		T.merge[21551] = 12294		-- Mortal Strike r2 (Sweeping Strikes)
		T.merge[21552] = 12294		-- Mortal Strike r3 (Sweeping Strikes)
		T.merge[21553] = 12294		-- Mortal Strike r4 (Sweeping Strikes)
		T.merge[25248] = 12294		-- Mortal Strike r5 (Sweeping Strikes)
		T.merge[30330] = 12294		-- Mortal Strike r6 (Sweeping Strikes)
		T.merge[47485] = 12294		-- Mortal Strike r7 (Sweeping Strikes)
		T.merge[47486] = 12294		-- Mortal Strike r8 (Sweeping Strikes)
		T.aoespam[12162] = 3		-- Deep Wounds r1
		T.merge[12850] = 12162		-- Deep Wounds r2
		T.merge[12868] = 12162		-- Deep Wounds r3
		T.aoespam[1680] = 1.5		-- Whirlwind
		T.merge[44949] = 1680		-- Whirlwind Off-Hand
		T.aoespam[6343] = 0			-- Thunder Clap r1
		T.merge[8198] = 6343		-- Thunder Clap r2
		T.merge[8204] = 6343		-- Thunder Clap r3
		T.merge[8205] = 6343		-- Thunder Clap r4
		T.merge[11580] = 6343		-- Thunder Clap r5
		T.merge[11581] = 6343		-- Thunder Clap r6
		T.merge[25264] = 6343		-- Thunder Clap r7
		T.merge[47501] = 6343		-- Thunder Clap r8
		T.merge[47502] = 6343		-- Thunder Clap r9
		T.aoespam[6572] = 0			-- Revenge r1
		T.merge[6574] = 6572		-- Revenge r2
		T.merge[7379] = 6572		-- Revenge r3
		T.merge[11600] = 6572		-- Revenge r4
		T.merge[11601] = 6572		-- Revenge r5
		T.merge[25288] = 6572		-- Revenge r6
		T.merge[25269] = 6572		-- Revenge r7
		T.merge[30357] = 6572		-- Revenge r8
		T.merge[57823] = 6572		-- Revenge r9
		T.aoespam[772] = 3			-- Rend r1
		T.merge[6546] = 772			-- Rend r2
		T.merge[6547] = 772			-- Rend r3
		T.merge[6548] = 772			-- Rend r4
		T.merge[11572] = 772		-- Rend r5
		T.merge[11573] = 772		-- Rend r6
		T.merge[11574] = 772		-- Rend r7
		T.merge[25208] = 772		-- Rend r8
		T.merge[46845] = 772		-- Rend r9
		T.merge[47465] = 772		-- Rend r10
		T.aoespam[23881] = 0		-- Bloodthirst r1
		T.merge[23892] = 23881		-- Bloodthirst r2
		T.merge[23893] = 23881		-- Bloodthirst r3
		T.merge[23894] = 23881		-- Bloodthirst r4
		T.merge[25251] = 23881		-- Bloodthirst r5
		T.merge[30335] = 23881		-- Bloodthirst r6
	end
	if C.combattext.healing then
		T.healfilter[23880] = true	-- Bloodthirst Heal r1
		T.healfilter[23889] = true	-- Bloodthirst Heal r2
		T.healfilter[23890] = true	-- Bloodthirst Heal r3
		T.healfilter[23891] = true	-- Bloodthirst Heal r4
		T.healfilter[25253] = true	-- Bloodthirst Heal r5
		T.healfilter[30340] = true	-- Bloodthirst Heal r6
	end
end
