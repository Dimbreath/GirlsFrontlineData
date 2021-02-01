local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionActivityController)

local InitUIElements = function(self)
	self:InitUIElements();
	self.txtActivityName.horizontalOverflow = CS.UnityEngine.HorizontalWrapMode.Wrap;
	self.txtActivityName.verticalOverflow = CS.UnityEngine.VerticalWrapMode.Overflow;
	self.txtActivityName.lineSpacing = 0.8;
	local layelement = self.txtActivityName:GetComponent(typeof(CS.UnityEngine.UI.LayoutElement));
	layelement.preferredWidth = 600;
	layelement.preferredHeight = 80;
end

util.hotfix_ex(CS.MissionSelectionActivityController,'InitUIElements',InitUIElements)
