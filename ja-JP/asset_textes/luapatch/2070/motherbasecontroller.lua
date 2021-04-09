local util = require 'xlua.util'
xlua.private_accessible(CS.MotherBaseController)
local Start = function(self)
	self:Start();
	local postEffect = CS.UnityEngine.Camera.main.transform:GetComponent(typeof(CS.UnityEngine.PostProcessing.PostProcessingBehaviour));
	postEffect.enabled = false;
end

util.hotfix_ex(CS.MotherBaseController,'Start',Start)

