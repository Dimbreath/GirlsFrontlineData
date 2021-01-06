local util = require 'xlua.util'
xlua.private_accessible(CS.AutoFormationTeamNodeController)
local myAutoTeamUse = function(self)
		local dic = CS.GameData.listAutoFormation[CS.AutoFormationShowTeamController.Instance.currentSelectedIndex].locationGunMap;
		local readyGunList = CS.System.Collections.Generic.List(CS.GF.Battle.Gun)();
		for i = 0, CS.FormationSettingController.Instance.listTile.Count - 1, 1 do
			local tile = CS.FormationSettingController.Instance.listTile[i];
			if(tile.gun ~= nil) then
				readyGunList:Add(tile.gun)
			end
		end
		for i = 0, CS.FormationSettingController.Instance.listTile.Count - 1, 1 do
			local tile = CS.FormationSettingController.Instance.listTile[i];
			if(tile.gun == nil) then
                local selectGun = nil;
				local gunInfoList = CS.System.Collections.Generic.List(CS.GunInfo)();
                if (dic:ContainsKey(tile.pos)) then
                    gunInfoList = dic[tile.pos];
				end
				local selectedTempGuns = CS.System.Collections.Generic.List(CS.GF.Battle.Gun)();
				for j = 0, gunInfoList.Count - 1, 1 do
					local gunInfo = gunInfoList[j];
					local ssss = CS.GameData.listGun;
					local tempGuns = CS.GameData.listGun:FindAll(
					function(s) 
						local tempsId = s.info.id;
						if(s.info.id > 20000) then
							tempsId = tempsId - 20000;
						end
						return 
						(s.teamId == 0 or s.teamId == CS.FormationSettingController.Instance.teamId) 
					and (s.info.id == gunInfo.id) 
					and (s.status == CS.GunStatus.normal) 
					and (readyGunList:Exists(
								function(ss) 
									local tempssId = ss.info.id;
									if(tempssId > 20000) then
										tempssId = tempssId - 20000;
									end
									return tempssId == tempsId 
								end) == false) 
					end
					);
					if(tempGuns.Count > 0) then
						local tempTables = ListToTable(tempGuns)
						table.sort(tempTables, sortGT);
						selectedTempGuns:Add(tempTables[1]);
					end
				end
                if(selectedTempGuns.Count > 1) then
					local tempTables = ListToTable(selectedTempGuns)
					table.sort(tempTables, sortGT);
                    --selectedTempGuns.Sort(ComparerAutoFormation);
                    selectGun = tempTables[1];
                elseif(selectedTempGuns.Count > 0) then
                    selectGun = selectedTempGuns[0];
				end
                if(selectGun ~= nil) then
                    readyGunList:Add(selectGun);
                    selectGun.pos = tile.pos;
                    CS.FormationSettingController.Instance:Init(selectGun);
                    local posId = selectGun.pos:ToId();
				end				
			else
				readyGunList:Add(tile.gun)
			end
		end
        CS.FormationSettingController.Instance.gameObject:SetActive(true);
        self:RefreshGunNumData();
        self:RefreshData();
        CS.FormationSettingController.Instance:AnysicFormationData();
        CS.FormationSettingController.Instance:RefreshTileUI();
end
function sortGT(left, right)
	if (left.id ~= -1) then
        if (right.id ~= -1) then
            local leftPoint = left:GetPoint(true, true,false, nil,false,nil);
            local rightPoint = right:GetPoint(true, true,false, nil, false,nil);
            if (leftPoint ~= rightPoint) then
                return leftPoint > rightPoint;
            else
                if (left.level ~= right.level) then
					return left.level > right.level;
				elseif (leftPoint ~= rightPoint) then
					return leftPoint > rightPoint
				elseif (left.info.rank_display ~= right.info.rank_display) then
					return left.info.rank_display > right.info.rank_display;
				else
					if (left.info.id ~= right.info.id) then
						return left.info.id > right.info.id;
					else
						return false;
					end
				end
			end
        else
            return true;
        end
    else
        if (right.id ~= -1) then
            return true;
        else
            return false;
		end
	end
end
function ListToTable(CSharpList)
    --将C#的List转成Lua的Table
    local list = {}
    if CSharpList then
        local index = 1
        local iter = CSharpList:GetEnumerator()
        while iter:MoveNext() do
            local v = iter.Current
            list[index] = v
            index = index + 1
        end
    else
        print("Error,CSharpList is null")
    end
    return list
end

util.hotfix_ex(CS.AutoFormationTeamNodeController,'AutoTeamUse',myAutoTeamUse)