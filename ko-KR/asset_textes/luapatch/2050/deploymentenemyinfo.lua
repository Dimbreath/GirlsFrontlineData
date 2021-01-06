local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyInfo)

local DeploymentEnemyInfo_ShowRightBuild = function(self,buildAction)
	self:ShowRightBuild(buildAction);
	self.imageHead.sprite = self.transform:Find("Top/Building/Info/Image"):GetComponent(typeof(CS.ExImage)).sprite;
	local txt = self.transform:Find("Top/Building/Info/Text/Trait/Text_SquadName"):GetComponent(typeof(CS.ExText)).text;
	self.transformBuildInfo:Find("Name"):GetComponent(typeof(CS.ExText)).text = txt;
end

local DeploymentEnemyInfo_ShowBuild = function(self)
	if self.currentSpot == nil then
		return;
	end
	if self.currentSpot.buildAction ~= nil then
		self:ShowRightBuild(self.currentSpot.buildAction);
	end
end
local DeploymentEnemyInfo_Show = function(self,...)
	self:Show(...);
	local iter = self.currentTeamInfo:GetEnumerator();
	while iter:MoveNext() do
		iter.Current.Value.icon = iter.Current.Value.gun.Name;
		iter.Current.Value.name = iter.Current.Value.gun.Name;
	end
	iter = nil;
end
local DeploymentEnemyInfo_ShowEnemyAISpot = function(self,enemyTeamInfo)
	if enemyTeamInfo.ai == 101 then
		if self.currentSpot.spotAction ~= nil then
			CS.DeploymentController.Instance:ShowPatrolInfo(self.currentSpot.spotAction.enemyaiInfo);
		else
			CS.DeploymentController.Instance:ShowPatrolInfo(enemyTeamInfo.ai_content);
		end	
	elseif enemyTeamInfo.ai == 102 then
		if self.currentSpot.spotAction ~= nil then
			CS.DeploymentController.Instance:ShowGuardInfo(self.currentSpot.spotAction.enemyaiInfo);
		else
			CS.DeploymentController.Instance:ShowGuardInfo(enemyTeamInfo.ai_content);
		end		
	end
end
util.hotfix_ex(CS.DeploymentEnemyInfo,'ShowRightBuild',DeploymentEnemyInfo_ShowRightBuild)
util.hotfix_ex(CS.DeploymentEnemyInfo,'ShowBuild',DeploymentEnemyInfo_ShowBuild)
util.hotfix_ex(CS.DeploymentEnemyInfo,'Show',DeploymentEnemyInfo_Show)
util.hotfix_ex(CS.DeploymentEnemyInfo,'ShowEnemyAISpot',DeploymentEnemyInfo_ShowEnemyAISpot)
