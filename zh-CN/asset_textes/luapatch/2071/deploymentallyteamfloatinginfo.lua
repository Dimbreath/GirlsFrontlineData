local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamFloatingInfo)

local CheckPoint = function(self)
	local point = self.allyTeamController.allyTeam:CurrentPower(self.allyTeamController.currentSpot);
	if self.power == point then
		self.txtEnemyTeam.text = tostring(point);
		self.txtAllyPoint.text = tostring(point);
	end
	self:CheckPoint();
end

util.hotfix_ex(CS.DeploymentAllyTeamFloatingInfo,'CheckPoint',CheckPoint)

