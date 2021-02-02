local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSquadListInfoController)

local Show = function(self,play)
	self:Show(play);
	if CS.GameData.currentSelectedMissionInfo.squadLimitTeam > 0 then
		local txt = tostring(CS.DeploymentController.Instance.SquadTeamsCount).."/"..tostring(CS.GameData.currentSelectedMissionInfo.squadLimitTeam);
		self.txtShowTeamNum.text = txt;
	else
		self.txtShowTeamNum.text = tostring(CS.DeploymentController.Instance.SquadTeamsCount);
	end
	if CS.GameData.currentSelectedMissionInfo.totalTeamLimit > 0 then
		local txt = tostring(CS.DeploymentController.Instance.TotalTeamsCount).."/"..tostring(CS.GameData.currentSelectedMissionInfo.totalTeamLimit);
		self.txtTotalDeployedNum.text = txt;
	else
		self.txtTotalDeployedNum.text = tostring(CS.DeploymentController.Instance.TotalTeamsCount);
	end
end


util.hotfix_ex(CS.DeploymentSquadListInfoController,'Show',Show)



