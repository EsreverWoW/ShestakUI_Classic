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
if T.class == "DRUID" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[22842] = 3.5		-- Frenzied Regeneration r1
		T.merge[22895] = 22842		-- Frenzied Regeneration r2
		T.merge[22896] = 22842		-- Frenzied Regeneration r3
		T.aoespam[414680] = 3		-- Living Seed [Season of Discovery]
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
		T.aoespam[8936] = 4			-- Regrowth r1
		T.merge[8938] = 8936		-- Regrowth r2
		T.merge[8939] = 8936		-- Regrowth r3
		T.merge[8940] = 8936		-- Regrowth r4
		T.merge[8941] = 8936		-- Regrowth r5
		T.merge[9750] = 8936		-- Regrowth r6
		T.merge[9856] = 8936		-- Regrowth r7
		T.merge[9857] = 8936		-- Regrowth r8
		T.merge[9858] = 8936		-- Regrowth r9
		T.aoespam[740] = 3			-- Tranquility r1
		T.merge[8918] = 740			-- Tranquility r2
		T.merge[9862] = 740			-- Tranquility r3
		T.merge[9863] = 740			-- Tranquility r4
		T.aoespam[408120] = 4		-- Wild Growth [Season of Discovery]
		T.aoespam[417147] = 3		-- Efflorescence [Season of Discovery]
		-- Damaging spells
		T.aoespam[779] = 0			-- Swipe r1
		T.merge[780] = 779			-- Swipe r2
		T.merge[769] = 779			-- Swipe r3
		T.merge[9754] = 779			-- Swipe r4
		T.merge[9908] = 779			-- Swipe r5
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
		T.aoespam[414684] = 3		-- Sunfire [Season of Discovery]
		T.merge[414687] = 414684	-- Sunfire (Bear) [Season of Discovery]
		T.merge[414689] = 414684	-- Sunfire (Cat) [Season of Discovery]
		T.aoespam[16914] = 3		-- Hurricane r1
		T.merge[17401] = 16914		-- Hurricane r2
		T.merge[17402] = 16914		-- Hurricane r3
		T.aoespam[1822] = 3			-- Rake r1
		T.merge[1823] = 1822		-- Rake r2
		T.merge[1824] = 1822		-- Rake r3
		T.merge[9904] = 1822		-- Rake r4
		T.aoespam[1079] = 3			-- Rip r1
		T.merge[9492] = 1079		-- Rip r2
		T.merge[9493] = 1079		-- Rip r3
		T.merge[9752] = 1079		-- Rip r4
		T.merge[9894] = 1079		-- Rip r5
		T.merge[9896] = 1079		-- Rip r6

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
		T.merge[425728] = 1978		-- Serpent Sting r1 (Serpent Spread) [Season of Discovery]
		T.merge[425729] = 1978		-- Serpent Sting r2 (Serpent Spread) [Season of Discovery]
		T.merge[425730] = 1978		-- Serpent Sting r3 (Serpent Spread) [Season of Discovery]
		T.merge[425732] = 1978		-- Serpent Sting r4 (Serpent Spread) [Season of Discovery]
		T.merge[425733] = 1978		-- Serpent Sting r5 (Serpent Spread) [Season of Discovery]
		T.merge[425734] = 1978		-- Serpent Sting r6 (Serpent Spread) [Season of Discovery]
		T.merge[425735] = 1978		-- Serpent Sting r7 (Serpent Spread) [Season of Discovery]
		T.merge[425736] = 1978		-- Serpent Sting r8 (Serpent Spread) [Season of Discovery]
		T.merge[425737] = 1978		-- Serpent Sting r9 (Serpent Spread) [Season of Discovery]
		T.aoespam[415320] = 0.5		-- Flanking Strike [Season of Discovery]
		T.merge[415326] = 415320	-- Flanking Strike [Season of Discovery]
		T.merge[415327] = 415320	-- Flanking Strike [Season of Discovery]
		T.aoespam[2643] = 0			-- Multi-Shot r1
		T.merge[14288] = 2643		-- Multi-Shot r2
		T.merge[14289] = 2643		-- Multi-Shot r3
		T.merge[14290] = 2643		-- Multi-Shot r4
		T.merge[25294] = 2643		-- Multi-Shot r5
		T.aoespam[425711] = 0.5		-- Carve [Season of Discovery]
		T.merge[433100] = 425711	-- Carve [Season of Discovery]
		T.aoespam[13812] = 3		-- Explosive Trap r1
		T.merge[14314] = 13812		-- Explosive Trap r2
		T.merge[14315] = 13812		-- Explosive Trap r3
		T.aoespam[1510] = 1			-- Volley r1
		T.merge[14294] = 1510		-- Volley r2
		T.merge[14295] = 1510		-- Volley r3
		-- Healing spells
		T.aoespam[136] = 9			-- Mend Pet r1
		T.merge[3111] = 136			-- Mend Pet r2
		T.merge[3661] = 136			-- Mend Pet r3
		T.merge[3662] = 136			-- Mend Pet r4
		T.merge[13542] = 136		-- Mend Pet r5
		T.merge[13543] = 136		-- Mend Pet r6
		T.merge[13544] = 136		-- Mend Pet r7
	end
	if C.combattext.healing then
		T.healfilter[19579] = true	-- Spirit Bond r1
		T.healfilter[24529] = true	-- Spirit Bond r2
	end
