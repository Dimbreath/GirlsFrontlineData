local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentTeamInfoController)

local ShowTeamPanel = function(self,play)
	self:ShowTeamPanel(play);
	self.transform:Find("TeamPanel/Right"):GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = true;
end

local MoveLeft = function(self)
	self:MoveLeft();
	self.transform:Find("TeamPanel/Right"):GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = false;
end

local RefreshSelfTeamCanDeploy = function(self)
	self:RefreshSelfTeamCanDeploy();
	self:UpdatePoint(CS.DeploymentTeamInfoController.currentSelectedTeamId);
end

local RequestReinforceHandle = function(self,data)
	self:RequestReinforceHandle(data);
	if CS.DeploymentTeamInfoController.currentSelectedTeamId > 0 then
		local team = CS.GameData.dictTeam[CS.DeploymentTeamInfoController.currentSelectedTeamId];
		for i=0,team.listGun.Count-1 do
			team.listGun[i]:UpdateStatus();
		end
		if CS.GameData.dictTeamFairy:ContainsKey(CS.DeploymentTeamInfoController.currentSelectedTeamId) and CS.GameData.dictTeamFairy[CS.DeploymentTeamInfoController.currentSelectedTeamId] ~= nil then
			CS.GameData.dictTeamFairy[CS.DeploymentTeamInfoController.currentSelectedTeamId].autoSkill = CS.ConfigData.autoFairySkill;
		end
	end
end

local OnClickButton = function(self,button)
	self:OnClickButton(button);
	if button == "Deploy" then
		if CS.DeploymentController.isDeplyment and CS.DeploymentTeamInfoController.currentSelectedTeamId >0 then
			if CS.GameData.dictTeamFairy:ContainsKey(CS.DeploymentTeamInfoController.currentSelectedTeamId) and CS.GameData.dictTeamFairy[CS.DeploymentTeamInfoController.currentSelectedTeamId] ~= nil then
				CS.GameData.dictTeamFairy[CS.DeploymentTeamInfoController.currentSelectedTeamId].autoSkill = CS.ConfigData.autoFairySkill;
			end
		end
	end
end
util.hotfix_ex(CS.DeploymentTeamInfoController,'OnClickButton',OnClickButton)
util.hotfix_ex(CS.DeploymentTeamInfoController,'ShowTeamPanel',ShowTeamPanel)
util.hotfix_ex(CS.DeploymentTeamInfoController,'MoveLeft',MoveLeft)
util.hotfix_ex(CS.DeploymentTeamInfoController,'RefreshSelfTeamCanDeploy',RefreshSelfTeamCanDeploy)
util.hotfix_ex(CS.DeploymentTeamInfoController,'RequestReinforceHandle',RequestReinforceHandle)