local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisFormaionController)

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:Find("ButtonFormation/Text_Formation"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(270048);
end
util.hotfix_ex(CS.SangvisFormaionController,'InitUIElements',InitUIElements)