local update_info_tbl = util.JSONToTable(http.Fetch("https://raw.githubusercontent.com/VaasKahnGrim/BASIC_StarwarsRP_Weapon_Base/master/versioning.json"))
local current_version = "Beta 3A"
if update_info_tbl.version != current_version then
	print("Vaas Weapon Base version didn't match the version check. Current version on server: "..current_version)
	--print("The currently uptodate version: "..update_info_tbl.version.." Version #: "..update_info_tbl.version_num)
	--print("You can find the current version here https://github.com/VaasKahnGrim/BASIC_StarwarsRP_Weapon_Base")
	print("Or here https://steamcommunity.com/sharedfiles/filedetails/?id=1548256366")
end
