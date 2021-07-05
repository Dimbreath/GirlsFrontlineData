local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local ShowContainerReturn = function(self,show)
	self:ShowContainerReturn(show);
	if self.campaionId == -44 then
		local targetMall = self.transform:Find("Left/MirrorStage_GotoMall(Clone)");
		local targetPoint = self.transform:Find("Left/MirrorStage_PointExchange(Clone)");
		local show =  self.containerReturn.gameObject.activeSelf and CS.OPSPanelBackGround.currentContainerId == -1;
		if targetPoint ~= nil then
			targetPoint.gameObject:SetActive(show);
		end
		if targetMall ~= nil then
			targetMall.gameObject:SetActive(not show);
		end
	end
end

local ReturnContainer = function(self)
	self:ReturnContainer();
	if self.campaionId == -44 then
		local targetMall = self.transform:Find("Left/MirrorStage_GotoMall(Clone)");
		local targetPoint = self.transform:Find("Left/MirrorStage_PointExchange(Clone)");
		local show =  self.containerReturn.gameObject.activeSelf and CS.OPSPanelBackGround.currentContainerId == -1;
		if targetPoint ~= nil then
			targetPoint.gameObject:SetActive(show);
		end
		if targetMall ~= nil then
			targetMall.gameObject:SetActive(not show);
		end
	end
end
spotInfo = {};--3dspotid-name
spot3dInfo = {};--3dspotid-mission<List<list>>列表
selectHolderOrder = -1;--默认选择holder
local id_ProcessObj = {};--3dspotid-mission列表obj
local hasPlaySpots = nil;
local change = 0;
local firstEnter = false;
local InitSpots = function(self)
	selectHolderOrder = -1;
	--selectHolderOrder = CS.UnityEngine.PlayerPrefs.GetInt("SelectHolerOrder",0);
	self:InitSpots();
	if self.containerBackground ~= nil and not self.containerBackground:isNull() then
		for i=0,self.containerBackground.transform.childCount-1 do
			self.containerBackground.transform:GetChild(i).gameObject:SetActive(false);
		end
		self.containerBackground.transform:Find("Static").gameObject:SetActive(true);
	end
	CS.OPSPanelProcessItem.canmapmove = true;	
	if self.campaionId == -46 then
		firstEnter = false;
		for i=0,CS.OPSPanelBackGround.Instance.all3dSpots.Count-1 do
			local spot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataByIndex(i);
			CheckMissionProcessData(spot);
		end
		CheckAllAnim(self);
		firstEnter = true;
	end
end

local ShowAllMission = function(self)
	CS.OPSPanelProcessItem.canmapmove = true;
	self:ShowAllMission();
end

local Load = function(self,campaion)
	self:Load(campaion);
	local textAsset = CS.ResManager.GetObjectByPath("ProfilesConfig/OPSPanel/Campion"..tostring(campaion), ".txt");
	if textAsset == nil then
		return;
	end
	local lineTxt = Split(textAsset.text,"\n");
	for i = 1, #lineTxt do
		local index = string.find(lineTxt[i],"/");
		if index == nil then
			local temp = Split(lineTxt[i],"|");
			if temp[1] == "MissionSpot3dShow" then
				local info = {};
				local order = tonumber(temp[2]);
				local allmission = CS.System.Collections.Generic.List(CS.System.Collections.Generic.List(CS.System.Int32))();
				if temp[3] ~= nil and temp[3] ~= "" then 
					local ids = Split(temp[3],",");
					for l=1,#ids do
						local missions = CS.System.Collections.Generic.List(CS.System.Int32)();
						local id = Split(ids[l],"-");
						for n=1,#id do
							missions:Add(tonumber(id[n]));
						end
						allmission:Add(missions);
					end
				end
				spot3dInfo[order] = allmission;
				--print("spot3dInfo添加数据"..order);
				id_ProcessObj[order] = nil;
			elseif temp[1] == "MissionSpotShow" then
				local order = tonumber(temp[2]);
				local langue = tonumber(temp[3]);
				spotInfo[order]	= langue;
			end
		end	
	end
	hasPlaySpots = CS.System.Collections.Generic.List(CS.System.Int32)();
end

