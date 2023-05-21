local T, C, L = unpack(ShestakUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Major Factions skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.MajorFactionRenownFrame

	T.SkinFrame(frame)
	frame.Background:SetAlpha(0)
end

T.SkinFuncs["Blizzard_MajorFactions"] = LoadSkin