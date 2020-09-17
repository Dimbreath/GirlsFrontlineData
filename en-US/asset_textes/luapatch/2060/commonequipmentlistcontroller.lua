local util = require 'xlua.util'
xlua.private_accessible(CS.CommonEquipmentListController)
xlua.private_accessible(CS.FactoryController)
local _OnDisable = function(self)
	self:OnDisable();
	if CS.FactoryController.Instance ~=nil and CS.FactoryController.Instance.currentType == CS.FactoryUIType.Retire then
		CS.FactoryController.Instance.toggleChoose:SetActive(false);		 
	end 
end
local myCreateList = function(self, ...)
	for i = 0, self.arrGoCategory.Length - 1, 1 do
        self.arrGoCategory[i]:SetActive(true);
	end
	self:CreateList(...);
	
end
util.hotfix_ex(CS.CommonEquipmentListController,'OnDisable',_OnDisable)
util.hotfix_ex(CS.CommonEquipmentListController,'CreateList',myCreateList)
