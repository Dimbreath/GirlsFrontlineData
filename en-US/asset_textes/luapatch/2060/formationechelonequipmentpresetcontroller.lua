local util = require 'xlua.util'
xlua.private_accessible(CS.FormationEchelonEquipmentPresetController)
xlua.private_accessible(CS.Equip)
local equipWantGunSoltMap = CS.System.Collections.Generic.Dictionary(CS.System.Int32, CS.System.Int64)()
local pa = nil;
myNextEquip = function(self, gun, gunLocation,slotIndex,dontDestory)
	if (slotIndex == 4) then
		if (self.currntGunLocationIndex == 4) then
			self.currntGunLocationIndex = 0;
			self:EndChangeEquip(dontDestory);
			if(self.needShowTips) then
				CS.CommonController.LightMessageTips(CS.Data.GetLang(270049));
				return;
			end	
		else
			myChangeEquip(self, self.currntGunLocationIndex + 1, self.currentSelectForce);
		end
	else
		local eq = nil;
		if (gun ~= nil) then
			if (equipWantGunSoltMap:ContainsKey(slotIndex)) then
				local eqId = equipWantGunSoltMap[slotIndex];
				eq = gun.wantEquipList:Find(function(s) return s.id == eqId end);
			end
		end
		myChangeEquip(self, gun, eq, slotIndex, gunLocation, slotIndex, self.currentSelectForce);
	end
