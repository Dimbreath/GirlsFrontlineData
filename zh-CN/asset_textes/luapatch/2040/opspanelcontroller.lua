local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)
xlua.private_accessible(CS.CommonVideoPlayer)
xlua.private_accessible(CS.CommonController)
xlua.private_accessible(CS.SpecialOPSMessageBox)

local timePerformanceWait = 0.0;
--local matVideo = nil;
local hasSetVideoSize = 0; -- 是否初始化判断是否大于3

local SetTime = function()
	timePerformanceWait = 1.0;
	if CS.CommonVideoPlayer.Instance ~= nil and not CS.CommonVideoPlayer.Instance:isNull() then
    	CS.CommonVideoPlayer.Instance.imgBG.gameObject:SetActive(false);
	end
end

local OPSPanelMissionContainer_LoadBackgroundVideo = function(self)
	self:LoadBackgroundVideo();
	if not CS.OPSConfig.Instance:DayFirst(self.campaionId) then
		CS.CommonController.Invoke(SetTime,3.0,self);
    end
end
local  OPSPanelMissionContainer_ShowUI =  function(self,loopname)
	self:ShowUI(loopname);
	CS.CommonController.Invoke(SetTime,3.0,self);
end

local OPSPanelMissionContainer_Update = function(self)
	if(timePerformanceWait > 0.5 and CS.CommonVideoPlayer.isExist) then
		timePerformanceWait = timePerformanceWait - CS.UnityEngine.Time.deltaTime * 0.5;
		CS.CommonVideoPlayer.Instance.imgVideo.material:SetFloat("_Alpha",timePerformanceWait);
		CS.CommonVideoPlayer.Instance.imgBG.gameObject:SetActive(false);
	end
	if hasSetVideoSize <= 3 then
		if CS.CommonVideoPlayer.isExist then
			local height = CS.CommonVideoPlayer.Instance.transform.sizeDelta.y;
			if height > 1152 then
				CS.CommonVideoPlayer.Instance.imgVideo.rectTransform.sizeDelta = CS.UnityEngine.Vector2(height * 16.0 / 9.0,height);
			end
			height = nil;
			hasSetVideoSize = 4;
		else
			hasSetVideoSize = hasSetVideoSize + 1; -- 最多等3帧，3帧后没出来视为不用视频
		end
	end
end

local lastContainerid = 0;

local ReturnContainerPos = function()
	local container = CS.OPSPanelBackGround.Instance.opsMissionContainers:Find(
		function(s) 
			return s.id == lastContainerid;
		end
	);
	local temp = CS.UnityEngine.Vector2(container.transform.localPosition.x,container.transform.localPosition.y);
    CS.OPSPanelBackGround.Instance:Move(temp,true,0.3,0,true,1);
    CS.OPSPanelBackGround.Instance:SaveRecord();
end

local OPSPanelMissionContainer_ReturnContainer = function(self)
	lastContainerid =  CS.OPSPanelBackGround.currentContainerId;
	self:ReturnContainer();
	CS.OPSPanelBackGround.currentEditType = CS.EditType.editContainer;
	if not CS.OPSPanelBackGround.recordScale[self.campaionId]:ContainsKey(0) then
		CS.CommonController.Invoke(ReturnContainerPos,0.6,self);
	end
end

local  OPSPanelContainer_CanGetPoint = function(self,itemid)
	return true;
end

local OPSPanelMissionContainer_ShowContainerReturn = function(self,show)
	self:ShowContainerReturn(show);
	if (self.containerReturn ~= nil and show) then
		self.containerReturn.transform:Find("ChapterContainer"):GetChild(0):Find("Processing").gameObject:SetActive(false);
	end
end

