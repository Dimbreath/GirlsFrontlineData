local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainRecordItem)

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("InfoGroup/SpecialInfo/Img_powerbg/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220090);--目标作战效能
	self.transform:Find("InfoGroup/Difficult/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220089);--强度
	self.transform:Find("InfoGroup/MultiInfo/InfoGroup_1/Img_BG/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220092);--阵容
	self.transform:Find("InfoGroup/RecordTime/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220091);--记录时间
end
util.hotfix_ex(CS.TargetTrainRecordItem,'InitUIElements',InitUIElements)