end
myChangeEquip = function(self, ...)
	local length = select('#', ...);
    if length == 6 then
        local gun = select(1, ...);
        local eq = select(2, ...);
        local i = select(3, ...);
        local gunLocation = select(4, ...);
        local slotIndex = select(5, ...);
		local currentSelectedForce = select(6, ...);
		self.currentSelectForce = currentSelectedForce;
		for i = 0, gun.equipList.Count - 1, 1 do
			local myEquip = gun.equipList[i];
			if(CS.GameData.equipRealGunSoltMap:ContainsKey(myEquip.id)) then
                myEquip.slotWithGun = CS.GameData.equipRealGunSoltMap[myEquip.id];  
			end
		end
        if eq ~= nil then
			if self.isSmartOn == true then
                if (CS.GameData.equipRealGunMap:ContainsKey(eq.id)) then
                    local gunid = CS.GameData.equipRealGunMap[eq.id];
                    local g = CS.GameData.listGun:GetDataById(gunid);
                    if (g.id ~= gun.id) then
						local tempEquips = CS.System.Collections.Generic.List(CS.Equip)();
                        tempEquips:AddRange(CS.GameData.listEquip:GetList());
						for k,v in pairs(CS.GameData.equipRealGunMap) do
							local equipId = k;
                            local userId = v;
                            for c = tempEquips.Count - 1, 0, -1 do
                                if(tempEquips[c].id == equipId and tempEquips[c].gunId ~= 0 and tempEquips[c].gunId ~= g.id) then
                                    tempEquips:RemoveAt(c);
                                    break;
								end
                            end
						end
                        local resultEquips = tempEquips:FindAll(
							function(ss)
								return CS.Ratio.arrEquipLevelRankLimit[CS.System.Convert.ToInt32(ss.info.rank)] <= gun.level and CS.GameData.equipRealGunMap:ContainsKey(ss.id) == false and ss.info.auto_select_id == eq.info.auto_select_id and (ss.info.listFitGunInfoId.Count == 0 or ss.info.listFitGunInfoId:Contains(g.info.id));
							end
						);
                        if (resultEquips.Count == 0) then
                            self.needShowTips = true;
							myRemoveList(self, gun, eq, gunLocation, slotIndex);
                            return;
                        else
							local resultTables = ListToTable(resultEquips)
							pa = CS.FormationEchelonEquipmentPresetController.Instance.param;
							if pcall(function() 
								table.sort(resultTables, sortGT)
							end) then
							
							end
                            local spEquip = resultTables[1];
                            spEquip.slotWithGun = eq.slotWithGun;
                            eq = spEquip;
						end
					end
                end
			else
                if (CS.GameData.equipRealGunMap:ContainsKey(eq.id)) then
                    local gunid = CS.GameData.equipRealGunMap[eq.id];
                    local g = CS.GameData.listGun:GetDataById(gunid);
                    if (g.status == CS.GunStatus.mission or g.status == CS.GunStatus.operation) then
						myRemoveList(self, gun, eq, gunLocation, slotIndex);
                        return;
                    end
                end
                local currentEq = self.equipGunMap:ContainsKey(eq.id); 
                if (currentEq and self.currentSelectForce == false) then
                    eq.gunId = self.equipGunMap[eq.id]; 
                    eq.gun = CS.GameData.listGun:GetDataById(self.equipGunMap[eq.id]);
                    eq.slotWithGun = CS.GameData.equipRealGunSoltMap[eq.id]; 
                    local idEquip = eq.gun.equipList:Find(function(s) return s.id == eq.id end);
                    if (idEquip ~= nil) then
						myRemoveList(self, gun, eq, gunLocation, slotIndex);
                        return;
                    else
                        local slotEquip = eq.gun.equipList:Find(function(s) return s.slotWithGun == eq.slotWithGun end);
                        if (slotEquip ~= nil) then
                            eq.gun.equipList:Remove(slotEquip);
                            slotEquip.gun = nil;
                            slotEquip.gunId = 0;
                            slotEquip.slotWithGun = 0;
						end
                        eq.gun.equipList:Add(eq);
						myRemoveList(self, gun, eq, gunLocation, slotIndex);
                        return;
					end
				end
			end
			local wantEquip = gun.equipList:Find(function(s) return s.id == eq.id end);
            local wantEquipSlot = slotIndex;
            if (wantEquip ~= nil) then
				for k,v in pairs(equipWantGunSoltMap) do
					if(v == wantEquip.id) then
						wantEquipSlot = k;
						break;
					end
				end
            end
            if (gun.equipList:Exists(function(s) return s.slotWithGun == wantEquipSlot and s.id == eq.id end)) then
				myRemoveList(self, gun, eq, gunLocation, slotIndex);
            elseif(gun.equipList:Exists( function(s) return s.id == eq.id end)) then
                local oldEq = gun.equipList:Find(function(s) return s.id == eq.id end);
                gun:RequestChangeEquip(
					function()
						if (gun.equipList:Exists(function(s) return wantEquipSlot == s.slotWithGun end)) then
                            local ooldEq = gun.equipList:Find(function(s) return s.slotWithGun == wantEquipSlot end);
                            gun:RequestChangeEquip(
								function()
									gun:RequestChangeEquip(
									function() 
										myRemoveList(self, gun, eq, gunLocation, slotIndex);
									end
									, eq, true, wantEquipSlot);
								end
                                , ooldEq, false, wantEquipSlot);
                        else
                            gun:RequestChangeEquip(
								function()
									myRemoveList(self, gun, eq, gunLocation, slotIndex);
								end
                                , eq, true, wantEquipSlot);
                        end
					end
					, oldEq, false, oldEq.slotWithGun);
            else
                if (gun.equipList:Exists(function(s) return wantEquipSlot == s.slotWithGun end)) then
                    local oldEq = gun.equipList:Find(function(s) return s.slotWithGun == wantEquipSlot end);
                    gun:RequestChangeEquip(
						function()
							if(gun.equipList:Exists(function(s) return s.info.type == eq.info.type end)) then
								local slot = gun.equipList:Find(function(s) return s.info.type == eq.info.type end).slotWithGun;
								gun:RequestChangeEquip(
									function()
										gun:RequestChangeEquip(
										function() 
											myRemoveList(self, gun, eq, gunLocation, slotIndex); 
										end , eq, true, wantEquipSlot);
									end
									, eq, false, slot)
							else
								gun:RequestChangeEquip(
									function()
										myRemoveList(self, gun, eq, gunLocation, slotIndex);
									end
									, eq, true, wantEquipSlot);
							end
						end
                        , oldEq, false, wantEquipSlot);
                else
                    if (gun.equipList:Exists(function(s) return s.id == eq.id end)) then
                        local slot = gun.equipList:Find(function(s) return s.id == eq.id end).slotWithGun;
                        gun:RequestChangeEquip(
							function()
								gun:RequestChangeEquip(
									function()
										myRemoveList(self, gun, eq, gunLocation, slotIndex);
									end
                                    , eq, true, wantEquipSlot);
							end
                            , eq, false, slot);
                    else
						if(gun.equipList:Exists(function(s) return s.info.type == eq.info.type end)) then
							local slot = gun.equipList:Find(function(s) return s.info.type == eq.info.type end).slotWithGun;
							gun:RequestChangeEquip(
							function()
								gun:RequestChangeEquip(
								function() 
									myRemoveList(self, gun, eq, gunLocation, slotIndex); 
								end , eq, true, wantEquipSlot);
							end
							, eq, false, slot)
						else
							gun:RequestChangeEquip(
								function()
									myRemoveList(self, gun, eq, gunLocation, slotIndex);
								end
								, eq, true, wantEquipSlot);
						end
					end
                end
			end
        else
            if (gun ~= nil and gun.equipList:Exists(function(s) return s.slotWithGun == i end)) then
                local oldEq = gun.equipList:Find(function(s) return s.slotWithGun == i end);
                gun:RequestChangeEquip(
					function()
						myRemoveList(self, gun, eq, gunLocation, slotIndex);
					end
                    , oldEq, false, i);
            else
				myRemoveList(self, gun, eq, gunLocation, slotIndex);
			end
        end
    else
		local gunLocation = select(1, ...);
        local currentSelectedForce = select(2, ...);
		
		self.currentSelectForce = currentSelectedForce;
		self.currntGunLocationIndex = gunLocation;
		local gunLabel = CS.FormationController.Instance.arrCharacterLabel[gunLocation];
		if (gunLabel.gun ~= nil and self._data.arrGun[gunLocation] ~= nil) then
	
		else
			if(self.currntGunLocationIndex < CS.FormationController.Instance.arrCharacterLabel.Length - 1) then
				myChangeEquip(self, self.currntGunLocationIndex + 1, self.currentSelectForce);
			else
				myNextEquip(self, nil, 0, 4, false); 
				return;
			end
		end
		local oldEquips = CS.System.Collections.Generic.List(CS.Equip)();
		if(self._data.arrGun ~= nil and self._data.arrGun[gunLocation] ~= nil)then
			oldEquips = self._data.arrGun[gunLocation].ListEquipCached;
			for ii = oldEquips.Count - 1, 0, -1 do
				if oldEquips[ii].gunId ~= CS.GameData.equipRealGunMap[oldEquips[ii].id] then
					oldEquips:RemoveAt(ii);
				end					
			end
		end
		
		local gun = gunLabel.gun;
		if(gun ~= nil) then
			local presetIndex = self.arrLabelHolder[gunLocation].currentRecordIndex;
			gun.wantEquipList:Clear();
			equipWantGunSoltMap:Clear();
			for ii = 0, 2, 1 do
				local equipRecord = gun.EquipPresetRecord[presetIndex][ii];
				if (equipRecord.equipID ~= 0) then
					local wantEQ = CS.GameData.listEquip:GetDataById(equipRecord.equipID);
					if(wantEQ ~= nil) then
						wantEQ.slotWithGun = ii + 1;
						gun.wantEquipList:Add(wantEQ);
						equipWantGunSoltMap:Add(ii + 1, wantEQ.id);
					end
				end
			end
			gun.equipList = oldEquips;
			for eindex = 0, gun.wantEquipList.Count - 1, 1 do
				local eq = gun.wantEquipList[eindex];
				if (CS.GameData.equipRealGunMap:ContainsKey(eq.id)) then
					local g = CS.GameData.listGun:GetDataById(CS.GameData.equipRealGunMap[eq.id]);
					if (self.currentTeamGuns:Exists(function(s) return s.id == g.id;end) == false) then										
						self.currentTeamGuns.Add(g);
					end		
				end
			end
			myNextEquip(self, gun, gunLocation, 1, true);
		end
    end 
