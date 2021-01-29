local util = require 'xlua.util'

local AddDieEnemyCount = function(self,enemyteam,addnum)
	self:AddDieEnemyCount(enemyteam,addnum);
	self.allDieEnemyNum = self.allDieEnemyNum + addnum;
end

util.hotfix_ex(CS.MissionAction,'AddDieEnemyCount',AddDieEnemyCount)