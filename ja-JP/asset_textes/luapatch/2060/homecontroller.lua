local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)
xlua.private_accessible(CS.WebCameraManager)
local ShowBackground_New = function(self, isShow)
	if CS.WebCameraManager.Instance ~= nil and isShow == false and CS.WebCameraManager.Instance.isScalePic == true then
		--CS.NDebug.LogError("lua ShowBackground return")
		return
	else
		--CS.NDebug.LogError("lua ShowBackground :" .. tostring(isShow))
		self:ShowBackground(isShow)
	end	
end
util.hotfix_ex(CS.HomeController,'ShowBackground',ShowBackground_New)