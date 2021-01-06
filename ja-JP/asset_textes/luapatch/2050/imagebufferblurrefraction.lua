local util = require 'xlua.util'
xlua.private_accessible(CS.ImageBufferBlurRefraction)

local ImageBufferBlurRefraction_Awake = function(self)
	if CS.UnityEngine.Camera.main ~= nil then
		self:Awake();
		if CS.ImageBufferBlurRefraction.depthonlyCamain ~= nil then
			CS.ImageBufferBlurRefraction.depthonlyCamain.orthographic = CS.UnityEngine.Camera.main.orthographic;
			if CS.UnityEngine.Application.loadedLevelName == "Home" then
				CS.ImageBufferBlurRefraction.depthonlyCamain.fieldOfView = 50;
			else
				CS.ImageBufferBlurRefraction.depthonlyCamain.fieldOfView = CS.UnityEngine.Camera.main.fieldOfView;
			end
		end
	end
end

util.hotfix_ex(CS.ImageBufferBlurRefraction,'Awake',ImageBufferBlurRefraction_Awake)
