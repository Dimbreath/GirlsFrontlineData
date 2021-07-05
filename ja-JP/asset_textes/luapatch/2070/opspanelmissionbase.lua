local util = require 'xlua.util'
local panelController = require("2070/OPSPanelController")
xlua.private_accessible(CS.OPSPanelMissionBase)
local ShowUnclockOther = function(self)
	self.lastmissioninfo = nil;
	self:ShowUnclockOther();
end

local RefreshUI = function(self)
	self:RefreshUI();
	if CS.OPSPanelController.Instance.campaionId == -46 then
		local image = self.transform:Find("Img_ChapterNum"):GetComponent(typeof(CS.ExImage));
		local spriteHolder = self.transform:Find("Img_ChapterNum"):GetComponent(typeof(CS.UGUISpriteHolder));
		local index = CS.UnityEngine.Mathf.Clamp(self.order,0,spriteHolder.listSprite.Count-1);
		image.sprite = spriteHolder.listSprite[index];		
		if spotInfo[self.order] ~= nil then
			local title = self.transform:Find("Tex_ChapterName"):GetComponent(typeof(CS.ExText));
			title.text = CS.Data.GetLang(spotInfo[self.order]);
		end
		local process = self.transform:Find("Tex_MissionProgress"):GetComponent(typeof(CS.ExText));
		local count=0;
		local all =0;
		for i=0, self.holder.spots3D.Count-1 do
			local order = self.holder.spots3D[i].id;
			local missionIds = spot3dInfo[order];
			if missionIds ~= nil then
				for j=0,missionIds.Count-1 do
					all = all + 1;
					--print("all"..all);
					local ids = missionIds[j];
					local diffcluty = CS.OPSPanelController.difficulty;
					local missionid = ids[diffcluty];
					local mission = CS.GameData.listMission:GetDataById(missionid);
					if mission ~= nil and mission.winCount>0 then						
						count = count+1;
					end
				end
			end
		end
		process.text = tostring(count).."/"..tostring(all);
		--local backimage = self.transform:Find("Img_Background"):GetComponent(typeof(CS.ExImage));
		--if self.holder.order == selectHolderOrder then
		--	backimage.color = CS.UnityEngine.Color.blue;
		--else
		--	backimage.color = CS.UnityEngine.Color.white;
		--end	
	end
end

local Awake = function(self)
	self:Awake();
	if CS.OPSPanelController.Instance.campaionId == -46 then
		local btn = self.transform:Find("Btn_ChapterPanel"):GetComponent(typeof(CS.ExButton));
		btn:AddOnClick(function()
			CS.OPSPanelController.Instance:SelectMissionPanel(self);
		end);	
	end
end

local InitData = function(self,data)
	local key = CS.System.Collections.Generic.List(CS.System.Int32)();
	local count = {};
	for i=0,data.missionIds.Length-1 do
		local missionid = data.missionIds[i];
		local mission = CS.GameData.listMission:GetDataById(missionid);
		if mission ~= nil then
			--print("check"..missionid);
			local data = mission.Drop_item_Mullt:GetEnumerator();
			while data:MoveNext() do
				local order = data.Current.Key;
				local num = data.Current.Value; 
				if not key:Contains(order) then
					key:Add(order);
				end
				if count[order] == nil then
					count[order] = num;
				else
					count[order] = CS.UnityEngine.Mathf.Max(count[order],num);
				end
				--print(mission.missionInfo.id.."当前最大值order"..order.."num"..num);
			end
		end
	end
	for i=0,data.missionIds.Length-1 do
		local mission = CS.GameData.listMission:GetDataById(data.missionIds[i]);
		if mission ~= nil then
			for i=0,key.Count-1 do
				if not mission.Drop_item_Mullt:ContainsKey(key[i]) then
					mission.Drop_item_Mullt:Add(key[i],count[key[i]]);
				else
					mission.Drop_item_Mullt[key[i]] = count[key[i]];
				end
			end
		end
	end
	self:InitData(data);
end

util.hotfix_ex(CS.OPSPanelMissionBase,'RefreshUI',RefreshUI)
util.hotfix_ex(CS.OPSPanelMissionBase,'ShowUnclockOther',ShowUnclockOther)
util.hotfix_ex(CS.OPSPanelMissionBase,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelMissionBase,'InitData',InitData)

