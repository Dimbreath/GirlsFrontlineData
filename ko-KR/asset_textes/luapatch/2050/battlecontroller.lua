local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.BattleController)
local IsTheaterBattlePerform = function(self)
	if CS.GameData.mTheaterExerciseAction == nil or CS.GameData.mTheaterExerciseAction.engagedSpot == nil  then
		return false
	else
		return self:IsTheaterBattlePerform()
	end
end
local BeforeBattle = function(self)
	self:BeforeBattle()
	if self.currentSpotAction ~= nil then
		if self.currentSpotAction.friendlyTeamId == 0 and self.currentSpotAction.sangvisTeamId ~= 0 then
			self.currentSpotAction.friendlyTeamId = self.currentSpotAction.sangvisTeamId
		end
	end
	if CS.GF.Battle.BattleController.isSangvisDuplicate then
		self.randomSeed = math.random(65536);
	end
end
local RequestBattleFinish = function(self,forceLose)
	if self.currentSpotAction ~= nil then
		local check = 0;
		for i = 0, self.currentSpotAction.battleSquadTeam.Count-1 do 
			local squadTeam = self.currentSpotAction.battleSquadTeam[i];
			if squadTeam.sangvisTeam ~= nil then
				if check > 0 then
					squadTeam.sangvisTeam.AssistUICanUse = false;
				end
				check = check + 1;
				squadTeam.allFreeBuffAmmoMre = true;
				squadTeam.sangvisTeam.ammo = squadTeam.sangvisTeam.ammo-CS.DeploymentController.sangvisCommonSupportAmmo;
				squadTeam.sangvisTeam.ammo = CS.Mathf.Max(0,squadTeam.sangvisTeam.ammo);
				squadTeam.sangvisTeam.mre = squadTeam.sangvisTeam.mre-CS.DeploymentController.sangvisCommonSupportMre;
				squadTeam.sangvisTeam.mre = CS.Mathf.Max(0,squadTeam.sangvisTeam.mre);
			end
		end
	end
	if self.currentSpotAction ~= nil and self.currentSpotAction.sangvisTeamId ~= 0 then
		self.currentSpotAction.friendlyTeamId = 0
	end
	self:RequestBattleFinish(forceLose)
	if self.currentSpotAction ~= nil then
		for i = 0, self.currentSpotAction.battleSquadTeam.Count-1 do 
			local squadTeam = self.currentSpotAction.battleSquadTeam[i];
			if squadTeam.sangvisTeam ~= nil then
				squadTeam.sangvisTeam.AssistUICanUse = true;
			end
		end
	end
end

local RequestBattleFinishHandle = function(self,www)
	self:RequestBattleFinishHandle(www);	
	if CS.GameData.missionAction ~= nil then
		local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
		CS.GameData.missionAction:LoadSkillData(jsonData);
	end
end
local RequestSangvisBattleFinishHandle = function(self,www)
	self:RequestSangvisBattleFinishHandle(www);	
	if CS.GameData.missionAction ~= nil then
		local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
		CS.GameData.missionAction:LoadSkillData(jsonData);
	end
end
local CheckInBattleImageGuide = function(self)
	if CS.CommonGuideController.instance == nil or not self.isSangvisBattle or CS.CommonGuideController.instance:CheckGuide(CS.GuideType.isFirstSangvisBattle) then
		return util.cs_generator(function() end)
	end	
	return util.cs_generator(function()
		while CS.BattleFrameManager.Instance:GetCurFrame() < 15 do
			coroutine.yield(0)
		end
		if CS.CommonGuideController.instance ~= nil then 
			if self.isSangvisBattle and not CS.CommonGuideController.instance:CheckGuide(CS.GuideType.isFirstSangvisBattle) then
					CS.CommonGuideController.TriggerCheckGuideEvent(CS.GuideType.isFirstSangvisBattle)
					self.gameObject:SetActive(false)
			end
		end
	end)
end
util.hotfix_ex(CS.GF.Battle.BattleController,'BeforeBattle',BeforeBattle)
util.hotfix_ex(CS.GF.Battle.BattleController,'RequestBattleFinish',RequestBattleFinish)
util.hotfix_ex(CS.GF.Battle.BattleController,'RequestBattleFinishHandle',RequestBattleFinishHandle)
util.hotfix_ex(CS.GF.Battle.BattleController,'RequestSangvisBattleFinishHandle',RequestSangvisBattleFinishHandle)
util.hotfix_ex(CS.GF.Battle.BattleController,'IsTheaterBattlePerform',IsTheaterBattlePerform)
xlua.hotfix(CS.GF.Battle.BattleController,'CheckInBattleImageGuide',CheckInBattleImageGuide)