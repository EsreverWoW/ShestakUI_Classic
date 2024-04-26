local T, C, L = unpack(ShestakUI)
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Sap -> http://www.wowhead.com/spell=6770
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.DiminishingSpells = {
	-- Stuns
	[47481] = {"stun"},				-- Gnaw (Ghoul)
	[5211] = {"stun"},				-- Bash
	[9005] = {"stun"},				-- Pounce
	[24394] = {"stun"},				-- Intimidation
	[44572] = {"stun"},				-- Deep Freeze
	[853] = {"stun"},				-- Hammer of Justice
	[1833] = {"stun"},				-- Cheap Shot
	[58861] = {"stun"},				-- Bash (Spirit Wolf)
	[93975] = {"stun"},				-- Aura of Foreboding r1
	[93986] = {"stun"},				-- Aura of Foreboding r2
	[60995] = {"stun"},				-- Demon Leap (Metamorphosis)
	[22703] = {"stun"},				-- Inferno Effect
	[30153] = {"stun"},				-- Intercept (Felguard)
	[30283] = {"stun"},				-- Shadowfury
	[7922] = {"stun"},				-- Charge Stun
	[96273] = {"stun"},				-- Charge Stun
	[12809] = {"stun"},				-- Concussion Blow
	[20253] = {"stun"},				-- Intercept
	[46968] = {"stun"},				-- Shockwave
	[85388] = {"stun"},				-- Throwdown
	[20549] = {"stun"},				-- War Stomp (Racial)
	[835] = {"stun"},				-- Tidal Charm
	[4064] = {"stun"},				-- Rough Copper Bomb
	[4065] = {"stun"},				-- Large Copper Bomb
	[4066] = {"stun"},				-- Small Bronze Bomb
	[4067] = {"stun"},				-- Big Bronze Bomb
	[4068] = {"stun"},				-- Iron Grenade
	[4069] = {"stun"},				-- Big Iron Bomb
	[12421] = {"stun"},				-- Mithril Frag Bomb
	[12543] = {"stun"},				-- Hi-Explosive Bomb
	[12562] = {"stun"},				-- The Big One
	[13237] = {"stun"},				-- Goblin Mortar
	[13808] = {"stun"},				-- M73 Frag Grenade
	[19769] = {"stun"},				-- Thorium Grenade
	[19784] = {"stun"},				-- Dark Iron Bomb
	[30216] = {"stun"},				-- Fel Iron Bomb
	[30461] = {"stun"},				-- The Bigger One
	[30217] = {"stun"},				-- Adamantite Grenade
	[67769] = {"stun"},				-- Cobalt Frag Bomb
	[53261] = {"stun"},				-- Saronite Grenade
	[54735] = {"stun"},				-- Electromagnetic Pulse

	--[[
	-- Stun Procs
	[12355] = {"stunproc"},			-- Impact
	[77505] = {"stunproc"},			-- Earthquake
	[39796] = {"stunproc"},			-- Stoneclaw Totem
	[56] = {"stunproc"},			-- Stun (The Chief's Enforcer / Bludgeon of the Grinning Dog / The Judge's Gavel / Hammer of the Titans)
	[15283] = {"stunproc"},			-- Stunning Blow (Dark Iron Pulverizer)
	[21152] = {"stunproc"},			-- Earthshaker (Earthshaker)
	--]]

	-- Disorients
	[49203] = {"disorient"},		-- Hungering Cold
	[22570] = {"disorient"},		-- Maim
	[118] = {"disorient"},			-- Polymorph
	[61305] = {"disorient"},		-- Polymorph: Black Cat
	[28272] = {"disorient"},		-- Polymorph: Pig
	[61721] = {"disorient"},		-- Polymorph: Rabbit
	[61025] = {"disorient"},		-- Polymorph: Serpent
	[61780] = {"disorient"},		-- Polymorph: Turkey
	[28271] = {"disorient"},		-- Polymorph: Turtle
	[59634] = {"disorient"},		-- Polymorph - Penguin
	[88625] = {"disorient"},		-- Holy Word: Chastise
	[1776] = {"disorient"},			-- Gouge
	[6770] = {"disorient"},			-- Sap
	[76780] = {"disorient"},		-- Bind Elemental
	[51514] = {"disorient"},		-- Hex
	[13327] = {"disorient"},		-- Reckless Charge (Horned Viking Helmet / Goblin Rocket Helmet)
	[26108] = {"disorient"},		-- Glimpse of Madness (Dark Edge of Insanity)

	-- Sleeps
	[2637] = {"sleep"},				-- Hibernate
	[19386] = {"sleep"},			-- Wyvern Sting

	-- Charms
	[605] = {"charm"},				-- Mind Control
	[13180] = {"charm"},			-- Gnomish Mind Control Cap
	[13181] = {"charm"},			-- Gnomish Thinking Cap / Mind Amplification Dish

	-- Fears
	[1513] = {"fear"},				-- Scare Beast
	[8122] = {"fear"},				-- Psychic Scream
	[87204] = {"fear"},				-- Sin and Punishment
	[5782] = {"fear"},				-- Fear
	[5484] = {"fear"},				-- Howl of Terror
	[6358] = {"fear"},				-- Seduction (Succubus)
	[5246] = {"fear"},				-- Intimidating Shout
	[5134] = {"fear"},				-- Flash Bomb (Flash Bomb)

	-- Horrors
	[64044] = {"horror"},			-- Psychic Horror
	[6789] = {"horror"},			-- Death Coil

	-- Unstable Affliction
	[43523] = {"ua"},				-- Unstable Affliction (Silence)
	[31117] = {"ua"},				-- Unstable Affliction (Silence)

	-- Roots
	[53534] = {"root"},				-- Chains of Ice
	-- [45334] = {"root"},				-- Feral Charge Effect
	[339] = {"root"},				-- Entangling Roots
	[19975] = {"root"},				-- Entangling Roots (Nature's Grasp)
	[19306] = {"root"},				-- Counterattack
	[19185] = {"root"},				-- Entrapment
	[33395] = {"root"},				-- Freeze (Water Elemental)
	[122] = {"root"},				-- Frost Nova
	[82691] = {"root"},				-- Ring of Frost
	[55080] = {"root"},				-- Shattered Barrier r1
	[83073] = {"root"},				-- Shattered Barrier r2
	[87193] = {"root"},				-- Paralysis r1
	[87194] = {"root"},				-- Paralysis r2
	[93974] = {"root"},				-- Aura of Foreboding r1
	[93987] = {"root"},				-- Aura of Foreboding r2
	[53019] = {"root"},				-- Earth's Grasp
	-- [58373] = {"root"},				-- Glyph of Hamstring
	-- [23694] = {"root"},				-- Improved Hamstring
	-- [27868] = {"root"},				-- Freeze (Magister's Regalia / Sorcerer's Regalia / Deadman's Hand)
	[39965] = {"root"},				-- Frost Grenade

	--[[
	-- Disarms
	[64346] = {"disarm"},			-- Fiery Payback
	[64058] = {"disarm"},			-- Psychic Horror
	[51722] = {"disarm"},			-- Dismantle
	[676] = {"disarm"},				-- Disarm
	--]]

	--[[
	-- Silences
	[47476] = {"silence"},			-- Strangulate
	[80964] = {"silence"},			-- Skull Bash (Bear)
	[80965] = {"silence"},			-- Skull Bash (Cat)
	[34490] = {"silence"},			-- Silencing Shot
	[18469] = {"silence"},			-- Silenced - Improved Counterspell
	[31935] = {"silence"},			-- Avenger's Shield
	[15487] = {"silence"},			-- Silence
	[1330] = {"silence"},			-- Garrote - Silence
	[24259] = {"silence"},			-- Spell Lock (Felhunter)
	[18498] = {"silence"},			-- Silenced - Gag Order
	[18425] = {"silence"},			-- Silenced - Improved Kick
	[28730] = {"silence"},			-- Arcane Torrent (Mana)
	[25046] = {"silence"},			-- Arcane Torrent (Energy)
	[50613] = {"silence"},			-- Arcane Torrent (Runic Power)
	-- [44835] = {"silence"},			-- Maim Interrupt (incorrect spellID)
	[32747] = {"silence"},			-- Interrupt
	--]]

	-- Cyclone / Blind
	[33786] = {"cycloneblind"},		-- Cyclone
	[2094] = {"cycloneblind"},		-- Blind

	-- Freezing Trap
	[3355] = {"freezingtrap"},		-- Freezing Trap

	-- Scatter Shot
	[19503] = {"scattershot"},		-- Scatter Shot

	-- Dragon's Breath
	[31661] = {"dragonsbreath"},	-- Dragon's Breath

	-- Repentance
	[20066] = {"repentance"},		-- Repentance

	--[[
	-- Turn Evil
	[10326] = {"turned"},			-- Turn Evil
	--]]

	--[[
	-- Shackle Undead
	[9484] = {"shackle"},			-- Shackle Undead
	--]]

	-- Kidney Shot
	[408] = {"kidneyshot"},			-- Kidney Shot

	-- Frost Shock
	[8056] = {"frostshock"},		-- Frost Shock
	[73682] = {"frostshock"},		-- Unleash Frost
}

local function GetIcon(id)
	local _, _, icon = GetSpellInfo(id)
	return icon
end

T.DiminishingIcons = {
	["stun"] = GetIcon(853),
	-- ["stunproc"] = GetIcon(5530),
	["disorient"] = GetIcon(118),
	["sleep"] = GetIcon(19386),
	["charm"] = GetIcon(605),
	["fear"] = GetIcon(8122),
	["horror"] = GetIcon(5782),
	["ua"] = GetIcon(43523),
	["root"] = GetIcon(339),
	-- ["disarm"] = GetIcon(676),
	-- ["silence"] = GetIcon(15487),
	["cycloneblind"] = GetIcon(33786),
	["freezingtrap"] = GetIcon(3355),
	["scattershot"] = GetIcon(19503),
	["dragonsbreath"] = GetIcon(31661),
	["repentance"] = GetIcon(20066),
	-- ["turned"] = GetIcon(10326),
	-- ["shackle"] = GetIcon(9484),
	["kidneyshot"] = GetIcon(408),
	["frostshock"] = GetIcon(8056),
}
