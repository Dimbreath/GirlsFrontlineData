local util = require 'xlua.util'
xlua.private_accessible(CS.SquadChipListController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.listController.transform:GetChild(0).gameObject:SetActive(false);
end
util.hotfix_ex(CS.SquadChipListController,'InitUIElements',InitUIElements)