local missionScroll;	
local ShowSelectView = function(self,spot)--显示左边关卡列表
	if spot3dInfo[spot.id] == nil then
		return;	
	end
	if missionScroll == nil or missionScroll:isNull() then
		missionScroll = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Pics/ActivityMap/MissionSpotMissionSelectList_2021"));
		missionScroll.transform:SetParent(self.transform,false);
	end
	self.chooseSpot = spot;
	missionScroll:SetActive(true);
	missionScroll.transform:Find("Img_Line").gameObject:SetActive(true);
	local btn = missionScroll.transform:Find("Background"):GetComponent(typeof(CS.ExButton));
	btn.onClick:RemoveAllListeners();
	btn:AddOnClick(function ()
		missionScroll:SetActive(false);
		CS.OPSPanelProcessItem.canmapmove = true;
		self.Line.gameObject:SetActive(false);
		self.MissionInfoController.gameObject:SetActive(false);
		self.MissionInfoController.mission = nil;
		self.chooseSpot = nil;
		CheckAllAnim(self);
	end);
	local selectmission = self.MissionInfoController.mission;
	local missionInfos = CS.System.Collections.Generic.List(CS.MissionInfo)();
	local currentMission = nil;
	for i=0,spot3dInfo[spot.id].Count-1 do
		local ids = spot3dInfo[spot.id][i];
		local missionId = ids[CS.OPSPanelController.difficulty];
		local missionInfo = CS.GameData.listMissionInfo:GetDataById(missionId);	
		local mission = CS.GameData.listMission:GetDataById(missionId);
		if mission ~= nil then
			if selectmission ~= nil and ids:Contains(selectmission.missionInfo.id) then
				currentMission = mission;
			end
			if currentMission == nil and mission.counter == 0 then
				currentMission = mission;
			end
			if currentMission == nil and mission.missionInfo == CS.GameData.currentSelectedMissionInfo then
				currentMission = mission;
			end
			if CS.GameData.missionAction ~= nil and mission == CS.GameData.missionAction.mission then
				currentMission = mission;
			end
			missionInfos:Add(missionInfo);
		end
	end
	if currentMission == nil then
		currentMission = CS.GameData.listMission:GetDataById(missionInfos[0].id);
		--print("最终选择"..currentMission.missionInfo.id);
	end
	CS.OPSPanelProcessItem.canmapmove = false;
	CS.OPSPanelBackGround.Instance:SaveRecord();
	self.MissionInfoController.gameObject:SetActive(false);
	for i=0,CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
		local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders:GetDataByIndex(i);
		local group = holder.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
		if group == nil or group:isNull() then
			group = holder.gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup));
		end	
		group:DOFade(0,0.5);
		group.blocksRaycasts = false;
	end
	local missionInfoControl = 	missionScroll.transform:Find("Mission"):GetComponent(typeof(CS.SpecialMissionSelectController));
	missionInfoControl:Init(missionInfos,currentMission.missionInfo);
	ShowMissionPanel(self,currentMission);
end
		
local selectprocessInfo;
local SelectProcessInfo = function(self,processInfo)
	--print(processInfo.panelHolder);
	if processInfo.diffcluty == -1 then
		ShowSelectView(self,processInfo.panelspot);
		CS.OPSPanelBackGround.Instance:SaveRecord();
		CS.OPSPanelBackGround.Instance:FocusPanelMove(processInfo.panelspot.transform.localPosition);
		return;
	end
	selectHolderOrder = processInfo.panelspot.missionHolderOrder;
	CS.OPSPanelController.difficulty = processInfo.diffcluty; 
	self:SelectProcessInfo(processInfo);
	CS.OPSPanelBackGround.Instance.movespotscale = CS.OPSPanelBackGround.Instance.scale;
	CS.OPSPanelBackGround.Instance:FocusSpotMove(processInfo.panelspot.transform.localPosition);
end

function ShowMissionPanel(self,mission)--显示关卡具体界面
	self.MissionInfoController.gameObject:SetActive(true);
	self.MissionInfoController.missionInfo = mission.missionInfo;
	self.MissionInfoController.mission = mission;
	self.MissionInfoController:RefreshOther();
	self.MissionInfoController:RefreshEntranceUI();
	self.MissionInfoController:RefresCommonUI();
	self.MissionInfoController:ShowOldReward();
	CS.CommonAudioController.PlayUI("UI_selete_2");
	self:PlaySpecialOpenMissionAudio();	
	local line = missionScroll.transform:Find("Img_Line"):GetComponent(typeof(CS.UnityEngine.RectTransform));
	line.anchoredPosition = CS.UnityEngine.Vector2(900,250);
	line.sizeDelta = CS.UnityEngine.Vector2(0,0);
	self.Line.gameObject:SetActive(true);
	self.Line:ShowLine(line,self.MissionInfoController.transform:Find("LinePoint"));	
