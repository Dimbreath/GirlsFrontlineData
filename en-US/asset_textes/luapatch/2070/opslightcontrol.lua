local util = require 'xlua.util'
xlua.private_accessible(CS.OPSLightControl)

local Init = function(self)
	self:Init();
	if CS.OPSPanelController.Instance.campaionId == -44 then
		self.light1.transform.position = CS.UnityEngine.Vector3(0,0,300);
		self.light2.transform.position = CS.UnityEngine.Vector3(-20,-100,40);
	end
end


util.hotfix_ex(CS.OPSLightControl,'Init',Init)


