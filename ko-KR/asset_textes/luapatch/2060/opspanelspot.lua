local util = require 'xlua.util'
local panelController = require("2060/OPSPanelController")
xlua.private_accessible(CS.OPSPanelSpot)
xlua.private_accessible(CS.OPSPanelController)

local Show = function(self,play,delay)
	if self.mission == nil then
		self:Hide();
		return;
	end
	if self.holder == nil then
		self.canClick = true;
	end
	if play and self.difficulty ~= -1 and CS.OPSPanelController.difficulty ~= self.difficulty then
		--CS.OPSPanelController.Instance:SelectDiffcluty();
		CS.OPSPanelController.difficulty = self.difficulty;
		CS.OPSPanelController.diffclutyRecord = self.difficulty;
		
		for i=0,CS.OPSPanelController.diffcluteNum-1 do			
			local child = CS.OPSPanelController.Instance.btnTitle.transform:Find(tostring(i));
			if child ~= nil then
				child.gameObject:SetActive(i == CS.OPSPanelController.difficulty);
			end
		end
		CS.OPSPanelController.Instance:RefreshUI();
		if CS.OPSPanelController.Instance.background3d ~= nil and CS.OPSPanelController.Instance.campaionId == -41 then
			local pos = CS.OPSPanelBackGround.Instance.modelPos+CS.UnityEngine.Vector3(0,0,-550*CS.OPSPanelController.difficulty);
			CS.OPSPanelController.Instance.background3d.transform:DOLocalMove(pos,0.5);
		end
		delay = delay + 0.5;
		--local btn = CS.OPSPanelController.Instance.btnTitle;
		--if btn ~= nil then
			--local pos = CS.UnityEngine.Vector3(btn.transform.position.x,btn.transform.position.y,btn.transform.position.z);
		--	self.transform:DOMove(btn.transform.position,1):SetDelay(1);
		--	self.transform:DOScale(CS.UnityEngine.Vector3.zero,0.5):SetDelay(1.5);
		--	self.path.BezierRenderer.material:DOFloat(0,"_Alpha",0.5):SetDelay(1);
		--end
	end
	--print(self.missionId);
	if play then
		self:Hide();
	end
	self:Show(play,delay);
	if play and canFind and CS.OPSPanelController.Instance.panelallMission.Count == 0 then
		local pos = CS.UnityEngine.Vector2(self.transform.localPosition.x,self.transform.localPosition.y);
		pos = pos + CS.UnityEngine.Vector2(-4000,-1000);
		print("spot41移动镜头")
		CS.OPSPanelBackGround.Instance:Move(pos,true,0.3,0,true,CS.OPSPanelBackGround.Instance.mapminScale,true,nil);
	end
	print("show"..tostring(self.missionId)..self.spineCode)
	if self.spineCode == spinename0 then
		if spine0 ~= nil and not spine0:isNull() then
			print("spine0"..tostring(play))
			if play then
				spine0.transform.localScale = CS.UnityEngine.Vector3.zero;
				spine0.transform:DOScale(CS.UnityEngine.Vector3(250,250,1),0.5);
			else
				spine0.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
			end
		end
	elseif self.spineCode == spinename1 then
		if spine1 ~= nil and not spine1:isNull() then
			print("spine1"..tostring(play))
			if play then
				spine1.transform.localScale = CS.UnityEngine.Vector3.zero;
				spine1.transform:DOScale(CS.UnityEngine.Vector3(250,250,1),0.5);
			else
				spine1.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
			end
		end	
	elseif self.spineCode == spinename2 then
		if spine2 ~= nil and not spine2:isNull() then
			print("spine2"..tostring(play))
			if play then
				spine2.transform.localScale = CS.UnityEngine.Vector3.zero;
				spine2.transform:DOScale(CS.UnityEngine.Vector3(250,250,1),0.5);
			else
				spine2.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
			end
		end
	elseif self.spineCode == spinename3 then
		if spine3 ~= nil and not spine3:isNull() then
			if play then
				spine3.transform.localScale = CS.UnityEngine.Vector3.zero;
				spine3.transform:DOScale(CS.UnityEngine.Vector3(250,250,1),0.5);
			else
				spine3.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
			end
		end	
	elseif self.spineCode == spinename4 then
		if spine4 ~= nil and not spine4:isNull() then
			if play then
				spine4.transform.localScale = CS.UnityEngine.Vector3.zero;
				spine4.transform:DOScale(CS.UnityEngine.Vector3(250,250,1),0.5);
			else
				spine4.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
			end
		end
	elseif self.spineCode == spinename5 then
		if spine5 ~= nil and not spine5:isNull() then
			if play then
				spine5.transform.localScale = CS.UnityEngine.Vector3.zero;
				spine5.transform:DOScale(CS.UnityEngine.Vector3(250,250,1),0.5);
			else
				spine5.transform.localScale = CS.UnityEngine.Vector3(250,250,1);
			end
		end
	end	
	if not CS.SpecialActivityController.missionid_State:ContainsKey(self.missionId) then
		return;
	end
	local lastspot = spot_lastspot[self.missionId];
	if lastspot ~= nil then
		print("检查上个点"..tostring(lastspot).."当前点"..tostring(self.missionId));
		local lastspot3d = CS.OPSPanelBackGround.Instance.all3dSpots:GetDataById(lastspot);
		if  lastspot3d == nil then
			return;
		end
		local id = CS.OPSPanelBackGround.Instance.all3dSpots:GetList():IndexOf(lastspot3d);
		if routeInfo[id] == nil then
			return;
		end
		print("上个点"..tostring(lastspot).."当前点"..tostring(self.missionId));
		if missionPath[lastspot] == nil or missionPath[lastspot]:isNull() then
			print("动态实例化线条"..tostring(lastspot));
			local obj = CS.UnityEngine.Object.Instantiate(self.path.gameObject);
			local path = obj:GetComponent(typeof(CS.OPSPanelLine));
			obj.transform:SetParent(CS.OPSPanelBackGround.Instance.CurveParent, false);
			obj.gameObject:SetActive(false);
			obj.name = tostring(lastspot);
			path.Point0 = lastspot3d.transform;
			path.Point1 = self.transform;
			path.missionEdit0 = nil;
			path.Ctrol_Point0.gameObject:SetActive(false);
			path.Ctrol_Point1.gameObject:SetActive(false);
			path.currentPathType = CS.OPSPanelLine.Direction.poliline;
			path.BezierRenderer.startWidth = routeInfo[id][3];
			path.BezierRenderer.endWidth = routeInfo[id][4];
			path.BezierRenderer.startColor = routeInfo[id][5];
			path.BezierRenderer.endColor = routeInfo[id][5];
			path.BezierRenderer.material:SetFloat("_AddDirection", 1);
			path.BezierRenderer.material:SetColor("_AddColor", routeInfo[id][6]);
			for i = 1,#routeInfo[id][7] do				
				local point = CS.UnityEngine.Object.Instantiate(path.Ctrol_Point0.gameObject);
				point.transform:SetParent(path.transform:Find("Point"), false);
				point.transform.localPosition = routeInfo[id][7][i];
				path.otherPoints:Add(point.transform);
				point.gameObject:SetActive(false);				
			end
			path:DrawCurve();
			path.BezierRenderer.material:SetFloat("_Control", 0);
			path.BezierRenderer.material:SetFloat("_AddControl", 0);
			missionPath[lastspot] = path;
		end
		if self.mission.winCount>0 then
			if play then
				missionPath[lastspot].BezierRenderer.material:DOFloat(1, "_AddControl", 0.5);	
			else
				missionPath[lastspot].BezierRenderer.material:SetFloat("_AddControl", 1);
			end
		else
			missionPath[lastspot].BezierRenderer.material:SetFloat("_AddControl", 0);
		end
		if play then
			print("显示线条"..lastspot)
			missionPath[lastspot].gameObject:SetActive(true);
			missionPath[lastspot]:PlayShow(0.5, delay);
		else
			print("显示线条"..lastspot)
			missionPath[lastspot].gameObject:SetActive(true);
			missionPath[lastspot].BezierRenderer.material:SetFloat("_Control", 1);
		end
	end