end
		
local SelectMissionPanel = function(self,panelMission)--选中上面关卡
	if self.campaionId == -46 then
		if panelMission == nil then
			return;
		end
		--CS.OPSPanelBackGround.Instance.movepanelscale = CS.OPSPanelBackGround.Instance.scale;
		CS.OPSPanelBackGround.Instance:FocusPanelMove(panelMission.holder.transform.localPosition);
		if panelMission.holder.order == selectHolderOrder then
			--selectHolderOrder = -1;
			--print("关闭");
			
			return;
		else
			selectHolderOrder = panelMission.holder.order;
			--=print("展开");
		end
		--CS.UnityEngine.PlayerPrefs.SetInt("SelectHolerOrder",selectHolderOrder);
		--CS.UnityEngine.PlayerPrefs.Save();
		--panelMission:RefreshUI();
		CS.CommonAudioController.PlayUI("UI_DropkickonMyDevil_ClickChapter");
		CheckAllAnim(self);
		return;
	end		
	self:SelectMissionPanel(panelMission);
end
local SelectMissionSpot = function(self,spot)
	if self.campaionId == -46 then
		if selectHolderOrder == spot.missionHolderOrder then
			--CS.OPSPanelBackGround.Instance:FocusSpotMove(spot.transform.localPosition);
			ShowSelectView(self,spot);
			CS.OPSPanelProcessItem.canmapmove = false;
			CS.CommonAudioController.PlayUI("UI_selete_2");
		elseif selectHolderOrder == -1 then
			self:SelectMissionPanel(spot.holder.currentLabel);
			CS.OPSPanelProcessItem.canmapmove = true;
		else
			selectHolderOrder = -1;
			if CS.OPSPanelBackGround.Instance.oldscale ~= 0 then
				CS.OPSPanelBackGround.Instance:Reaset();
			end
			CS.OPSPanelProcessItem.canmapmove = true;
			CheckAllAnim(self);
		end
		return;	
	end
	self:SelectMissionSpot(spot);
end	
local canCancel = true;
local CancelMission = function(self)
	if not canCancel then
		return;
	end
	self:CancelMission();
	if missionScroll~= nil and not missionScroll:isNull() and missionScroll.activeSelf then
		CS.OPSPanelProcessItem.canmapmove = true;
		missionScroll:SetActive(false);
		CS.OPSPanelBackGround.Instance:Reaset();
		CS.CommonAudioController.PlayUI("UI_OPSCloseMissionInfo");
		CheckAllAnim(self);
	elseif self.campaionId == -46 then
		if selectHolderOrder ~= -1 then
			selectHolderOrder = -1;
			if CS.OPSPanelBackGround.Instance.oldscale ~= 0 then
				CS.OPSPanelBackGround.Instance:Reaset();
			end
			CheckAllAnim(self);
		end
	end
end

function CheckMissionProcessData(panelspot)--为每个点检查关卡条目
	local index = panelspot.id;
	--print("check"..index);
	if spot3dInfo[index] == nil  then
		return;
	end
	local datas = CS.System.Collections.Generic.List(CS.OPSProcessMissionInfo)();
	local missionIds = spot3dInfo[index];
	for i=0,missionIds.Count-1 do
		local ids = missionIds[i];
		local diffcluty = CS.OPSPanelController.difficulty;
		local missionid = ids[diffcluty];
		local mission = CS.GameData.listMission:GetDataById(missionid);
		if mission ~= nil then
			local data = CS.OPSProcessMissionInfo();
			data.mission = mission;
			data.panelspot = panelspot;
			data.diffcluty=-1;
			--print("添加Mission"..missionid);
			datas:Add(data);
		end
	end
	local initData_generic = xlua.get_generic_method(CS.CommonListController, 'InitData', 1)
	local initData = initData_generic(CS.OPSProcessMissionInfo)
	if id_ProcessObj[index] == nil or id_ProcessObj[index]:isNull() then
		id_ProcessObj[index] = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Pics/ActivityRes/MissionSpotMissionList_2021"));
		id_ProcessObj[index].transform:SetParent(panelspot.transform,false);
	end
	local listController = id_ProcessObj[index].transform:Find("MissionSpotMissionList/MissionLayout"):GetComponent(typeof(CS.CommonListController));
	initData(listController,datas);		
