local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)

local CheckUseBattleSkill = function(self)
	if CS.DeploymentBackgroundController.Instance.listSpotPath.Count ~= 0 then
		self:CheckUseBattleSkill();
	end
end

local CheckDefender = function(self,playcameramove,time)
	if not self.gameObject.activeInHierarchy then
		self.lastactiveid = self.buildAction.activeOrder;
	end
	self:CheckDefender(playcameramove,time);
end

util.hotfix_ex(CS.DeploymentBuildingController,'CheckUseBattleSkill',CheckUseBattleSkill)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckDefender',CheckDefender)