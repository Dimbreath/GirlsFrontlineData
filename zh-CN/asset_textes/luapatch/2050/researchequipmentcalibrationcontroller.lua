local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchEquipmentCalibrationController)
xlua.private_accessible(CS.ResearchFairyCalibrationController)
local _OnEnable = function(self)
	 self:OnEnable();
	 if self.currentEquip == nil then
	 	self:ClearAll();
	 end
end
local _Init = function(self)
	 self:Init();
	 self:GetCostResourceNum();
end
util.hotfix_ex(CS.ResearchEquipmentCalibrationController,'OnEnable',_OnEnable)
util.hotfix_ex(CS.ResearchFairyCalibrationController,'Init',_Init)