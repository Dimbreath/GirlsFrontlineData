local util = require 'xlua.util'
xlua.private_accessible(CS.BuildingAction)

local AddDieEnemyCount = function(self,enemyteam,addnum)
	self:AddDieEnemyCount(enemyteam,addnum);
	self.allDieEnemyNum = self.allDieEnemyNum + addnum;
end

local buildController_New = function(self)
	return self._buildController;
end
util.hotfix_ex(CS.MissionAction,'AddDieEnemyCount',AddDieEnemyCount)
--util.hotfix_ex(CS.BuildingAction,'get_buildController',buildController_New)