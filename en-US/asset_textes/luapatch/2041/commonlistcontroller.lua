local util = require 'xlua.util'
xlua.private_accessible(CS.CommonListController)
local Start = function(self)
	self.maxPoolSize = 64;
	self:Start();
end
util.hotfix_ex(CS.CommonListController,'Start',Start)