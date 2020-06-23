local util = require 'xlua.util'
xlua.private_accessible(CS.MallController)

local _WaitingForValidate = function(self)
	self.isIAPValidate=true;
end

if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal then
	if CS.ConfigData.clientVersion == "20501" and CS.ApplicationConfigData.PlatformChannelId == "TX" then
	util.hotfix_ex(CS.MallController,'WaitingForValidate',_WaitingForValidate)
	end
end