elseif T.class == "MAGE" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[401405] = 3		-- Chronomantic Healing [Season of Discovery]
		T.merge[433455] = 401405	-- Chronomantic Healing [Season of Discovery]
		T.aoespam[436516] = 3		-- Chronostatic Preservation [Season of Discovery]
		T.aoespam[412510] = 3		-- Mass Regeneration [Season of Discovery]
		T.aoespam[401460] = 3		-- Rapid Regeneration [Season of Discovery]
		T.aoespam[401417] = 3		-- Regeneration [Season of Discovery]
		-- Damaging spells
		T.aoespam[400613] = 3.5		-- Living Bomb [Season of Discovery]
		T.aoespam[401559] = 3		-- Living Flame [Season of Discovery]
		T.aoespam[2120] = 0			-- Flamestrike r1
		T.merge[2121] = 2120		-- Flamestrike r2
		T.merge[8422] = 2120		-- Flamestrike r3
		T.merge[8423] = 2120		-- Flamestrike r4
		T.merge[10215] = 2120		-- Flamestrike r5
		T.merge[10216] = 2120		-- Flamestrike r6
		T.aoespam[12654] = 3		-- Ignite
		T.aoespam[10] = 3			-- Blizzard r1
		T.merge[6141] = 10			-- Blizzard r2
		T.merge[8427] = 10			-- Blizzard r3
		T.merge[10185] = 10			-- Blizzard r4
		T.merge[10186] = 10			-- Blizzard r5
		T.merge[10187] = 10			-- Blizzard r6
		T.aoespam[122] = 0			-- Frost Nova r1
		T.merge[865] = 122			-- Frost Nova r2
		T.merge[6131] = 122			-- Frost Nova r3
		T.merge[10230] = 122		-- Frost Nova r4
		T.aoespam[1449] = 0			-- Arcane Explosion r1
		T.merge[8437] = 1449		-- Arcane Explosion r2
		T.merge[8438] = 1449		-- Arcane Explosion r3
		T.merge[8439] = 1449		-- Arcane Explosion r4
		T.merge[10201] = 1449		-- Arcane Explosion r5
		T.merge[10202] = 1449		-- Arcane Explosion r6
		T.aoespam[120] = 0			-- Cone of Cold r1
		T.merge[8492] = 120			-- Cone of Cold r2
		T.merge[10159] = 120		-- Cone of Cold r3
		T.merge[10160] = 120		-- Cone of Cold r4
		T.merge[10161] = 120		-- Cone of Cold r5
		T.aoespam[7268] = 1.6		-- Arcane Missiles r1
		T.merge[7269] = 7268		-- Arcane Missiles r2
		T.merge[7270] = 7268		-- Arcane Missiles r3
		T.merge[8419] = 7268		-- Arcane Missiles r4
		T.merge[8418] = 7268		-- Arcane Missiles r5
		T.merge[10273] = 7268		-- Arcane Missiles r6
		T.merge[10274] = 7268		-- Arcane Missiles r7
		T.merge[25346] = 7268		-- Arcane Missiles r8
		T.aoespam[11113] = 0		-- Blast Wave r1
		T.merge[13018] = 11113		-- Blast Wave r2
		T.merge[13019] = 11113		-- Blast Wave r3
		T.merge[13020] = 11113		-- Blast Wave r4
		T.merge[13021] = 11113		-- Blast Wave r5
	end
