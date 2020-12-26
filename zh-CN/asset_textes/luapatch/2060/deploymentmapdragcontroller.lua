local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentMapDragController)
local UpdateScalePos = function(self,vary,limit)
	if CS.DeploymentBackgroundController.currentLayerData == nil then
		return;
	end
	self:UpdateScalePos(vary,limit);
	if CS.DeploymentBackgroundController.Instance.snowSystem ~= nil and not CS.DeploymentBackgroundController.Instance.snowSystem:isNull() then
		local posx = CS.DeploymentBackgroundController.currentLayerData.leftSpotPos.x+CS.DeploymentBackgroundController.currentLayerData.rightSpotPos.x;
		local posy = CS.DeploymentBackgroundController.currentLayerData.downSpotPos.y + CS.DeploymentBackgroundController.currentLayerData.upSpotPos.y;
		local xlength = CS.DeploymentBackgroundController.currentLayerData.rightSpotPos.x - CS.DeploymentBackgroundController.currentLayerData.leftSpotPos.x;
		local ylength = CS.DeploymentBackgroundController.currentLayerData.upSpotPos.y - CS.DeploymentBackgroundController.currentLayerData.downSpotPos.y;
		CS.DeploymentBackgroundController.Instance.snowSystem.transform.localPosition = CS.UnityEngine.Vector3(posx*0.5,posy*0.5,0);
		CS.DeploymentBackgroundController.Instance.snowSystem.transform.localScale = CS.UnityEngine.Vector3(xlength*0.5,1,ylength*0.5);
	end
end

util.hotfix_ex(CS.DeploymentMapDragController,'UpdateScalePos',UpdateScalePos)
