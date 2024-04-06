local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Specialization Functions
----------------------------------------------------------------------------------------
function T.GetSpecialization(isInspect, isPet, specGroup)
	if T.Cata then
		return GetPrimaryTalentTree(isInspect, isPet, specGroup)
	else
		if (isInspect or isPet) then
			return
		end
		local specIndex
		local max = 0
		for tabIndex = 1, GetNumTalentTabs() do
			local spent = select(3, GetTalentTabInfo(tabIndex, "player", T.Wrath and specGroup))
			if spent > max then
				specIndex = tabIndex
				max = spent
			end
		end
		return specIndex
	end
end

local isCaster = {
	DEATHKNIGHT = {nil, nil, nil},
	DRUID = {true},					-- Balance
	HUNTER = {nil, nil, nil},
	MAGE = {true, true, true},
	PALADIN = {nil, nil, nil},
	PRIEST = {nil, nil, true},		-- Shadow
	ROGUE = {nil, nil, nil},
	SHAMAN = {true},				-- Elemental
	WARLOCK = {true, true, true},
	WARRIOR = {nil, nil, nil}
}

function T.GetSpecializationRole()
	-- TODO: Use IsSpellKnownOrOverridesKnown instead for checking rune slot spellIDs
	local tree = T.GetSpecialization()
	-- eventually check for tank stats in case a tanking in a non-traditional spec (mostly for warriors)
	if (T.class == "DEATHKNIGHT" and T.CheckPlayerBuff(GetSpellInfo(48263)))
	or (T.class == "DRUID" and GetBonusBarOffset() == 3)
	or (T.class == "PALADIN" and tree == 2)
	or (T.class == "ROGUE" and T.SoD and IsPlayerSpell(410412))
	or (T.class == "SHAMAN" and T.SoD and T.CheckPlayerBuff(GetSpellInfo(408680)))
	or (T.class == "WARLOCK" and T.SoD and T.CheckPlayerBuff(GetSpellInfo(403789)))
	or (T.class == "WARRIOR" and (tree == 3 or GetBonusBarOffset() == 2)) then
		return "TANK"
	elseif (T.class == "PALADIN" and tree == 1) or (T.class == "DRUID" and tree == 3) or (T.class == "SHAMAN" and tree == 3) or (T.class == "PRIEST" and tree ~= 3) then
		return "HEALER"
	else
		local base, posBuff, negBuff = UnitAttackPower("player")

		local current = {}
		local best = 1
		for i = 1, 7 do
			current[i] = GetSpellBonusDamage(i)
			if current[i] > current[best] then
				best = i
			end
		end

		local ap = base + posBuff + negBuff
		local spell = GetSpellBonusDamage(best)
		local heal = GetSpellBonusHealing()

		if T.class ~= "HUNTER" and heal >= ap and heal >= spell then
			return "HEALER" -- healing gear without having the majority of talents in a healing tree
		elseif T.class ~= "HUNTER" and (isCaster[T.class][tree] or spell >= ap) then
			return "CASTER" -- ordinarily "DAMAGER"
		else
			return "MELEE" -- ordinarily "DAMAGER"
		end
	end
end

----------------------------------------------------------------------------------------
--	Check if Classic or Burning Crusade Classic / Wrath of the Lich King Classic
----------------------------------------------------------------------------------------
if not T.Vanilla then return end

----------------------------------------------------------------------------------------
--	LibClassicDurations (by d87)
----------------------------------------------------------------------------------------
local LibClassicDurations = LibStub("LibClassicDurations")
if LibClassicDurations then
	LibClassicDurations:Register("ShestakUI")
end

