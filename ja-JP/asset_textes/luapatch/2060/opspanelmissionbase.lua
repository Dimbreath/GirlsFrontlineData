local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionBase)

local PlayShow = function(self)
	self.currentMission = nil;
	self:RefreshUI();
	if self.holder.allowShow then
		--print(self.holder.allowShow);
		self:ActiveTween(true);
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
util.hotfix_ex(CS.OPSPanelMissionBase,'PlayShow',PlayShow)
util.hotfix_ex(CS.OPSPanelMissionBase,'InitData',InitData)