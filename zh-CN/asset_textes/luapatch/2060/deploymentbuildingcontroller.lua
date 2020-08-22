local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)

local CheckUseBattleSkill = function(self)
	if CS.DeploymentBackgroundController.Instance.listSpotPath.Count ~= 0 then
		self:CheckUseBattleSkill();
	end
end

util.hotfix_ex(CS.DeploymentBuildingController,'CheckUseBattleSkill',CheckUseBattleSkill)