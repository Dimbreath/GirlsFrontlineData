local util = require 'xlua.util'
xlua.private_accessible(CS.FormationEchelonEquipmentPresetController)
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
    if(isSmartOn == true) then
        self:ChangeEquip(0, true);
	else
        if (showTip == true) then
            CS.CommonMessageBoxController.Instance:ShowToogle(CS.Data.GetLang(54038), CS.Data.GetLang(54039), 
			function(force)  
				self:ChangeEquip(0, force); 
				end, nil, self.currentSelectForce);
        else
            self:ChangeEquip(0, false);
		end
    end
end
util.hotfix_ex(CS.FormationEchelonEquipmentPresetController,'OnClickComfirm',myOnClickComfirm)