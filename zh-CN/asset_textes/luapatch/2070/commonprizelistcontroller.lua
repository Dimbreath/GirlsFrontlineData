local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPrizeListController)
local get_toggleSortDirection = function(self)
	return self.uiHolder:GetUIElement("SafeRect/Right/FurnitureFliter/ButtonSortDirection",typeof(CS.ExToggleChoose));
end
local RefreshUI = function(self,hideFilter)
	self:RefreshUI(hideFilter);
	if self._skinDisplayList ~= nil then
		self._skinDisplayList.gameObject:SetActive(false);
    end
end
util.hotfix_ex(CS.CommonPrizeListController,'get_toggleSortDirection',get_toggleSortDirection)
util.hotfix_ex(CS.CommonPrizeListController,'RefreshUI',RefreshUI)