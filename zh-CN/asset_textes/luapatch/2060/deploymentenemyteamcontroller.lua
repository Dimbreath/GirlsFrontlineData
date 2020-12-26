local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentEnemyTeamController)

local CheckUseBuildTip = function(self)
	self:CheckUseBuildTip();
	if self.buildTip ~= nil and not self.buildTip:isNull() then
		self.buildTip.gameObject:SetActive(self.currentSpot.visible);
	end
end

local CheckFriendTip = function(self)
	self:CheckFriendTip();
	if self.yudiTip ~= nil and not self.yudiTip:isNull()  then
		self.yudiTip.gameObject:SetActive(self.currentSpot.visible);
	end	
end

local CheckSpecialCodePos = function(self)
	
end

local CloseWinTarget = function(self,missionwintypeid)
	if self.winTypeid_targetObj:ContainsKey(missionwintypeid) then
		if self.winTypeid_targetObj[missionwintypeid] ~= nil and self.winTypeid_targetObj[missionwintypeid]:isNull() then
			CS.UnityEngine.Object.Destroy(self.winTypeid_targetObj[missionwintypeid]);
		end
		self.winTypeid_targetObj:Remove(missionwintypeid);
	end
	self:CloseWinTarget(missionwintypeid);
end

local ShowWinTarget = function(self,missionwintypeid,medal)
	self:ShowWinTarget(missionwintypeid,medal);
	local data = self.winTypeid_targetObj:GetEnumerator();
	while data:MoveNext() do		
		local teamData = data.Current.Value;
		if self.currentSpot.CannotSee then
			teamData:SetActive(false);
		else
			teamData:SetActive(true);
		end
	end
end
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckUseBuildTip',CheckUseBuildTip)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckFriendTip',CheckFriendTip)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CheckSpecialCodePos',CheckSpecialCodePos)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'CloseWinTarget',CloseWinTarget)
util.hotfix_ex(CS.DeploymentEnemyTeamController,'ShowWinTarget',ShowWinTarget)