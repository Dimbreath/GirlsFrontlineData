local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)

local DeploymentBuildingController_ShowWinTarget = function(self,winType,medal)
	if self.info ~= nil then
		self:ShowWinTarget(winType,medal);
	end
end
local DeploymentBuildingController_CloseWinTarget = function(self,winType)
	if self.info ~= nil then
		self:CloseWinTarget(winType);
	end
end

util.hotfix_ex(CS.DeploymentBuildingController,'ShowWinTarget',DeploymentBuildingController_ShowWinTarget)
util.hotfix_ex(CS.DeploymentBuildingController,'CloseWinTarget',DeploymentBuildingController_CloseWinTarget)
