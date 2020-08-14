local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)
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
	local pos = CS.UnityEngine.Vector2(missionholder.transform.localPosition.x,missionholder.transform.localPosition.y);
	CS.OPSPanelBackGround.Instance:Move(pos,true,0.5,0,true,CS.OPSPanelBackGround.Instance.mapminScale,true,nil);
end
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelController,'MoveSpine',MoveSpine)
util.hotfix_ex(CS.OPSPanelController,'CheckSpineSpot',CheckSpineSpot)