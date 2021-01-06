local util = require 'xlua.util'
xlua.private_accessible(CS.CommonController)
local GotoScene = function(...)
	if CS.Utility.loadedLevelName == 'Login' then
		CS.CommonController.gotoSceneThrottleDuration = 0.01;
	else
		CS.CommonController.gotoSceneThrottleDuration = 0.5;
	end
	CS.CommonController.GotoScene(...);
end
util.hotfix_ex(CS.CommonController,'GotoScene',GotoScene)