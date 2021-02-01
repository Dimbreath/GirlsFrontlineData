local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)
xlua.private_accessible(CS.OPSPanelMissionHolder)
xlua.private_accessible(CS.OPSPanelSpot)
xlua.private_accessible(CS.OPSPanelBackGround)
spinename0 = nil;
spinename1 = nil;
spinename2 = nil;
spinename3 = nil;
spinename4 = nil;
spinename5 = nil;

spot0 = nil;
spine0 = nil;
spot1 = nil;
spine1 = nil;
spot2 = nil;
spine2 = nil;
spot3 = nil;
spine3 = nil;
spot4 = nil;
spine4 = nil;
spot5 = nil;
spine5 = nil;

local spots0 = {};
local spots1 = {};
local spots2 = {};
local spots3 = {};
local spots4 = {};
local spots5 = {};
--spotmissionId = {};
spot_lastspot = {};
spot_nextspot = {};
missionPath = {};
routeInfo = {};
spotInfo = {};
canFind = true;
allowminscale = 0;
item_Data = {}
infospine = nil;
infoline = nil;
infoimage = nil;
echospot = nil;
cameraBackground = nil;
local cameraObj = nil;
local hasload = false;
function LoadItemData()
	--if CS.OPSPanelController.OpenCompaions.Count == 0 then
	--	return;
	--end	
	if  hasload then
		return;
	end
	print("读取ActivityMapConfig")
	local textAsset = CS.ResManager.GetObjectByPath("ProfilesConfig/ActivityMapConfig", ".txt");
	local lineTxt = Split(textAsset.text,"\n");
	for i = 1, #lineTxt do
		local index = string.find(lineTxt[i],"/");
		if index == nil then
			local temp = Split(lineTxt[i],"|");
			if temp[1] == "OPSShowItem" then
				local campaionId = tonumber(temp[2]);
				local items = {};
				if temp[3] ~= nil and temp[3] ~= "" then 
					local pos = Split(temp[3],",");
					for l=1,#pos do
						local v = tonumber(pos[l]);
						table.insert(items,v);
					end
				end
				item_Data[campaionId] = items;
			end
		end
	end
	hasload = true;
end

local Awake = function(self)
	spots0 = {};
	spots1 = {};
	spots2 = {};
	spots3 = {};
	spots4 = {};
	spots5 = {};
	spinename0 =nil;
	spinename1 =nil;
	spinename2 =nil;
	spinename3 =nil;
	spinename4 = nil;
	spinename5 = nil;
	spot_lastspot = {};
	spot_nextspot = {};
	missionPath = {};
	routeInfo = {};
	spotInfo = {};
	self:Awake();
	self:Load(self.campaionId);
	if self.currentPanelConfig ~= nil then
		CS.OPSPanelBackGround.Instance.mainCamera.transform.position = CS.UnityEngine.Vector3(0, 0, self.currentPanelConfig.cameraHight);
		CS.OPSPanelBackGround.Instance.mainCamera.fieldOfView = self.currentPanelConfig.cameraField;
	end
	LoadItemData();
	if self.campaionId == -43 and not CS.CommonVideoPlayer.isExist then
		CS.CommonAudioController.PlayUI("UI_Division_OpenScene");
	end
end