end
local myOnClickComfirm = function(self)
	local showTip = false;
	local guns = CS.System.Collections.Generic["List`1[GF.Battle.Gun]"]() 
	self.equipGunMap:Clear();
    local dontEdit = false;
	for i = 0, 4, 1 do
		local gunLabel = CS.FormationController.Instance.arrCharacterLabel[i];
        local gun = gunLabel.gun;
        if(dontEdit == false and gun ~= nil and (gun.status == CS.GunStatus.mission or gun.status == CS.GunStatus.operation)) then
            dontEdit = true;
        end
		guns:Add(gun);
	end
    if dontEdit == true then
        CS.CommonController.LightMessageTips(CS.Data.GetLang(100038));
        return;
    end
	for i = 0, 4, 1 do
		if (self._data.arrGun[i] == nil) then
            
		else
			local listNewEquips = self._data.arrGun[i].ListNewEquip;
            local aGunId = self._data.arrGun[i].referenceGun.id;
			for k = 0, listNewEquips.Count - 1 do
				local eq = listNewEquips[k];
				local eqRealGunId = 0;
				if(CS.GameData.equipRealGunMap:ContainsKey(eq.id)) then
					eqRealGunId = CS.GameData.equipRealGunMap[eq.id];
				end
                if(eqRealGunId ~= 0 and eqRealGunId ~= aGunId) then
                    showTip = true;
                    if (self.equipGunMap:ContainsKey(eq.id)) then
                        self.equipGunMap[eq.id] = eqRealGunId;
                    else
                        self.equipGunMap:Add(eq.id, eqRealGunId);
                    end
                end
			end
		end
	end
    if(self.isSmartOn == true) then
		myChangeEquip(self, 0, true);
	else
        if (showTip == true) then
            CS.CommonMessageBoxController.Instance:ShowToogle(CS.Data.GetLang(54038), CS.Data.GetLang(54039), 
			function(force)  
					myChangeEquip(self,0, force); 
				end, nil, self.currentSelectForce);
        else
			myChangeEquip(self,0, false);
		end
    end
