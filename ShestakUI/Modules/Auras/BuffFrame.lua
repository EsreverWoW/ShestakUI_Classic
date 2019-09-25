local T, C, L, _ = unpack(select(2, ...))
if C.aura.player_auras ~= true then return end

----------------------------------------------------------------------------------------
--	Style player buff(by Tukz)
----------------------------------------------------------------------------------------
_G.BUFF_WARNING_TIME = 0
local rowbuffs = 16

local GetFormattedTime = function(s)
	if s >= 86400 then
		return format("%dd", floor(s / 86400 + 0.5))
	elseif s >= 3600 then
		return format("%dh", floor(s / 3600 + 0.5))
	elseif s >= 60 then
		return format("%dm", floor(s / 60 + 0.5))
	end
	return floor(s + 0.5)
end

local BuffsAnchor = CreateFrame("Frame", "BuffsAnchor", UIParent)
BuffsAnchor:SetPoint(unpack(C.position.player_buffs))
BuffsAnchor:SetSize((15 * C.aura.player_buff_size) + 42, (C.aura.player_buff_size * 2) + 3)

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)

_G["TempEnchant2"]:ClearAllPoints()
_G["TempEnchant2"]:SetPoint("RIGHT", _G["TempEnchant1"], "LEFT", -3, 0)

local function StyleBuffs(buttonName, index)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]

	if border then border:Hide() end

	if icon and not buff.isSkinned then
		if buttonName ~= "TempEnchant" or (buttonName == "TempEnchant" and index ~= 3) then
			buff:SetTemplate("Default")
			if C.aura.classcolor_border == true then
				buff:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			end
		end

		buff:SetSize(C.aura.player_buff_size, C.aura.player_buff_size)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", buff, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", buff, -2, 2)
		icon:SetDrawLayer("BORDER")

		duration:ClearAllPoints()
		duration:SetPoint("CENTER", 2, 1)
		duration:SetDrawLayer("ARTWORK")
		duration:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		duration:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		if not buff.timer then
			buff.timer = buff:CreateAnimationGroup()
			buff.timerAnim = buff.timer:CreateAnimation()
			buff.timerAnim:SetDuration(0.1)

			buff.timer:SetScript("OnFinished", function(self, requested)
				if not requested then
					if buff.timeLeft and C.aura.show_timer == true then
						buff.duration:SetFormattedText(GetFormattedTime(buff.timeLeft))
						buff.duration:SetVertexColor(1, 1, 1)
					else
						self:Stop()
					end
					self:Play()
				end
			end)
			buff.timer:Play()
		end

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 2, 0)
		count:SetDrawLayer("ARTWORK")
		count:SetFont(C.font.auras_font, C.font.auras_font_size, C.font.auras_font_style)
		count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

		buff.isSkinned = true
	end
end

local function UpdateBuffAnchors()
	local buffName = "BuffButton"
	local enchantName = "TempEnchant"
	local previousBuff, aboveBuff
	local numBuffs = 0
	local numAuraRows = 0
	local slack = BuffFrame.numEnchants
	local mainhand, _, _, _, offhand = GetWeaponEnchantInfo()

	for index = 1, NUM_TEMP_ENCHANT_FRAMES do
		StyleBuffs(enchantName, index)
	end

	for index = 1, BUFF_ACTUAL_DISPLAY do
		StyleBuffs(buffName, index)
		local buff = _G[buffName..index]
		numBuffs = numBuffs + 1
		index = numBuffs + slack
		buff:ClearAllPoints()
		if (index > 1) and (mod(index, rowbuffs) == 1) then
			numAuraRows = numAuraRows + 1
			buff:SetPoint("TOP", aboveBuff, "BOTTOM", 0, -3)
			aboveBuff = buff
		elseif index == 1 then
			numAuraRows = 1
			buff:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
		else
			if numBuffs == 1 then
				if T.classic then
					if mainhand and offhand then
						buff:SetPoint("RIGHT", TempEnchant2, "LEFT", -3, 0)
					elseif ((mainhand and not offhand) or (offhand and not mainhand)) then
						buff:SetPoint("RIGHT", TempEnchant1, "LEFT", -3, 0)
					else
						buff:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
					end
				else
					if mainhand and offhand and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant2, "LEFT", -3, 0)
					elseif ((mainhand and not offhand) or (offhand and not mainhand)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant1, "LEFT", -3, 0)
					else
						buff:SetPoint("TOPRIGHT", BuffsAnchor, "TOPRIGHT", 0, 0)
					end
				end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", -3, 0)
			end
		end
		previousBuff = buff
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	_G[buttonName..index]:Hide()
end

AuraButton_UpdateDuration = function(buff)
	if not string.find(buff:GetName(), "TempEnchant") then return end

	local name = buff:GetName()
	local offset, index = 2, 16
	local weapon = name:sub(-1)
	if strmatch(weapon, "2") then
		offset = 6
		index = 17
	end

	local quality = GetInventoryItemQuality("player", index)
	if quality then
		buff:SetBackdropBorderColor(GetItemQualityColor(quality))
	end

	local expirationTime, count = select(offset, GetWeaponEnchantInfo())

	if expirationTime then
		if count and count > 0 then
			buff.count:SetText(count)
		else
			buff.count:SetText("")
		end
		buff.timeLeft = expirationTime / 1e3
	else
		buff.timeLeft = nil
		buff.count:SetText("")
		buff.duration:SetText("")
	end

	if buff.timeLeft then
		buff.duration:SetFormattedText(GetFormattedTime(buff.timeLeft))
		buff.duration:SetVertexColor(1, 1, 1)
		buff.duration:Show()
	else
		buff.duration:Hide()
	end
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
