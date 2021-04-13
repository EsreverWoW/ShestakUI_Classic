local T, C, L, _ = unpack(select(2, ...))
if not T.BCC or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Socket skin
----------------------------------------------------------------------------------------

T.SkinFuncs["Blizzard_ItemSocketingUI"] = LoadSkin