end

function PlayDrop()
	CS.CommonAudioController.PlayUI("UI_DropkickonMyDevil_Ente");
end

function CheckSpotAnim(panelspot)
	local mat = panelspot.transform:Find("layer0"):GetComponent(typeof(CS.UnityEngine.SpriteRenderer)).material;
	local lerp = CS.UnityEngine.Mathf.InverseLerp(-1000,8000,panelspot.transform.localPosition.x);
	local delay = CS.UnityEngine.Mathf.Lerp(0.5,1.0,lerp);
	local play = false;
	if not hasPlaySpots:Contains(panelspot.id) then	
		print("bofang"..panelspot.id);
		if 	firstEnter then
			if selectHolderOrder ~= -1 then
				selectHolderOrder = -1
			end
			CS.OPSPanelBackGround.Instance.movespotscale = CS.OPSPanelBackGround.Instance.scale;
			CS.OPSPanelBackGround.Instance:FocusSpotMove(panelspot.transform.localPosition);
			delay = delay +0.5;
		end	
		mat:SetFloat("_Alpha",0);
		mat:DOFloat(1,"_Alpha",0.3):SetDelay(delay);
		local layer0trans = panelspot.transform:Find("layer0");
		local layer1trans = panelspot.transform:Find("layer1");
		layer0trans.localPosition = CS.UnityEngine.Vector3(0,0,-2200);
		layer0trans:DOLocalMoveZ(-200,0.5):SetDelay(delay):SetEase(CS.DG.Tweening.Ease.InQuad);
		layer0trans:DOLocalMoveZ(-400,0.15):SetDelay(delay+0.5):SetEase(CS.DG.Tweening.Ease.OutCubic);
		layer0trans:DOLocalMoveZ(-200,0.15):SetDelay(delay+0.65):SetEase(CS.DG.Tweening.Ease.InCubic);
		--layer1trans.localPosition = CS.UnityEngine.Vector3(0,0,100);
		layer1trans.localScale = CS.UnityEngine.Vector3(0,0,0);
		--layer1trans:DOLocalMoveZ(0,0.4):SetDelay(delay+0.5);
		layer1trans:DOScale(CS.UnityEngine.Vector3(200,200,200),0.4):SetDelay(delay+0.5):SetEase(CS.DG.Tweening.Ease.OutBack);
		hasPlaySpots:Add(panelspot.id);
		CS.CommonController.Invoke(PlayDrop,delay+0.5,CS.OPSPanelController.Instance);
		play = true;
	else
		--print("chushi"..panelspot.id);
		mat:SetFloat("_Alpha",1);
		local layer0trans = panelspot.transform:Find("layer0");
		local layer1trans = panelspot.transform:Find("layer1");
		layer0trans.localPosition = CS.UnityEngine.Vector3(0,0,-200);
		--layer1trans.localPosition = CS.UnityEngine.Vector3(0,0,0);
		layer1trans.localScale = CS.UnityEngine.Vector3(200,200,200);
	end
	local shouldshow = panelspot.missionHolderOrder == selectHolderOrder;
	panelspot.canClick = true;
	panelspot.transform:Find("layer1").gameObject:SetActive(panelspot.CanShow);
	local mat = panelspot.transform:Find("layer1"):GetComponent(typeof(CS.UnityEngine.SpriteRenderer)).material;
	local mat1 = panelspot.transform:Find("layer1"):GetChild(0):GetComponent(typeof(CS.UnityEngine.SpriteRenderer)).material;
	if play then
		--panelspot.transform:Find("layer1").localPosition = CS.UnityEngine.Vector3(0,0,200);
		--panelspot.transform:Find("layer1"):DOLocalMoveZ(0,0.5):SetDelay(delay+0.5);
		mat:SetFloat("_Alpha",0);
		mat:DOFloat(1,"_Alpha",0.5):SetDelay(delay+0.5);
		mat1:SetFloat("_Alpha",0);
		mat1:DOFloat(1,"_Alpha",0.5):SetDelay(delay+0.5);
	else	
		--panelspot.transform:Find("layer1").localPosition = CS.UnityEngine.Vector3(0,0,0);
		mat:DOFloat(1,"_Alpha",0.5);
		mat1:DOFloat(1,"_Alpha",0.5);
	end
	local index = panelspot.id;
	if id_ProcessObj[index] ~= nil and not id_ProcessObj[index]:isNull() then
		local canvas = id_ProcessObj[index]:GetComponent(typeof(CS.UnityEngine.CanvasGroup));	
		if shouldshow then
			if play then
				canvas.alpha = 0;
				canvas.blocksRaycasts = true;
				canvas:DOFade(1,0.5):SetDelay(delay+0.5);
				id_ProcessObj[index].transform.localPosition = CS.UnityEngine.Vector3(100,-120,300);
				id_ProcessObj[index].transform:DOLocalMoveZ(0,0.5):SetDelay(delay+0.5);
			else
				canvas:DOFade(1,0.5);
				canvas.blocksRaycasts = true;
				id_ProcessObj[index].transform:DOLocalMoveZ(0,0.5);
			end
		else
			canvas:DOFade(0,0.5);
			canvas.blocksRaycasts = false;
			id_ProcessObj[index].transform:DOLocalMoveZ(300,0.5);
		end
	end
