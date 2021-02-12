local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGetNewSangvisGunController)
local firstGo = false
local myInitSangvisGunInfo = function(self,sangvisGun,action)
	if(firstGo == false) then
		print("LuaD 执行");
		firstGo = true;
		CS.UnityEngine.Object.DestroyImmediate(self.gameObject);
		local path = ""
		if(sangvisGun.sangvisInfo.forces == CS.SangvisForceType.KCCO) then
			path = "UGUIPrefabs/SangvisGasha/GetKCCO";
		elseif sangvisGun.sangvisInfo.forces == CS.SangvisForceType.sangvis then
			path = "UGUIPrefabs/SangvisGasha/GetSangvis";
		elseif sangvisGun.sangvisInfo.forces == CS.SangvisForceType.paradeus then
			path = "UGUIPrefabs/SangvisGasha/GetParadeus";
		else
			path = "UGUIPrefabs/SangvisGasha/GetOther";
		end
		local obj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath(path));
		local newSangvisGunController = obj:GetComponent(typeof(CS.CommonGetNewSangvisGunController))
		newSangvisGunController:InitSangvisGunInfo(sangvisGun,action)
	end
end
local myClose = function(self)
	if(self.boolCanClose == true) then
		firstGo = false;
	end
	self:Close();
end
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'InitSangvisGunInfo',myInitSangvisGunInfo)
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'Close',myClose)