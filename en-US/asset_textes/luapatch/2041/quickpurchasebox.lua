local util = require 'xlua.util'
xlua.private_accessible(CS.QuickPurchaseBox)
local SetWarningText = function(self,text)
	if text == "动能梯度计价" then
		text = CS.Data.GetLang(71120);
	end
	self:SetWarningText(text);
end
local Init = function(self)
	self:InitUIElements();
	self.textTitleDescription.text = CS.Data.GetLang(1652);
end
util.hotfix_ex(CS.QuickPurchaseBox,'SetWarningText',SetWarningText)
util.hotfix_ex(CS.QuickPurchaseBox,'InitUIElements',Init)