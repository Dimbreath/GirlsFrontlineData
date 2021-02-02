local util = require 'xlua.util'

local RequestBuildControlSuccess = function(self, www)
    self:SuccessHandleData(www);
	if self.jsonData:Contains("type5_score") then
		CS.GameData.missionAction.endlessScore = self.jsonData:GetValue("type5_score").Int;
	end
	CS.DeploymentUIController.Instance:RefreshUI();
end

local RequestBuffSkillControlSuccess = function(self, www)
	self:SuccessHandleData(www);
	if self.jsonData:Contains("type5_score") then
		CS.GameData.missionAction.endlessScore = self.jsonData:GetValue("type5_score").Int;
	end
	CS.DeploymentUIController.Instance:RefreshUI();
end

local RequestSangvisGunSkillStartSuccess = function(self, www)
	self.jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
	CS.GameData.missionAction:LoadSkillData(self.jsonData);
	CS.GameData.missionAction:LoadTeleportData(self.jsonData);
	CS.GameData.missionAction:AnalysicsSpotTransInfo(self.jsonData);
	CS.DeploymentController.Instance:AnalysisNightEnemy(self.jsonData, false);
	CS.GameData.missionAction:LoadDieEnemy(self.jsonData);
	if self.jsonData:Contains("building_info") then
		CS.GameData.missionAction:ReadBuildingAction(self.jsonData:GetValue("building_info"),false);
	end
	CS.GameData.missionAction.ap = self.jsonData:GetValue("ap").Int;
end
util.hotfix_ex(CS.RequestBuildControl,'SuccessHandleData',RequestBuildControlSuccess)
util.hotfix_ex(CS.RequestBuffSkillControl,'SuccessHandleData',RequestBuffSkillControlSuccess)
util.hotfix_ex(CS.RequestSangvisGunSkillStart,'SuccessHandleData',RequestSangvisGunSkillStartSuccess)