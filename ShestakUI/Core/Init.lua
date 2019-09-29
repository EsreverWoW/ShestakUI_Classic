----------------------------------------------------------------------------------------
--	Initiation of ShestakUI
----------------------------------------------------------------------------------------
-- Including system
local addon, engine = ...
engine[1] = {}	-- T, Functions
engine[2] = {}	-- C, Config
engine[3] = {}	-- L, Localization

ShestakUI = engine	-- Allow other addons to use Engine

--[[
	This should be at the top of every file inside of the ShestakUI AddOn:
	local T, C, L, _ = unpack(select(2, ...))

	This is how another addon imports the ShestakUI engine:
	local T, C, L, _ = unpack(ShestakUI)
]]

----------------------------------------------------------------------------------------
--	Fix UIDropDownMenu taint
----------------------------------------------------------------------------------------
--HonorFrameLoadTaint workaround
--credit: https://www.townlong-yak.com/bugs/afKy4k-HonorFrameLoadTaint
if (_G.UIDROPDOWNMENU_VALUE_PATCH_VERSION or 0) < 2 then
	_G.UIDROPDOWNMENU_VALUE_PATCH_VERSION = 2
	hooksecurefunc('UIDropDownMenu_InitializeHelper', function()
		if _G.UIDROPDOWNMENU_VALUE_PATCH_VERSION ~= 2 then
			return
		end
		for i=1, _G.UIDROPDOWNMENU_MAXLEVELS do
			for j=1, _G.UIDROPDOWNMENU_MAXBUTTONS do
				local b = _G['DropDownList' .. i .. 'Button' .. j]
				if not (issecurevariable(b, 'value') or b:IsShown()) then
					b.value = nil
					repeat
						j, b["fx" .. j] = j+1, nil
					until issecurevariable(b, 'value')
				end
			end
		end
	end)
end

--CommunitiesUI taint workaround
--credit: https://www.townlong-yak.com/bugs/Kjq4hm-DisplayModeTaint
if (_G.UIDROPDOWNMENU_OPEN_PATCH_VERSION or 0) < 1 then
	_G.UIDROPDOWNMENU_OPEN_PATCH_VERSION = 1
	hooksecurefunc('UIDropDownMenu_InitializeHelper', function(frame)
		if _G.UIDROPDOWNMENU_OPEN_PATCH_VERSION ~= 1 then
			return
		end
		if _G.UIDROPDOWNMENU_OPEN_MENU and _G.UIDROPDOWNMENU_OPEN_MENU ~= frame
		   and not issecurevariable(_G.UIDROPDOWNMENU_OPEN_MENU, 'displayMode') then
			_G.UIDROPDOWNMENU_OPEN_MENU = nil
			local t, f, prefix, i = _G, issecurevariable, ' \0', 1
			repeat
				i, t[prefix .. i] = i + 1, nil
			until f('UIDROPDOWNMENU_OPEN_MENU')
		end
	end)
end

--CommunitiesUI taint workaround #2
--credit: https://www.townlong-yak.com/bugs/YhgQma-SetValueRefreshTaint
if (_G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION or 0) < 1 then
	_G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION = 1
	local function CleanDropdowns()
		if _G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION ~= 1 then
			return
		end
		local f, f2 = _G.FriendsFrame, _G.FriendsTabHeader
		local s = f:IsShown()
		f:Hide()
		f:Show()
		if not f2:IsShown() then
			f2:Show()
			f2:Hide()
		end
		if not s then
			f:Hide()
		end
	end
	hooksecurefunc('Communities_LoadUI', CleanDropdowns)
	hooksecurefunc('SetCVar', function(n)
		if n == 'lastSelectedClubId' then
			CleanDropdowns()
		end
	end)
end