local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchEquipmentStrengthenController)
local OnClickClearAll = function(self)
	local isOpen = CS.CommonEquipmentListController.inst ~= nil and (not CS.CommonEquipmentListController.inst:isNull()) and CS.CommonEquipmentListController.inst.gameObject.activeSelf;
	self:OnClickClearAll();
	if (not isOpen) and CS.CommonEquipmentListController.inst ~= nil and not CS.CommonEquipmentListController.inst:isNull() then
		CS.CommonEquipmentListController.inst.gameObject:SetActive(false);
	end
	isOpen = nil;
end
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'OnClickClearAll',OnClickClearAll)