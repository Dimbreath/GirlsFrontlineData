local util = require 'xlua.util'
xlua.private_accessible(CS.AdjustAdjutantScaleController)
local OnClickSwitchDamaged = function(self)
	if (self.mAdjutantInfo.GetAdjutantType == CS.AdjutantInfo.AdjutantType.GUN) then
		if (CS.HomeController.Instance.btnPicHolder.transform.childCount > 0 and CS.HomeController.Instance.btnPicHolder.transform:GetChild(0).childCount > 1) then
			CS.HomeController.Instance.picController:SwitchDamaged(not CS.HomeController.Instance.btnPicHolder.transform:GetChild(0):GetChild(1).gameObject.activeSelf);
			return;
		end
	end
	self:OnClickSwitchDamaged()
end
util.hotfix_ex(CS.AdjustAdjutantScaleController,'OnClickSwitchDamaged',OnClickSwitchDamaged)