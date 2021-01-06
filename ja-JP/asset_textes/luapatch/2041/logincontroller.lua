local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)

local LoginController_RequestGetNBVersion = function(self)
	if CS.ResCenter.instance.currentUsePath == CS.HotUpdateController.UsePath.UsePersistentDataPath then
		if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea then
			if string.find(CS.ResManager.resUrl,"http://gfkrcdn.imtxwy.com/") ~= 1 then
				print (CS.ResManager.resUrl)
				CS.ResCenter.instance:LoadScene("HotUpdate");
				return;
			end
		elseif CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw then
			if string.find(CS.ResManager.resUrl, "http://sncdn.imtxwy.com/") ~= 1 then
				print (CS.ResManager.resUrl)
				CS.ResCenter.instance:LoadScene("HotUpdate");
				return;
			end	
		end
	end
	self:RequestGetNBVersion();
end
util.hotfix_ex(CS.LoginController,'RequestGetNBVersion',LoginController_RequestGetNBVersion)