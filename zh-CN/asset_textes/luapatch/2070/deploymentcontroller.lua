local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local CheckBuild = function()
	for i=0,CS.GameData.missionAction.listBuildingAction:GetList().Count-1 do
		local buildaction = CS.GameData.missionAction.listBuildingAction:GetDataByIndex(i);
		if buildaction.buildController ~= nil and not buildaction.buildController:isNull() then
			buildaction.buildController:RefreshController(false);
		end
	end
	CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
end

local RequestMoveTeamHandle = function(self,www)
	self:RequestMoveTeamHandle(www);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckBuild);
end

local HasTeamCanUse = function(self,spot)
	if spot.type == CS.SpotType.HeavyDTA then
		for i=0,CS.GameData.listSquad.Count-1 do
			local squad = CS.GameData.listSquad:GetDataByIndex(i);
			if squad.info.infoType == CS.SquadInfoCategory.fireTeam and squad.rank>0 then
				if self.squadTeams:Find(function(t)
						return t.squadTeam.squadData == squad;
					end) == nil then
					return true;
				end
			end
		end
	end
	return  self:HasTeamCanUse(spot);
end
util.hotfix_ex(CS.DeploymentController,'RequestMoveTeamHandle',RequestMoveTeamHandle)
util.hotfix_ex(CS.DeploymentController,'HasTeamCanUse',HasTeamCanUse)