local InitConfig = function(self,campaionId)
	self:InitConfig(campaionId);
	for i=0,self.currentPanelConfig.spot3dInfos.Count -1 do
		local info = self.currentPanelConfig.spot3dInfos[i];
		local spot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(info.missionid);
		if spot.mission ~= nil then
			print(spot.spineCode.."/"..tostring(info.missionid));
			if spot.spineCode == spinename0 then
				table.insert(spots0,spot);
			elseif spot.spineCode == spinename1 then
				table.insert(spots1,spot);
			elseif spot.spineCode == spinename2 then
				table.insert(spots2,spot);
			elseif spot.spineCode == spinename3 then
				table.insert(spots3,spot);
			elseif spot.spineCode == spinename4 then
				table.insert(spots4,spot);
			elseif spot.spineCode == spinename5 then
				table.insert(spots5,spot);
			end	
		end
	end
	--if not CS.OPSPanelController.spineStayMission:ContainsKey(-1) and next(spots0) ~= nil then
	--	CS.OPSPanelController.spineStayMission:Add(-1,spots0[1].missionId);
	--end
	--if not CS.OPSPanelController.spineStayMission:ContainsKey(-2) and next(spots1) ~= nil then
	--	CS.OPSPanelController.spineStayMission:Add(-2,spots1[1].missionId);
	--end
	--if not CS.OPSPanelController.spineStayMission:ContainsKey(-3) and next(spots2) ~= nil then
	--	CS.OPSPanelController.spineStayMission:Add(-3,spots2[1].missionId);
	--end
	--if not CS.OPSPanelController.spineStayMission:ContainsKey(-4) and next(spots3) ~= nil then
	--	CS.OPSPanelController.spineStayMission:Add(-4,spots3[1].missionId);
	--end
	--if not CS.OPSPanelController.spineStayMission:ContainsKey(-5) and next(spots4) ~= nil then
	--	CS.OPSPanelController.spineStayMission:Add(-5,spots4[1].missionId);
	--end
	--if not CS.OPSPanelController.spineStayMission:ContainsKey(-6) and next(spots5) ~= nil then
	--	CS.OPSPanelController.spineStayMission:Add(-6,spots5[1].missionId);
	--end
	local check = false;
	local missionid0 = 0;
	local missionid1 = 0;
	local missionid2 = 0;
	local missionid3 = 0;
	local missionid4 = 0;
	local missionid5 = 0;
	if next(spots0) ~= nil then
		missionid0 = spots0[1].missionId;
	end
	if next(spots1) ~= nil then
		missionid1 = spots1[1].missionId;
	end
	if next(spots2) ~= nil then
		missionid2 = spots2[1].missionId;
	end
	if next(spots3) ~= nil then
		missionid3 = spots3[1].missionId;
	end
	if next(spots4) ~= nil then
		missionid4 = spots4[1].missionId;
	end
	if next(spots5) ~= nil then
		missionid5 = spots5[1].missionId;
	end
	for i = 1, #(spots0) do
		if not check and spots0[i].mission ~= nil and spots0[i].mission.winCount>0 then
			missionid0 = spots0[i].missionId;
		else
			check = true;
		end
		if spots0[i+1] ~= nil and not spots0[i+1]:isNull() then
			--print("0/起始"..tostring(spots0[i].missionId).."结束"..tostring(spots0[i+1].missionId));
			spot_lastspot[spots0[i+1].missionId] = spots0[i].missionId;
			spot_nextspot[spots0[i].missionId] = spots0[i+1].missionId;
		end	
	end	
	check = false;
	for i = 1, #(spots1) do		
		if not check and spots1[i].mission ~= nil and spots1[i].mission.winCount>0 then
			missionid1 = spots1[i].missionId;
		else
			check = true;
		end
		if spots1[i+1] ~= nil and not spots1[i+1]:isNull() then
			--print("1/起始"..tostring(spots1[i].missionId).."结束"..tostring(spots1[i+1].missionId));
			spot_lastspot[spots1[i+1].missionId] = spots1[i].missionId;
			spot_nextspot[spots1[i].missionId] = spots1[i+1].missionId;
		end	
	end
	check = false;
	for i = 1, #(spots2) do
		if not check and spots2[i].mission ~= nil and spots2[i].mission.winCount>0 then
			missionid2 = spots2[i].missionId;
		else
			check = true;
		end
		if spots2[i+1] ~= nil and not spots2[i+1]:isNull() then
			--print("2/起始"..tostring(spots2[i].missionId).."结束"..tostring(spots2[i+1].missionId));
			spot_lastspot[spots2[i+1].missionId] = spots2[i].missionId;
			spot_nextspot[spots2[i].missionId] = spots2[i+1].missionId;
		end		
	end
	check = false;
	for i = 1, #(spots3) do
		if not check and spots3[i].mission ~= nil and spots3[i].mission.winCount>0 then
			missionid3 = spots3[i].missionId;
		else
			check = true;
		end 
		if spots3[i+1] ~= nil and not spots3[i+1]:isNull() then
			--print("2/起始"..tostring(spots3[i].missionId).."结束"..tostring(spots3[i+1].missionId));
			spot_lastspot[spots3[i+1].missionId] = spots3[i].missionId;
			spot_nextspot[spots3[i].missionId] = spots3[i+1].missionId;
		end		
	end
	check = false;
	for i = 1, #(spots4) do
		if not check and spots4[i].mission ~= nil and spots4[i].mission.winCount>0 then
			missionid4 = spots4[i].missionId;
		else
			check = true;
		end 
		if spots4[i+1] ~= nil and not spots4[i+1]:isNull() then
			--print("2/起始"..tostring(spots4[i].missionId).."结束"..tostring(spots4[i+1].missionId));
			spot_lastspot[spots4[i+1].missionId] = spots4[i].missionId;
			spot_nextspot[spots4[i].missionId] = spots4[i+1].missionId;
		end		
	end
	check = false;
	for i = 1, #(spots5) do
		if not check and spots5[i].mission ~= nil and spots5[i].mission.winCount>0 then
			missionid5 = spots5[i].missionId;
		else
			check = true;
		end  
		if spots5[i+1] ~= nil and not spots5[i+1]:isNull() then
			--print("2/起始"..tostring(spots5[i].missionId).."结束"..tostring(spots5[i+1].missionId));
			spot_lastspot[spots5[i+1].missionId] = spots5[i].missionId;
			spot_nextspot[spots5[i].missionId] = spots5[i+1].missionId;
		end		
	end
	if not CS.OPSPanelController.spineStayMission:ContainsKey(-1) and missionid0 ~= 0 then
		CS.OPSPanelController.spineStayMission:Add(-1,missionid0);
	end
	if not CS.OPSPanelController.spineStayMission:ContainsKey(-2) and missionid1 ~= 0 then
		CS.OPSPanelController.spineStayMission:Add(-2,missionid1);
	end
	if not CS.OPSPanelController.spineStayMission:ContainsKey(-3) and missionid2 ~= 0 then
		CS.OPSPanelController.spineStayMission:Add(-3,missionid2);
	end
	if not CS.OPSPanelController.spineStayMission:ContainsKey(-4) and missionid3 ~= 0 then
		CS.OPSPanelController.spineStayMission:Add(-4,missionid3);
	end
	if not CS.OPSPanelController.spineStayMission:ContainsKey(-5) and missionid4 ~= 0 then
		CS.OPSPanelController.spineStayMission:Add(-5,missionid4);
	end
	if not CS.OPSPanelController.spineStayMission:ContainsKey(-6) and missionid5 ~= 0 then
		CS.OPSPanelController.spineStayMission:Add(-6,missionid5);
	end
	print("初始化线条")
	for i=0, CS.OPSPanelBackGround.Instance.all3dSpots.Count-1 do
		local spot3d = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataByIndex(i);
		if spot_lastspot[spot3d.missionId] ~= nil then	
			local lastmissionid = spot_lastspot[spot3d.missionId];
			local lastspot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(lastmissionid);
			local spot3dShow = spot3d.mission ~= nil;
			local lastspotShow = lastspot.mission ~= nil;
			print(tostring(spot3d.missionId)..tostring(spot3dShow)..tostring(lastmissionid)..tostring(nextspotShow))
			local index = CS.OPSPanelBackGround.Instance.all3dSpots:GetList():IndexOf(lastspot);
			local route = routeInfo[index];
			if route ~= nil and spot3dShow and lastspotShow then
				if missionPath[lastmissionid] == nil or missionPath[lastmissionid]:isNull() then
					print("实例化线条"..tostring(lastmissionid));
					spot3d:InitLine();
					local obj = CS.UnityEngine.Object.Instantiate(spot3d.path.gameObject);
					local path = obj:GetComponent(typeof(CS.OPSPanelLine));
					obj.transform:SetParent(CS.OPSPanelBackGround.Instance.CurveParent, false);
					obj.gameObject:SetActive(false);
					obj.name = tostring(spot_lastspot[spot3d.missionId]);
					path.Point0 = lastspot.transform;
					path.Point1 = spot3d.transform;
					path.otherPoints:Clear();
					path.Ctrol_Point0.gameObject:SetActive(false);
					path.Ctrol_Point1.gameObject:SetActive(false);
					path.currentPathType = CS.OPSPanelLine.Direction.poliline;
					path.BezierRenderer.startWidth = route[3];
					path.BezierRenderer.endWidth = route[4];
					path.BezierRenderer.startColor = route[5];
					path.BezierRenderer.endColor = route[5];
					path.BezierRenderer.material:SetFloat("_AddDirection", 1);
					path.BezierRenderer.material:SetColor("_AddColor", route[6]);
					if route[7] ~= nil then
						for j = 1,#route[7] do				
							local point = CS.UnityEngine.Object.Instantiate(path.Ctrol_Point0.gameObject);
							point.transform:SetParent(path.transform:Find("Point"), false);
							point.transform.localPosition = route[7][j];
							--print(obj.name..tostring(routeInfo[i][7][j]));
							path.otherPoints:Add(point.transform);
							point.gameObject:SetActive(false);				
						end
					end
					path:DrawCurve();
					path.BezierRenderer.material:SetFloat("_Control", 0);
					missionPath[lastmissionid] = path;
				end
				missionPath[lastmissionid].BezierRenderer.material:SetFloat("_AddControl", 0);
				--missionPath[nextspot].BezierRenderer.material:SetFloat("_Control", 1);
				local isspot0 = CS.OPSPanelController.spineStayMission:ContainsKey(-1) and CS.OPSPanelController.spineStayMission[-1] == spot3d.missionId;
				local isspot1 = CS.OPSPanelController.spineStayMission:ContainsKey(-2) and CS.OPSPanelController.spineStayMission[-2] == spot3d.missionId;
				local isspot2 = CS.OPSPanelController.spineStayMission:ContainsKey(-3) and CS.OPSPanelController.spineStayMission[-3] == spot3d.missionId;
				local isspot3 = CS.OPSPanelController.spineStayMission:ContainsKey(-4) and CS.OPSPanelController.spineStayMission[-4] == spot3d.missionId;
				local isspot4 = CS.OPSPanelController.spineStayMission:ContainsKey(-5) and CS.OPSPanelController.spineStayMission[-5] == spot3d.missionId;
				local isspot5 = CS.OPSPanelController.spineStayMission:ContainsKey(-6) and CS.OPSPanelController.spineStayMission[-6] == spot3d.missionId;
				if  not isspot0 and not isspot1 and not isspot2 and not isspot3 and not isspot4 and not isspot5 then
					--print("显示线条"..lastspot.missionId)
					if spot3d.mission.winCount>0 then
						print("On"..spot3d.missionId)
						missionPath[lastmissionid].BezierRenderer.material:SetFloat("_AddControl", 1);
					end
				end	
				local lastShow = CS.SpecialActivityController.missionid_State:ContainsKey(lastmissionid);
				local currentShow = CS.SpecialActivityController.missionid_State:ContainsKey(spot3d.missionId);	
				if lastShow and currentShow then
					print("显示线条"..lastmissionid)
					missionPath[lastmissionid].gameObject:SetActive(true);	
				else
					print("隐藏线条"..lastmissionid)
					missionPath[lastmissionid].gameObject:SetActive(false);	
				end
			end
		end
	end