end

local Hide = function(self,play)
	--print("隐藏"..self.gameObject.name)
	self:Hide(play);
	--local lastspot = spot_lastspot[self.missionId];
	--if lastspot ~= nil and missionPath[lastspot] ~= nil then
	--	print("隐藏线条"..lastspot)
	--	missionPath[lastspot].gameObject:SetActive(false);
	--end
	
	if self.spineCode == spinename0 then
		if spine0 ~= nil and not spine0:isNull() then
			spine0.transform.localScale = CS.UnityEngine.Vector3.zero;
		end
	elseif self.spineCode == spinename1 then
		if spine1 ~= nil and not spine1:isNull() then
			spine1.transform.localScale = CS.UnityEngine.Vector3.zero;
		end	
	elseif self.spineCode == spinename2 then
		if spine2 ~= nil and not spine2:isNull() then
			spine2.transform.localScale = CS.UnityEngine.Vector3.zero;
		end
	elseif self.spineCode == spinename3 then
		if spine3 ~= nil and not spine3:isNull() then
			spine3.transform.localScale = CS.UnityEngine.Vector3.zero;
		end	
	elseif self.spineCode == spinename4 then
		if spine4 ~= nil and not spine4:isNull() then
			spine4.transform.localScale = CS.UnityEngine.Vector3.zero;
		end
	elseif self.spineCode == spinename5 then
		if spine5 ~= nil and not spine5:isNull() then
			spine5.transform.localScale = CS.UnityEngine.Vector3.zero;
		end
	end
	local lastspot = spot_lastspot[self.missionId];
	if lastspot ~= nil then
		if missionPath[lastspot] ~= nil and not missionPath[lastspot]:isNull() then
			missionPath[lastspot].gameObject:SetActive(false);
		end
	end
