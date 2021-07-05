local util = require 'xlua.util'
xlua.private_accessible(CS.ConfigData)
local SetLowResolution = function(isLow)
	if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.IPhonePlayer then
		CS.ConfigData.SetLowResolution(isLow);
	end
end

util.hotfix_ex(CS.ConfigData,'SetLowResolution',SetLowResolution)