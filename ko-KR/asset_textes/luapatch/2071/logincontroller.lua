local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)
xlua.private_accessible(CS.ResCenter)
local myEnterGame = function()
    CS.GameData.equipRealGunSoltMap:Clear();
	for i = 0, CS.GameData.listGun.Count - 1, 1 do
		local gun = CS.GameData.listGun[i];
		for j = 0, gun.equipList.Count - 1, 1 do
			local eq = gun.equipList[j];
			if (CS.GameData.equipRealGunSoltMap:ContainsKey(eq.id)) then
                CS.GameData.equipRealGunSoltMap[eq.id] = eq.slotWithGun;
            else
                CS.GameData.equipRealGunSoltMap:Add(eq.id, eq.slotWithGun);
            end
            if (CS.GameData.equipRealGunMap:ContainsKey(eq.id)) then
                CS.GameData.equipRealGunMap[eq.id] = gun.id;
            else
                CS.GameData.equipRealGunMap:Add(eq.id, gun.id);
			end
		end
	end
	CS.LoginController.EnterGame();
end

local RequestGetNBVersion = function(self)
	self:RequestGetNBVersion(www);
	if CS.ResCenter.instance.newResData ~= nil then
		CS.ResCenter.instance:DeleteSpareRes();
	end
end

local Start = function(self)
	self:Start();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Prefabs/RatingMark"), self.transform);
		gobj.transform:SetSiblingIndex(3);
	end
end
util.hotfix_ex(CS.LoginController,'EnterGame',myEnterGame)
util.hotfix_ex(CS.LoginController,'RequestGetNBVersion',RequestGetNBVersion)
util.hotfix_ex(CS.LoginController,'Start',Start)