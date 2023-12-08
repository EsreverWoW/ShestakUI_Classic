local T, C, L = unpack(ShestakUI)
if C.bag.enable == true then return end

local hook
local _E

local pipe = function(self)
	if oGlow:IsClassic() then
		local id = self:GetID()
		local name = self:GetName()
		local size = self.size

		for i = 1, size do
			local bid = size - i + 1
			local slotFrame = _G[name.."Item"..bid]
			local slotLink = C_Container.GetContainerItemLink(id, i)
			oGlow:CallFilters("bags", slotFrame, _E and slotLink)
		end
	else
		for _, button in self:EnumerateValidItems() do
			local bagID = button:GetBagID()
			local slotID = button:GetID()
			local slotLink = C_Container.GetContainerItemLink(bagID, slotID)

			oGlow:CallFilters("bags", button, _E and slotLink)
		end
	end
end

local update = function(self)
	local frame = _G["ContainerFrame1"]
	local i = 2
	while(frame and frame.size) do
		pipe(frame)
		frame = _G["ContainerFrame"..i]
		i = i + 1
	end
end

local enable = function(self)
	_E = true

	if not hook then
		if oGlow:IsClassic() then
			hooksecurefunc("ContainerFrame_Update", pipe)
		else
			for i = 1, NUM_CONTAINER_FRAMES do
				local frame = _G["ContainerFrame"..i]
				hooksecurefunc(frame, "UpdateItems", pipe)
			end
			hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", pipe)
		end

		hook = true
	end
end

local disable = function(self)
	_E = nil
end

oGlow:RegisterPipe("bags", enable, disable, update, "Bag containers")