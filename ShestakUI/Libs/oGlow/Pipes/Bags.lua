local T, C, L, _ = unpack(select(2, ...))
if C.bag.enable == true then return end

local hook
local _E

local pipe = function(self)
	local id = self:GetID()
	local name = self:GetName()
	local size = self.size

	for i = 1, size do
		local bid = size - i + 1
		local slotFrame = _G[name.."Item"..bid]
		local slotLink = GetContainerItemLink(id, i)

		oGlow:CallFilters("bags", slotFrame, _E and slotLink)
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
		hooksecurefunc("ContainerFrame_Update", pipe)
		hook = true
	end
end

local disable = function(self)
	_E = nil
end

oGlow:RegisterPipe("bags", enable, disable, update, "Bag containers")
