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
util.hotfix_ex(CS.RequestBuildControl,'SuccessHandleData',RequestBuildControlSuccess)
util.hotfix_ex(CS.RequestBuffSkillControl,'SuccessHandleData',RequestBuffSkillControlSuccess)