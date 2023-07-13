local T, C, L = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Move vehicle indicator
----------------------------------------------------------------------------------------
local VehicleAnchor = CreateFrame("Frame", "VehicleAnchor", UIParent)
VehicleAnchor:SetPoint(unpack(C.position.vehicle))
VehicleAnchor:SetSize(130, 130)

hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(_, _, parent)
	if parent and parent ~= VehicleAnchor then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint("BOTTOM", VehicleAnchor, "BOTTOM", 0, 24)
		VehicleSeatIndicator:SetFrameStrata("LOW")
	end
end)

----------------------------------------------------------------------------------------
--	Vehicle indicator on mouseover
----------------------------------------------------------------------------------------
if C.general.vehicle_mouseover then
	local function VehicleSeatMouseover(self, vehicleID)
		if self:IsShown() then
			self:SetAlpha(0)
			self:HookScript("OnEnter", function() self:SetAlpha(1) end)
			self:HookScript("OnLeave", function() self:SetAlpha(0) end)

			local _, numSeat = GetVehicleUIIndicator(vehicleID)
			for i = 1, numSeat do
				local b = _G["VehicleSeatIndicatorButton"..i]
				b:HookScript("OnEnter", function() self:SetAlpha(1) end)
				b:HookScript("OnLeave", function() self:SetAlpha(0) end)
			end
		end
	end
	hooksecurefunc(VehicleSeatIndicator, "SetupVehicle", VehicleSeatMouseover)
end