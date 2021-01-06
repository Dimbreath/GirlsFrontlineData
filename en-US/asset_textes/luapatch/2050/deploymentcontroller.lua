local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
xlua.private_accessible(CS.DeploymentTeamController)

local DeploymentController_GoBattle = function(self)
	local spotaction = CS.GameData.engagedSpot;
	if spotaction ~= nil then
		if spotaction.spot.currentTeam ~= nil then
			for i = 0,spotaction.spot.currentTeam.currentListBuffAction.Count-1 do
				local num = spotaction.spot.currentTeam.currentListBuffAction[i].battleFinishNum;
				spotaction.spot.currentTeam.currentListBuffAction[i].battleFinishNum = num + 1;
			end
		end
		if spotaction.spot.currentTeamTemp ~= nil then
			for i = 0,spotaction.spot.currentTeamTemp.currentListBuffAction.Count-1 do
				local num = spotaction.spot.currentTeamTemp.currentListBuffAction[i].battleFinishNum;
				spotaction.spot.currentTeamTemp.currentListBuffAction[i].battleFinishNum = num + 1;
			end
		end
	end	
	self:GoBattle();
end

local DeploymentController_RequestStartMissionHandle = function(self,www)
	self:RequestStartMissionHandle(www);
	local hasteam = false;
	for i = 0,self.playerTeams.Count-1 do
		if self.playerTeams[i].teamId >0 then
			hasteam = true;
		end
	end
	if not hasteam and self.sangvisTeams.Count>0 then
		local gun = CS.GameData.dictTeam[self.sangvisTeams[0].teamId]:GetLeader();
		--print(gun:GetVoiceCode())
		CS.CommonAudioController.PlayCharacterVoice(gun:GetVoiceCode(), CS.VoiceType._GOATTACK_);
	end
end

local DeploymentController_InitField = function(self)
	self:InitField();
	for i = 0,self.squadTeams.Count-1 do
		self.squadTeams[i]:CheckBattleSkill();
	end
	for i = 0,self.allyTeams.Count-1 do
		self.allyTeams[i]:CheckBattleSkill();
	end
	for i = 0,self.sangvisTeams.Count-1 do
		self.sangvisTeams[i]:CheckBattleSkill();
	end
	for i = 0,CS.DeploymentBackgroundController.Instance.listBuildingController.Count-1 do
		CS.DeploymentBackgroundController.Instance.listBuildingController[i]:RefreshController();
	end
	self.firestCheck = false;
end

--local DeploymentController_RequestStartEnemyTurn = function(self)
--	self.firestCheck = false;
--	self:RequestStartEnemyTurn();
--end
local DeploymentController_TriggerAVGFinishEvent = function()
	CS.DeploymentController.TriggerSelectTeam(nil);
	CS.DeploymentController.TriggerAVGFinishEvent();
end

local DeploymentController_FinishBattle = function(self)
	self:FinishBattle();
	if self.showSpotAction.spot.currentTeamTemp ~= nil and self.showSpotAction.spot.currentTeamTemp == self.showSpotAction.spot.currentTeam then
		self.showSpotAction.spot.currentTeamTemp = nil;
	end
end

util.hotfix_ex(CS.DeploymentController,'TriggerAVGFinishEvent',DeploymentController_TriggerAVGFinishEvent)
util.hotfix_ex(CS.DeploymentController,'GoBattle',DeploymentController_GoBattle)
util.hotfix_ex(CS.DeploymentController,'RequestStartMissionHandle',DeploymentController_RequestStartMissionHandle)
util.hotfix_ex(CS.DeploymentController,'InitField',DeploymentController_InitField)
util.hotfix_ex(CS.DeploymentController,'FinishBattle',DeploymentController_FinishBattle)
--util.hotfix_ex(CS.DeploymentController,'RequestWithDrawHandle',DeploymentController_RequestWithDrawHandle)
--util.hotfix_ex(CS.DeploymentController,'RequestStartEnemyTurn',DeploymentController_RequestStartEnemyTurn)
