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
T.toc = select(4, GetBuildInfo())
T.newPatch = T.toc >= 100105
T.Mainline =_G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE
T.Classic = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC or _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC or _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC
T.Vanilla = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC
T.Vanilla115 = T.Vanilla and T.toc >= 10105
T.TBC = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
T.Wrath = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC
T.HiDPI = GetScreenHeight() / T.screenHeight < 0.75

-- BETA
GetContainerItemInfo = GetContainerItemInfo or function(bagIndex, slotIndex)
	local info = C_Container.GetContainerItemInfo(bagIndex, slotIndex)
	if info then
		return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
	end
end