end

local CreateSpine = function(self,play)
	--local name = Getspinename0();
	--print(self.spineCode);
	if self.spineCode == spinename0 then
		CS.OPSPanelController.Instance.spine = spine0;
		CS.OPSPanelController.Instance.currentSpot = spot0;
	elseif self.spineCode == spinename1 then
		CS.OPSPanelController.Instance.spine = spine1;
		CS.OPSPanelController.Instance.currentSpot = spot1;
	elseif self.spineCode == spinename2 then
		CS.OPSPanelController.Instance.spine = spine2;
		CS.OPSPanelController.Instance.currentSpot = spot2;
	elseif self.spineCode == spinename3 then
		CS.OPSPanelController.Instance.spine = spine3;
		CS.OPSPanelController.Instance.currentSpot = spot3;
	elseif self.spineCode == spinename4 then
		CS.OPSPanelController.Instance.spine = spine4;
		CS.OPSPanelController.Instance.currentSpot = spot4;
	elseif self.spineCode == spinename5 then
		CS.OPSPanelController.Instance.spine = spine5;
		CS.OPSPanelController.Instance.currentSpot = spot5;
	else
		return;
	end
	self:CreateSpine(play);
	if self.spineCode == spinename0 then
		spine0 = CS.OPSPanelController.Instance.spine;
		spot0 = CS.OPSPanelController.Instance.currentSpot;
	elseif self.spineCode == spinename1 then
		spine1 = CS.OPSPanelController.Instance.spine;
		spot1 = CS.OPSPanelController.Instance.currentSpot;
	elseif self.spineCode == spinename2 then
		spine2 = CS.OPSPanelController.Instance.spine;
		spot2 = CS.OPSPanelController.Instance.currentSpot;
	elseif self.spineCode == spinename3 then
		spine3 = CS.OPSPanelController.Instance.spine;
		spot3 = CS.OPSPanelController.Instance.currentSpot;
	elseif self.spineCode == spinename4 then
		spine4 = CS.OPSPanelController.Instance.spine;
		spot4 = CS.OPSPanelController.Instance.currentSpot;
	elseif self.spineCode == spinename5 then
		spine5 = CS.OPSPanelController.Instance.spine;
		spot5 = CS.OPSPanelController.Instance.currentSpot;
	end	
