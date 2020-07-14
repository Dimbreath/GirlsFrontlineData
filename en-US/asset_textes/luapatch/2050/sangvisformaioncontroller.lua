local util = require 'xlua.util'
xlua.private_accessible(CS.Request)
xlua.private_accessible(CS.GF.Battle.BaseTeam)
xlua.private_accessible(CS.FormationSettingController)
xlua.private_accessible(CS.SangvisFormaionController)
local _Reques = function(self,functionName,message,content,complateHandler,failedHandler,slient,selfCheck)
	if functionName == "Sangvis/teamSangvis" and CS.FormationSettingController.Instance ~=nil and CS.FormationSettingController.Instance.gameObject.activeSelf then
		self.functionName="Sangvis/presetToTeam";
	end
end
local _CheckRearrangeMemberList = function(self)
	if self.needRearrange == true and self.isCostEnable == true then
		self:CheckRearrangeMemberList();
	end
end
local _ExChangeLeaderGun = function(self,originGun,newGun)
	if originGun ~= nil and newGun.teamId ~= 0 and newGun.teamId ~= 101 and newGun.teamId == originGun.teamId and CS.GameData.dictTeam[newGun.teamId].listGun.Count==2 then
		 local fake= CS.SangvisGun();
		 CS.GameData.dictTeam[newGun.teamId].listGun:Add(fake);
	end
	self:ExChangeLeaderGun(originGun,newGun);
end
local _getListGun = function(self,id)--BaseTeam this[int id]

	if self.listGun.Count==0 then
		print(id);
		return nil;
	else  
		return self.listGun[id];
	end
end
util.hotfix_ex(CS.Request,'.ctor',_Reques)
util.hotfix_ex(CS.SangvisFormaionController,'CheckRearrangeMemberList',_CheckRearrangeMemberList)
util.hotfix_ex(CS.SangvisFormaionController,'ExChangeLeaderGun',_ExChangeLeaderGun)
--util.hotfix_ex(CS.GF.Battle.BaseTeam,'get_Item',_getListGun)