elseif T.class == "PALADIN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[20267] = 6		-- Judgement of Light r1
		T.merge[20341] = 20267		-- Judgement of Light r2
		T.merge[20342] = 20267		-- Judgement of Light r3
		T.merge[20343] = 20267		-- Judgement of Light r4
		-- Damaging spells
		T.aoespam[26573] = 3		-- Consecration r1
		T.merge[20116] = 26573		-- Consecration r2
		T.merge[20922] = 26573		-- Consecration r3
		T.merge[20923] = 26573		-- Consecration r4
		T.merge[20924] = 26573		-- Consecration r5
		T.aoespam[407632] = 1		-- Hammer of the Righteous [Season of Discovery]
		T.aoespam[20911] = 3		-- Blessing of Sanctuary r1
		T.merge[20912] = 20911		-- Blessing of Sanctuary r2
		T.merge[20913] = 20911		-- Blessing of Sanctuary r3
		T.merge[20914] = 20911		-- Blessing of Sanctuary r4
		T.aoespam[407778] = 0		-- Divine Storm [Season of Discovery]
		T.aoespam[20925] = 3		-- Holy Shield r1
		T.merge[20927] = 20925		-- Holy Shield r2
		T.merge[20928] = 20925		-- Holy Shield r3
	end
elseif T.class == "PRIEST" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[401946] = 1		-- Circle of Healing [Season of Discovery]
		T.aoespam[15290] = 4		-- Vampiric Embrace
		T.aoespam[402289] = 2.5		-- Penance [Season of Discovery]
		T.aoespam[23455] = 0		-- Holy Nova r1
		T.merge[23458] = 23455		-- Holy Nova r2
		T.merge[23459] = 23455		-- Holy Nova r3
		T.merge[27803] = 23455		-- Holy Nova r4
		T.merge[27804] = 23455		-- Holy Nova r5
		T.merge[27805] = 23455		-- Holy Nova r6
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
		T.aoespam[596] = 0			-- Prayer of Healing r1
		T.merge[996] = 596			-- Prayer of Healing r2
		T.merge[10960] = 596		-- Prayer of Healing r3
		T.merge[10961] = 596		-- Prayer of Healing r4
		T.merge[25316] = 596		-- Prayer of Healing r5
		-- Damaging spells
		T.aoespam[413260] = 3		-- Mind Sear [Season of Discovery]
		T.aoespam[15237] = 0		-- Holy Nova r1
		T.merge[15430] = 15237		-- Holy Nova r2
		T.merge[15431] = 15237		-- Holy Nova r3
		T.merge[27799] = 15237		-- Holy Nova r4
		T.merge[27800] = 15237		-- Holy Nova r5
		T.merge[27801] = 15237		-- Holy Nova r6
		T.aoespam[589] = 4			-- Shadow Word: Pain r1
		T.merge[594] = 589			-- Shadow Word: Pain r2
		T.merge[970] = 589			-- Shadow Word: Pain r3
		T.merge[992] = 589			-- Shadow Word: Pain r4
		T.merge[2767] = 589			-- Shadow Word: Pain r5
		T.merge[10892] = 589		-- Shadow Word: Pain r6
		T.merge[10893] = 589		-- Shadow Word: Pain r7
		T.merge[10894] = 589		-- Shadow Word: Pain r8
		T.aoespam[15407] = 3		-- Mind Flay r1
		T.merge[17311] = 15407		-- Mind Flay r2
		T.merge[17312] = 15407		-- Mind Flay r3
		T.merge[17313] = 15407		-- Mind Flay r4
		T.merge[17314] = 15407		-- Mind Flay r5
		T.merge[18807] = 15407		-- Mind Flay r6
		T.aoespam[402284] = 2.5		-- Penance [Season of Discovery]
		T.aoespam[14914] = 3		-- Holy Fire r1
		T.merge[15262] = 14914		-- Holy Fire r2
		T.merge[15263] = 14914		-- Holy Fire r3
		T.merge[15264] = 14914		-- Holy Fire r4
		T.merge[15265] = 14914		-- Holy Fire r5
		T.merge[15266] = 14914		-- Holy Fire r6
		T.merge[15267] = 14914		-- Holy Fire r7
		T.merge[15261] = 14914		-- Holy Fire r8
		T.aoespam[425204] = 2.5		-- Void Plague [Season of Discovery]
		T.aoespam[431681] = 3		-- Void Zone [Season of Discovery]
	end
	if C.combattext.healing then
		T.healfilter[15290] = false	-- Vampiric Embrace
	end
