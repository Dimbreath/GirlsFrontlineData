local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialMissionInfoController)
local RequestAbortAutoMissionActionHandle = function(self,result)
	self:RequestAbortAutoMissionActionHandle(result);
	CS.CommonTopController.TriggerRefershResourceEvent();
end
local InitLimitSquadItem = function(self)
	local t = self.mission.missionInfo.limit_squad
	if self.mission.missionInfo.currentMissionCombination ~= nil and self.mission.missionInfo.currentMissionCombination.uselimitSquad then		
		self.mission.missionInfo.limit_squad = self.mission.missionInfo.currentMissionCombination.limitSquad
	end
	self:InitLimitSquadItem()
	self.mission.missionInfo.limit_squad = t	
end
local InitLimitSangvisItem = function(self)
	local t = self.mission.missionInfo.limit_sangvis
	if self.mission.missionInfo.currentMissionCombination ~= nil and self.mission.missionInfo.currentMissionCombination.uselimitSangvis then		
		self.mission.missionInfo.limit_sangvis = self.mission.missionInfo.currentMissionCombination.limitSangvis
	end
	self:InitLimitSangvisItem()
	self.mission.missionInfo.limit_sangvis = t	
end

local ShowOldReward = function(self)
	self.ClearwhiteTag.gameObject:SetActive(false);
	local rect = self.RewardBg:Find("IconScrollView/Rect");
	while rect.childCount >1 do
		CS.UnityEngine.Object.DestroyImmediate(rect:GetChild(1).gameObject);
	end
	self:ShowOldReward();
end

local ShowNewReward = function(self)
	self.showtxtNew:Find("PointNode").gameObject:SetActive(false);
	for i=0,self.panelMission.missionIds.Length-1 do
		local mission = CS.GameData.listMission:GetDataById(self.panelMission.missionIds[i]);
		if mission == nil  then
			print("关卡未解锁"..self.panelMission.missionIds[i]);
			return;
		end
	end
	self:ShowNewReward();
end

local InitUIElements = function(self)
	CS.SpecialMissionInfoController.Instance = self;
	self:InitUIElements();
end
util.hotfix_ex(CS.SpecialMissionInfoController,'RequestAbortAutoMissionActionHandle',RequestAbortAutoMissionActionHandle)
util.hotfix_ex(CS.SpecialMissionInfoController,'InitLimitSquadItem',InitLimitSquadItem)
util.hotfix_ex(CS.SpecialMissionInfoController,'InitLimitSangvisItem',InitLimitSangvisItem)
util.hotfix_ex(CS.SpecialMissionInfoController,'ShowOldReward',ShowOldReward)
util.hotfix_ex(CS.SpecialMissionInfoController,'ShowNewReward',ShowNewReward)
util.hotfix_ex(CS.SpecialMissionInfoController,'InitUIElements',InitUIElements)