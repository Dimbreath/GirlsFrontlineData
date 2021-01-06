local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildSkillItem)

local CheckLayer = function()
	print("final");
	if CS.DeploymentController.Instance.currentSelectedTeam ~= nil and CS.DeploymentController.Instance.currentSelectedTeam:CurrentTeamBelong() ~= CS.TeamBelong.friendly then
		CS.DeploymentController.TriggerSelectTeam(nil);
	end
	CS.DeploymentUIController.Instance:CheckLayer();
	CS.DeploymentController.Instance:AddAndPlayPerformance(nil);
	CS.DeploymentController.TriggerRefreshUIEvent();
end

local RequestControlBuild = function(self,data)
	if self.canCastSkill then
		local iter = self.missionskillinfo.itemCose:GetEnumerator();
		if iter:MoveNext() then
			local item = iter.Current.Key;
			local num = iter.Current.Value;
			local totalnum = CS.GameData.GetItem(item);
			local resum = totalnum - num; 
			print("当前消耗道具"..item.."数目"..num.."剩余"..resum);
			CS.GameData.SetItem(item,resum);
		end
	end
	local layer = CS.DeploymentBackgroundController.currentlayer;
	for i = 0,CS.DeploymentBackgroundController.layers.Count-1 do
		if CS.DeploymentBackgroundController.layers[i] ~= layer then
			CS.DeploymentBackgroundController.currentlayer = CS.DeploymentBackgroundController.layers[i];
			CS.DeploymentController.Instance:PlaySpotTransChange();
			CS.DeploymentController.Instance:PlayChangAllyTeam();
			CS.DeploymentController.Instance:PlayCameraBuildChange();
		end
	end
	CS.DeploymentBackgroundController.currentlayer = layer;
	self:RequestControlBuild(data);
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckLayer);
end

local RequestBuffControlBuild = function(self,data)
	if self.canCastSkill then
		local iter = self.missionskillinfo.itemCose:GetEnumerator();
		if iter:MoveNext() then
			local item = iter.Current.Key;
			local num = iter.Current.Value;
			local totalnum = CS.GameData.GetItem(item);
			local resum = totalnum - num; 
			print("当前消耗道具"..item.."数目"..num.."剩余"..resum);
			CS.GameData.SetItem(item,resum);
		end
	end
	local layer = CS.DeploymentBackgroundController.currentlayer;
	for i = 0,CS.DeploymentBackgroundController.layers.Count-1 do
		if CS.DeploymentBackgroundController.layers[i] ~= layer then
			CS.DeploymentBackgroundController.currentlayer = CS.DeploymentBackgroundController.layers[i];
			CS.DeploymentController.Instance:PlaySpotTransChange();
			CS.DeploymentController.Instance:PlayChangAllyTeam();
			CS.DeploymentController.Instance:PlayCameraBuildChange();
		end
	end
	CS.DeploymentBackgroundController.currentlayer = layer;
	self:RequestBuffControlBuild(data);	
	CS.DeploymentController.Instance:AddAndPlayPerformance(CheckLayer);
end

util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestControlBuild',RequestControlBuild)
util.hotfix_ex(CS.DeploymentBuildSkillItem,'RequestBuffControlBuild',RequestBuffControlBuild)