elseif T.class == "ROGUE" then
	if C.combattext.merge_aoe_spam then
		T.aoespam[2818] = 5			-- Deadly Poison
		T.merge[2819] = 2818		-- Deadly Poison II
		T.merge[11353] = 2818		-- Deadly Poison III
		T.merge[11354] = 2818		-- Deadly Poison IV
		T.merge[25349] = 2818		-- Deadly Poison V
		T.aoespam[703] = 5			-- Garrote r1
		T.merge[8631] = 703			-- Garrote r2
		T.merge[8632] = 703			-- Garrote r3
		T.merge[8633] = 703			-- Garrote r4
		T.merge[11289] = 703		-- Garrote r5
		T.merge[11290] = 703		-- Garrote r6
		T.aoespam[8680] = 3			-- Instant Poison
		T.merge[8685] = 8680		-- Instant Poison II
		T.merge[8688] = 8680		-- Instant Poison III
		T.merge[11338] = 8680		-- Instant Poison IV
		T.merge[11336] = 8680		-- Instant Poison V
		T.merge[11337] = 8680		-- Instant Poison VI
		T.aoespam[22482] = 3		-- Blade Flurry
		T.aoespam[399960] = 0		-- Mutilate [Season of Discovery]
		T.aoespam[424785] = 5		-- Saber Slash [Season of Discovery]
		T.aoespam[1943] = 5			-- Rupture r1
		T.merge[8639] = 1943		-- Rupture r2
		T.merge[8640] = 1943		-- Rupture r3
		T.merge[11273] = 1943		-- Rupture r4
		T.merge[11274] = 1943		-- Rupture r5
		T.merge[11275] = 1943		-- Rupture r6
		T.aoespam[399986] = 3		-- Shuriken Toss [Season of Discovery]
		T.merge[399961] = 5374		-- Mutilate Off-Hand [Season of Discovery]
	end
