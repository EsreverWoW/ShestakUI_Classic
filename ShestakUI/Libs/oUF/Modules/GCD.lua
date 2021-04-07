local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_gcd ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_GCD(by ALZA)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local starttime, duration, usingspell, spellid
local GetTime = GetTime

local spells

if T.classic then
	spells = {
		["DRUID"] = 1126,
		["HUNTER"] = 1978,
		["MAGE"] = 168,
		["PALADIN"] = 20154,
		["PRIEST"] = 1243,
		["ROGUE"] = 1752,
		["SHAMAN"] = 403,
		["WARLOCK"] = 687,
		["WARRIOR"] = 6673,
	}
else
	spells = {
		["DEATHKNIGHT"] = 61304,
		["DEMONHUNTER"] = 61304,
		["DRUID"] = 61304,
		["HUNTER"] = 61304,
		["MAGE"] = 61304,
		["MONK"] = 61304,
		["PALADIN"] = 61304,
		["PRIEST"] = 61304,
		["ROGUE"] = 61304,
		["SHAMAN"] = 61304,
		["WARLOCK"] = 61304,
		["WARRIOR"] = 61304,
	}
end

local Enable = function(self)
	if not self.GCD then return end
	local bar = self.GCD
	local width = bar:GetWidth()
	bar:Hide()

	bar.spark = bar:CreateTexture(nil, "OVERLAY")
	bar.spark:SetTexture(C.media.blank)
	bar.spark:SetVertexColor(unpack(bar.Color))
	bar.spark:SetHeight(bar.Height)
	bar.spark:SetWidth(bar.Width)
	bar.spark:SetBlendMode("ADD")

	local function OnUpdateSpark()
		bar.spark:ClearAllPoints()
		local elapsed = GetTime() - starttime
		local perc = elapsed / duration
		if perc > 1 then
			return bar:Hide()
		else
			bar.spark:SetPoint("CENTER", bar, "LEFT", width * perc, 0)
		end
	end

	local function Init()
		local isKnown = IsSpellKnown(spells[T.class])
		if isKnown then
			spellid = spells[T.class]
		end
		if spellid == nil then
			return
		end
		return spellid
	end

	local function OnHide()
		bar:SetScript("OnUpdate", nil)
		usingspell = nil
	end

	local function OnShow()
		bar:SetScript("OnUpdate", OnUpdateSpark)
	end

	local function UpdateGCD()
		if spellid == nil then
			if Init() == nil then
				return
			end
		end
		local start, dur = GetSpellCooldown(spellid)
		if dur and dur > 0 and dur <= 2 then
			usingspell = 1
			starttime = start
			duration = dur
			bar:Show()
			return
		elseif usingspell == 1 and dur == 0 then
			bar:Hide()
		end
	end

	bar:SetScript("OnShow", OnShow)
	bar:SetScript("OnHide", OnHide)

	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", UpdateGCD, true)
end

oUF:AddElement("GCD", UpdateGCD, Enable)