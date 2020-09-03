local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentMapDragController)
local UpdateScalePos = function(self,vary,limit)
	if CS.DeploymentBackgroundController.currentLayerData == nil then
		return;
	end
	self:UpdateScalePos(vary,limit);
end

util.hotfix_ex(CS.DeploymentMapDragController,'UpdateScalePos',UpdateScalePos)