end

local lastspot = nil;
local MoveSpine = function(self,spot)
	if spot.mission ~= nil and not spot.mission.clocked then
		if spot.mission.missionInfo.isEcho then
			spot:LoadEffect();
			spot:ShowEffect();
			self:ShowEchoInfo(spot);
			--if lastspot ~= nil and lastspot ~= spot then
			--	lastspot:HideEffect();
			--	lastspot = nil;
			--end
			--lastspot = spot;
		else
			--if lastspot ~= nil and lastspot ~= spot then
			--	lastspot:HideEffect();
			--	lastspot = nil;
			--end
			self:CloseEchoInfo();
			self:SelectMissionSpot(spot);
		end
	end
	return;

	--if spot.spineCode == spinename0 then
		--CS.OPSPanelController.spineStayMission[-1] = spot.missionId;
	--	self.currentSpot = spot0;
	--	print("选中"..tostring(spot.missionId));
	--	if spot0 == spot then
	--		self:SelectMissionSpot(spot0);	
	--		return;		
	--	end
	--self.targetSpot = spot;
	--self:CancelMission();
	--self:CloseEchoInfo();
	--if self.currentSpot ~= nil then
	--	self:MoveBySpotPosition();
	--end
end

--local MoveBySpotPosition = function(self)
--	self.moveSpots:Clear();
--	if spot_lastspot[self.targetSpot.missionId] == self.currentSpot.missionId then
--		self.moveSpots:Add(self.targetSpot.missionId);
--	end
	--if self.currentSpot.spineCode == spinename0 then
		--local add = false;		
		--for key, value in ipairs(spots0) do
		--	if add then
		--		print("添加移动"..tostring(spots0[key].missionId));
		--		self.moveSpots:Add(spots0[key].missionId);
		--	end
		--	if self.currentSpot==spots0[key] then
		--		add = true;
		--	end
		--	if self.targetSpot==spots0[key] then
		--		add = false;
		--	end		
		--end
	--end
