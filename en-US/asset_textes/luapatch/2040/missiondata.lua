local util = require 'xlua.util'
xlua.private_accessible(CS.MissionAction)
xlua.private_accessible(CS.HurtAction)
xlua.private_accessible(CS.MissionData)

local MissionAction_AnarysicsHurtData = function(self,jsonData)
	self.friendTeamData:Clear();
	self.enemyTeamData:Clear();
	self.allyTeamData:Clear();
	self.squadTeamData:Clear();
	for m=0,jsonData.Count - 1 do
		local friendTeamId = jsonData[m]:GetValue("team_id").Int;
		local enemyInstanceId = jsonData[m]:GetValue("enemy_instance_id").Int;
		local allyInstanceId = jsonData[m]:GetValue("ally_instance_id").Int;
		local squadInstanceId = jsonData[m]:GetValue("squad_instance_id").Int;
		if (friendTeamId ~= 0 and not self.friendTeamData:ContainsKey(friendTeamId)) then
            self.friendTeamData:Add(friendTeamId, jsonData[m]);
        elseif (enemyInstanceId ~= 0 and not self.enemyTeamData:ContainsKey(enemyInstanceId)) then
            self.enemyTeamData:Add(enemyInstanceId, jsonData[m]);
         elseif (allyInstanceId ~= 0 and not self.allyTeamData:ContainsKey(allyInstanceId)) then
            self.allyTeamData:Add(allyInstanceId, jsonData[m]);
        elseif (squadInstanceId ~= 0 and not self.squadTeamData:ContainsKey(squadInstanceId)) then
            self.squadTeamData:Add(squadInstanceId, jsonData[m]);
        else       
            local hurtaction = CS.HurtAction(jsonData[m]);      	
    	end
	end
end

local MissionData_CheckTargetCondition = function(targetid,teamcontroller,spotaction)
	local spots = CS.MissionData.CheckTargetCondition(targetid,teamcontroller,spotaction);
	local targetuseid = tonumber(targetid);
	local conditioninfo = CS.GameData.listTriggerIndexCfg:GetDataById(targetuseid);
	if conditioninfo ~= nil and conditioninfo.type == 4 then
		for  i =0,CS.DeploymentController.Instance.allyTeams.Count -1 do           
            if CS.MissionData.CheckBuffAction(CS.DeploymentController.Instance.allyTeams[i], conditioninfo) then
                spots:Add(CS.DeploymentController.Instance.allyTeams[i].currentSpot.spotAction.spotInfo.id);
            end
        end    
	end
	CS.MissionData.id_spotids[targetuseid] = spots;
	return spots;
end

local MissionAction_CanUseActiveMissionSkill = function(self)
	if self.currentSpotAction == nil then
		self.activeOrder = self.buildingInfo.initial_state;
		return false;
	end
	if self.currentDefender <= 0 then
		self.activeOrder = -1;
		return false;
	end
	if self.buildingInfo.working_special_spot == nil or self.buildingInfo.working_special_spot =='' then
		self.activeOrder = 0;
		return true;
	end
	return self:checkSpecialSpotOr(self.buildingInfo.working_special_spot);	
end
util.hotfix_ex(CS.BuildingAction,'get_CanUseActiveMissionSkill',MissionAction_CanUseActiveMissionSkill)
util.hotfix_ex(CS.MissionAction,'AnarysicsHurtData',MissionAction_AnarysicsHurtData)
util.hotfix_ex(CS.MissionData,'CheckTargetCondition',MissionData_CheckTargetCondition)