local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderPreviewController)
local CommanderPreviewController_OpenOrClosePresetList = function(self)
	if self.tweenPosPresetBtn ~= nil and self.tweenPosPresetBtn.from ~= self.btnShowPreset.transform.localPosition then
		self.tweenPosPresetBtn.from = self.btnShowPreset.transform.localPosition;
		self.tweenPosPresetBtn.to = CS.UnityEngine.Vector3(self.btnShowPreset.transform.localPosition.x, self.btnShowPreset.transform.localPosition.y+41.0,0);
	end
	self:OpenOrClosePresetList();
end
 
util.hotfix_ex(CS.CommanderPreviewController,'OpenOrClosePresetList',CommanderPreviewController_OpenOrClosePresetList)