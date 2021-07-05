local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingInfo)

local Init = function(self,buildController)
	self:Init(buildController);
	if buildController.buildObj.name == "Console_P" then
		self.transform:Find("Title").localPosition = CS.UnityEngine.Vector3(0,-100,0);
	end
end

local UpdateInfo = function(self)
	if self.buildController.buildAction.activeOrder < 0 then
		self.buildController:InitCode(self.buildController.buildAction.buildingInfo.spineCode);
	end
	self:UpdateInfo();
end

util.hotfix_ex(CS.DeploymentBuildingInfo,'Init',Init)
util.hotfix_ex(CS.DeploymentBuildingInfo,'UpdateInfo',UpdateInfo)


