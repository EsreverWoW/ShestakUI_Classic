local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.announcements.spells == true then
	T.announce_spells = {
		61999,	-- Raise Ally
		20484,	-- Rebirth
		20707,	-- Soulstone
		31821,	-- Aura Mastery
		64205,	-- Divine Sacrifice
		633,	-- Lay on Hands
		34477,	-- Misdirection
		57934,	-- Tricks of the Trade
		19801,	-- Tranquilizing Shot
	}

	if #C.announcements.spells_list > 0 then
		T.announce_spells = C.announcements.spells_list
	else
		if C.options.announcements and C.options.announcements.spells_list then
			C.options.announcements.spells_list = nil
		end
	end
	T.AnnounceSpells = {}
	for _, spell in pairs(T.announce_spells) do
		T.AnnounceSpells[spell] = true
	end
end

if C.announcements.toys == true then
	T.AnnounceToys = {
		[61031] = true,		-- Toy Train Set
		[49844] = true,		-- Direbrew's Remote
	}
end

if C.announcements.feasts == true then
	T.AnnounceFeast = {
		[57301] = true,		-- Great Feast
		[57426] = true,		-- Fish Feast
		[58465] = true,		-- Gigantic Feast
		[58474] = true,		-- Small Feast
		[66476] = true,		-- Bountiful Feast
	}
	T.AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
		[44389] = true,		-- Field Repair Bot 110G
		[54711] = true,		-- Scrapbot
		[67826] = true,		-- Jeeves
	}
end

if C.announcements.portals == true then
	T.AnnouncePortals = {
		-- Alliance
		[10059] = true,		-- Stormwind
		[11416] = true,		-- Ironforge
		[11419] = true,		-- Darnassus
		[32266] = true,		-- Exodar
		[49360] = true,		-- Theramore
		[33691] = true,		-- Shattrath
		[88345] = true,		-- Tol Barad
		-- Horde
		[11417] = true,		-- Orgrimmar
		[11420] = true,		-- Thunder Bluff
		[11418] = true,		-- Undercity
		[32267] = true,		-- Silvermoon
		[49361] = true,		-- Stonard
		[35717] = true,		-- Shattrath
		[88346] = true,		-- Tol Barad
		-- Alliance/Horde
		[28148] = true,		-- Karazhan
		[53142] = true,		-- Dalaran
	}
end


if C.announcements.bad_gear == true then
	local badRings = {
		[40585] = true,		-- Signet of the Kirin Tor
		[40586] = true,		-- Band of the Kirin Tor
		[44934] = true,		-- Loop of the Kirin Tor
		[44935] = true,		-- Ring of the Kirin Tor
		[45688] = true,		-- Inscribed Band of the Kirin Tor
		[45689] = true,		-- Inscribed Loop of the Kirin Tor
		[45690] = true,		-- Inscribed Ring of the Kirin Tor
		[45691] = true,		-- Inscribed Signet of the Kirin Tor
		[48954] = true,		-- Etched Band of the Kirin Tor
		[48955] = true,		-- Etched Loop of the Kirin Tor
		[48956] = true,		-- Etched Ring of the Kirin Tor
		[48957] = true,		-- Etched Signet of the Kirin Tor
		[51557] = true,		-- Runed Signet of the Kirin Tor
		[51558] = true,		-- Runed Loop of the Kirin Tor
		[51559] = true,		-- Runed Ring of the Kirin Tor
		[51560] = true,		-- Runed Band of the Kirin Tor
	}

	T.AnnounceBadGear = {
		-- Head
		[1] = {
			[33820] = true,	-- Weather-Beaten Fishing Hat
			[19972] = true,	-- Lucky Fishing Hat
		},
		-- Neck
		[2] = {
			[32757] = true,	-- Blessed Medallion of Karabor
		},
		-- Feet
		[8] = {
			[50287] = true,	-- Boots of the Bay
			[19969] = true,	-- Nat Pagle's Extreme Anglin' Boots
		},
		-- Rings
		[11] = badRings,
		[12] = badRings,
		-- Back
		[15] = {
			[65360] = true,		-- Cloak of Coordination (Alliance)
			[65274] = true,		-- Cloak of Coordination (Horde)
		},
		-- Main-Hand
		[16] = {
			[44050] = true,	-- Mastercraft Kalu'ak Fishing Pole
			[45992] = true,	-- Jeweled Fishing Pole
			[45991] = true,	-- Bone Fishing Pole
			[45858] = true,	-- Nat's Lucky Fishing Pole
			[19970] = true,	-- Arcanite Fishing Pole
			[19022] = true,	-- Nat Pagle's Extreme Angler FC-5000
			[25978] = true,	-- Seth's Graphite Fishing Pole
			[6367] = true,	-- Big Iron Fishing Pole
			[6366] = true,	-- Darkwood Fishing Pole
			[6365] = true,	-- Strong Fishing Pole
			[12225] = true,	-- Blump Family Fishing Pole
			[6256] = true,	-- Fishing Pole
		},
	}
end