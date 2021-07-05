local util = require 'xlua.util'
local panelController = require("2070/OPSPanelController")
xlua.private_accessible(CS.OPSPanelSpot)

local CanSpotShow = function(self)
	--print("检查order"..self.id);
	if spot3dInfo[self.id] ~= nil then
		local missionIds = spot3dInfo[self.id];
		if missionIds ~= nil then
			for i=0,missionIds.Count-1 do
				local ids = missionIds[i];
				local diffcluty = CS.OPSPanelController.difficulty;
				local missionid = ids[diffcluty];
				local mission = CS.GameData.listMission:GetDataById(missionid);
				if mission ~= nil then
					return true;
				end
			end
		end
	end	
	return  self.CanShow;
end

local Show = function(self,play,delay)
	if spot3dInfo[self.id] ~= nil then
		local show = self.CanShow;
		local select = selectHolderOrder == -1 or selectHolderOrder == self.missionHolderOrder;
		self.gameObject:SetActive(show);
		self.canClick = show;
		--local renders = self.transform:GetComponentsInChildren(typeof(CS.UnityEngine.SpriteRenderer));
		--if play then
		--	for i=0,renders.Length-1 do
		--		renders[i]:DOColor(CS.UnityEngine.Color(1,1,1,1), 0.5):SetDelay(delay);
		--	end
		--end
	else
		self:Show(play,delay);
	end
end
local Hide = function(self,play)
	if spot3dInfo[self.id] ~= nil then
		local show = self.CanShow;
		local select = selectHolderOrder == -1 or selectHolderOrder == self.missionHolderOrder;
		self.gameObject:SetActive(show);
		self.canClick = show;
	else
		self:Hide(play);
	end
end

local ClearCount = function(self)
	if spot3dInfo[self.id] ~= nil then
		local mids = CS.System.Collections.Generic.List(CS.System.Int32)();
		for i=0,spot3dInfo[self.id].Count-1 do
			local ids = spot3dInfo[self.id][i];
			for j=0,ids.Count -1 do
				local missionId = ids[j];
				local mission = CS.GameData.listMission:GetDataById(missionId);
				if mission~= nil and mission.winCount>0 and not mids:Contains(missionId) then
					mids:Add(missionId);
				end
			end
		end
		return 	mids.Count;
	end
	return self:ClearCount();
end

local AllCount = function(self)
	if spot3dInfo[self.id] ~= nil then
		local mids = CS.System.Collections.Generic.List(CS.System.Int32)();
		for i=0,spot3dInfo[self.id].Count-1 do
			local ids = spot3dInfo[self.id][i];
			for j=0,ids.Count -1 do
				local missionId = ids[j];
				if not mids:Contains(missionId) then
					mids:Add(missionId);
				end
			end
		end
		return 	mids.Count;
	end
	return self:AllCount();
end
util.hotfix_ex(CS.OPSPanelSpot,'get_CanShow',CanSpotShow)
util.hotfix_ex(CS.OPSPanelSpot,'Show',Show)
util.hotfix_ex(CS.OPSPanelSpot,'Hide',Hide)
util.hotfix_ex(CS.OPSPanelSpot,'ClearCount',ClearCount)
util.hotfix_ex(CS.OPSPanelSpot,'AllCount',AllCount)