local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata -- BETA

T.dummy = function() return end
T.name = UnitName("player")
T.race = select(2, UnitRace("player"))
T.class = select(2, UnitClass("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.screenWidth, T.screenHeight = GetPhysicalScreenSize()
T.toc = select(4, GetBuildInfo())
T.newPatch = T.toc >= 100100
T.Mainline =_G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE
T.Classic = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC or _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC or _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC
T.Vanilla = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC
T.TBC = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
T.Wrath = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC
T.HiDPI = GetScreenHeight() / T.screenHeight < 0.75

-- BETA
if T.newPatch or T.Classic then
	SortBags = C_Container.SortBags
	SortBankBags = C_Container.SortBankBags
	SortReagentBankBags = C_Container.SortReagentBankBags
	SetSortBagsRightToLeft = C_Container.SetSortBagsRightToLeft
	SetInsertItemsLeftToRight = C_Container.SetInsertItemsLeftToRight
	PickupContainerItem = C_Container.PickupContainerItem
	ContainerIDToInventoryID = C_Container.ContainerIDToInventoryID
	GetContainerItemEquipmentSetInfo = C_Container.GetContainerItemEquipmentSetInfo

	GetContainerItemInfo = GetContainerItemInfo or function(bagIndex, slotIndex)
		local info = C_Container.GetContainerItemInfo(bagIndex, slotIndex)
		if info then
			return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
		end
	end
end
