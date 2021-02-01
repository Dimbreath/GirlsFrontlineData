local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPresetLabelController)
local CommonPresetLabelController_UpdateChosenState = function(self,index)
	self:UpdateChosenState(index);
	if self.presetIndex == index then
		self.uiHolder:GetUIElement("Frame",typeof(CS.UnityEngine.UI.Toggle)).isOn=true;
	else
		self.uiHolder:GetUIElement("Frame",typeof(CS.UnityEngine.UI.Toggle)).isOn=false;
	end
end
util.hotfix_ex(CS.CommonPresetLabelController,'UpdateChosenState',CommonPresetLabelController_UpdateChosenState)