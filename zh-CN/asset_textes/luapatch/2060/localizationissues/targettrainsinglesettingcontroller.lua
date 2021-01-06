local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainSingleSettingController)
local InitUIElements = function(self)
	self.transform:Find("Main/Btn_Enture/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(1007);
end
util.hotfix_ex(CS.TargetTrainSingleSettingController,'InitUIElements',InitUIElements)