end
function StopUIAudio()
	CS.CommonAudioController.PlayUI("Stop_UI_loop");
end
function AlarmAudio()
	CS.CommonAudioController.PlayUI("UI_DropkickonMyDevil_Alarm");
end
local effect = nil;
local effect1 = nil;
function CheckAllAnim(self)--播放所有动画
	for i=0,CS.OPSPanelBackGround.Instance.all3dSpots.Count-1 do
		local spot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataByIndex(i);
		if spot.CanShow then
			CheckSpotAnim(spot);
		end
	end	
	for i=0,CS.OPSPanelBackGround.Instance.spotMissionHolders.Count-1 do
		local holder = CS.OPSPanelBackGround.Instance.spotMissionHolders:GetDataByIndex(i);
		local group = holder.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
		if group == nil or group:isNull() then
			group = holder.gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup));
		end	
		if selectHolderOrder == -1 then
			group:DOFade(1,0.5);
			group.blocksRaycasts = true;
		else
			if holder.order == selectHolderOrder then
				group:DOFade(1,0.5);
				group.blocksRaycasts = true;
			else
				group:DOFade(0,0.5);
				group.blocksRaycasts = false;
			end
		end
	end
	--print(self.background3d);
	local show = 0;
	if selectHolderOrder == 0 or selectHolderOrder == 9 then
		show = 1;
	elseif selectHolderOrder == 1 then
		show = 2;
	elseif selectHolderOrder == 2 or selectHolderOrder == 8 then
		show = 3;
	elseif selectHolderOrder == 3 or selectHolderOrder == 10 then
		show = 4;
	elseif selectHolderOrder == 4 then
		show = 5;
	elseif selectHolderOrder == 5 or selectHolderOrder == 7 then
		show = 6;
	elseif selectHolderOrder == 6 then
		show = 7;	
	end	
	change = CS.UnityEngine.PlayerPrefs.GetInt("MissionKeyChange",0);
	local has = CS.GameData.missionKeyNum:ContainsKey(1077000) and CS.GameData.missionKeyNum[1077000]>0;
	local shouldchange = has and not CS.GameData.missionKeyNum:ContainsKey(1077200);		
	for i=1,7 do
		local side = self.background3d.transform:Find("model/GameObject/tokyo_side0"..tostring(i)):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		local top = self.background3d.transform:Find("model/GameObject/tokyo_top0"..tostring(i)):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		local wall = self.background3d.transform:Find("model/GameObject/wall_0"..tostring(i)):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
		if i == show then
			top.material:DOFloat(-5, "_pos", 1);
			side.material:DOFloat(-5, "_pos", 1);
			for j=0,wall.materials.Length-1 do
				wall.materials[j]:DOFloat(1, "_Alpha", 1);	
			end
		else
			top.material:DOFloat(-20, "_pos", 1);
			side.material:DOFloat(-20, "_pos", 1);
			for j=0,wall.materials.Length-1 do
				wall.materials[j]:DOFloat(0, "_Alpha", 1);	
			end
		end		
		if change == 0 then
			top.material:SetFloat("_DissolveValue", 0);			
			side.material:SetFloat("_DissolveValue", 0);
			if shouldchange then
				top.material:DOFloat(1, "_DissolveValue", 5);
				side.material:DOFloat(1, "_DissolveValue", 5);										
			end
		elseif change == 1 then
			top.material:SetFloat("_DissolveValue", 1);			
			side.material:SetFloat("_DissolveValue", 1);
			if 	not shouldchange then
				top.material:DOFloat(0, "_DissolveValue", 5);
				side.material:DOFloat(0, "_DissolveValue", 5);		
			end
		end
	end
	local sideother = self.background3d.transform:Find("model/GameObject/tokyo_side"):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
	local topother = self.background3d.transform:Find("model/GameObject/tokyo_top"):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
	local ground = self.background3d.transform:Find("model/GameObject/tokyo_ground"):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
	if change == 0 then
		sideother.material:SetFloat("_DissolveValue", 0);
		topother.material:SetFloat("_DissolveValue", 0);
		ground.material:SetFloat("_DissolveValue", 0);
		CS.CommonAudioController.PlayBGM("GF_Jyashinchan_Story_Jinbouchou");									
		if shouldchange then
			if effect == nil then	
				effect = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Effect/Sbt_fire_lz"));
			end
			if effect1 == nil then	
				effect1 = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Effect/Sbt_fire_yan"));
				effect1.transform:SetParent(self.background3d.transform,false);
			end
			sideother.material:DOFloat(1, "_DissolveValue", 5);
			topother.material:DOFloat(1, "_DissolveValue", 5);		
			ground.material:DOFloat(1, "_DissolveValue", 5);
			change = 1;
			CS.CommonAudioController.PlayBGM(CS.AudioBGM.BGM_Empty);
			CS.CommonController.Invoke(AlarmAudio,3,CS.OPSPanelController.Instance);
			CS.CommonAudioController.PlayUI("UI_DropkickonMyDevil_Fire");									
		end
	elseif change == 1 then
		sideother.material:SetFloat("_DissolveValue", 1);
		topother.material:SetFloat("_DissolveValue", 1);
		ground.material:SetFloat("_DissolveValue", 1);
		CS.CommonAudioController.PlayUI("UI_DropkickonMyDevil_Fire");
		if effect == nil or effect:isNull() then	
			effect = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Effect/Sbt_fire_lz"));
		end	
		if effect1 == nil or effect1:isNull() then	
			effect1 = CS.UnityEngine.GameObject.Instantiate(CS.ResManager.GetObjectByPath("Effect/Sbt_fire_yan"));
			effect1.transform:SetParent(self.background3d.transform,false);
		end				
		if 	not shouldchange then
			sideother.material:DOFloat(0, "_DissolveValue", 5);
			topother.material:DOFloat(0, "_DissolveValue", 5);
			ground.material:DOFloat(0, "_DissolveValue", 5);
			change = 0;
			if 	effect ~= nil and not effect:isNull()  then
				local particle = effect:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem));
				for i=0,particle.Length-1 do
					particle[i].enableEmission = false;
				end	
			end
			if 	effect1 ~= nil and not effect1:isNull() then
				local particle = effect1:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem));
				for i=0,particle.Length-1 do
					particle[i].enableEmission = false;
				end	
			end
			CS.CommonAudioController.PlayBGM("GF_Jyashinchan_Story_Jinbouchou");
			CS.CommonController.Invoke(StopUIAudio,0.5,CS.OPSPanelController.Instance);
		else
			CS.CommonAudioController.PlayBGM(CS.AudioBGM.BGM_Empty);
			CS.CommonController.Invoke(AlarmAudio,3,CS.OPSPanelController.Instance);
		end
	end
	CS.UnityEngine.PlayerPrefs.SetInt("MissionKeyChange",change);
	CS.UnityEngine.PlayerPrefs.Save();
	--CS.UnityEngine.PlayerPrefs.SetInt("SelectHolerOrder",selectHolderOrder);
	--CS.UnityEngine.PlayerPrefs.Save();
