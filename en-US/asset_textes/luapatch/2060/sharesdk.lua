local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)
local Start = function(self)
	self:Start();
	if CS.cn.sharesdk.unity3d.ShareSDK.instance ~= nil then
		CS.UnityEngine.Object.DontDestroyOnLoad(CS.cn.sharesdk.unity3d.ShareSDK.instance.gameObject);
	end
end
util.hotfix_ex(CS.LoginController,'Start',Start)