--	if self.moveSpots.Count == 0 then
--		self:SelectMissionSpot(self.targetSpot);
--		return;
--	end
--	self:MoveSpotNext();
--end

local CheckSpineSpot = function(self)
	print("定义小人位置")
	if not canFind then
		return;
	end
	--self:MoveMissionHolder();
	local missionholder = nil;
	if CS.GameData.missionAction ~= nil then
		for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
			local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
			if holder.currentMission ~= nil and holder.currentMission == CS.GameData.missionAction.mission then
				print("1"..tostring(holder.order));
				missionholder = holder;
				break;
			end
		end
	end
	if missionholder == nil and CS.GameData.currentSelectedMissionInfo ~= nil then
		--print("2"..tostring(CS.GameData.currentSelectedMissionInfo.id));
		for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
			local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
			if holder.currentMission ~= nil and holder.currentMission.missionInfo.id == CS.GameData.currentSelectedMissionInfo.id then
				--print("2"..tostring(holder.order));
				missionholder = holder;
				break;
			end
			for j=0,holder.spots3D.Count-1 do
				local spot = holder.spots3D[j];
				if spot.missionId == CS.GameData.currentSelectedMissionInfo.id then
					--print("2"..tostring(holder.order));
					missionholder = holder;		
				end
			end
		end	
	end
	if missionholder == nil then
		for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
			local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
			if holder.gameObject.activeSelf then
				--print("3"..tostring(holder.order));
				missionholder = holder;
				break;
			end
		end	
	end
	local read =  CS.OPSPanelBackGround.Instance:ReadRecord();
	if not read and missionholder ~= nil then		
		local pos = CS.UnityEngine.Vector2(missionholder.transform.localPosition.x,missionholder.transform.localPosition.y);
		print("定义初始位置");
		CS.OPSPanelBackGround.Instance:Move(pos,true,0.5,0,true,CS.OPSPanelBackGround.Instance.mapminScale,true,nil);
	end
	if self.campaionId ~= -43 then
		return;
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-1) then
		local missionid = CS.OPSPanelController.spineStayMission[-1];		
		if spot0 == nil or spot0:isNull() then
			spot0 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
			if spot0.CanShow then
				print("创建spine0"..tostring(missionid))	
				CS.OPSPanelController.Instance.currentSpot = spot0;
				CS.OPSPanelController.Instance.spine = spine0;
				spot0:CreateSpine(false);
			end
		end
		if spine0 ~= nil and not spine0:isNull() then
			spine0.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-2) then
		local missionid = CS.OPSPanelController.spineStayMission[-2];
		if spot1 == nil or spot1:isNull() then		
			spot1 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
			if spot1.CanShow then
				print("创建spine1"..tostring(missionid))
				CS.OPSPanelController.Instance.currentSpot = spot1;
				CS.OPSPanelController.Instance.spine = spine1;
				spot1:CreateSpine(false);
			end
		end
		if spine1 ~= nil and not spine1:isNull() then
			spine1.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-3) then
		local missionid = CS.OPSPanelController.spineStayMission[-3];	
		if spot2 == nil or spot2:isNull() then	
			spot2 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
			if spot2.CanShow then
				print("创建spine2"..tostring(missionid))
				CS.OPSPanelController.Instance.currentSpot = spot2;
				CS.OPSPanelController.Instance.spine = spine2;
				spot2:CreateSpine(false);
			end
		end
		if spine2 ~= nil and not spine2:isNull() then
			spine2.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-4) then	
		local missionid = CS.OPSPanelController.spineStayMission[-4];
		if spot3 == nil or spot3:isNull() then	
			spot3 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
			if spot3.CanShow then
				print("创建spine3"..tostring(missionid))
				CS.OPSPanelController.Instance.currentSpot = spot3;
				CS.OPSPanelController.Instance.spine = spine3;
				spot3:CreateSpine(false);
			end
		end
		if spine3 ~= nil and not spine3:isNull() then
			spine3.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-5) then
		local missionid = CS.OPSPanelController.spineStayMission[-5];	
		if spot4 == nil or spot4:isNull() then	
			spot4 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
			if spot4.CanShow then
				print("创建spine4"..tostring(missionid))
				CS.OPSPanelController.Instance.currentSpot = spot4;
				CS.OPSPanelController.Instance.spine = spine4;
				spot4:CreateSpine(false);
			end
		end
		if spine4 ~= nil and not spine4:isNull() then
			spine4.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-6) then	
		local missionid = CS.OPSPanelController.spineStayMission[-6];
		if spot5 == nil or spot5:isNull() then	
			spot5 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
			if spot5.CanShow then
				print("创建spine5"..tostring(missionid))
				CS.OPSPanelController.Instance.currentSpot = spot5;
				CS.OPSPanelController.Instance.spine = spine5;
				spot5:CreateSpine(false);
			end
		end
		if spine5 ~= nil and not spine5:isNull() then
			spine5.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	for k, v in pairs(missionPath) do  
		if missionPath[k] ~= nil then 
			if self.lastposX == 0 then
				missionPath[k].BezierRenderer.material:SetFloat("_Control", 1);				
			end
		end
	end 
	CS.CommonController.Invoke(CheckAllSpine,0.5,CS.OPSPanelController.Instance);
