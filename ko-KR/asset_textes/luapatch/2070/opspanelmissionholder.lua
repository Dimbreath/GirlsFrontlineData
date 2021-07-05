local util = require 'xlua.util'
local panelController = require("2070/OPSPanelController")
xlua.private_accessible(CS.OPSPanelMissionHolder)
local PlayMove = function(self)
	self:PlayMove();
	self:ShowLable();
	self.currentLabel.lastmissioninfo = nil;
	self.currentLabel:PlayShow();
end

local CanHolderShow = function(self)
	for i=0, self.spots3D.Count-1 do
		local order = self.spots3D[i].id;
		--print("order"..order);
		local missionIds = spot3dInfo[order];
		if missionIds ~= nil then
			for j=0,missionIds.Count-1 do
				local ids = missionIds[j];
				local diffcluty = CS.OPSPanelController.difficulty;
				local missionid = ids[diffcluty];
				--print("checkmissionid"..missionid);
				local mission = CS.GameData.listMission:GetDataById(missionid);
				if mission ~= nil then
					--print("解锁missionid"..missionid);
					return true;
				end
			end
		end
	end
	return  self.CanShow;
end

local ShowSpots = function(self,play,delay)
	if CS.OPSPanelController.Instance.campaionId == -46 then
		for i=0,self.spots3D.Count-1 do
			self.spots3D[i]:Show(play,delay);			
		end
	else
		self:ShowSpots(play,delay);
	end
end
util.hotfix_ex(CS.OPSPanelMissionHolder,'PlayMove',PlayMove)
util.hotfix_ex(CS.OPSPanelMissionHolder,'get_CanShow',CanHolderShow)
util.hotfix_ex(CS.OPSPanelMissionHolder,'ShowSpots',ShowSpots)

