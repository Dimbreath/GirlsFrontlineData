local util = require 'xlua.util'
xlua.private_accessible(CS.CommonEquipmentListController)
xlua.private_accessible(CS.FactoryController)
local _OnDisable = function(self)
	self:OnDisable();
	if CS.FactoryController.Instance ~=nil and CS.FactoryController.Instance.currentType == CS.FactoryUIType.Retire then
		CS.FactoryController.Instance.toggleChoose:SetActive(false);		 
	end 
end
util.hotfix_ex(CS.CommonEquipmentListController,'OnDisable',_OnDisable)