local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
local RequestStartMissionHandle = function(self,www)
	self:RequestStartMissionHandle(www);
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		CS.DeploymentBackgroundController.Instance.listSpot[i]:CheckBuild();
	end
end

util.hotfix_ex(CS.DeploymentController,'RequestStartMissionHandle',RequestStartMissionHandle)