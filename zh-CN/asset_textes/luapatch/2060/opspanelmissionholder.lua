local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionHolder)
local PlayMove = function(self)
	self:PlayMove();
	if  not self.canshow then
		local pos = CS.UnityEngine.Vector2(self.transform.localPosition.x,self.transform.localPosition.y);
		if CS.OPSPanelController.Instance.campaionId == -43 then
			pos = pos + CS.UnityEngine.Vector2(-1500,4000);
		end
		print("holder10移动镜头")
		CS.OPSPanelBackGround.Instance:Move(pos,true,0.3,0.3,true,CS.OPSPanelBackGround.Instance.mapminScale);
	end
end

local CheckNext = function(self)
	self:CheckNext();
	--local pos = CS.UnityEngine.Vector2(self.transform.localPosition.x,self.transform.localPosition.y);
	--print("holder18移动镜头")
	--CS.OPSPanelBackGround.Instance:Move(pos,true,0.3,0.3,true,CS.OPSPanelBackGround.Instance.mapminScale);	
end
local CheckWaveValues = function(self,forceChange)
	if self.currentMission == nil then
		return;
	end
	self:CheckWaveValues(forceChange);
end

local ShowLable = function(self)
	if not self.allowShow then
		return;
	end
	self:ShowLable();
end

local ShowSpots = function(self,play,delay)
	for i=0,self.spots3D.Count-1 do
		local spot = self.spots3D[i];
		if spot.mission ~= nil then
			if spot:MissionKeyChange() then
				if not CS.OPSPanelController.Instance.playHolders:Contains(self) then
					CS.OPSPanelController.Instance.playHolders:Add(self);
					print("添加MissionKeyChange"..spot.gameObject.name);
					goto continue;
				end
			elseif not CS.SpecialActivityController.missionid_State:ContainsKey(spot.missionId) then
				spot:Hide();
				if not CS.OPSPanelController.Instance.playHolders:Contains(self) then
					CS.OPSPanelController.Instance.playHolders:Add(self);
					print("添加missionid_State"..spot.gameObject.name);
					goto continue;
				end
			elseif CS.SpecialActivityController.missionid_State[spot.missionId].clocked ~= spot.mission.clocked then
				if not CS.OPSPanelController.Instance.playHolders:Contains(self) then
					CS.OPSPanelController.Instance.playHolders:Add(self);
					print("添加missionid_Clock"..spot.gameObject.name);
					goto continue;
				end
			end
		end 	
		if not spot.CanShow then
			spot:Hide();
		else
			spot:Show(play,delay);	
		end
		::continue::		
	end
end

local CheckPos = function(self)
	self.dir = CS.OPSPanelController.Instance.transform.position - self.transform.position;
	if self.dir.x>500 or self.dir.x<-500 or self.dir.y>200 or self.dir.y<-200 then
		self:HideLabel();
	else
		self:ShowLable();
	end
end

local PlayLabel1 = function(self)
	print("PlayLabel1")
	self.canshow = true;
	self:Show();
	self.currentLabel:PlayShow();
	self:ShowSpots(true);
end

util.hotfix_ex(CS.OPSPanelMissionHolder,'PlayMove',PlayMove)
util.hotfix_ex(CS.OPSPanelMissionHolder,'CheckWaveValues',CheckWaveValues)
util.hotfix_ex(CS.OPSPanelMissionHolder,'CheckNext',CheckNext)
util.hotfix_ex(CS.OPSPanelMissionHolder,'ShowLable',ShowLable)
util.hotfix_ex(CS.OPSPanelMissionHolder,'ShowSpots',ShowSpots)
util.hotfix_ex(CS.OPSPanelMissionHolder,'CheckPos',CheckPos)
--util.hotfix_ex(CS.OPSPanelMissionHolder,'PlayLabel1',PlayLabel1)