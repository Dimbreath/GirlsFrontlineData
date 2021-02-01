local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainRecordController)

local InitUIElements = function(self)
	self:InitUIElements();
	self.textCurrent.text = CS.Data.GetLang(220074);
end
util.hotfix_ex(CS.TargetTrainRecordController,'InitUIElements',InitUIElements)