local util = require 'xlua.util'
xlua.private_accessible(CS.ConnectionController)
local ReLogin = function()
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw then
		print('twkr TriggerDisposeAllStreamEvent')
		CS.TableHelper.TriggerDisposeAllStreamEvent();
	end
	CS.ConnectionController.ReLogin();
end
util.hotfix_ex(CS.ConnectionController,'ReLogin',ReLogin)