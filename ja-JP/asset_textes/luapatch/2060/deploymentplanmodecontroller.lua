local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPathController)
local OnClickSpotFast = function(self,spot)
	if spot.CanNotEnter then
		return;
	end	
	self:OnClickSpotFast(spot);
end

local getNodeLengthInfo = function(self,node)
	if node.CanNotEnter then
		return CS.System.int.MaxValue;
	end
	return self:getNodeLengthInfo(node);
end

util.hotfix_ex(CS.DeploymentPlanModeController,'OnClickSpotFast',OnClickSpotFast)
util.hotfix_ex(CS.DeploymentPlanModeController,'getNodeLengthInfo',getNodeLengthInfo)