local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentAllyTeamController)

local CheckUseBuildTip = function(self)
	self:CheckUseBuildTip();
	if self.buildTip ~= nil and not self.buildTip:isNull() then
		self.buildTip.gameObject:SetActive(self.currentSpot.visible);
	end
end

local CheckFriendTip = function(self)
	self:CheckFriendTip();
	if self.tip ~= nil and not self.tip:isNull() then
		self.tip.gameObject:SetActive(self.currentSpot.visible);
	end	
end

local CheckBattleSkill = function(self)
	if self.currentSpot.spotAction == nil then
		return;
	end
	if self.lastSpot ~= nil and self.lastSpot ~= self.currentSpot then		
		if self.allyTeam.currentBelong == CS.TeamBelong.friendly then
			if self.allyTeam.sangvisTeam ~= nil and self.allyTeam.sangvisTeam.friendSquadTeam ~= nil and self.allyTeam.sangvisTeam.friendSquadTeam.CanUseSupportSkill then
				local neweffectSpotaction = self.currentSpot.spotAction:GetRangeSpotInfo(self.allyTeam.sangvisTeam.friendSquadTeam.squadData.info.battleSkillRangeMax, self.allyTeam.sangvisTeam.friendSquadTeam.squadData.info.battleSkillRangeMin);
				--print("生效数目"..tostring(neweffectSpotaction.Count));
				--print("旧数目"..tostring(self.effectSpotAction.Count));
				for i=0,self.effectSpotAction.Count-1 do
					if not neweffectSpotaction:Contains(self.effectSpotAction[i]) then
						--print("移除"..tostring(i));
						self.effectSpotAction[i].battleSquadTeam:Remove(self.allyTeam.sangvisTeam.friendSquadTeam);
					end
				end
			end
		end
	end
	--print("qian"..tostring(self.currentSpot.spotAction.battleSquadTeam.Count));
	self:CheckBattleSkill();
	--print(tostring(self.currentSpot.spotAction.battleSquadTeam.Count));
end

local Complete = function(self)
	self:CheckBattleSkill();
	self:Complete();
end
util.hotfix_ex(CS.DeploymentAllyTeamController,'CheckUseBuildTip',CheckUseBuildTip)
util.hotfix_ex(CS.DeploymentAllyTeamController,'CheckFriendTip',CheckFriendTip)
util.hotfix_ex(CS.DeploymentAllyTeamController,'CheckBattleSkill',CheckBattleSkill)
util.hotfix_ex(CS.DeploymentAllyTeamController,'Complete',Complete)