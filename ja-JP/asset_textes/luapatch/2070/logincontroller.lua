local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)
local Start = function(self)
	self:Start()
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if CS.ApplicationConfigData.PlatformChannelId == "vivo" then
			print("vivo");
		 	CS.SunBornUserCenter.Instance:SetSunbornSDK("PassportUrl", "http://gfcn-passport-other-ly.sunborngame.com");
		end
	end
end
util.hotfix_ex(CS.LoginController,'Start',Start)