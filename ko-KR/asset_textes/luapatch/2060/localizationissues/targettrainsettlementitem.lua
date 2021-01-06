local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainSettlementItem)

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("AttriList/DmgInfoGroup/InfoGroup_01/Img_InfoBg/UI_Text_AttriName"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(40338);--强度
end
util.hotfix_ex(CS.TargetTrainSettlementItem,'InitUIElements',InitUIElements)