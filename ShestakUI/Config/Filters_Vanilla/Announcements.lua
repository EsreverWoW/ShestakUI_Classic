local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.announcements.spells == true then
	T.announce_spells = {
		20484,	-- Rebirth
		20707,	-- Soulstone
		407804,	-- Divine Sacrifice [Season of Discovery]
		633,	-- Lay on Hands
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
	}
end

if C.announcements.feasts == true then
	T.AnnounceFeast = {
	}
	T.AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
	}
end

if C.announcements.portals == true then
	T.AnnouncePortals = {
		-- Alliance
		[10059] = true,		-- Stormwind
		[11416] = true,		-- Ironforge
		[11419] = true,		-- Darnassus
		-- Horde
		[11417] = true,		-- Orgrimmar
		[11420] = true,		-- Thunder Bluff
		[11418] = true,		-- Undercity
		-- Alliance/Horde
		[28148] = true,		-- Karazhan
	}
end


if C.announcements.bad_gear == true then
	T.AnnounceBadGear = {
		-- Head
		[1] = {
			[19972] = true,	-- Lucky Fishing Hat
		},
		-- Feet
		[8] = {
			[19969] = true,	-- Nat Pagle's Extreme Anglin' Boots
		},
		-- Main-Hand
		[16] = {
			[19970] = true,	-- Arcanite Fishing Pole
			[19022] = true,	-- Nat Pagle's Extreme Angler FC-5000
			[6367] = true,	-- Big Iron Fishing Pole
			[6366] = true,	-- Darkwood Fishing Pole
			[6365] = true,	-- Strong Fishing Pole
			[12225] = true,	-- Blump Family Fishing Pole
			[6256] = true,	-- Fishing Pole
		},
	}
end