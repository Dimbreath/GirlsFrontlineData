local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)
xlua.private_accessible(CS.OPSPanelMissionHolder)
local canFind = true;

local Awake = function(self)
	self:Awake();
	self:Load(self.campaionId);
	if self.currentPanelConfig ~= nil then
		CS.OPSPanelBackGround.Instance.mainCamera.transform.position = CS.UnityEngine.Vector3(0, 0, self.currentPanelConfig.cameraHight);
		CS.OPSPanelBackGround.Instance.mainCamera.fieldOfView = self.currentPanelConfig.cameraField;
	end
end
local MoveSpine = function(self,spot)
	if spot.mission ~= nil and not spot.mission.clocked then
		self:SelectMissionSpot(spot);
	end
end
local CheckSpineSpot = function(self)
	if not canFind then
		return;
	end
	self:MoveMissionHolder();
	local missionholder = nil;
	if CS.GameData.missionAction ~= nil then
		for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
			local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
			if holder.currentMission ~= nil and holder.currentMission == CS.GameData.missionAction.mission then
				missionholder = holder;
				break;
			end
		end
	end
	if missionholder == nil then
		for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
			local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
			if holder.currentMission ~= nil and holder.currentMission.winCount == 0 then
				missionholder = holder;
				break;
			end
		end	
	end
	if missionholder == nil then
		for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
			local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
			if holder.gameObject.activeSelf then
				missionholder = holder;
				break;
			end
		end	
	end
	if missionholder ~= nil then		
		local pos = CS.UnityEngine.Vector2(missionholder.transform.localPosition.x,missionholder.transform.localPosition.y);
		print("定义初始位置");
		CS.OPSPanelBackGround.Instance:Move(pos,true,0.5,0,true,CS.OPSPanelBackGround.Instance.mapminScale,true,nil);
	end
end


local HideAllLabel = function(self)
	if self.campaionId == -41 then
		canFind = false;
	end
	for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
		local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
		holder.allowShow = false;
		--holder.show = false;		
		if holder.currentLabel ~= nil then
			holder.currentLabel.gameObject:SetActive(true);
			holder.currentLabel:ActiveTween(false);
		end
		holder:HideSpots();
	end

	if self.background3d ~= nil then
		local pos = CS.OPSPanelBackGround.Instance.modelPos+CS.UnityEngine.Vector3(0,0,-700*CS.OPSPanelController.difficulty);
		self.background3d.transform:DOLocalMove(pos,0.5);
	end
end

local ShowAllLabel = function(self)
	canFind = true;
	for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
		local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
		holder.allowShow = true;
		--holder.show = true;
		if holder.currentLabel ~= nil then
			holder.currentLabel.gameObject:SetActive(true);
		end
		holder:ShowSpots(true,0.5);
	end
end

local InitBackground = function(self)
	self:InitBackground();
	if self.background3d ~= nil then
		local pos = CS.OPSPanelBackGround.Instance.modelPos+CS.UnityEngine.Vector3(0,0,-700*CS.OPSPanelController.difficulty);
		self.background3d.transform.localPosition = pos;
	end
end

local  function RemoveRepetition(TableData)
	local bExist = {}
	for v, k in pairs(TableData) do
		bExist[k] = true
	end
	local result = {}
	for v, k in pairs(bExist) do
		table.insert(result, v)
	end
		
	return result
end

local CheckAnim = function(self)
	local labels = {}
	print("playHoldersCount:"..tostring(self.playHolders.Count));
	for i=0,self.playHolders.Count-1 do
		labels[i+1] = self.playHolders[i]; 
	end
	labels = RemoveRepetition(labels);
	self.playHolders:Clear();
	for i=1,#labels do
		if labels[i].currentMission ~= nil  then
			self.playHolders:Add(labels[i]);
		end
	end
	self:CheckAnim();
end

local RefreshItemNum = function(self)
	if CS.OPSPanelController.showItemId.Count>0 then
		self:RefreshItemNum();
	end
end
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelController,'MoveSpine',MoveSpine)
util.hotfix_ex(CS.OPSPanelController,'InitBackground',InitBackground)
util.hotfix_ex(CS.OPSPanelController,'CheckSpineSpot',CheckSpineSpot)
util.hotfix_ex(CS.OPSPanelController,'HideAllLabel',HideAllLabel)
util.hotfix_ex(CS.OPSPanelController,'ShowAllLabel',ShowAllLabel)
util.hotfix_ex(CS.OPSPanelController,'CheckAnim',CheckAnim)
util.hotfix_ex(CS.OPSPanelController,'RefreshItemNum',RefreshItemNum)