local util = require 'xlua.util'
xlua.private_accessible(CS.CommonIconController)
local Init = function(self,builder)
	self.goChecked:SetActive(true);
	self:Init(builder);
end
util.hotfix_ex(CS.CommonIconController,'Init',Init)