end

function CheckAllSpine()
	for i=1,6 do
		local num = -1*i;
		if CS.OPSPanelController.spineStayMission:ContainsKey(num) then
			local id = CS.OPSPanelController.spineStayMission[num];
			print(num.."|"..id);
			if spot_nextspot[id] ~= nil then 
				local nextSpot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(spot_nextspot[id]);
				local spot3d = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(id);
				print("检查当前点"..id);
				if nextSpot.CanShow and nextSpot.mission.winCount>0 then
					print("移动spine至"..spot_nextspot[id]);
					CS.OPSPanelController.spineStayMission[num] = spot_nextspot[id];
					CS.OPSPanelController.Instance.moveSpots:Add(spot_nextspot[id]);
					CS.OPSPanelController.Instance.currentSpot = spot3d;
					CS.OPSPanelController.Instance.targetSpot = nextSpot;			
					local pos0 = CS.UnityEngine.Vector2(spot3d.transform.localPosition.x,spot3d.transform.localPosition.y);
					pos0 = pos0 + CS.UnityEngine.Vector2(-4000,-1000);
					print("移动镜头")
					CS.OPSPanelBackGround.Instance:Move(pos0,true,0.3,0.3,true,CS.OPSPanelBackGround.Instance.mapminScale,true,nil);
					CS.CommonController.Invoke(function()
						CS.OPSPanelController.Instance:MoveSpotNext();
					end,0.6,CS.OPSPanelController.Instance);
					return;
				end
			end
		end
	end
end

local MoveSpotNext = function(self)
	if self.moveSpots.Count == 0 then
		CS.OPSPanelController.Instance.currentChoose = nil;
		CheckAllSpine();
		CS.OPSPanelBackGround.Instance.CanClick = true;
	else
		CS.OPSPanelBackGround.Instance.CanClick = false;
		local lastSpot = CS.OPSPanelController.Instance.currentSpot;
		local spot3d = CS.OPSPanelController.Instance.targetSpot;
		CS.OPSPanelController.Instance.currentChoose = spot3d.holder.currentLabel;
		local time = CS.UnityEngine.Vector3.Distance(lastSpot.transform.localPosition, spot3d.transform.localPosition)/1000;
		local pos1 = CS.UnityEngine.Vector2(spot3d.transform.localPosition.x,spot3d.transform.localPosition.y);
		pos1 = pos1 + CS.UnityEngine.Vector2(-4000,-1000);
		print("移动镜头"..lastSpot.missionId.."目标点"..spot3d.missionId)
		CS.OPSPanelBackGround.Instance:Move(pos1,true,time,0,true,CS.OPSPanelBackGround.Instance.mapminScale,true,nil);
		if missionPath[lastSpot.missionId] ~= nil and not missionPath[lastSpot.missionId]:isNull() then
			missionPath[lastSpot.missionId].gameObject:SetActive(true);
			missionPath[lastSpot.missionId].BezierRenderer.material:SetFloat("_AddControl", 0);
			missionPath[lastSpot.missionId].BezierRenderer.material:DOFloat(1, "_AddControl", time+0.3);
		end
	end
	self:MoveSpotNext();
end

local HideAllLabel = function(self)
	if self.campaionId == -41 then
		canFind = false;
	end
	if self.campaionId == -43 then
		canFind = false;
		--return;
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
	if self.campaionId == -41 then
		if self.background3d ~= nil and not self.background3d:isNull() then
			local pos = CS.OPSPanelBackGround.Instance.modelPos+CS.UnityEngine.Vector3(0,0,-550*CS.OPSPanelController.difficulty);
			self.background3d.transform:DOLocalMove(pos,0.5);
		end
	end
end

local ShowAllLabel = function(self)
	if self.campaionId == -43 then
		--return;
	end
	for i=0, CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
		local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders[i];
		holder.allowShow = true;
		--holder.show = true;
		if holder.currentLabel ~= nil then
			holder.currentLabel.gameObject:SetActive(true);
		end
		holder:ShowSpots(true,0.5);
	end
	canFind = true;
end

function CheckCameraObj()
	if cameraObj ~= nil and not cameraObj:isNull() then
		for i=0,CS.OPSPanelController.diffcluteNum-1 do
			local child = cameraObj.transform:GetChild(0):Find(tostring(i));
			if child ~= nil then
				local canvasgroup = child:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
				if i == CS.OPSPanelController.difficulty then
					canvasgroup:DOFade(1,2);
				else
					canvasgroup:DOFade(0,2);
				end
			end
		end
	end
end

local SelectDiffcluty = function(self)
	self:SelectDiffcluty();
	CheckCameraObj();
end