end

local CheckAnim = function(self)
	self:CheckAnim();
	if self.campaionId == -46 then
		for i=0,CS.OPSPanelBackGround.Instance.all3dSpots.Count-1 do
			local spot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataByIndex(i);
			CheckMissionProcessData(spot);
		end
		CheckAllAnim(self);
	end
end

local RefreshCurrentDiffcluty = function(self)
	if self.campaionId == -46 then
		canCancel = false;
		if self.chooseSpot ~= nil then
			ShowSelectView(self,self.chooseSpot);
		end
	end
	self:RefreshCurrentDiffcluty();	
	self:CheckAnim();
	canCancel = true;
end
local RefreshUI = function(self)
	self:RefreshUI();
	--for i=0,CS.OPSPanelBackGround.Instance.all3dSpots.Count-1 do
	--	local spot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataByIndex(i);
	--	CheckMissionProcessData(spot);
	--end
	--CheckAllAnim(self);
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

local InitCameraBackground = function(self)
	self:InitCameraBackground();
	if self.cameraBackground ~= nil and not self.cameraBackground:isNull() then
		self.cameraBackground.transform.localPosition = CS.UnityEngine.Vector3(0,0,-100);
	end
end
local MoveSpine = function(self,spot)
	if self.campaionId == -46 then
		self:SelectMissionSpot(spot); 
		return;
	end
	self:MoveSpine(spot);
