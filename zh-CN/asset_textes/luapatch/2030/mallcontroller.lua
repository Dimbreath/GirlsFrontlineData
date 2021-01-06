local util = require 'xlua.util'
xlua.private_accessible(CS.MallController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.uiHolder:GetUIElement("Main/ScrollBar/ExchangePanel",typeof(CS.UnityEngine.UI.GridLayoutGroup)).startAxis = CS.UnityEngine.UI.GridLayoutGroup.Axis.Horizontal;
	self.uiHolder:GetUIElement("Main/ScrollBar/GiftPanel",typeof(CS.UnityEngine.UI.GridLayoutGroup)).startAxis = CS.UnityEngine.UI.GridLayoutGroup.Axis.Horizontal;
end
util.hotfix_ex(CS.MallController,'InitUIElements',InitUIElements)