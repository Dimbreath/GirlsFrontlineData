local util = require 'xlua.util'
xlua.private_accessible(CS.FormationSettingController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:InitNarrowScreenAdaption();
end
util.hotfix_ex(CS.FormationSettingController,'InitUIElements',InitUIElements)