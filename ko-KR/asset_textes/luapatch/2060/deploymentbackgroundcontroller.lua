local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentBackgroundController)
xlua.private_accessible(CS.DeploymentSpotController)
local RequestMissionCombinationHandle = function(self,data)
	self:RequestMissionCombinationHandle(data);
	if CS.DeploymentController.isDeplyment then
		for i=0,self.listSpot.Count-1 do
			local spot = self.listSpot:GetDataByIndex(i);
			if not spot.packageIgnore then
				if spot.currentTeam ~= nil and spot.currentTeam.gameObject == nil then
					spot.currentTeam = nil;
				end
				--if spot.spotInfo.enemyTeamInfoID ~= 0 then
				--	if spot.currentTeam == nil then
				--		CS.DeploymentController.Instance:CreateTeam(spot,spot.spotInfo.enemyTeamInfoID,CS.DeploymentController.TeamType.enemyTeam);
				--	end
				--elseif spot.spotInfo.allyTeamId ~= 0 then
				--	if spot.currentTeam == nil then
				--		CS.DeploymentController.Instance:CreateTeam(spot,0,CS.DeploymentController.TeamType.allyTeam);
				--	end			
				--end
			end
		end
	end
	for i=0,self.listSpot.Count-1 do
		local spot = self.listSpot:GetDataByIndex(i);
		if spot.packageIgnore then
			print("ignore"..spot.spotInfo.id)
			for j=0,spot.routLines.Length-1 do
				while spot.routLines[j].transform.childCount>0 do
					CS.UnityEngine.Object.DestroyImmediate(spot.routLines[j].transform:GetChild(0).gameObject);
				end
				spot.routLines[j].spot0_1:Clear();
				spot.routLines[j].spot1_0:Clear();
				spot.routLines[j].shadows:Clear();
			end
		end
	end
end

local ShowShade = function(self,play)
	self:ShowShade(play);
	CS.DeploymentController.TriggerRefreshUIEvent();
end

local Init = function(self)
	self:Init();
	self.transform:Find("Active"):GetComponent(typeof(CS.UnityEngine.Canvas)).sortingOrder = 100;
	CS.DeploymentBuildSkillItem.showSelectSpot = false;
end

local PlayerWantlayer = function(self)
	CS.DeploymentUIController.Instance:CheckLayer();
	for i=0,CS.DeploymentBackgroundController.canClickLayers.Count-1 do
		local layer = CS.DeploymentBackgroundController.canClickLayers[i];
		print("检查层级HQ"..layer);
		for j=0,CS.DeploymentBackgroundController.layerDatas[layer].spots.Count-1 do
			local spot = CS.DeploymentBackgroundController.layerDatas[layer].spots[j];
			if not spot.Ignore and spot.type == CS.SpotType.headQuarter and spot.belong == CS.Belong.friendly then
				local hasspotaction = spot.spotAction ~= nil;
				print("HQ当前设定层级"..spot.layer..tostring(spot.spotInfo.id)..tostring(hasspotaction))
				return spot.layer;
			end
		end
	end
	for i=0,CS.DeploymentBackgroundController.canClickLayers.Count-1 do
		local layer = CS.DeploymentBackgroundController.canClickLayers[i];
		print("检查层级DTA"..layer);
		for j=0,CS.DeploymentBackgroundController.layerDatas[layer].spots.Count-1 do
			local spot = CS.DeploymentBackgroundController.layerDatas[layer].spots[j];
			if not spot.Ignore and spot.type == CS.SpotType.DTA and spot.belong == CS.Belong.friendly then
				local hasspotaction = spot.spotAction ~= nil;
				print("DTA当前设定层级"..spot.layer..tostring(spot.spotInfo.id)..tostring(hasspotaction))
				return spot.layer;
			end
		end
	end
	for i=0,CS.DeploymentBackgroundController.canClickLayers.Count-1 do
		local layer = CS.DeploymentBackgroundController.canClickLayers[i];
		print("检查层级Team"..layer);
		for j=0,CS.DeploymentBackgroundController.layerDatas[layer].spots.Count-1 do
			local spot = CS.DeploymentBackgroundController.layerDatas[layer].spots[j];
			if not spot.Ignore and spot.currentTeam ~= nil and spot.currentTeam:CurrentTeamBelong() == CS.TeamBelong.friendly then
				local hasspotaction = spot.spotAction ~= nil;
				print("Team当前设定层级"..spot.layer..tostring(spot.spotInfo.id)..tostring(hasspotaction))
				return spot.layer;
			end
		end
	end
	print("当前设定层级"..tostring(CS.DeploymentBackgroundController.canClickLayers[0]))
	return CS.DeploymentBackgroundController.canClickLayers[0];
end
util.hotfix_ex(CS.DeploymentBackgroundController,'RequestMissionCombinationHandle',RequestMissionCombinationHandle)
util.hotfix_ex(CS.DeploymentBackgroundController,'ShowShade',ShowShade)
util.hotfix_ex(CS.DeploymentBackgroundController,'Init',Init)
util.hotfix_ex(CS.DeploymentBackgroundController,'PlayerWantlayer',PlayerWantlayer)
