local util = require 'xlua.util'
xlua.private_accessible(CS.Data)
local listGun = nil;
local GetGunsSuggestedToCombine_Raw = function()
	listGun = CS.Data.GetGunsSuggestedToCombine();
end
local GetGunsSuggestedToCombine = function()
   	if pcall(GetGunsSuggestedToCombine_Raw) then
		-- success
		return listGun;
	else
		-- failure
		listGun = nil;
		CS.UnityEngine.PlayerPrefs.DeleteKey('LocalGunsIgnoreCombineSuggest');
		return CS.System.Collections.Generic.List(CS.GF.Battle.Gun)();
	end
end
util.hotfix_ex(CS.Data,'GetGunsSuggestedToCombine',GetGunsSuggestedToCombine)