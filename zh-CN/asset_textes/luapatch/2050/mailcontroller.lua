local util = require 'xlua.util'
xlua.private_accessible(CS.MailController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:GetChild(0).anchoredPosition = CS.UnityEngine.Vector2(0,0);
end
util.hotfix_ex(CS.MailController,'InitUIElements',InitUIElements)