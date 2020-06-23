local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBuildingController)


local DeploymentBuildingController_CheckControlUI = function(self,teamcontroller)
	local detail = self:CheckControlUI(teamcontroller);	
	local i = 0;
	while i < detail.Count do
		local skill = detail[i];
		local spots = CS.GameData.listSpotAction:GetList();
		if skill.skill.startRange < 7 then
		   spots = teamcontroller.currentSpot.spotAction:GetRangeSpotInfo(skill.skill.startRange);
		end
		local j = 0;
		while j < skill.targetSpotAction.Count do
			local spot = skill.targetSpotAction[j];
			local exit = true;
			local currentType = 0;
			if spot.currentSpotType == CS.SpotType.headQuarter then
				currentType = 1;
			elseif spot.currentSpotType == CS.SpotType.CA then
				currentType = 2;
			elseif spot.currentSpotType == CS.SpotType.DTA then
				currentType = 3;
			elseif spot.currentSpotType == CS.SpotType.Radar then
				currentType = 4;
			elseif spot.currentSpotType == CS.SpotType.TimeDTA then
				currentType = -3;							
			elseif spot.currentSpotType == CS.SpotType.LimitedSupply then
				currentType = 5;
			elseif spot.currentSpotType == CS.SpotType.RallyPoint then
				currentType = 6;
			elseif spot.currentSpotType == CS.SpotType.HeavyDTA then
				currentType = 7;
			elseif spot.currentSpotType == CS.SpotType.TimeHeavyDTA then
				currentType = -7;
			end			
			if not skill.skill.spotTypeCondition:Contains(-1) and not skill.skill.spotTypeCondition:Contains(currentType) then
					--print(spot.spotInfo.id.."/"..tostring(spot.currentSpotType).."SpotTypeUnpass")
					exit = false;
				elseif not skill.skill.spotBelongCondition:Contains(-1) and not skill.skill.spotBelongCondition:Contains(spot.skillBelong) then
					--print(spot.spotInfo.id.."/"..tostring(spot.skillBelong).."BelongUnpass")
					exit = false;
				elseif not skill.skill.spotTeamsCondition:Contains(-1) and not skill.skill.spotTeamsCondition:Contains(spot.echelon) then
					--print(spot.spotInfo.id.."/"..tostring(spot.echelon).."teamUnpass")	
					exit = false;
				elseif not 	spots:Contains(spot) then
					exit = false;	
			end
			if not exit then
				skill.targetSpotAction:Remove(spot);
			else
				j = j + 1;		
			end	
		end
		--print(i.."all"..detail.Count)
		if skill.targetSpotAction.Count == 0 then
			print(skill.skill.id.."MissionSkillIdUnpass")
			detail:Remove(skill);
		else
			i = i + 1;
		end
	end
	return detail
end

local DeploymentBuildingController_InitCode = function(self,code)
	self:InitCode(code);
	if self.spineHolder ~= nil and self.spineHolder.name == "Birdge_Down" then
		self.spineHolder:GetComponent(typeof(CS.Board)).enabled = false;
	end
end

local DeploymentBuildingController_CheckUseBattleSkill = function(self)
	self:CheckUseBattleSkill();
	if self.effectSpotAction ~= nil then
		for  i = 0, self.effectSpotAction.Count-1 do
			local spotAction = self.effectSpotAction[i];
			if spotAction.spot.currentTeamTemp ~= nil then
				spotAction.spot.currentTeamTemp:CheckSpecialSpotLine();
			end
		end
	end
end

util.hotfix_ex(CS.DeploymentBuildingController,'CheckControlUI',DeploymentBuildingController_CheckControlUI)
util.hotfix_ex(CS.DeploymentBuildingController,'InitCode',DeploymentBuildingController_InitCode)
util.hotfix_ex(CS.DeploymentBuildingController,'CheckUseBattleSkill',DeploymentBuildingController_CheckUseBattleSkill)
