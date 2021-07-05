local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)
local Start = function(self)
	self:Start()
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if CS.ApplicationConfigData.PlatformChannelId == "vivo" then
		 	CS.SunBornUserCenter.Instance:SetSunbornSDK("PassportUrl", "http://gfcn-passport-other-ly.sunborngame.com");
		end
		local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Prefabs/RatingMark"), self.transform);
		gobj.transform:SetSiblingIndex(3);
	end
end
util.hotfix_ex(CS.LoginController,'Start',Start)