end

local MoveSpine = function(self,target,handle)	
	if self.spineCode == spinename0 then
		CS.OPSPanelController.Instance.spine = spine0;
		CS.OPSPanelController.Instance.currentSpot = spot0;
	elseif self.spineCode == spinename1 then
		CS.OPSPanelController.Instance.spine = spine1;
		CS.OPSPanelController.Instance.currentSpot = spot1;
	elseif self.spineCode == spinename2 then
		CS.OPSPanelController.Instance.spine = spine2;
		CS.OPSPanelController.Instance.currentSpot = spot2;
	elseif self.spineCode == spinename3 then
		CS.OPSPanelController.Instance.spine = spine3;
		CS.OPSPanelController.Instance.currentSpot = spot3;
	elseif self.spineCode == spinename4 then
		CS.OPSPanelController.Instance.spine = spine4;
		CS.OPSPanelController.Instance.currentSpot = spot4;
	elseif self.spineCode == spinename5 then
		CS.OPSPanelController.Instance.spine = spine5;
		CS.OPSPanelController.Instance.currentSpot = spot5;
	end
	print("移动到目标点"..tostring(target.missionId));	
	self:MoveSpine(target,handle);
	if target.spineCode == spinename0 then
		spot0 = target;
	elseif target.spineCode == spinename1 then
		spot1 = target;
	elseif target.spineCode == spinename2 then
		spot2 = target;
	elseif target.spineCode == spinename3 then
		spot3 = target;
	elseif target.spineCode == spinename4 then
		spot4 = target;
	elseif target.spineCode == spinename5 then
		spot5 = target;
	end	
	if self.spineCode == spinename0 then
		--CS.OPSPanelController.spineStayMission[-1] = self.missionId;
		--print("-1记录当前位置"..self.missionId)
	elseif self.spineCode == spinename1 then
		--CS.OPSPanelController.spineStayMission[-2] = self.missionId;
		--print("-2记录当前位置"..self.missionId)
	elseif self.spineCode == spinename2 then
		--CS.OPSPanelController.spineStayMission[-3] = self.missionId;
		--print("-3记录当前位置"..self.missionId)
	elseif self.spineCode == spinename3 then
		--CS.OPSPanelController.spineStayMission[-4] = self.missionId;
		--print("-3记录当前位置"..self.missionId)
	elseif self.spineCode == spinename4 then
		--CS.OPSPanelController.spineStayMission[-5] = self.missionId;
		--print("-3记录当前位置"..self.missionId)
	elseif self.spineCode == spinename5 then
		--CS.OPSPanelController.spineStayMission[-6] = self.missionId;
		--print("-3记录当前位置"..self.missionId)
	end	
end

local get_CanShow = function(self)
	if self.holder ~= nil and self.holder.currentMission == nil then
		return false;
	end
	if self.mission == nil then
		return false;
	end	
	if self.difficulty == -1 then
		return true;
	end
	return self.difficulty == CS.OPSPanelController.difficulty;
end

local CheckSpinePos = function(self)
	
end
util.hotfix_ex(CS.OPSPanelSpot,'Show',Show)
util.hotfix_ex(CS.OPSPanelSpot,'Hide',Hide)
util.hotfix_ex(CS.OPSPanelSpot,'get_CanShow',get_CanShow)
util.hotfix_ex(CS.OPSPanelSpot,'CreateSpine',CreateSpine)
util.hotfix_ex(CS.OPSPanelSpot,'MoveSpine',MoveSpine)
util.hotfix_ex(CS.OPSPanelSpot,'CheckSpinePos',CheckSpinePos)

