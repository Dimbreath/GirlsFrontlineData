local util = require 'xlua.util'
xlua.private_accessible(CS.TargetTrainMultiSettingItem)

local PreviewEnemy = function(self)
	self:PreviewEnemy();
	CS.DeploymentEnemyFormation.InstanceUse.transform:SetParent(CS.CommonController.MainCanvas.transform,false);
end

util.hotfix_ex(CS.TargetTrainMultiSettingItem,'PreviewEnemy',PreviewEnemy)
