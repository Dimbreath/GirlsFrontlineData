local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainSettlement)

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("Main/LeftInfoGroup/AimBaseInfoGroup/MultiInfo/InfoGroup_Difficult/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220089);--强度
end
util.hotfix_ex(CS.TargetTrainSettlement,'InitUIElements',InitUIElements)