----------------------------------------------------------------------------------------
--	TBC+ Shaman Coloring (config option later)
----------------------------------------------------------------------------------------
if not CUSTOM_CLASS_COLORS then
	local r, g, b, colorStr = 0, 0.44, 0.98, "ff0070de"

	-- for ShestakUI coloring
	if T.class == "SHAMAN" then
		T.color = {}
		T.color.r = r
		T.color.g = g
		T.color.b = b
		T.color.colorStr = colorStr

		C.media.classborder_color = {T.color.r, T.color.g, T.color.b, 1}
	end

	-- for Blizzard UI elements
	--[[
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(_, _, addon)
		if addon == "Blizzard_RaidUI" then
			hooksecurefunc("RaidGroupFrame_Update", function()
				local isRaid = IsInRaid()
				if not isRaid then return end
				for i = 1, min(GetNumGroupMembers(), MAX_RAID_MEMBERS) do
					local _, _, subgroup, _, _, class, _, online, dead = GetRaidRosterInfo(i)
					if online and not dead and _G["RaidGroup"..subgroup].nextIndex <= MEMBERS_PER_RAID_GROUP and class and class == "SHAMAN" then
						local button = _G["RaidGroupButton"..i]
						button.subframes.name:SetTextColor(r, g, b)
						button.subframes.class.text:SetTextColor(r, g, b)
						button.subframes.level:SetTextColor(r, g, b)
					end
				end
			end)

			hooksecurefunc("RaidGroupFrame_UpdateHealth", function(i)
				local _, _, _, _, _, class, _, online, dead = GetRaidRosterInfo(i)
				if online and not dead and class and class == "SHAMAN" then
					_G["RaidGroupButton"..i.."Name"]:SetTextColor(r, g, b)
					_G["RaidGroupButton"..i.."Class"]:SetTextColor(r, g, b)
					_G["RaidGroupButton"..i.."Level"]:SetTextColor(r, g, b)
				end
			end)

			hooksecurefunc("RaidPullout_UpdateTarget", function(frame, button, unit, which)
				if _G[frame]["show"..which] and UnitCanCooperate("player", unit) then
					local _, class = UnitClass(unit)
					if class and class == "SHAMAN" then
						_G[button..which.."Name"]:SetTextColor(r, g, b)
					end
				end
			end)

			local petowners = {}
			for i = 1, 40 do
				petowners["raidpet"..i] = "raid"..i
			end
			hooksecurefunc("RaidPulloutButton_UpdateDead", function(button, dead, class)
				if not dead and class and class == "SHAMAN" then
					if class == "PETS" then
						class, class = UnitClass(petowners[button.unit])
					end
					button.nameLabel:SetVertexColor(r, g, b)
				end
			end)
		end
	end)
	--]]

	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
		local opts = frame.optionTable
		if opts.healthBarColorOverride or not opts.useClassColors
				or not (opts.allowClassColorsForNPCs or UnitIsPlayer(frame.unit))
				or not UnitIsConnected(frame.unit) then
			return
		end

		local _, class = UnitClass(frame.unit)
		if not class or class ~= "SHAMAN" then return end

		frame.healthBar:SetStatusBarColor(r, g, b)
		if frame.optionTable.colorHealthWithExtendedColors then
			frame.selectionHighlight:SetVertexColor(r, g, b)
		end
	end)

	hooksecurefunc("MasterLooterFrame_UpdatePlayers", function()
		for k, playerFrame in pairs(MasterLooterFrame) do
			if type(k) == "string" and strmatch(k, "^player%d+$") and type(playerFrame) == "table" and playerFrame.id and playerFrame.Name then
				local i = playerFrame.id
				local _, class
				if IsInRaid() then
					_, class = UnitClass("raid"..i)
				elseif i > 1 then
					_, class = UnitClass("party"..i)
				else
					_, class = UnitClass("player")
				end

				if class and class == "SHAMAN" then
					playerFrame.Name:SetTextColor(r, g, b)
				end
			end
		end
	end)

	hooksecurefunc("LootHistoryFrame_UpdateItemFrame", function(self, itemFrame)
		local itemID = itemFrame.itemIdx
		local rollID, _, _, done, winnerID = C_LootHistory.GetItem(itemID)
		local expanded = self.expandedRolls[rollID]
		if done and winnerID and not expanded then
			local _, class = C_LootHistory.GetPlayerInfo(itemID, winnerID)
			if class and class == "SHAMAN" then
				itemFrame.WinnerName:SetVertexColor(r, g, b)
			end
		end
	end)

	hooksecurefunc("LootHistoryFrame_UpdatePlayerFrame", function(self, playerFrame)
		if playerFrame.playerIdx then
			local name, class = C_LootHistory.GetPlayerInfo(playerFrame.itemIdx, playerFrame.playerIdx)
			if class and class == "SHAMAN" then
				playerFrame.PlayerName:SetVertexColor(r, g, b)
			end
		end
	end)

	function LootHistoryDropDown_Initialize(self)
		local info = UIDropDownMenu_CreateInfo()
		info.text = MASTER_LOOTER
		info.fontObject = GameFontNormalLeft
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)

		local name, class = C_LootHistory.GetPlayerInfo(self.itemIdx, self.playerIdx)
		local color = RAID_CLASS_COLORS[class]

		info = UIDropDownMenu_CreateInfo()
		if class == "SHAMAN" then
			info.text = format(MASTER_LOOTER_GIVE_TO, format("|c%s%s|r", colorStr, name))
		else
			info.text = format(MASTER_LOOTER_GIVE_TO, format("|c%s%s|r", color.colorStr, name))
		end
		info.func = LootHistoryDropDown_OnClick
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	end
end
