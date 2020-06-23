local util = require 'xlua.util'
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.FormationController)
local IsAllTeamExistLeader = function()
	CS.FormationController.Instance:IsAllTeamExistLeader();
end
local IsAllTeamCostAvailible = function()
	CS.FormationController.Instance:IsAllTeamCostAvailible();
end
local GotoScene = function(...)
	if CS.Utility.loadedLevelName == 'Login' then
		CS.CommonController.gotoSceneThrottleDuration = 0.01;
	else
		CS.CommonController.gotoSceneThrottleDuration = 0.5;
	end
	CS.CommonController.GotoScene(...);
end
util.hotfix_ex(CS.CommonController,'GotoScene',GotoScene)