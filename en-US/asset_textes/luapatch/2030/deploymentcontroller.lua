local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
local GetEnemySpotData = function(self,jsonData)
    self:GetEnemySpotData(jsonData);
    print('GetEnemySpotData')
    for i=0,CS.GameData.listSpotAction.Count-1 do
        local sa = CS.GameData.listSpotAction:GetDataByIndex(i)
        if sa.allyTeamInstanceIds.Count > 1 and sa.allyTeamInstanceIds[1] == sa.allyTeamInstanceIds[0] then
            sa.allyTeamInstanceIds:RemoveAt(0)
        end
    end
end
local RequestStartMissionHandle = function(self,www)
    self:RequestStartMissionHandle(www);
    local iter = self.listSpot:GetEnumerator()
    while iter:MoveNext() do
        iter.Current.spotAction.hostageGunId = iter.Current.spotInfo.hostageGunId
        iter.Current.spotAction.hostageHp = iter.Current.spotInfo.hostageMaxHp
        iter.Current.spotAction.hostageMaxHp = iter.Current.spotInfo.hostageMaxHp
        iter.Current.spotAction.isRandom = iter.Current.spotInfo.isRandom
    end
end

local DeductMreEvent = function(self,force)
	if CS.GameData.currentSelectedMissionInfo.missionType == CS.MissionType.simulation then
		return;
	end
	for i=0, self.playerTeams.Count-1 do
		if self.playerTeams[i].teamId > 0 then
			local guns = CS.GameData.dictTeam[self.playerTeams[i].teamId].listGun;
			for j=0,guns.Count-1 do
				guns[j].mre = guns[j].mre - 1;
				if guns[j].mre < 0 then
					guns[j].mre = 0;
				end
			end
			guns = nil;
		end
	end
	
	for i=0,self.squadTeams.Count-1 do
		if self.squadTeams[i].squadTeam.isPlayer then
			self.squadTeams[i].squadTeam.squadData.mre = self.squadTeams[i].squadTeam.squadData.mre - self.squadCommonStandbyMre;
			if self.squadTeams[i].squadTeam.squadData.mre < 0 then
				self.squadTeams[i].squadTeam.squadData.mre = 0;
			end
			self.squadTeams[i]:CheckBattleSkill();
		end
	end
end

local ClickSpot = function(self,spot)
	local ot = 0
	print('ClickSpot1')
	if self.currentSelectedTeam ~= nil and self.currentSelectedTeam.squadTeam ~= nil then
		ot = self.currentSelectedTeam.teamId
		self.currentSelectedTeam.teamId = 114514
	end
	self:ClickSpot(spot)
	print('ClickSpot2')
	if self.currentSelectedTeam ~= nil and self.currentSelectedTeam.teamId == 114514 then
		self.currentSelectedTeam.teamId = ot
	end
	ot = nil
end
local SelectTeam = function(self,team)
	if self.currentSelectedTeam ~= nil and self.currentSelectedTeam.squadTeam ~= nil  and self.currentSelectedTeam.teamId == 114514 then
		self.currentSelectedTeam.teamId = 0
	end
	self:SelectTeam(team)
end
util.hotfix_ex(CS.DeploymentController,'DeductMreEvent',DeductMreEvent)
util.hotfix_ex(CS.DeploymentController,'GetEnemySpotData',GetEnemySpotData)
util.hotfix_ex(CS.DeploymentController,'RequestStartMissionHandle',RequestStartMissionHandle)
util.hotfix_ex(CS.DeploymentController,'ClickSpot',ClickSpot)
util.hotfix_ex(CS.DeploymentController,'SelectTeam',SelectTeam)