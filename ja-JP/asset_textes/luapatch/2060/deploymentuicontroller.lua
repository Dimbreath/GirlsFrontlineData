local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)
local CheckLayer = function(self)
	if CS.DeploymentController.isDeplyment then
		for i = 0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
			local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
			spot.spotAction = CS.SpotAction();
			spot.spotAction.belong = spot.spotInfo.belong;
		end
		self:CheckLayer();
		for i = 0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
			local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
			spot.spotAction = nil;
		end
	else
		self:CheckLayer();
	end
end
util.hotfix_ex(CS.DeploymentUIController,'CheckLayer',CheckLayer)