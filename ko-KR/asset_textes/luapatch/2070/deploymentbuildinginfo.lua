local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingInfo)

local Init = function(self,buildController)
	self:Init(buildController);
	if buildController.buildObj.name == "Console_P" then
		self.transform:Find("Title").localPosition = CS.UnityEngine.Vector3(0,-100,0);
	end
end


util.hotfix_ex(CS.DeploymentBuildingInfo,'Init',Init)