local InitBackground = function(self)
	self:InitBackground();
	if self.background3d ~= nil and not self.background3d:isNull() then
		if self.campaionId == -41 then
			local pos = CS.OPSPanelBackGround.Instance.modelPos+CS.UnityEngine.Vector3(0,0,-550*CS.OPSPanelController.difficulty);
			self.background3d.transform.localPosition = pos;
		end
		local model = self.background3d.transform:Find("manhadun");
		if model ~= nil then
			for i=0, model.childCount-1 do
				local render = model:GetChild(i):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
				if render ~= nil and not render:isNull() then
					local mat = render.material;
					mat:SetFloat("_pos", 10);
					mat:DOFloat(-10, "_pos", 4);
				end
				--mat:DOFloat(-100, "_pos", 4):SetDelay(1):SetEase(CS.DG.Tweening.Ease.InCubic);
			end
		end
	end
	if cameraBackground ~= nil then
		print("实例化背景相机")
		local textAsset = CS.ResManager.GetObjectByPath("Pics/ActivityRes/"..cameraBackground);
		cameraObj = CS.UnityEngine.Object.Instantiate(textAsset);
		local camera = cameraObj:GetComponent(typeof(CS.UnityEngine.Camera));
		CS.OPSPanelBackGround.Instance.mainCamera.cullingMask = ~camera.cullingMask;
		CS.OPSPanelBackGround.Instance.mainCamera.clearFlags = CS.UnityEngine.CameraClearFlags.Depth;
	end
	CheckCameraObj();
end

