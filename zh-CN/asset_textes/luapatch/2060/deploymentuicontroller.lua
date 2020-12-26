local util = require 'xlua.util'
local panelController = require("2060/OPSPanelController")
xlua.private_accessible(CS.DeploymentUIController)
xlua.private_accessible(CS.DeploymentBackgroundController)

local data = {};

local CheckLayer = function(self)
	if CS.DeploymentController.isDeplyment then
		CS.DeploymentBackgroundController.canClickLayers:Clear();
		for i = 0,CS.DeploymentBackgroundController.Instance.listSpot.Count-1 do
			local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataByIndex(i);
			if  not spot.Ignore then
				if spot.spotInfo.belong == CS.Belong.friendly or spot:HasFriendlyTeam() then					
					if not CS.DeploymentBackgroundController.canClickLayers:Contains(spot.layer) then
						print("添加默认层级"..spot.layer)
						CS.DeploymentBackgroundController.canClickLayers:Add(spot.layer);
					end
				end
			end
		end
		CS.DeploymentBackgroundController.canClickLayers:Sort();
		if CS.DeploymentBackgroundController.canClickLayers.Count <= 1 then
			self.btnSwitchLayer.gameObject:SetActive(false);
			return;
		end
		self.btnSwitchLayer.gameObject:SetActive(true);
		local child = self.btnSwitchLayer.transform:GetChild(0);
		while child.childCount < CS.DeploymentBackgroundController.canClickLayers.Count  do
			local tip = CS.UnityEngine.Object.Instantiate(child:GetChild(0).gameObject).transform;
			tip:SetParent(child,false);
		end
		for i=0,child.transform.childCount-1 do
			if i<CS.DeploymentBackgroundController.canClickLayers.Count then
				child.transform:GetChild(i).gameObject:SetActive(true);
				local image = child.transform:GetChild(i):GetComponent(typeof(CS.ExImage));
				if CS.DeploymentBackgroundController.currentlayer == CS.DeploymentBackgroundController.canClickLayers[i] then
					image.color = CS.UnityEngine.Color.white;
				else
					image.color = CS.UnityEngine.Color.black;
				end
			else
				child.transform:GetChild(i).gameObject:SetActive(false);
			end
		end
	else
		if CS.GameData.missionAction == nil then
			return;
		end
		self:CheckLayer();
	end
end

Itemobj = nil;
local RefreshUI = function(self)
	if CS.GameData.missionAction ~= nil then
		for i=0,CS.GameData.missionAction.listBuildingAction.Count-1 do
			local build  = CS.GameData.missionAction.listBuildingAction:GetDataByIndex(i);
			if build.buildController == nil or build.buildController:isNull() then	
				local spot = CS.DeploymentBackgroundController.Instance.listSpot:GetDataById(build.spotId);
				if spot ~= nil then 		
					build.buildController = spot.buildControl;
				end
			end
		end
	end
	self:RefreshUI();
	if CS.GameData.missionAction ~= nil and CS.GameData.currentSelectedMissionInfo.specialType == CS.MapSpecialType.Normal then
		local count = 0;
		for i=0,CS.GameData.listSpotAction.Count-1 do
			local spotAction = CS.GameData.listSpotAction[i];
			if spotAction.spot ~= nil and not spotAction.spot.Ignore then
				if spotAction.spot.currentTeam ~= nil and spotAction.spot.currentTeam:CurrentTeamBelong() ~= CS.TeamBelong.friendly then
					count = count + 1;
				end
			end			
		end
		self.textRestEnemyCount.text = count;
	end
	LoadItemData();
	if item_Data == nil then
		return;
	end
	if item_Data[CS.GameData.currentSelectedMissionInfo.campaign] == nil then
		return;
	end
	if Itemobj == nil or Itemobj:isNull() then
		Itemobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("WorldCollide/TheDivision/TheDivision_DeploymentItems"));
		Itemobj.transform:SetParent(self.transform,false);
		local rectTransform = Itemobj:GetComponent(typeof(CS.UnityEngine.RectTransform));
		rectTransform.anchoredPosition3D = CS.UnityEngine.Vector3(-190,-240,0);
	end
	for i=1, #item_Data[CS.GameData.currentSelectedMissionInfo.campaign] do
		local itemid = item_Data[CS.GameData.currentSelectedMissionInfo.campaign][i];
		local child = Itemobj.transform:GetChild(0):GetChild(i-1);
		CS.EventTriggerListener.Get(child.gameObject).onEnter = DeploymentShowTip;
		CS.EventTriggerListener.Get(child.gameObject).onExit = DeploymentCloseTip;
		print("itemid"..itemid)
		local iteminfo = CS.GameData.listItemInfo:GetDataById(itemid);
		if iteminfo ~= nil then
			--local image = child:Find("Img_Icon"):GetComponent(typeof(CS.ExImage));
			--image.sprite = CS.CommonController.LoadPngCreateSprite(iteminfo.codePath);
		end
		local numText = child:Find("Tex_Num"):GetComponent(typeof(CS.ExText));
		local num = CS.GameData.GetItem(itemid);
		local shownum = "";
		local shadow = child:Find("Img_Shadow"):GetComponent(typeof(CS.ExImage));
		if num == 0 then
			child:Find("Img_OrangeShadow").gameObject:SetActive(false);
			shadow.color = CS.UnityEngine.Color(160/255,160/255,160/255,1);
		else
			child:Find("Img_OrangeShadow").gameObject:SetActive(true);
			shadow.color = CS.UnityEngine.Color(243/255,152/255,0/255,1);
		end
		if num < 10 then
			if num == 0 then
				shownum = "<color=#A0A0A0FF>00</color>";
			else
				shownum = "<color=#A0A0A0FF>0</color><color=#000000FF>"..tostring(num).."</color>";
			end
		elseif num > 99 then
			shownum = "<color=#000000FF>99+</color>";
		else
			shownum = "<color=#000000FF>"..tostring(num).."</color>";
		end
		numText.text = shownum;
	end
