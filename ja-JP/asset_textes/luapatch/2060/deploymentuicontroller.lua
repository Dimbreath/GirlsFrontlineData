local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)
local CheckLayer = function(self)
	if CS.DeploymentController.isDeplyment then
		for i = 0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
			local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
			spot.spotAction = CS.SpotAction();
			spot.spotAction.belong = spot.spotInfo.belong;
		end
		self:CheckLayer();
		for i = 0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
			local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
			spot.spotAction = nil;
		end
	else
		self:CheckLayer();
	end
end

local RefreshUI = function(self)
	self:RefreshUI();
	if CS.GameData.missionAction ~= nil and CS.GameData.currentSelectedMissionInfo.specialType == CS.MapSpecialType.Normal then
		local count = 0;
		for i=0,CS.GameData.listSpotAction.Count-1 do
			local spotAction = CS.GameData.listSpotAction[i];
			if not spotAction.spot.Ignore then
				if spotAction.spot.currentTeam ~= nil and spotAction.spot.currentTeam:CurrentTeamBelong() ~= CS.TeamBelong.friendly then
					count = count + 1;
				end
			end			
		end
		self.textRestEnemyCount.text = count;
	end
end

util.hotfix_ex(CS.DeploymentUIController,'CheckLayer',CheckLayer)
util.hotfix_ex(CS.DeploymentUIController,'RefreshUI',RefreshUI)