end

local InitData = function(self)
	self:InitData();
	if self.processList == nil or self.processList:isNull() then
		return;
	end
	if self.campaionId == -46 then
		local mids = CS.System.Collections.Generic.List(CS.System.Int32)();
		 for i=0,CS.OPSPanelBackGround.Instance.all3dSpots.Count-1 do
		 	local spot = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataByIndex(i);
			if spot3dInfo[spot.id] ~= nil then
				local missionIds = spot3dInfo[spot.id];
				if missionIds ~= nil then
					for l=0,missionIds.Count-1 do
						local ids = missionIds[l];
						for j=0,ids.Count-1 do
							local missionid = ids[j];
							local mission = CS.GameData.listMission:GetDataById(missionid);
							if mission ~= nil and not self:CannotShow(mission) and not mids:Contains(missionid) then
								mids:Add(missionid);
								local info = CS.OPSProcessMissionInfo();
								info.panelspot = spot;
								info.mission = mission;
								info.diffcluty = j;
								self.processInfos:Add(info);
							end
						end
					end
				end
			end	
		 end
		local initData_generic = xlua.get_generic_method(CS.CommonListController, 'InitData', 1)
		local initData = initData_generic(CS.OPSProcessMissionInfo)
		local listController = self.processList.transform:Find("MissionLayout"):GetComponent(typeof(CS.CommonListController));
		initData(listController,self.processInfos);	
	end
end
local MoveMissionHolder = function(self)
	if self.campaionId == -46  then		
		if not firstEnter then
			self:MoveMissionHolder();
		end
	else
		self:MoveMissionHolder();
	end
end
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',ShowContainerReturn)
util.hotfix_ex(CS.OPSPanelController,'ReturnContainer',ReturnContainer)
util.hotfix_ex(CS.OPSPanelController,'InitSpots',InitSpots)
util.hotfix_ex(CS.OPSPanelController,'InitCameraBackground',InitCameraBackground)
util.hotfix_ex(CS.OPSPanelController,'ShowAllMission',ShowAllMission)
util.hotfix_ex(CS.OPSPanelController,'Load',Load)
util.hotfix_ex(CS.OPSPanelController,'SelectMissionPanel',SelectMissionPanel)
util.hotfix_ex(CS.OPSPanelController,'SelectProcessInfo',SelectProcessInfo)
util.hotfix_ex(CS.OPSPanelController,'SelectMissionSpot',SelectMissionSpot)
util.hotfix_ex(CS.OPSPanelController,'RefreshCurrentDiffcluty',RefreshCurrentDiffcluty)
util.hotfix_ex(CS.OPSPanelController,'MoveSpine',MoveSpine)
util.hotfix_ex(CS.OPSPanelController,'CancelMission',CancelMission)
util.hotfix_ex(CS.OPSPanelController,'RefreshUI',RefreshUI)
util.hotfix_ex(CS.OPSPanelController,'CheckAnim',CheckAnim)
util.hotfix_ex(CS.OPSPanelController,'InitData',InitData)
util.hotfix_ex(CS.OPSPanelController,'MoveMissionHolder',MoveMissionHolder)

