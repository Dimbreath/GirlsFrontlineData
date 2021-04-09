local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialMissionSelectController)
local Start = function(self)
	self:Start();
	self.scrollrect.inertia = false;
end
local Update = function(self)
	self.posy = self.conentRect.anchoredPosition.y;
	self.itemHeight_min = self.offsetDown;
	self.itemHeight_max = self.offsetDown+self.itemHeight*(self.conentRect.childCount-2)+20;
	if self.checkpos then
		self:CheckCurrentPos();
	end
	self.posy = CS.UnityEngine.Mathf.Clamp(self.posy,self.itemHeight_min,self.itemHeight_max);
	self.conentRect.anchoredPosition = CS.UnityEngine.Vector2(self.conentRect.anchoredPosition.x,self.posy);
	self:ItemList();	
end
local CheckCurrentPos = function(self)
	self:CheckCurrentPos();
	if not self.checkpos then
		self.speed = 100;
		local index = (self.posy+self.itemHeight*2)/self.itemHeight;
		self.posy = CS.Mathf.RoundToInt(index-2)*self.itemHeight;
	end
end
local Init = function(self,showMissions,currentMissionInfo)
	self:Init(showMissions,currentMissionInfo);
	self.textList:Insert(0,self.conentRect:GetChild(0));
	self.offsetDown = -101;
	for i=0,showMissions.Count-1 do
		local child = self.conentRect:GetChild(i+1);
		local mission = CS.GameData.listMission:GetDataById(showMissions[i].id);
		child:Find("RollingText/Tex_Mission"):GetComponent(typeof(CS.ExText)).text = showMissions[i].name;
		child:Find("Img_MissionBattleType").gameObject:SetActive(showMissions[i].specialType ~= CS.MapSpecialType.Story);
		child:Find("Img_MissionStoryType").gameObject:SetActive(showMissions[i].specialType == CS.MapSpecialType.Story);
		child:Find("Img_New").gameObject:SetActive(mission.counter == 0);
	end
end
local ItemList = function(self)
	for i=0,self.textList.Count-1 do		
		local a = CS.Mathf.Abs(self.textList[i].position.y - self.targetRec.position.y);
		local lerp = CS.Mathf.Abs(self.curve_color:Evaluate(a / 8));
		local color = CS.UnityEngine.Color.Lerp(CS.UnityEngine.Color(0.5,0.5,0.5,1),CS.UnityEngine.Color(0,0,0,1),lerp);
		self.textList[i]:Find("RollingText/Tex_Mission"):GetComponent(typeof(CS.ExText)).color = color; 
	end
end
util.hotfix_ex(CS.SpecialMissionSelectController,'Init',Init)
util.hotfix_ex(CS.SpecialMissionSelectController,'Start',Start)
util.hotfix_ex(CS.SpecialMissionSelectController,'CheckCurrentPos',CheckCurrentPos)
util.hotfix_ex(CS.SpecialMissionSelectController,'Update',Update)
util.hotfix_ex(CS.SpecialMissionSelectController,'ItemList',ItemList)
