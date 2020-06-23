local util = require 'xlua.util'
xlua.private_accessible(CS.CommonFurnitureListLabelController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("TextPutin"):SetParent(self.gobjPutIn.transform, true);
end
util.hotfix_ex(CS.CommonFurnitureListLabelController,'InitUIElements',InitUIElements)