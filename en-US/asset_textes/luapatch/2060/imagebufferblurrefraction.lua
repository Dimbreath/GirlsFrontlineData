local util = require 'xlua.util'
xlua.private_accessible(CS.ImageBufferBlurRefraction)
local Awake = function(self)
	self:Awake();
	if  CS.UnityEngine.Application.loadedLevelName == "SpecialActivity" and CS.ImageBufferBlurRefraction.depthonlyCamain ~= nil then
		CS.ImageBufferBlurRefraction.depthonlyCamain.nearClipPlane = -5;
	end
end

util.hotfix_ex(CS.ImageBufferBlurRefraction,'Awake',Awake)
