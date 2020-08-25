local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
local RequestStartMissionHandle = function(self,www)
	local cache = CS.ConfigData.endTurnConfirmation;
	CS.ConfigData.endTurnConfirmation = false;
	self:RequestStartMissionHandle(www);
	CS.ConfigData.endTurnConfirmation = cache;
	cache = nil;
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		CS.DeploymentBackgroundController.Instance.listSpot[i]:CheckBuild();
	end
end

local AnalyzeGrowSpots = function(self)
	self:AnalyzeGrowSpots();
	for i=0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
		local spot = CS.DeploymentBackgroundController.Instance.listSpot[i];
		if spot.spotAction ~= nil and spot.currentTeam == null then
			if spot.spotAction.enemyInstanceId ~= 0 then
				local team = nil;
				for j=0,self.enemyTeams.Count-1 do
					if self.enemyTeams[j].enemyInstanceId == spot.spotAction.enemyInstanceId then
						team = self.enemyTeams[j];
					end
				end
				if team == nil and not self.growEnemySpot:Contains(spot) then
					self.growEnemySpot:Add(spot);
				end
			end
			if spot.spotAction.allyTeamInstanceIds.Count > 0 then
				for j=0,self.allyTeams.Count-1 do
					if self.allyTeams[j].allyTeamInstanceId == spot.spotAction.allyTeamInstanceIds[0] then
						team = self.allyTeams[j];
					end
				end
				if team == nil and not self.growEnemySpot:Contains(spot) then
					self.growEnemySpot:Add(spot);
				end					
			end
		end		
	end
end

local ClickSpot = function(self,spot)
	if not self.isDeplyment then
		if self.currentSelectedTeam ~= nil and not spot.Show and not self:CheckSpotConnect(spot) then
			CS.DeploymentController.TriggerSelectTeam(nil);
			return;
		end
	end	
	self:ClickSpot(spot);
end

local AnalysisDaySpot = function(self,data,currentBelong,isSurround)
	if data:ToJson() ~= "[]" then
		local iter = data.Keys:GetEnumerator();
		while iter:MoveNext() do
			local check = iter.Current;
			local spotid = tonumber(check);
			local belong = data:GetValue(check).Int;
			local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataById(spotid);
			print(spotid);
			if spot ~= nil then				
				if belong == 1 then
					spot.spotAction.belong = CS.Belong.friendly;
				elseif belong == 2 then
					spot.spotAction.belong = CS.Belong.enemy;
				elseif belong == 3 then
					spot.spotAction.belong = CS.Belong.neutral;
				elseif belong == 0 then
					spot.spotAction.belong = CS.Belong.other;
				elseif belong == 99 then
					spot.spotAction.belong = CS.Belong.hide;
				elseif belong == 100 then
					spot.spotAction.belong = CS.Belong.ingore;
				end				
			end
		end
	end
	self:AnalysisDaySpot(data,currentBelong,isSurround);
end

local PlayMoveRecord = function(self,record,play)
	if record.allyTeamInstanceId ~= 0 then
		local fromSpot = record.from.spot;
		fromSpot.spotAction.allyTeamInstanceIds:Remove(record.allyTeamInstanceId);
	elseif record.squadTeamInstanceId ~= 0 then
		local fromSpot = record.from.spot;
		fromSpot.spotAction.squadTeamInstanceIds:Remove(record.squadTeamInstanceId);		
	end
	self:PlayMoveRecord(record,play);
end

local GoBattle = function(self)
	self:GoBattle();
	CS.DeploymentController.TriggerSwitchAbovePanelEvent(true);
	CS.DeploymentPlanModeController.Instance.enabled = false;
end

local RequestWithDraw = function(self)
	if self.currentSelectedTeam ~= nil then
		for i=0,self.currentSelectedTeam.allListBuffAction.Count-1 do
			self.currentSelectedTeam.allListBuffAction[i]:Clear();
		end
	end
	self:RequestWithDraw();
end

util.hotfix_ex(CS.DeploymentController,'RequestStartMissionHandle',RequestStartMissionHandle)
util.hotfix_ex(CS.DeploymentController,'AnalyzeGrowSpots',AnalyzeGrowSpots)
util.hotfix_ex(CS.DeploymentController,'ClickSpot',ClickSpot)
util.hotfix_ex(CS.DeploymentController,'AnalysisDaySpot',AnalysisDaySpot)
util.hotfix_ex(CS.DeploymentController,'PlayMoveRecord',PlayMoveRecord)
util.hotfix_ex(CS.DeploymentController,'GoBattle',GoBattle)
util.hotfix_ex(CS.DeploymentController,'RequestWithDraw',RequestWithDraw)