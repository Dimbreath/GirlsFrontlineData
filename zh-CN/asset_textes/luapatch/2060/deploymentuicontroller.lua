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

local SwitchAbovePanel = function(self,show)
	self:SwitchAbovePanel(show);
	self.goAbove.transform:SetAsLastSibling();
end

local NoShowMiddleLine = function(self)
	for i=0,self.currentline.Count-1 do
		self.currentline[i]:CloseLine();
		self.useline:Enqueue(self.currentline[i]);
	end
	for i=0,self.spots.Count-1 do
		if self.spots[i].buildAction ~= nil and not self.spots[i].buildAction.buildControl:IsNull() then
			self.spots[i].buildingAction.buildController:EndTweenKle();
		end
	end
	self.currentline:Clear();
	self.spots:Clear();
end

local OnClickButton = function(self,Button)
	local cache = CS.ConfigData.endTurnConfirmation;
	if CS.GameData.currentSelectedMissionInfo.useDemoMission then
		CS.ConfigData.endTurnConfirmation = false;
	end
	self:OnClickButton(Button);
	if CS.GameData.currentSelectedMissionInfo.useDemoMission then
		CS.ConfigData.endTurnConfirmation = cache;
	end	
end

local OnClickEndTurn = function(self)
	self:SwitchAbovePanel(true);
	self:OnClickEndTurn();
end

util.hotfix_ex(CS.DeploymentUIController,'CheckLayer',CheckLayer)
util.hotfix_ex(CS.DeploymentUIController,'RefreshUI',RefreshUI)
util.hotfix_ex(CS.DeploymentUIController,'SwitchAbovePanel',SwitchAbovePanel)
util.hotfix_ex(CS.DeploymentUIController,'NoShowMiddleLine',NoShowMiddleLine)
util.hotfix_ex(CS.DeploymentUIController,'OnClickButton',OnClickButton)
util.hotfix_ex(CS.DeploymentUIController,'OnClickEndTurn',OnClickEndTurn)