local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = UnitName("player")
T.race = select(2, UnitRace("player"))
T.class = select(2, UnitClass("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = C_AddOns.GetAddOnMetadata("ShestakUI", "Version")
T.screenWidth, T.screenHeight = GetPhysicalScreenSize()
T.HiDPI = GetScreenHeight() / T.screenHeight < 0.75

T.toc = select(4, GetBuildInfo())
T.newPatch = T.toc >= 100105
T.Mainline =_G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE
T.Classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE
T.Vanilla = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC
T.Vanilla115 = T.Vanilla and T.toc >= 11500
T.TBC = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
T.Wrath = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC
T.Cata = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CATACLYSM_CLASSIC
T.Hardcore = C_GameRules and C_GameRules.IsHardcoreActive()
T.SoM = C_Seasons and C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfMastery
T.SoD = C_Seasons and C_Seasons.HasActiveSeason() and (C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfDiscovery or C_Seasons.GetActiveSeason() == Enum.SeasonID.Placeholder)

-- BETA
GetContainerItemInfo = GetContainerItemInfo or function(bagIndex, slotIndex)
	local info = C_Container.GetContainerItemInfo(bagIndex, slotIndex)
	if info then
		return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
	end
end