local OPSPanelMissionContainer_RefreshItemNum = function(self)
	self:RefreshItemNum();
	if self.itemuiObj ~= nil then
		self.itemuiObj:SetActive(false);
	end
	--[[
	local itemid = CS.OPSPanelController.showItemId[0]
	self.itemuiObj.transform:Find("SecretLayout/Group_0/Tex_PointShow"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = self.item_use[itemid].itemRealNum;
  	local iteminfo  = CS.GameData.listItemInfo:GetDataById(itemid);
  	local hasget = 0;
	if(CS.GameData.itemLimit:ContainsKey(itemid)) then
		hasget = CS.GameData.itemLimit[itemid].has_get;
	end
	local process = hasget*1.0/(hasget+self.item_use[itemid].ItemResetLimitNum);
	self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Img_Value"):GetComponent(typeof(CS.UnityEngine.UI.Image)).fillAmount = process;
	local btn =  self.itemuiObj.transform:Find("Btn_TextGroup/Image_Touch"):GetComponent(typeof(CS.ExButton));
  	btn.onClick:RemoveAllListeners();
  	btn.onClick:AddListener(function()
  		self.UnclockMessageBox.gameObject:SetActive(true);
  		self.UnclockMessageBox.transform:Find("Frame").gameObject:SetActive(false);
  		self.UnclockMessageBox.transform:Find("SecretInfoFrame").gameObject:SetActive(true);
  		self.UnclockMessageBox.transform:Find("SecretInfoFrame/ProgressBar/Image"):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Image"):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite;
  		self.UnclockMessageBox.transform:Find("SecretInfoFrame/Tex_Point /"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = self.item_use[itemid].itemRealNum;
  		self.UnclockMessageBox.transform:Find("SecretInfoFrame/ProgressBar/Img_Value"):GetComponent(typeof(CS.UnityEngine.UI.Image)).fillAmount = process;
  		local txt = CS.System.String.Format(CS.Data.GetLang(60057),tostring(math.floor(process*100)));
		self.UnclockMessageBox.transform:Find("SecretInfoFrame/ExplainNode/PointSurplus/Image/UI_Text"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = txt;
		txt = nil;
	end)]]
end
local OPSPanelMissionContainer_Start = function(self)
	self:Start();
	hasSetVideoSize = 0;
end

local OPSPanelMissionContainer_RequestUnClockCampaigns = function(self,data)
	local hasUnClock = false;
	for i=0,self.panelMissionuse.missionIds.Length - 1 do
		if (self.panelMissionuse.missionIds[i] ~= 0) then
			local mission = CS.GameData.listMission:GetDataById(self.panelMissionuse.missionIds[i]);
			if(mission ~= nil) then
				mission.clocked = false;
				if not hasUnClock then
					hasUnClock = true;
					for j=0,CS.OPSPanelController.showItemId.Count-1 do
						if(mission.missionInfo.PointCose:ContainsKey(CS.OPSPanelController.showItemId[j])) then
							local cost = mission.missionInfo.PointCose[CS.OPSPanelController.showItemId[j]];
							local num = CS.GameData.GetItem(CS.OPSPanelController.showItemId[j]);
							CS.GameData.SetItem(CS.OPSPanelController.showItemId[j], num - cost);
						end
					end
				end
			end
		end
	end
	OPSPanelMissionContainer_RefreshItemNum(self);
	self.panelMissionuse:ShowUnclock();
	self:ShowProcess();
end

local OPSPanelController_ShowContainerBackground = function(self,containerid,play)	
	for i=0, CS.OPSPanelBackGround.Instance.opsMissionContainers.Count-1 do
		local container = CS.OPSPanelBackGround.Instance.opsMissionContainers[i];
		if containerid == 0 or container.id == containerid then
			if container:UnClock() then
				 local child = self.containerBackground.transform:Find(tostring(container.id));
				 if child ~= nil then
				 	child.gameObject:SetActive(true);
				 end
			end
			for j=0, CS.OPSPanelBackGround.Instance.opsMissionContainers.Count-1 do
				local targetcontainer = CS.OPSPanelBackGround.Instance.opsMissionContainers[j];
				if targetcontainer ~= container and targetcontainer:UnClock() then
					local targetchild = self.containerBackground.transform:Find(tostring(container.id).."-"..tostring(targetcontainer.id));
					if targetchild ~= nil then
						targetchild.gameObject:SetActive(true);
					end
				end
			end
		end
	end
end

local OPSPanelController_InitShowContainer = function(self)
	self:RefreshUI();
	self:InitShowContainer();
end
util.hotfix_ex(CS.OPSPanelController,'LoadBackgroundVideo',OPSPanelMissionContainer_LoadBackgroundVideo)
util.hotfix_ex(CS.OPSPanelController,'ShowUI',OPSPanelMissionContainer_ShowUI)
util.hotfix_ex(CS.OPSPanelController,'Update',OPSPanelMissionContainer_Update)
util.hotfix_ex(CS.OPSPanelController,'CanGetPoint',OPSPanelContainer_CanGetPoint)
util.hotfix_ex(CS.OPSPanelController,'ReturnContainer',OPSPanelMissionContainer_ReturnContainer)
util.hotfix_ex(CS.OPSPanelController,'RefreshItemNum',OPSPanelMissionContainer_RefreshItemNum)
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',OPSPanelMissionContainer_ShowContainerReturn)
util.hotfix_ex(CS.OPSPanelController,'Start',OPSPanelMissionContainer_Start)
util.hotfix_ex(CS.OPSPanelController,'RequestUnClockCampaigns',OPSPanelMissionContainer_RequestUnClockCampaigns)
util.hotfix_ex(CS.OPSPanelController,'ShowContainerBackground',OPSPanelController_ShowContainerBackground)
util.hotfix_ex(CS.OPSPanelController,'InitShowContainer',OPSPanelController_InitShowContainer)