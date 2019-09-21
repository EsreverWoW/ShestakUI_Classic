local classic = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC

--[[
Name: LibBanzai-2.0
Revision: $Revision: 45 $
Author(s): Rabbit (rabbit.magtheridon@gmail.com), maia
Documentation: http://www.wowace.com/index.php/Banzai-2.0_API_Documentation
SVN: http://svn.wowace.com/wowace/trunk/BanzaiLib/Banzai-2.0
Description: Aggro notification library.
Dependencies: LibStub
]]

-------------------------------------------------------------------------------
-- Locals
-------------------------------------------------------------------------------

local MAJOR_VERSION = "LibBanzai-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 45 $"):match("(%d+)"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

lib.callbacks = lib.callbacks or {}
local callbacks = lib.callbacks
lib.frame = lib.frame or CreateFrame("Frame")
local frame = lib.frame

local _G = _G
local UnitExists = _G.UnitExists
local UnitName = _G.UnitName
local UnitCanAttack = _G.UnitCanAttack
local IsInRaid = _G.IsInRaid
local IsInGroup = _G.IsInGroup
local GetNumGroupMembers = _G.GetNumGroupMembers
local GetNumSubgroupMembers = _G.GetNumSubgroupMembers
local unpack = _G.unpack

-------------------------------------------------------------------------------
-- Roster
-------------------------------------------------------------------------------

local raidUnits = setmetatable({}, {__index =
	function(self, key)
		self[key] = ("raid%d"):format(key)
		return self[key]
	end
})
local raidPetUnits = setmetatable({}, {__index =
	function(self, key)
		self[key] = ("raidpet%d"):format(key)
		return self[key]
	end
})
local partyUnits = {"party1","party2","party3","party4"}
local partyPetUnits = {"partypet1","partypet2","partypet3","partypet4"}
local roster = {}
local needsUpdate = nil

-- If some pet has the same name as a person in the raid, they'll end up being
-- the same unit for the purposes of banzai, but we won't care right now.
local function addUnit(unit)
	if not UnitExists(unit) then return end
	local name = UnitName(unit)
	if not roster[name] then roster[name] = {} end
	roster[name][#roster[name] + 1] = unit
end

local function actuallyUpdateRoster()
	wipe(roster)
	addUnit("player")
	addUnit("pet")
	if not classic then addUnit("focus") end
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			addUnit(raidUnits[i])
			addUnit(raidPetUnits[i])
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			addUnit(partyUnits[i])
			addUnit(partyPetUnits[i])
		end
	end
	needsUpdate = nil
end

local function updateRoster()
	needsUpdate = true
end

-------------------------------------------------------------------------------
-- Banzai
-------------------------------------------------------------------------------

local targets = setmetatable({}, {__index =
	function(self, key)
		self[key] = key .. "target"
		return self[key]
	end
})

local aggro = {}
local banzai = {}

local total = 0
local function updateBanzai(_, elapsed)
	total = total + elapsed
	if total > 0.2 then
		if needsUpdate then actuallyUpdateRoster() end
		for name, units in pairs(roster) do
			local unit = units[1]
			local targetId = targets[unit]
			if UnitExists(targetId) then
				local ttId = targets[targetId]
				if not classic and unit == "focus" and UnitIsEnemy("focus", "player") then
					ttId = "focustarget"
					targetId = "focus"
				end
				if UnitExists(ttId) and UnitCanAttack(ttId, targetId) then
					for n, u in pairs(roster) do
						if UnitIsUnit(u[1], ttId) then
							banzai[n] = (banzai[n] or 0) + 10
							break
						end
					end
				end
			end
			if banzai[name] then
				if banzai[name] >= 5 then banzai[name] = banzai[name] - 5 end
				if banzai[name] > 25 then banzai[name] = 25 end
			end
		end
		for name, units in pairs(roster) do
			if banzai[name] and banzai[name] > 15 then
				if not aggro[name] then
					aggro[name] = true
					for i, v in next, callbacks do
						v(1, name, unpack(units))
					end
				end
			elseif aggro[name] then
				aggro[name] = nil
				for i, v in next, callbacks do
					v(0, name, unpack(units))
				end
			end
		end
		total = 0
	end
end

-------------------------------------------------------------------------------
-- Starting and stopping
-------------------------------------------------------------------------------

local running = nil
local function start()
	if running then return end
	updateRoster()
	frame:SetScript("OnUpdate", updateBanzai)
	frame:SetScript("OnEvent", updateRoster)
	frame:RegisterEvent("GROUP_ROSTER_UPDATE")
	frame:RegisterEvent("UNIT_PET")
	if not classic then frame:RegisterEvent("PLAYER_FOCUS_CHANGED") end
	running = true
end

local function stop()
	if not running then return end
	frame:SetScript("OnUpdate", nil)
	frame:SetScript("OnEvent", nil)
	frame:UnregisterAllEvents()
	running = nil
end

-------------------------------------------------------------------------------
-- API
-------------------------------------------------------------------------------

function lib:IsRunning() return running end
function lib:GetUnitAggroByUnitName(name) return aggro[name] end
function lib:GetUnitAggroByUnitId(unit)
	if not UnitExists(unit) then return end
	return aggro[UnitName(unit)]
end

function lib:RegisterCallback(func)
	if type(func) ~= "function" then
		error(("Bad argument to :RegisterCallback, function expected, got %q."):format(type(func)), 2)
	end

	callbacks[#callbacks + 1] = func
	start()
end

function lib:UnregisterCallback(func)
	if type(func) ~= "function" then
		error(("Bad argument to :UnregisterCallback, function expected, got %q."):format(type(func)), 2)
	end

	local found = nil
	for i, v in next, callbacks do
		if v == func then
			table.remove(callbacks, i)
			found = true
			break
		end
	end
	if #callbacks == 0 then stop() end

	if not found then
		error("Bad argument to :UnregisterCallback, the provided function was not registered.", 2)
	end
end

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------

frame:SetScript("OnUpdate", nil)
frame:SetScript("OnEvent", nil)
frame:UnregisterAllEvents()
if #callbacks > 0 then start() end
