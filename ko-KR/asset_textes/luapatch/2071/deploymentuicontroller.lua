local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)

local RefreshText = function(self)
	self:RefreshText();
	if CS.GameData.missionAction ~= nil then
		local num = CS.GameData.missionAction.enemyDieNumber + CS.GameData.missionAction.alldieallyNum;
		self.textDeadRestEnemyCount.text = tostring(num);
	end
end

util.hotfix_ex(CS.DeploymentUIController,'RefreshText',RefreshText)



