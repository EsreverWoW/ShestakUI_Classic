local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or T.classic ~= true then return end
----------------------------------------------------------------------------------------
--	Classic Actionbar Spell Proc Glow by cKeles
----------------------------------------------------------------------------------------
-- Locals and speed
local _G = _G
local next = next
local pairs = pairs
local ipairs = ipairs

local allSpells = {
  WARRIOR = {
    Execute = {
      ids = { 20662, 20661, 20660, 20658, 5308 },
      duration = 0
    },
    Overpower = {
      ids = { 7384, 7887, 11584, 11585 },
      duration = 5
    },
    Revenge = {
      ids = { 6572, 6574, 7379, 11600, 11601, 25288 },
      duration = 5
    }
  },
  ROGUE = {
    Riposte = {
      ids = { 14251 },
      duration = 5
    }
  }
}
local loadedSpells = {}

-- Main
local glower = CreateFrame("Frame", "glower")

function glower:Init()
	self:SetScript("OnEvent", self.OnEvent)
  self:RegisterEvent("PLAYER_LOGIN")
end

-- Frame Events
function glower:OnEvent(event, ...)
	local action = self[event]
	if action then
		action(self, event, ...)
	end
end

-- Game Events
function glower:PLAYER_LOGIN()
  loadedSpells = {}
  local spells = allSpells[T.class]
  if spells then
    checkFor(spells)
    if loadedSpells then
      for k, _ in pairs(loadedSpells) do
        self:loadGlow(k)
      end
    end
  end
end

function glower:loadGlow(spellName)
  if spellName == "Execute" then
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterUnitEvent("UNIT_HEALTH", "target")
    self.PLAYER_TARGET_CHANGED = self.UNIT_HEALTH
  end
end

function glower:UNIT_HEALTH(event, unit)
  if UnitExists("target") and not UnitIsFriend("player", "target") then
    local targetHP = UnitHealth("target")
    if targetHP > 0 and (UnitHealth("target") / UnitHealthMax("target") <= .199) then
      self:startGlow("Execute")
    else
      self:stopGlow("Execute")
    end
  elseif loadedSpells["Execute"].glowing == true then
    self:stopGlow("Execute")
  end
end

function glower:startGlow(spellName)
  local spell = loadedSpells[spellName]
  if spell.glowing == true then return end
  self:btnHook("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", spell.id)
  loadedSpells[spellName].glowing = true
end

function glower:stopGlow(spellName)
  local spell = loadedSpells[spellName]
  if spell.glowing == false then return end
  self:btnHook("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE", spell.id)
  loadedSpells[spellName].glowing = false
end

function glower:btnHook(event, ...)
  for k, v in pairs(getButtons()) do
      local evnt = v:GetScript("OnEvent")
      evnt(v, event, ...)
  end
end

-- Functions
function checkFor(spells)
  for k, v in pairs(spells) do
    for _, spellId in ipairs(v.ids) do
      if IsPlayerSpell(spellId) then
        loadedSpells[k] = {
          name = GetSpellInfo(spellId),
          id = spellId,
          duration = v.duration,
          glowing = false
        }
      end
    end
  end
end

function getButtons()
  local rtn = {}
  for i = 1, 5 do
    local frame = _G["Bar"..i.."Holder"]
    if frame:IsVisible() then
      for k, v in pairs(getFrameButtons(i)) do
        rtn[k] = v
      end
    end
  end
  return rtn
end

function getFrameButtons(frameNumber)
  local btnName = nil
  rtn = {}
  if frameNumber == 1 then
    btnName = "ActionButton"
  elseif frameNumber == 2 then
    btnName = "MultiBarBottomLeftButton"
  elseif frameNumber == 3 then
    btnName = "MultiBarLeftButton"
  elseif frameNumber == 4 then
    btnName = "MultiBarRightButton"
  elseif frameNumber == 5 then
    btnName = "MultiBarBottomRightButton"
  end
  for i = 1, 12 do
    rtn[btnName..i] = _G[btnName..i]
  end
  return rtn
end

-- Init
glower:Init()