elseif T.class == "SHAMAN" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[415242] = 5		-- Healing Rain [Season of Discovery]
		T.aoespam[5672] = 5			-- Healing Stream Totem r1
		T.merge[6371] = 5672		-- Healing Stream Totem r2
		T.merge[6372] = 5672		-- Healing Stream Totem r3
		T.merge[10460] = 5672		-- Healing Stream Totem r4
		T.merge[10461] = 5672		-- Healing Stream Totem r5
		T.aoespam[1064] = 3			-- Chain Heal r1
		T.merge[10622] = 1064		-- Chain Heal r2
		T.merge[10623] = 1064		-- Chain Heal r3
		T.aoespam[409333] = 3		-- Ancestral Guidance [Season of Discovery]
		T.aoespam[408521] = 6		-- Riptide [Season of Discovery]
		-- Damaging spells
		-- T.aoespam[26545] = 3		-- Lightning Shield
		T.aoespam[421] = 1			-- Chain Lightning r1
		T.merge[930] = 421			-- Chain Lightning r2
		T.merge[2860] = 421			-- Chain Lightning r3
		T.merge[10605] = 421		-- Chain Lightning r4
		T.aoespam[8349] = 0			-- Fire Nova r1
		T.merge[8502] = 8349		-- Fire Nova r2
		T.merge[8503] = 8349		-- Fire Nova r3
		T.merge[11306] = 8349		-- Fire Nova r4
		T.merge[11307] = 8349		-- Fire Nova r5
		T.merge[408424] = 8349		-- Fire Nova r2 [Season of Discovery]
		T.merge[408426] = 8349		-- Fire Nova r3 [Season of Discovery]
		T.merge[408427] = 8349		-- Fire Nova r4 [Season of Discovery]
		T.merge[408428] = 8349		-- Fire Nova r5 [Season of Discovery]
		T.aoespam[8187] = 3			-- Magma Totem r1
		T.merge[10579] = 8187		-- Magma Totem r2
		T.merge[10580] = 8187		-- Magma Totem r3
		T.merge[10581] = 8187		-- Magma Totem r4
		T.aoespam[8050] = 4			-- Flame Shock r1
		T.merge[8052] = 8050		-- Flame Shock r2
		T.merge[8053] = 8050		-- Flame Shock r3
		T.merge[10447] = 8050		-- Flame Shock r4
		T.merge[10448] = 8050		-- Flame Shock r5
		T.merge[29228] = 8050		-- Flame Shock r6
		T.aoespam[29469] = 3		-- Flametongue Attack r1
		T.merge[29228] = 29469		-- Flametongue Attack r2
		T.merge[10444] = 29469		-- Flametongue Attack r3
		T.aoespam[3606] = 3			-- Searing Bolt r1
		T.merge[6350] = 3606		-- Searing Bolt r2
		T.merge[6351] = 3606		-- Searing Bolt r3
		T.merge[6352] = 3606		-- Searing Bolt r4
		T.merge[10435] = 3606		-- Searing Bolt r5
		T.merge[10436] = 3606		-- Searing Bolt r6
		T.aoespam[409337] = 3		-- Ancestral Guidance [Season of Discovery]
		-- T.aoespam[432129] = 3		-- Rolling Thunder [Season of Discovery]
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
		T.aoespam[348] = 3			-- Immolate r1
		T.merge[707] = 348			-- Immolate r2
		T.merge[1094] = 348			-- Immolate r3
		T.merge[2941] = 348			-- Immolate r4
		T.merge[11665] = 348		-- Immolate r5
		T.merge[11667] = 348		-- Immolate r6
		T.merge[11668] = 348		-- Immolate r7
		T.merge[25309] = 348		-- Immolate r8
		T.aoespam[980] = 3			-- Agony r1
		T.merge[1014] = 980			-- Agony r2
		T.merge[6217] = 980			-- Agony r3
		T.merge[11711] = 980		-- Agony r4
		T.merge[11712] = 980		-- Agony r5
		T.merge[11713] = 980		-- Agony r6
		T.aoespam[18265] = 3		-- Siphon Life r1
		T.merge[18879] = 18265		-- Siphon Life r2
		T.merge[18880] = 18265		-- Siphon Life r3
		T.merge[18881] = 18265		-- Siphon Life r4
		T.aoespam[5740] = 3			-- Rain of Fire r1
		T.merge[6219] = 5740		-- Rain of Fire r2
		T.merge[11677] = 5740		-- Rain of Fire r3
		T.merge[11678] = 5740		-- Rain of Fire r4
		T.aoespam[5857] = 3			-- Hellfire Effect r1
		T.merge[11681] = 5857		-- Hellfire Effect r2
		T.merge[11682] = 5857		-- Hellfire Effect r3
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
		T.healfilter[403677] = true	-- Drain Life r1 [Season of Discovery]
		T.healfilter[403685] = true	-- Drain Life r2 [Season of Discovery]
		T.healfilter[403686] = true	-- Drain Life r3 [Season of Discovery]
		T.healfilter[403687] = true	-- Drain Life r4 [Season of Discovery]
		T.healfilter[403688] = true	-- Drain Life r5 [Season of Discovery]
		T.healfilter[403689] = true	-- Drain Life r6 [Season of Discovery]
		T.healfilter[18265] = true	-- Siphon Life r1
		T.healfilter[18879] = true	-- Siphon Life r2
		T.healfilter[18880] = true	-- Siphon Life r3
		T.healfilter[18881] = true	-- Siphon Life r4
	end
