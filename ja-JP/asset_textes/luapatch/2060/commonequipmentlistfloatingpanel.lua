local util = require 'xlua.util'
xlua.private_accessible(CS.CommonEquipmentListFloatingPanel)
local SetEquip = function(self, equip)
	self:SetEquip(equip);
	if equip.info.bonus_type == '' or equip.info.bonus_type == nil then
		self.btnEnhancement.image.color = CS.UnityEngine.Color(1,1,1,0.5);
	end
end
local OnClickEnhancement = function(self)
	
	if self.equip.info.bonus_type == '' or self.equip.info.bonus_type == nil then
		--CS.CommonController.LightMessageTips(CS.Data.GetLang(1));
	else
		self:OnClickEnhancement();
	end
end
util.hotfix_ex(CS.CommonEquipmentListFloatingPanel,'SetEquip',SetEquip)
util.hotfix_ex(CS.CommonEquipmentListFloatingPanel,'OnClickEnhancement',OnClickEnhancement)