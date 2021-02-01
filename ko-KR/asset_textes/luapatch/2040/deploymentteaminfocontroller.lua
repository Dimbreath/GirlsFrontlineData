local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local DeploymentTeamInfoController_SquadSupplyHandle = function(data)
	local squadTeam = CS.GameData.missionAction.listSquadTeams:GetDataById(data.squadInstanceId);
	if squadTeam.squadTeamController.currentSpot.spotAction~=nil and squadTeam.squadTeamController.currentSpot.spotAction.currentSpotType == CS.SpotType.LimitedSupply then
		if CS.GameData.missionAction.spotid_ChangeType:ContainsKey(squadTeam.squadTeamController.currentSpot.spotAction.spotInfo.id) then
				local count = CS.GameData.missionAction.spotid_ChangeType[squadTeam.squadTeamController.currentSpot.spotAction.spotInfo.id].useCount;
                CS.GameData.missionAction.spotid_ChangeType[squadTeam.squadTeamController.currentSpot.spotAction.spotInfo.id].useCount = count +1;
            else
            	local count = squadTeam.squadTeamController.currentSpot.spotAction.hasSupplyTime;
                squadTeam.squadTeamController.currentSpot.spotAction.hasSupplyTime = count + 1;
         end
	end
	CS.DeploymentTeamInfoController.SquadSupplyHandle(data);
end


util.hotfix_ex(CS.DeploymentTeamInfoController,'SquadSupplyHandle',DeploymentTeamInfoController_SquadSupplyHandle)