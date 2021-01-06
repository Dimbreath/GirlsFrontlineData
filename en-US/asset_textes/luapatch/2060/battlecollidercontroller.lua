local util = require 'xlua.util'
xlua.private_accessible(CS.BattleColliderController)
local Init = function(self,battleObstacle)
	if battleObstacle:GetType() == typeof(CS.BattleObstacleController) then
		self.Obstacle = battleObstacle
	else
		self.battleCharacter = battleObstacle
	end
	
end
util.hotfix_ex(CS.BattleColliderController,'Init',Init)