end

function DeploymentShowTip(go)
	--print("show")
	local index = go.transform:GetSiblingIndex();
	--print(index)
	local itemid = item_Data[CS.GameData.currentSelectedMissionInfo.campaign][index+1];
	local iteminfo = CS.GameData.listItemInfo:GetDataById(itemid);
	print(itemid)
	local posOffset = CS.UnityEngine.Vector3(-300, 0, 0);	
	CS.CommonTipsContent.ShowTips(iteminfo.name, iteminfo.introduction, "", 9, go.transform:TransformPoint(posOffset), go.transform.parent,100);
end
function DeploymentCloseTip(go)
	CS.CommonTipsContent.HideTips();
end

local SwitchAbovePanel = function(self,show)
	self:SwitchAbovePanel(show);
	self.goAbove.transform:SetAsLastSibling();
end
local ShowMiddleLine = function(self)
	self:ShowMiddleLine();
	if self.middleholder ~= nil and self.middleholder.transform.childCount>0 then
		local item = self.middleholder.transform:GetChild(0):GetComponent(typeof(CS.DeploymentBuildSkillItem));
		if item.uicfg.is_manual_target == 1 then
			for i=0,self.currentline.Count-1 do
				self.currentline[i].gameObject:SetActive(false);
			end
		else
			for i=0,self.currentline.Count-1 do
				self.currentline[i].gameObject:SetActive(true);
			end		
		end
	end
end
local NoShowMiddleLine = function(self)
	for i=0,self.currentline.Count-1 do
		self.currentline[i]:CloseLine();
		self.useline:Enqueue(self.currentline[i]);
	end
	for i=0,self.spots.Count-1 do
		if self.spots[i].buildAction ~= nil and not self.spots[i].buildAction.buildControl:isNull() then
			self.spots[i].buildingAction.buildController:EndTweenKle();
		end
	end
	for i=1,#data do
		if data[i].buildAction ~= nil and not data[i].buildAction.buildController:isNull() then
			data[i].buildAction.buildController:EndTweenKle();
		end
		for j=0,data[i].targetSpotAction.Count-1 do
			if data[i].targetSpotAction[j].spot ~= nil and not data[i].targetSpotAction[j].spot:isNull() then
				if data[i].targetSpotAction[j].spot.buildControl ~= nil and not data[i].targetSpotAction[j].spot.buildControl:isNull() then
					data[i].targetSpotAction[j].spot.buildControl:EndTweenKle();
				end
			end
		end
	end
	self.currentline:Clear();
	self.spots:Clear();
end

local OnClickButton = function(self,Button)
	local cache = CS.ConfigData.endTurnConfirmation;
	if CS.GameData.currentSelectedMissionInfo.useDemoMission then
		CS.ConfigData.endTurnConfirmation = false;
	end
	self:OnClickButton(Button);
	if CS.GameData.currentSelectedMissionInfo.useDemoMission then
		CS.ConfigData.endTurnConfirmation = cache;
	end	
