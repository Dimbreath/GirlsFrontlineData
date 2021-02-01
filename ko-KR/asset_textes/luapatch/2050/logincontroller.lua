local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)

local Start = function(self)
	self:Start();
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
		if self.transform:Find("LogoCorner") == nil then
			local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Prefabs/Logos"), self.transform);
			gobj.transform:SetSiblingIndex(5);
		end
	end
end
util.hotfix_ex(CS.LoginController,'Start',Start)