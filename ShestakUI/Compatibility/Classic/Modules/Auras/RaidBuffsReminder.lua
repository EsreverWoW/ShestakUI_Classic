local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.reminder.raid_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by Elv22)
----------------------------------------------------------------------------------------
-- Locals
local flaskBuffs = T.ReminderBuffs["Flask"]
local otherBuffs = T.ReminderBuffs["Other"]
local foodBuffs = T.ReminderBuffs["Food"]
local spell3Buffs = T.ReminderBuffs["Spell3Buff"]
local spell4Buffs = T.ReminderBuffs["Spell4Buff"]
local spell5Buffs = T.ReminderBuffs["Spell5Buff"]
local spell6Buffs = T.ReminderBuffs["Spell6Buff"]
local spell7Buffs = T.ReminderBuffs["Spell7Buff"]
local customBuffs = T.ReminderBuffs["Custom"]

local visible

local isPresent = {
	flask = false,
	food = false,
	spell3 = false,
	spell4 = false,
	spell5 = false,
	spell6 = false,
	spell7 = false,
	custom = false,
}

-- Aura Checks
local function CheckElixir()
	local requireFlask, otherBuffsRequired = T.ReminderFlaskRequirements()
	local hasFlask, otherBuffsCount, meetsRequirements = false, 0, false

	FlaskFrame.t:SetTexture("")

	if requireFlask then
		if flaskBuffs and flaskBuffs[1] then
			for i, flaskBuffs in pairs(flaskBuffs) do
				local name, _, icon = GetSpellInfo(flaskBuffs)
				if i == 1 then
					FlaskFrame.t:SetTexture(icon)
				end
				if T.CheckPlayerBuff(name) then
					FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
					hasFlask = true
					break
				end
			end
		end
	else
		hasFlask = true
	end

	if FlaskFrame.t:GetTexture() == "" then
		FlaskFrame.t:SetTexture(134821)
	end

	if not hasFlask then
		FlaskFrame:SetAlpha(1)
		isPresent.flask = false
		return
	end

	if otherBuffsRequired > 0 then
		if otherBuffs then
			for k, _ in pairs(otherBuffs) do
				for _, v in pairs(otherBuffs[k]) do
					local name = GetSpellInfo(v)
					if T.CheckPlayerBuff(name) then
						otherBuffsCount = otherBuffsCount + 1
						if otherBuffsCount >= otherBuffsRequired then
							meetsRequirements = true
							break
						end
					end
				end
			end
		end
	else
		meetsRequirements = true
	end

	if hasFlask and meetsRequirements then
		FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
		isPresent.flask = true
		return
	else
		FlaskFrame:SetAlpha(1)
		isPresent.flask = false
		return
	end
end

local function CheckBuff(list, frame, n)
	if list and list[1] then
		for i, list in pairs(list) do
			local name, _, icon = GetSpellInfo(list)
			if i == 1 then
				frame.t:SetTexture(icon)
			end
			if T.CheckPlayerBuff(name) then
				frame:SetAlpha(C.reminder.raid_buffs_alpha)
				isPresent[n] = true
				break
			else
				frame:SetAlpha(1)
				isPresent[n] = false
			end
		end
	end	
end

-- Main Script
local function OnAuraChange(self, event, unit)
	if event == "UNIT_AURA" and unit ~= "player" then return end

	-- If We're a caster we may want to see different buffs
	if T.Role == "Caster" or T.Role == "Healer" then
		T.ReminderCasterBuffs()
	else
		T.ReminderPhysicalBuffs()
	end

	spell4Buffs = T.ReminderBuffs["Spell4Buff"]
	spell5Buffs = T.ReminderBuffs["Spell5Buff"]
	spell6Buffs = T.ReminderBuffs["Spell6Buff"]

	-- Start checking buffs to see if we can find a match from the list
	CheckElixir()

	CheckBuff(foodBuffs, FoodFrame, "food")
	CheckBuff(spell3Buffs, Spell3Frame, "spell3")
	CheckBuff(spell4Buffs, Spell4Frame, "spell4")
	CheckBuff(spell5Buffs, Spell5Frame, "spell5")
	CheckBuff(spell6Buffs, Spell6Frame, "spell6")
	CheckBuff(spell7Buffs, Spell7Frame, "spell7")

	if customBuffs and customBuffs[1] then
		CheckBuff(customBuffs, CustomFrame, "custom")
	else
		CustomFrame:Hide()
		isPresent.custom = true
	end

	local _, instanceType = IsInInstance()
	if (not IsInGroup() or instanceType ~= "raid") and C.reminder.raid_buffs_always == false then
		RaidBuffReminder:SetAlpha(0)
		visible = false
	elseif isPresent.flask == true and isPresent.food == true and isPresent.spell3 == true and isPresent.spell4 == true and isPresent.spell5 == true and isPresent.spell6 == true and isPresent.spell7 == true and isPresent.custom == true then
		if not visible then
			RaidBuffReminder:SetAlpha(0)
			visible = false
		end
		if visible then
			UIFrameFadeOut(RaidBuffReminder, 0.5)
			visible = false
		end
	else
		if not visible then
			UIFrameFadeIn(RaidBuffReminder, 0.5)
			visible = true
		end
	end
end

-- Create Anchor
local RaidBuffsAnchor = CreateFrame("Frame", "RaidBuffsAnchor", UIParent)
RaidBuffsAnchor:SetWidth((C.reminder.raid_buffs_size * 6) + 15)
RaidBuffsAnchor:SetHeight(C.reminder.raid_buffs_size)
RaidBuffsAnchor:SetPoint(unpack(C.position.raid_buffs))

-- Create Main bar
local raidbuff_reminder = CreateFrame("Frame", "RaidBuffReminder", UIParent)
raidbuff_reminder:CreatePanel("Invisible", (C.reminder.raid_buffs_size * 6) + 15, C.reminder.raid_buffs_size + 4, "TOPLEFT", RaidBuffsAnchor, "TOPLEFT", 0, 4)
raidbuff_reminder:RegisterEvent("UNIT_AURA")
raidbuff_reminder:RegisterEvent("PLAYER_ENTERING_WORLD")
raidbuff_reminder:RegisterEvent("CHARACTER_POINTS_CHANGED")
raidbuff_reminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
raidbuff_reminder:SetScript("OnEvent", OnAuraChange)

-- Function to create buttons
local function CreateButton(name, relativeTo, firstbutton)
	local button = CreateFrame("Frame", name, RaidBuffReminder)
	if firstbutton == true then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOMLEFT", relativeTo, "BOTTOMLEFT", 0, 0)
	else
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "LEFT", relativeTo, "RIGHT", 3, 0)
	end
	button:SetFrameLevel(RaidBuffReminder:GetFrameLevel() + 2)

	button.t = button:CreateTexture(name..".t", "OVERLAY")
	button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.t:SetPoint("TOPLEFT", 2, -2)
	button.t:SetPoint("BOTTOMRIGHT", -2, 2)
end

-- Create Buttons
do
	CreateButton("FlaskFrame", RaidBuffReminder, true)
	CreateButton("FoodFrame", FlaskFrame, false)
	CreateButton("Spell3Frame", FoodFrame, false)
	CreateButton("Spell4Frame", Spell3Frame, false)
	CreateButton("Spell5Frame", Spell4Frame, false)
	CreateButton("Spell6Frame", Spell5Frame, false)
	CreateButton("Spell7Frame", Spell6Frame, false)
	CreateButton("CustomFrame", Spell7Frame, false)
end
