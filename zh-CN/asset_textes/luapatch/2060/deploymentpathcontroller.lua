local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentPathController)
local CheckSpotsLineVisible = function(self,play)
	if not self.spot0:isNull() and  self.spot0.packageIgnore then
		return;
	end
	if not self.spot1:isNull() and  self.spot1.packageIgnore then
		return;
	end	
	self:CheckSpotsLineVisible(play);
end
util.hotfix_ex(CS.DeploymentPathController,'CheckSpotsLineVisible',CheckSpotsLineVisible)