elseif T.class == "WARRIOR" then
	if C.combattext.merge_aoe_spam then
		-- Healing spells
		T.aoespam[402913] = 3.5		-- Enraged Regeneration [Season of Discovery]
		-- Damaging spells
		T.aoespam[845] = 0.5		-- Cleave r1
		T.merge[7369] = 845			-- Cleave r2
		T.merge[11608] = 845		-- Cleave r3
		T.merge[11609] = 845		-- Cleave r4
		T.merge[20569] = 845		-- Cleave r5
		T.aoespam[5308] = 0.5		-- Execute r1 (Sweeping Strikes)
		T.merge[20658] = 5308		-- Execute r2 (Sweeping Strikes)
		T.merge[20660] = 5308		-- Execute r3 (Sweeping Strikes)
		T.merge[20661] = 5308		-- Execute r4 (Sweeping Strikes)
		T.merge[20662] = 5308		-- Execute r5 (Sweeping Strikes)
		T.aoespam[7384] = 0.5		-- Overpower r1 (Sweeping Strikes)
		T.merge[7887] = 7384		-- Overpower r2 (Sweeping Strikes)
		T.merge[11584] = 7384		-- Overpower r3 (Sweeping Strikes)
		T.merge[11585] = 7384		-- Overpower r4 (Sweeping Strikes)
		T.aoespam[1464] = 0.5		-- Slam r1 (Sweeping Strikes)
		T.merge[8820] = 1464		-- Slam r2 (Sweeping Strikes)
		T.merge[11604] = 1464		-- Slam r3 (Sweeping Strikes)
		T.merge[11605] = 1464		-- Slam r4 (Sweeping Strikes)
		T.aoespam[12294] = 0.5		-- Mortal Strike r1 (Sweeping Strikes)
		T.merge[21551] = 12294		-- Mortal Strike r2 (Sweeping Strikes)
		T.merge[21552] = 12294		-- Mortal Strike r3 (Sweeping Strikes)
		T.merge[21553] = 12294		-- Mortal Strike r4 (Sweeping Strikes)
		T.aoespam[12162] = 3		-- Deep Wounds r1
		T.merge[12850] = 12162		-- Deep Wounds r2
		T.merge[12868] = 12162		-- Deep Wounds r3
		T.aoespam[1680] = 1.5		-- Whirlwind
		T.aoespam[6343] = 0			-- Thunder Clap r1
		T.merge[8198] = 6343		-- Thunder Clap r2
		T.merge[8204] = 6343		-- Thunder Clap r3
		T.merge[8205] = 6343		-- Thunder Clap r4
		T.merge[11580] = 6343		-- Thunder Clap r5
		T.merge[11581] = 6343		-- Thunder Clap r6
		T.aoespam[6572] = 0			-- Revenge r1
		T.merge[6574] = 6572		-- Revenge r2
		T.merge[7379] = 6572		-- Revenge r3
		T.merge[11600] = 6572		-- Revenge r4
		T.merge[11601] = 6572		-- Revenge r5
		T.merge[25288] = 6572		-- Revenge r6
		T.aoespam[772] = 3			-- Rend r1
		T.merge[6546] = 772			-- Rend r2
		T.merge[6547] = 772			-- Rend r3
		T.merge[6548] = 772			-- Rend r4
		T.merge[11572] = 772		-- Rend r5
		T.merge[11573] = 772		-- Rend r6
		T.merge[11574] = 772		-- Rend r7
		T.aoespam[23881] = 0		-- Bloodthirst r1
		T.merge[23892] = 23881		-- Bloodthirst r2
		T.merge[23893] = 23881		-- Bloodthirst r3
		T.merge[23894] = 23881		-- Bloodthirst r4
	end
	if C.combattext.healing then
		T.healfilter[23880] = true	-- Bloodthirst Heal r1
		T.healfilter[23889] = true	-- Bloodthirst Heal r2
		T.healfilter[23890] = true	-- Bloodthirst Heal r3
		T.healfilter[23891] = true	-- Bloodthirst Heal r4
	end
end
