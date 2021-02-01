local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentCampaignExplain)
local InitOld = function(self)
	if self.useNew then
		local mission = CS.GameData.listMission:GetDataById(CS.GameData.currentSelectedMissionInfo.id);
		local order = 0;
		local distance = 174;
		local orcount = 0;
		local typeList = {}
		--local wintypes = CS.List(mission.missionInfo.winTypes)();
		for i=0,mission.missionInfo.winTypes.Count-1 do
			typeList[i+1] = mission.missionInfo.winTypes[i];
			for j=0,mission.missionInfo.winTypes[i].Count-1 do
				order = order+1;
				local temp = mission.missionInfo.winTypes[i][j];
				local hide = string.find(temp, "*");
				local hide1 = hide ~= nil;
				local txt = string.gsub(temp, "*","");			
				local winNum = tonumber(txt);
				local winType = CS.MissionWinType.getPoint;
				if winNum == 2 then
					winType = CS.MissionWinType.captureHQ;
				elseif winNum == 3 then
					winType = CS.MissionWinType.destroy;
				elseif winNum == 4 then
					winType = CS.MissionWinType.killBoss;
				elseif winNum == 5 then
					winType = CS.MissionWinType.endlessmode;
				elseif winNum == 6 then
					winType = CS.MissionWinType.createSupplyLine;
				elseif winNum == 7 then
					winType = CS.MissionWinType.saveHostage;
				elseif winNum == 8 then
					winType = CS.MissionWinType.killThirdBoss;
				elseif winNum == 9 then
					winType = CS.MissionWinType.killAllThirdTeam;
				elseif winNum == 10 then
					winType = CS.MissionWinType.killAllneturalTeam;
				elseif winNum == 11 then
					winType = CS.MissionWinType.keepTurn;
				elseif winNum == 101 then
					winType = CS.MissionWinType.getPoint1;
				elseif winNum == 102 then
					winType = CS.MissionWinType.getPoint2;
				end										
				--print("winType"..tostring(winType));
				--print("hide1"..tostring(hide1));
				self:ShowLeftTarget(winType,hide1,i);
			end
			local wintypeCount = mission.missionInfo.winTypes[i].Count;
			if wintypeCount > 1 then
				local y = -(order - wintypeCount) * distance - orcount*34;
				local height = distance * wintypeCount-20;
				--print("y"..tostring(y));
				--print("height"..tostring(height));
				self:CreateFrame(y, height);
			end	
			if i ~= mission.missionInfo.winTypes.Count -1 then
				local y = -order * distance+6;
				--print("y1"..tostring(y));
				self:CreateOrLine(y);
				orcount = orcount +1;
			end	
			self.goGrid:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta = CS.UnityEngine.Vector2(920, distance * order+ orcount*34);	
		end
		--local wintypes = mission.missionInfo.winTypes;
		mission.missionInfo.winTypes:Clear();
		self:InitOld();
		for i=1,#typeList do
			mission.missionInfo.winTypes:Add(typeList[i]);
		end
	else
		self:InitOld();	
	end
end

local ShowTarget = function(self,select)
	self:ShowTarget(select);
	if select then
		if not CS.System.String.IsNullOrEmpty(CS.GameData.currentSelectedMissionInfo.win_type) or not CS.System.String.IsNullOrEmpty(CS.GameData.currentSelectedMissionInfo.win_step) then
			self.goMissionIntroduceNew.gameObject:SetActive(true);
			if CS.GameData.currentSelectedMissionInfo.missionType == CS.MissionType.normal or CS.GameData.currentSelectedMissionInfo.missionType == CS.MissionType.Emergency then
				self.goMissionIntroduce.gameObject:SetActive(false);
			else	
				self.goMissionIntroduce.gameObject:SetActive(true);
				self.targetNewParent.gameObject:SetActive(false);
				self.ConditionNewParent.gameObject:SetActive(true);
			end
		else
			self.goMissionIntroduceNew.gameObject:SetActive(false);
			self.goMissionIntroduce.gameObject:SetActive(true);	
		end
	end
end
local Init = function(self)
	if CS.GameData.currentSelectedMissionInfo.useWinType or CS.GameData.currentSelectedMissionInfo.useWinStep then
		self:InitNew();
	else
		self:InitOld();
	end
end
util.hotfix_ex(CS.DeploymentCampaignExplain,'InitOld',InitOld)
util.hotfix_ex(CS.DeploymentCampaignExplain,'Init',Init)
util.hotfix_ex(CS.DeploymentCampaignExplain,'ShowTarget',ShowTarget)