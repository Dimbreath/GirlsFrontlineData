local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPathController)
local CheckSpotsLineVisible = function(self,play)
	if self.spot0 ~= nil and  self.spot0.packageIgnore then
		return;
	end
	if self.spot1 ~= nil and  self.spot1.packageIgnore then
		return;
	end	
	self:CheckSpotsLineVisible(play);
end
util.hotfix_ex(CS.DeploymentPathController,'CheckSpotsLineVisible',CheckSpotsLineVisible)