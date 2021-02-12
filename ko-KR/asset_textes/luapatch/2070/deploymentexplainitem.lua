local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentExplainItem)
local RefreshMain = function(self)
	local change = false;
	if self.winTypeInfo.type == 1406 or self.winTypeInfo.type == 1407 then
		if  self.winTypeInfo.hiden then
			self.winTypeInfo.is_hidden = 0;
			change = true;
		end
	end	
	self:RefreshMain();
	if change then
		self.winTypeInfo.is_hidden = 1;
	end
end

util.hotfix_ex(CS.DeploymentExplainItem,'RefreshMain',RefreshMain)

