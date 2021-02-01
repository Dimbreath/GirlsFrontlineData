local util = require 'xlua.util'
local panelController = require("2060/DeploymentUIController")
xlua.private_accessible(CS.DeploymentFairySkillPanelController)

local UpdateAllFriendlyFloatingTeamInfo = function(self)
	self:UpdateAllFriendlyFloatingTeamInfo();
	for i=0,CS.DeploymentController.Instance.allyTeams.Count-1 do
		CS.DeploymentController.Instance.allyTeams[i]:RefeshBuffUI();
	end
end

local OnClickSwitchGlobalSkillAuto = function(self)
	self:OnClickSwitchGlobalSkillAuto();
	if self.currentFairy ~= nil then
		self.currentFairy.autoSkill = CS.ConfigData.autoFairySkill;
	end
end

local ShowSinglePanel = function(self)
	self:ShowSinglePanel();
	if Itemobj ~= nil and not Itemobj:isNull() then
		local rectTransform = Itemobj:GetComponent(typeof(CS.UnityEngine.RectTransform));
		rectTransform:DOAnchorPosX(-380,0.5):SetEase(CS.DG.Tweening.Ease.OutBack);
	end
end
local HideSinglePanel = function(self)
	self:HideSinglePanel();
	if Itemobj ~= nil and not Itemobj:isNull() then
		local rectTransform = Itemobj:GetComponent(typeof(CS.UnityEngine.RectTransform));
		rectTransform:DOAnchorPosX(-190,0.5):SetEase(CS.DG.Tweening.Ease.OutBack);
	end
end
local OnSelectTeam = function(self,team)
	self.currentSelectedTeam = team;
	local last = true;
	if self.currentFairy ~= nil then
		if CS.ConfigData.autoFairySkill then
			self.currentFairy.autoSkill = true;
		end
		print("begin"..self.currentFairy.teamId);
		last = self.currentFairy.autoSkill;
	end
	self:OnSelectTeam(team);
	if self.currentSelectedTeam ~= nil and self.currentFairy ~= nil then
		print(self.currentFairy.teamId);
		--print(last);
		self.currentFairy.autoSkill = last;
		self:RefreshPanel();
	end
end

local UpdateSinglePanelInfo = function(self)
	self:UpdateSinglePanelInfo();
	self.textSkillConsumption.rectTransform.sizeDelta = CS.UnityEngine.Vector2(30,30);
	self.textSkillConsumption.rectTransform.anchoredPosition = CS.UnityEngine.Vector2(35,0);
end
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'UpdateAllFriendlyFloatingTeamInfo',UpdateAllFriendlyFloatingTeamInfo)
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'OnClickSwitchGlobalSkillAuto',OnClickSwitchGlobalSkillAuto)
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'ShowSinglePanel',ShowSinglePanel)
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'HideSinglePanel',HideSinglePanel)
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'OnSelectTeam',OnSelectTeam)
util.hotfix_ex(CS.DeploymentFairySkillPanelController,'UpdateSinglePanelInfo',UpdateSinglePanelInfo)