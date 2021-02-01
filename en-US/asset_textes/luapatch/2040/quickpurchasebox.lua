local util = require 'xlua.util'
xlua.private_accessible(CS.QuickPurchaseBox)
local QuickPurchaseBox_InitUIElements = function(self)
	 self:InitUIElements();
	 self.textTitleHint.text = CS.Data.GetLang(1192);
end
util.hotfix_ex(CS.QuickPurchaseBox,'InitUIElements',QuickPurchaseBox_InitUIElements)
