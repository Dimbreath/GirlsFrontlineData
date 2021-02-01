local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSpotController)
xlua.private_accessible(CS.DeploymentBackgroundController)

local DeploymentBackgroundController_Init = function(self)
	self:Init();
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count -1 do
		CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i).show = false;		
	end
end
	
util.hotfix_ex(CS.DeploymentBackgroundController,'Init',DeploymentBackgroundController_Init)