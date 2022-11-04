local _, ns = ...
local oUF = ns.oUF

-- sourced from FrameXML/ArenaUI.lua
local MAX_ARENA_ENEMIES = _G.MAX_ARENA_ENEMIES or 5

-- sourced from FrameXML/TargetFrame.lua
local MAX_BOSS_FRAMES = _G.MAX_BOSS_FRAMES or 5

-- sourced from FrameXML/PartyMemberFrame.lua
local MAX_PARTY_MEMBERS = _G.MAX_PARTY_MEMBERS or 4

local isArenaHooked = false
local isPartyHooked = false

local hiddenParent = CreateFrame('Frame', nil, UIParent)
hiddenParent:SetAllPoints()
hiddenParent:Hide()

local function insecureOnShow(self)
	self:Hide()
end

local function handleFrame(baseName, doNotReparent)
	local frame
	if(type(baseName) == 'string') then
		frame = _G[baseName]
	else
		frame = baseName
	end

	if(frame) then
		frame:UnregisterAllEvents()
		frame:Hide()

		if(not doNotReparent) then
			frame:SetParent(hiddenParent)
		end

		local health = frame.healthBar or frame.healthbar or frame.HealthBar
		if(health) then
			health:UnregisterAllEvents()
		end

		local power = frame.manabar or frame.ManaBar
		if(power) then
			power:UnregisterAllEvents()
		end

		local spell = frame.castBar or frame.spellbar
		if(spell) then
			spell:UnregisterAllEvents()
		end

		local altpowerbar = frame.powerBarAlt or frame.PowerBarAlt
		if(altpowerbar) then
			altpowerbar:UnregisterAllEvents()
		end

		local buffFrame = frame.BuffFrame
		if(buffFrame) then
			buffFrame:UnregisterAllEvents()
		end

		local petFrame = frame.petFrame or frame.PetFrame
		if(petFrame) then
			petFrame:UnregisterAllEvents()
		end

		local totFrame = frame.totFrame
		if(totFrame) then
			totFrame:UnregisterAllEvents()
		end
	end
end

function oUF:DisableBlizzard(unit)
	if(not unit) then return end

	if(unit == 'player') then
		handleFrame(PlayerFrame)

		-- For the damn vehicle support:
		PlayerFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
		if(not oUF:IsClassic() or oUF:IsWrath()) then
			PlayerFrame:RegisterEvent('UNIT_ENTERING_VEHICLE')
			PlayerFrame:RegisterEvent('UNIT_ENTERED_VEHICLE')
			PlayerFrame:RegisterEvent('UNIT_EXITING_VEHICLE')
			PlayerFrame:RegisterEvent('UNIT_EXITED_VEHICLE')
		end

		-- User placed frames don't animate
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetDontSavePosition(true)
	elseif(unit == 'pet') then
		handleFrame(PetFrame)
	elseif(unit == 'target') then
		handleFrame(TargetFrame)
		if(oUF:IsClassic()) then
			handleFrame(ComboFrame)
		end
	elseif(unit == 'focus') then
		handleFrame(FocusFrame)
		if (oUF:IsClassic()) then
			handleFrame(TargetofFocusFrame)
		end
	elseif(oUF:IsClassic() and unit == 'targettarget') then
		handleFrame(TargetFrameToT)
	elseif(unit:match('boss%d?$')) then
		local id = unit:match('boss(%d)')
		if(id) then
			handleFrame('Boss' .. id .. 'TargetFrame')
		else
			for i = 1, MAX_BOSS_FRAMES do
				handleFrame('Boss' .. i .. 'TargetFrame')
			end
		end
	elseif(unit:match('party%d?$')) then
		if(oUF:IsClassic()) then
			local id = unit:match('party(%d)')
			if(id) then
				handleFrame('PartyMemberFrame' .. id)
			else
				for i = 1, MAX_PARTY_MEMBERS do
					handleFrame('PartyMemberFrame' .. i)
				end
			end
		else
			if(not isPartyHooked) then
				isPartyHooked = true

				PartyFrame:UnregisterAllEvents()

				for frame in PartyFrame.PartyMemberFramePool:EnumerateActive() do
					handleFrame(frame)
				end
			end
		end
	elseif(unit:match('arena%d?$')) then
		if(oUF:IsClassic()) then
			local id = unit:match('arena(%d)')
			if(id) then
				handleFrame('ArenaEnemyFrame' .. id)
			else
				for i = 1, MAX_ARENA_ENEMIES do
					handleFrame('ArenaEnemyFrame' .. i)
				end
			end

			-- Blizzard_ArenaUI should not be loaded
			_G.Arena_LoadUI = function() end
			SetCVar('showArenaEnemyFrames', '0', 'SHOW_ARENA_ENEMY_FRAMES_TEXT')
		else
			if(not isArenaHooked) then
				isArenaHooked = true

				-- this disables ArenaEnemyFramesContainer
				SetCVar('showArenaEnemyFrames', '0')
				SetCVar('showArenaEnemyPets', '0')

				-- but still UAE all containers
				ArenaEnemyFramesContainer:UnregisterAllEvents()
				ArenaEnemyPrepFramesContainer:UnregisterAllEvents()
				ArenaEnemyMatchFramesContainer:UnregisterAllEvents()

				for i = 1, MAX_ARENA_ENEMIES do
					handleFrame('ArenaEnemyMatchFrame' .. i)
					handleFrame('ArenaEnemyPrepFrame' .. i)
				end
			end
		end
	elseif(unit:match('nameplate%d+$')) then
		local frame = C_NamePlate.GetNamePlateForUnit(unit)
		if(frame and frame.UnitFrame) then
			if(not frame.UnitFrame.isHooked) then
				frame.UnitFrame:HookScript('OnShow', insecureOnShow)
				frame.UnitFrame.isHooked = true
			end

			handleFrame(frame.UnitFrame, true)
		end
	end
end