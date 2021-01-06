local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local DeploymentAllyTeamController_Complete = function(self)
	local belong = CS.GameData.missionAction.currentTurnBelong;
	CS.GameData.missionAction.currentTurnBelong = CS.MissionAction.TurnBelong.SelfTurn;
	self:Complete();
	CS.GameData.missionAction.currentTurnBelong = belong;
	if self.isFriend then
		CS.DeploymentController.TriggerEnemyMoveEvent();
	end
end

util.hotfix_ex(CS.DeploymentAllyTeamController,'Complete',DeploymentAllyTeamController_Complete)
