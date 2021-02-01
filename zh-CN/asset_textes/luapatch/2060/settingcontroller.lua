local util = require 'xlua.util'
xlua.private_accessible(CS.SettingController)
local Start = function(self)
	self:Start();
	self.goChangeSever:SetActive(CS.Data.GetBool("translate_switch"));
	if CS.HotUpdateController.instance.mUsePlatform ~= CS.HotUpdateController.EUsePlatform.ePlatform_Tw and CS.HotUpdateController.instance.mUsePlatform ~= CS.HotUpdateController.EUsePlatform.ePlatform_Korea then
		self.goILike:SetActive(false);
	end
end
util.hotfix_ex(CS.SettingController,'Start',Start)