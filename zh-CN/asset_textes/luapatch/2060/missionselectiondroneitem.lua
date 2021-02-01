local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneItem)

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("ItemLocked/Img_BG/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(40300);
	self.transform:Find("Btn_Battle/Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220075);
end

util.hotfix_ex(CS.MissionSelectionDroneItem,'InitUIElements',InitUIElements)
