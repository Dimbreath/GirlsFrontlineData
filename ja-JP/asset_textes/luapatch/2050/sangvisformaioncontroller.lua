local util = require 'xlua.util'
xlua.private_accessible(CS.Request)
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
util.hotfix_ex(CS.Request,'.ctor',_Reques)
util.hotfix_ex(CS.SangvisFormaionController,'CheckRearrangeMemberList',_CheckRearrangeMemberList)