local InitSpots = function(self)
	self:InitSpots();
	if self.campaionId ~= -43 then
		return;
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-1) then		
		local missionid = CS.OPSPanelController.spineStayMission[-1];
		print("创建spine"..tostring(missionid))
		spot0 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
		CS.OPSPanelController.Instance.currentSpot = spot0;
		CS.OPSPanelController.Instance.spine = spine0;
		spot0:CreateSpine();
		if spine0 ~= nil and not spine0:isNull() then
			spine0.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-2) then		
		local missionid = CS.OPSPanelController.spineStayMission[-2];
		print("创建spine"..tostring(missionid))
		spot1 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
		CS.OPSPanelController.Instance.currentSpot = spot1;
		CS.OPSPanelController.Instance.spine = spine1;
		spot1:CreateSpine();
		if spine1 ~= nil and not spine1:isNull() then
			spine1.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-3) then		
		local missionid = CS.OPSPanelController.spineStayMission[-3];
		print("创建spine"..tostring(missionid))
		spot2 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
		CS.OPSPanelController.Instance.currentSpot = spot2;
		CS.OPSPanelController.Instance.spine = spine2;
		spot2:CreateSpine();
		if spine2 ~= nil and not spine2:isNull() then
			spine2.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-4) then		
		local missionid = CS.OPSPanelController.spineStayMission[-4];
		print("创建spine"..tostring(missionid))
		spot3 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
		CS.OPSPanelController.Instance.currentSpot = spot3;
		CS.OPSPanelController.Instance.spine = spine3;
		spot3:CreateSpine();
		if spine3 ~= nil and not spine3:isNull() then
			spine3.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-5) then		
		local missionid = CS.OPSPanelController.spineStayMission[-5];
		print("创建spine"..tostring(missionid))
		spot4 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
		CS.OPSPanelController.Instance.currentSpot = spot4;
		CS.OPSPanelController.Instance.spine = spine4;
		spot4:CreateSpine();
		if spine4 ~= nil and not spine4:isNull() then
			spine4.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
	end
	if CS.OPSPanelController.spineStayMission:ContainsKey(-6) then		
		local missionid = CS.OPSPanelController.spineStayMission[-6];
		print("创建spine"..tostring(missionid))
		spot5 = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(missionid);
		CS.OPSPanelController.Instance.currentSpot = spot5;
		CS.OPSPanelController.Instance.spine = spine5;
		spot5:CreateSpine();
		if spine5 ~= nil and not spine5:isNull() then
			spine5.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
		end
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
		local iter = self.item_use:GetEnumerator();
		while iter:MoveNext() do
			local data = iter.Current.Value;
			local num = 0;
			if CS.GameData.itemLimit:ContainsKey(self.currentitemid) then
			 	num = CS.GameData.itemLimit[self.currentitemid].daily_get;
			end
			print("今日已获取"..num)
			print("今日还能获取"..data.ItemTodayCost)
			data.ItemResetLimitNum = data.ItemResetLimitNum + data.ItemTodayCost;
			self.process = num*1.0/(data.ItemResetLimitNum+num);
			print("process"..self.process)
			if self.itemuiObj ~= nil and not self.itemuiObj:isNull() then
				local image = self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Img_Value"):GetComponent(typeof(CS.UnityEngine.UI.Image));
				image.fillAmount = self.process;
			end
		end
	end
	if self.campaionId == -31 then
		if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Japan then
			if self.itemuiObj ~= nil and not self.itemuiObj:isNull() then
				self.itemuiObj:SetActive(true);
				self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
				self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Img_Value"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
				self.itemuiObj.transform:Find("Btn_TextGroup/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
			end
		else
			if self.itemuiObj ~= nil and not self.itemuiObj:isNull() then
				self.itemuiObj:SetActive(false);
			end
		end
	end	
end

local GetColor = function(stringtxt)
	local a,color = CS.UnityEngine.ColorUtility.TryParseHtmlString("#"..stringtxt); 
	return color;
end

local Load = function(self,campaion)
	self:Load(campaion);
	if self.currentPanelConfig ~= nil then
		if campaion == -31 then
			self.currentPanelConfig.ItemId = "8001";
		elseif campaion == -33 then
			self.currentPanelConfig.ItemId = "8003";	
		end
	end
	local textAsset = CS.ResManager.GetObjectByPath("ProfilesConfig/OPSPanel/Campion"..tostring(campaion), ".txt");
	if textAsset == nil then
		return;
	end
	local lineTxt = Split(textAsset.text,"\n");
	for i = 1, #lineTxt do
		local index = string.find(lineTxt[i],"/");
		if index == nil then
			local temp = Split(lineTxt[i],"|");
			if temp[1] == "MissionSpot3dRoute" then
					local route = {};
					local startorder = tonumber(Split(temp[2],",")[1]);
					local endorder = tonumber(Split(temp[2],",")[2]);
					local startwidth = tonumber(Split(temp[3],",")[1]); 
					local endwidth = tonumber(Split(temp[3],",")[2]);
					local startColor = GetColor(Split(temp[4],",")[1]);
					local endColor = GetColor(Split(temp[4],",")[2]);
					local poliPos = {};
					if temp[5] ~= nil and temp[5] ~= "" then 
						local pos = Split(temp[5],";");
						for l=1,#pos do
							local v = Split(pos[l],",");
							local p = CS.UnityEngine.Vector3(tonumber(v[1]),tonumber(v[2]),tonumber(v[3]));
							table.insert(poliPos,p);
						end
					end
					table.insert(poliPos,p);
					table.insert(route,startorder);
					table.insert(route,endorder);
					table.insert(route,startwidth);
					table.insert(route,endwidth);
					table.insert(route,startColor);
					table.insert(route,endColor);
					table.insert(route,poliPos);
					routeInfo[startorder] = route;
					--print("读取MissionSpot3dRoute"..startorder);
					--print("内容"..lineTxt[i]);
					--print("endColor"..tostring(endColor));
			end
			if temp[1] == "MissionSpot" then
				local order = tonumber(temp[2]);
				local info = {};
				if temp[8] ~= nil then
					table.insert(info,temp[8]);
				end
				if temp[9] ~= nil then
					table.insert(info,tonumber(temp[9]));
				end
				spotInfo[order] = info;
			end
			if temp[1] == "MissionMapMinScale" then
				allowminscale = tonumber(temp[2]);
			end
			if temp[1] == "MissionBackgroundCamera" then
				cameraBackground = temp[2];
				print("MissionBackgroundCamera"..cameraBackground)
			end
		end
	end
	local names = {}
	for i=0,self.currentPanelConfig.spot3dInfos.Count -1 do
		local code = self.currentPanelConfig.spot3dInfos[i].spineCode;
		if code ~= "" then
			if names[code] == nil then
				names[code] = code;
				if spinename0 == nil  then
					spinename0 = code;
				elseif spinename1 == nil then
					spinename1 = code;
				elseif	spinename2 == nil then
					spinename2 = code;
				elseif	spinename3 == nil then
					spinename3 = code;
				elseif	spinename4 == nil then
					spinename4 = code;
				elseif	spinename5 == nil then
					spinename5 = code;	
				end
			end	
		end 
	end
end


function Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

local LoadUI = function(self,campaion)
	self.leftMain.gameObject:SetActive(false);
	self:LoadUI(campaion);
	CS.CommonController.Invoke(function()
			self.leftMain.gameObject:SetActive(true);
		end,0.3,self);
	if item_Data[self.campaionId] == nil then
		return;
	end
	local obj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Pics/ActivityMap/TheDivision_MissionItems"));
	obj.transform:SetParent(self.leftMain,false);
	for i=1, #item_Data[self.campaionId] do
		local itemid = item_Data[self.campaionId][i];
		print("itemid"..itemid)
		local iteminfo = CS.GameData.listItemInfo:GetDataById(itemid);
		local child = obj.transform:GetChild(0):GetChild(i-1);
		CS.EventTriggerListener.Get(child.gameObject).onEnter = ShowTip;
		CS.EventTriggerListener.Get(child.gameObject).onExit = CloseTip;
		if iteminfo ~= nil then
			--local image = child:Find("Img_Icon"):GetComponent(typeof(CS.ExImage));
			--image.sprite = CS.CommonController.LoadPngCreateSprite(iteminfo.codePath);
			--image.rectTransform.sizeDelta = CS.UnityEngine.Vector2(80,80);
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
	if self.campaionId == -43 then
		local child = self.transform:Find("Left/TheDivisoin_GotoMall(Clone)/TimeText");
		local num = CS.GameData.GetItem(100070);
		child:GetComponent(typeof(CS.ExText)).text = tostring(num);
	end
end

function ShowTip(go)
	--print("show")
	local index = go.transform:GetSiblingIndex();
	--print(index)
	local itemid = item_Data[CS.OPSPanelController.Instance.campaionId][index+1];
	local iteminfo = CS.GameData.listItemInfo:GetDataById(itemid);
	local posOffset = CS.UnityEngine.Vector3(300, 100, 0);	
	CS.CommonTipsContent.ShowTips(iteminfo.name, iteminfo.introduction, "", 9, go.transform:TransformPoint(posOffset), go.transform.parent,100);
end
function CloseTip(go)
	CS.CommonTipsContent.HideTips();
	--print("CloseTip")
end

local CancelMission = function(self)
	--print("关闭Missioninfo")
	self.MissionInfoController.gameObject:SetActive(false);
	self:CancelMission();
end


local ShowEchoInfo = function(self,spot)
	echospot = spot;
	if not spot.echoPic:isNull() then
		print("infospine")
		infoimage = spot.echoPic:GetComponent(typeof(CS.UnityEngine.SpriteRenderer));
	end
	local line = spot.transform:Find("Spot/Line");
	if line ~= nil then
		print("infoline")
		infoline = line:GetComponent(typeof(CS.UnityEngine.LineRenderer));
	end
	infospine = nil;
	if spine0 ~= nil and not spine0:isNull() then
		if spine0.transform.localPosition == spot.transform.localPosition then
			infospine = spine0:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		end
	end
	if spine1 ~= nil and not spine1:isNull() then
		if spine1.transform.localPosition == spot.transform.localPosition then
			infospine = spine1:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		end
	end
	if spine2 ~= nil and not spine2:isNull() then
		if spine2.transform.localPosition == spot.transform.localPosition then
			infospine = spine2:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		end
	end
	if spine3 ~= nil and not spine3:isNull() then
		if spine3.transform.localPosition == spot.transform.localPosition then
			infospine = spine3:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		end
	end
	if spine4 ~= nil and not spine4:isNull() then
		if spine4.transform.localPosition == spot.transform.localPosition then
			infospine = spine4:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		end
	end
	if spine5 ~= nil and not spine5:isNull() then
		if spine5.transform.localPosition == spot.transform.localPosition then
			infospine = spine5:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		end
	end
	local pos = CS.OPSPanelBackGround.Instance.targetPosition;
	self:ShowEchoInfo(spot);
	self.MissionEchoSpotInfo.transform.localPosition = CS.UnityEngine.Vector3(120,-20,-160);
	CS.OPSPanelBackGround.Instance.map.transform:DOKill();
	CS.OPSPanelBackGround.Instance.CanClick = true;
	CS.OPSPanelBackGround.Instance.targetPosition = pos;
end
local CloseEchoInfo = function(self)
	self:CloseEchoInfo();
	--CS.CommonAudioController.PlayUI("UI_Division_Echo_Off");
end

local PlayShowSpot = function(self)
	if self.currentPanelConfig.spot3dInfos.Count>0 then
		self:CheckSpineSpot();
	else
		self:PlayShowSpot();
	end
end

local LoadMissionInfo = function(self,obj)
	
end

local ShowItemMessage = function(self)
	self:ShowItemMessage();
	if self.iteminfo == nil then
		return;
	end
	self.UnclockMessageBox.transform:Find("SecretInfoFrame/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
	self.UnclockMessageBox.transform:Find("SecretInfoFrame/ProgressBar/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
	self.UnclockMessageBox.transform:Find("SecretInfoFrame/ProgressBar/Img_Value"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
	self.UnclockMessageBox.transform:Find("SecretInfoFrame/Tex_Point /"):GetComponent(typeof(CS.ExText)).color = CS.UnityEngine.Color(1,120/255,60/255,1);
	--self.InfoFrame:Find("SecretInfoFrame/ProgressBar/Img_Value"):GetComponent(typeof(CS.ExImage)).fillAmount = CS.OPSPanelController.Instance.process;
	--self.InfoFrame:Find("SecretInfoFrame/ExplainNode/PointAdd/Image/Image"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(60056);
	--local txt = tostring(self.process*100);
	--self.InfoFrame:Find("SecretInfoFrame/ExplainNode/PointSurplus/Image/Image"):GetComponent(typeof(CS.ExText)).text = CS.System.String.Format(CS.Data.GetLang(60057),txt);
end
local SelectMissionPanel = function(self,panelMission)
	self:SelectMissionPanel(panelMission);
	if self.campaionId == -43 then
		CS.CommonAudioController.PlayUI("UI_Division_ClickMission");
	else
		CS.CommonAudioController.PlayUI("UI_OPSShowMissionInfoNormal");
	end
end
local SelectMissionSpot = function(self,spot)
	self:SelectMissionSpot(spot);
	if self.campaionId == -43 then
		CS.CommonAudioController.PlayUI("UI_Division_ClickMission");
	else
		CS.CommonAudioController.PlayUI("UI_OPSShowMissionInfoNormal");
	end
end
local SortHolder = function(self)
	self:SortHolder();
	CS.OPSPanelBackGround.Instance.CanClick = false;
end
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelController,'InitConfig',InitConfig)
util.hotfix_ex(CS.OPSPanelController,'MoveSpine',MoveSpine)
util.hotfix_ex(CS.OPSPanelController,'MoveSpotNext',MoveSpotNext)
--util.hotfix_ex(CS.OPSPanelController,'MoveBySpotPosition',MoveBySpotPosition)
util.hotfix_ex(CS.OPSPanelController,'InitBackground',InitBackground)
util.hotfix_ex(CS.OPSPanelController,'InitSpots',InitSpots)
util.hotfix_ex(CS.OPSPanelController,'CheckSpineSpot',CheckSpineSpot)
util.hotfix_ex(CS.OPSPanelController,'HideAllLabel',HideAllLabel)
util.hotfix_ex(CS.OPSPanelController,'ShowAllLabel',ShowAllLabel)
util.hotfix_ex(CS.OPSPanelController,'CheckAnim',CheckAnim)
util.hotfix_ex(CS.OPSPanelController,'RefreshItemNum',RefreshItemNum)
util.hotfix_ex(CS.OPSPanelController,'Load',Load)
util.hotfix_ex(CS.OPSPanelController,'LoadUI',LoadUI)
util.hotfix_ex(CS.OPSPanelController,'CancelMission',CancelMission)
util.hotfix_ex(CS.OPSPanelController,'ShowEchoInfo',ShowEchoInfo)
util.hotfix_ex(CS.OPSPanelController,'SelectDiffcluty',SelectDiffcluty)
util.hotfix_ex(CS.OPSPanelController,'PlayShowSpot',PlayShowSpot)
util.hotfix_ex(CS.OPSPanelController,'LoadMissionInfo',LoadMissionInfo)
util.hotfix_ex(CS.OPSPanelController,'ShowItemMessage',ShowItemMessage)
util.hotfix_ex(CS.OPSPanelController,'CloseEchoInfo',CloseEchoInfo)
util.hotfix_ex(CS.OPSPanelController,'SelectMissionPanel',SelectMissionPanel)
util.hotfix_ex(CS.OPSPanelController,'SelectMissionSpot',SelectMissionSpot)
util.hotfix_ex(CS.OPSPanelController,'SortHolder',SortHolder)