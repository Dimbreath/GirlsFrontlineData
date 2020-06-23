local util = require 'xlua.util'
xlua.private_accessible(CS.BingoController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.imgBackground.rectTransform.sizeDelta = CS.UnityEngine.Vector2(2048,2048);
end
util.hotfix_ex(CS.BingoController,'InitUIElements',InitUIElements)