end
function sortGT(left, right)
	local leftRankValue = CS.System.Convert.ToInt32(left.info.rank) 
	local rightRankValue = CS.System.Convert.ToInt32(right.info.rank) 
	
	if (leftRankValue > rightRankValue) then
		return true;
	end
	if (leftRankValue < rightRankValue) then
		return false;
	end
	local leftElevelValue = left.equip_level 
	local rightElevelValue = right.equip_level
	
	if(leftElevelValue > rightElevelValue) then
		return true;
	end
	if(leftElevelValue < rightElevelValue) then
		return false;
	end
	
	local leftPropertyValue = left:CheckPropertyAllMax()
	local rightPropertyValue = right:CheckPropertyAllMax()
	
	if(leftPropertyValue ~= rightPropertyValue) then
		if(leftPropertyValue == true) then
			return true;
		end
		if(rightPropertyValue == true) then
			return false;
		end
	end
	local leftIdValue = left.id
	local rightIdValue = right.id
	
	if(leftIdValue > rightIdValue) then
		return true;
	end
	if(leftIdValue < rightIdValue) then
		return false;
	end	
	return false;
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

myRemoveList = function(self, gun, eq, gunLocation, slotIndex)
	if (eq ~= nil and gun ~= nil) then
		gun.wantEquipList:Remove(eq);
	end
	myNextEquip(self, gun, gunLocation, slotIndex+1, true);
end
util.hotfix_ex(CS.FormationEchelonEquipmentPresetController,'ChangeEquip',myChangeEquip)
util.hotfix_ex(CS.FormationEchelonEquipmentPresetController,'OnClickComfirm',myOnClickComfirm)
util.hotfix_ex(CS.FormationEchelonEquipmentPresetController,'NextEquip',myNextEquip)
util.hotfix_ex(CS.FormationEchelonEquipmentPresetController,'RemoveList',myRemoveList)