end

local OnClickEndTurn = function(self)
	self:SwitchAbovePanel(true);
	self:OnClickEndTurn();
end

local Awake = function(self)
	self:Awake();
	--LoadItemData();
end

local ShowBuildSkill = function(self,missionskills)
	data = {};
	for i=0,missionskills.Count-1 do
		if missionskills[i].skill.istransfer then
			local tempspot = {};
			for j=0,missionskills[i].targetSpotAction.Count-1 do
				local spotaction = missionskills[i].targetSpotAction[j];
				for l=0,spotaction.listSpecialAction.Count-1 do
					if spotaction.listSpecialAction[l].spotBuffInfo ~= nil and spotaction.listSpecialAction[l].spotBuffInfo.noairborne then
						table.insert(tempspot,spotaction);
					end
				end
			end
			for i=1,#tempspot do
				missionskills[i].targetSpotAction:Remove(tempspot[i]);
			end
		end
		if missionskills[i].skill.itemCose.Keys.Count>0 then
			local iter = missionskills[i].skill.itemCose:GetEnumerator();
			if iter:MoveNext() then
				local item = iter.Current.Key;
				local num = iter.Current.Value;
				local totalnum = CS.GameData.GetItem(item);
				print("当前需要消耗道具"..item.."数目"..num.."剩余"..totalnum);
				if totalnum>= num then
					table.insert(data,missionskills[i]);
				end
			end
		else
			table.insert(data,missionskills[i]);
		end
	end
	missionskills:Clear();
	for i=1,#data do
		missionskills:Add(data[i]);
	end
	if missionskills.Count>0 then
		self:ShowBuildSkill(missionskills);
	else
		self:CloseBuildControlUI();
	end
end

local CheckBuildInActiveNumLeast = function(missionwintypeid,logic,process,medal)
	print("检查buildAction");
	if CS.GameData.missionAction ~= nil then
		for i=0,CS.GameData.missionAction.listBuildingAction.Count-1 do
		local build  = CS.GameData.missionAction.listBuildingAction:GetDataByIndex(i);
			if build.buildController == nil then				
				build.buildController = CS.DeploymentBackgroundController.Instance.listSpot:GetDataById(build.spotId).buildControl;
			end
		end
	end
	local result,process = CS.DeploymentUIController.CheckBuildInActiveNumLeast(missionwintypeid,logic,process,medal);
	return result;
end

local CloseBuildControlUI = function(self)
	self:CloseBuildControlUI();
	for i=1,#data do
		if data[i].buildAction ~= nil then
			data[i].buildAction.buildController:EndTweenKle();
		end
		for j=0,data[i].targetSpotAction.Count-1 do
			if data[i].targetSpotAction[j].spot ~= nil and not data[i].targetSpotAction[j].spot:isNull() then
				if data[i].targetSpotAction[j].spot.buildControl ~= nil and not data[i].targetSpotAction[j].spot.buildControl:isNull() then
					data[i].targetSpotAction[j].spot.buildControl:EndTweenKle();
				end
			end
		end
	end
end
util.hotfix_ex(CS.DeploymentUIController,'Awake',Awake)	
util.hotfix_ex(CS.DeploymentUIController,'CheckLayer',CheckLayer)
util.hotfix_ex(CS.DeploymentUIController,'RefreshUI',RefreshUI)
util.hotfix_ex(CS.DeploymentUIController,'SwitchAbovePanel',SwitchAbovePanel)
util.hotfix_ex(CS.DeploymentUIController,'ShowMiddleLine',ShowMiddleLine)
util.hotfix_ex(CS.DeploymentUIController,'NoShowMiddleLine',NoShowMiddleLine)
util.hotfix_ex(CS.DeploymentUIController,'OnClickButton',OnClickButton)
util.hotfix_ex(CS.DeploymentUIController,'OnClickEndTurn',OnClickEndTurn)
util.hotfix_ex(CS.DeploymentUIController,'ShowBuildSkill',ShowBuildSkill)
util.hotfix_ex(CS.DeploymentUIController,'CheckBuildInActiveNumLeast',CheckBuildInActiveNumLeast)
util.hotfix_ex(CS.DeploymentUIController,'CloseBuildControlUI',CloseBuildControlUI)	