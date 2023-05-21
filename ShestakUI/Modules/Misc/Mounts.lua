local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Universal Mount macro(by Monolit)
--	/cancelform [noform:4]
--	/run Mountz("your_ground_mount","your_flying_mount","your_underwater_mount","your_dragonriding_mount")
----------------------------------------------------------------------------------------
function Mountz(groundmount, flyingmount, underwatermount, dragonridingmount)
	if not underwatermount then underwatermount = groundmount end
	local flyablex, swimablex, vjswim, InVj, nofly
	local num = C_MountJournal.GetNumMounts()
	if not num or IsMounted() then
		Dismount()
		return
	end
	if CanExitVehicle() then
		VehicleExit()
		return
	end
	if IsUsableSpell(59569) ~= true then
		nofly = true
	end
	if not nofly and IsFlyableArea() then
		flyablex = true
	end
	for i = 1, 40 do
		local sid = select(10, UnitBuff("player", i))
		if sid == 73701 or sid == 76377 then
			InVj = true
		end
	end
	if InVj and IsSwimming() then
		vjswim = true
	end
	if IsSwimming() and not flyablex and not vjswim then
		swimablex = true
	end

	local riding
	if IsAdvancedFlyableArea() and IsOutdoors() then
		riding = true
		flyablex = true
		if not IsControlKeyDown() then
			flyingmount = ""
			groundmount = ""
		end
	end

	if IsControlKeyDown() then
		if IsSwimming() and not vjswim then
			swimablex = not swimablex
		elseif not vjswim then
			flyablex = not flyablex
			if riding then riding = false end
		else
			vjswim = not vjswim
		end
	end

	local mountIDs = C_MountJournal.GetMountIDs()
	for _, mountID in pairs(mountIDs) do
		local creatureName, spellID = C_MountJournal.GetMountInfoByID(mountID)
		if dragonridingmount and creatureName == dragonridingmount and riding and not swimablex then
			C_MountJournal.SummonByID(mountID)
			return
		elseif flyingmount and creatureName == flyingmount and flyablex and not swimablex then
			C_MountJournal.SummonByID(mountID)
			return
		elseif groundmount and creatureName == groundmount and not flyablex and not swimablex and not vjswim then
			C_MountJournal.SummonByID(mountID)
			return
		elseif underwatermount and creatureName == underwatermount and swimablex then
			C_MountJournal.SummonByID(mountID)
			return
		elseif spellID == 75207 and vjswim then
			C_MountJournal.SummonByID(mountID)
			return
		end
	end
end
