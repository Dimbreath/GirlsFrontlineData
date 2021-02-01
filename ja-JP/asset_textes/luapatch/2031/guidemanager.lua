local util = require 'xlua.util'
xlua.private_accessible(CS.GuideManagerController)
xlua.private_accessible(CS.MissionSelectionIntroduceController)
xlua.private_accessible(CS.MissionSelectionController)
local GetTargetByName = function(self,name)
	self:GetTargetByName(name);
	if self.target ~= nil and CS.DeploymentController.Instance ~= nil then
		if self.target:GetComponent(typeof(CS.DeploymentSpotController)) ~= nil then
			self.goMask.transform.localPosition = CS.UnityEngine.Vector3(0,0,19500);
			self.goMask.transform.localScale = CS.UnityEngine.Vector3(10,10,1);
		else
			self.goMask.transform.localPosition = CS.UnityEngine.Vector3(0,0,0);
			self.goMask.transform.localScale = CS.UnityEngine.Vector3(1,1,1);
		end
	end
end
local MissionSelectionIntroduceController_InitUIElements = function(self)
	-- print('do nothing')
end
local MissionSelectionController_UpdateCampaignData = function(self,id)
	-- move to ResourceManager.LoadResourceLoader.LoadResourceAgent
end
local MissionSelectionController_InitMissionBarAsync = function(self,objects,userdata,duration)
	self:InitMissionBarAsync(objects,userdata,duration);
	objects[0].name = 'MissionBar(Clone)';
	if self.listMissionBar.Count == userdata[1] then
		if self.guideAction ~= nil then
			self.guideAction = nil;
			CS.CommonGuideController.Instance:InitGuide();
		end
	end
end
util.hotfix_ex(CS.GuideManagerController,'GetTargetByName',GetTargetByName)
--util.hotfix_ex(CS.MissionSelectionController,'UpdateCampaignData',MissionSelectionController_UpdateCampaignData)
util.hotfix_ex(CS.MissionSelectionController,'InitMissionBarAsync',MissionSelectionController_InitMissionBarAsync)
xlua.hotfix(CS.MissionSelectionIntroduceController,'InitUIElements',MissionSelectionIntroduceController_InitUIElements)