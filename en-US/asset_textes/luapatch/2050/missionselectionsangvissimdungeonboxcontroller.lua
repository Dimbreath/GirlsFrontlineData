local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionSangvisSimDungeonBoxController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.SubTitle.text = CS.Data.GetLang(40288);
	self.transform:Find("Background"):GetComponent(typeof(CS.ImageBufferBlurRefraction)).enabled = false;
end
util.hotfix_ex(CS.MissionSelectionSangvisSimDungeonBoxController,'InitUIElements',InitUIElements)