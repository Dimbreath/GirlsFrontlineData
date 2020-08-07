local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)
local Awake = function(self)
	self:Awake();
	self:Load(self.campaionId);
	if self.currentPanelConfig ~= nil then
		CS.OPSPanelBackGround.Instance.mainCamera.transform.position = CS.UnityEngine.Vector3(0, 0, self.currentPanelConfig.cameraHight);
		CS.OPSPanelBackGround.Instance.mainCamera.fieldOfView = self.currentPanelConfig.cameraField;
	end
end
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)