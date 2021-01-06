local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentSquadInfoController)

local DeploymentSquadInfoController_Supply = function (self)
    if(CS.DeploymentTeamInfoController.Instance == nil) then
    	CS.DeploymentTeamInfoController.InstanceUse.gameObject:SetActive(false);
    end
    self:Supply();
end

local DeploymentSquadInfoController_Draw = function (self)
    if(CS.DeploymentTeamInfoController.Instance == nil) then
    	CS.DeploymentTeamInfoController.InstanceUse.gameObject:SetActive(false);
    end
	self:Draw();
end
util.hotfix_ex(CS.DeploymentSquadInfoController,'Supply',DeploymentSquadInfoController_Supply)
util.hotfix_ex(CS.DeploymentSquadInfoController,'Draw',DeploymentSquadInfoController_Draw)