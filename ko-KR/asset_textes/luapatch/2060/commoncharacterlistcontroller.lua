local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCharacterListController)
local myOnClickItem = function(self,gun)
	if(self.listType == CS.ListType.autoGunFormation) then
		if(self.lockingInterface == false) then
			if(gun ~= nil and gun.id == -1) then
				self:OnClickItem(gun)
			else
				if(gun == nil) then
					self:OnClickItem(gun)
				else
					local tempGunId = CS.FormationSettingController.Instance.CurrentSelectedTile.gun.info.id;
					if(tempGunId > 20000) then
						tempGunId = tempGunId - 20000;
					end
					local tempGunInfoId = gun.info.id;
					if(tempGunInfoId > 20000) then
						tempGunInfoId = tempGunInfoId - 20000;
					end
					local bb = false;
					for i = 0, CS.FormationSettingController.Instance.listTile.Count - 1, 1 do
						local s = CS.FormationSettingController.Instance.listTile[i];
						if s.gun ~= nil then 
							local sgunInfoId = s.gun.info.id;
							if(sgunInfoId > 20000) then
								sgunInfoId = sgunInfoId - 20000;
							end
							if(s.gun ~= nil and sgunInfoId == tempGunInfoId) then
								bb = true;	
								break;
							end
						end
					end
					if (((CS.FormationSettingController.Instance.CurrentSelectedTile.gun ~= nil and tempGunId == tempGunInfoId) == false) 
							and bb) then 
                        CS.CommonController.LightMessageTips(CS.Data.GetLang(100048));
                        return;
                    end
                    local formationController = self.goInvoker:GetComponent(typeof(CS.FormationController));
                    if (gun ~= nil) then
                        gun.pos = CS.GF.Battle.GridPos(CS.FormationSettingController.Instance.currentSelectedGunPos.x, CS.FormationSettingController.Instance.currentSelectedGunPos.y);
                        CS.FormationSettingController.Instance:Init(gun);
                        local posId = gun.pos:ToId();
                        CS.AutoFormationTeamNodeController.Instance:RefreshGunNumData();
                    end
                        self.gameObject:SetActive(false);
                        CS.FormationSettingController.Instance.gameObject:SetActive(true);
                        CS.AutoFormationTeamNodeController.Instance:RefreshData();
                        CS.FormationSettingController.Instance:AnysicFormationData();
                        CS.FormationSettingController.Instance:RefreshTileUI();
				end
			end
		end
	else
		self:OnClickItem(gun)
	end
    
end
util.hotfix_ex(CS.CommonCharacterListController,'OnClickItem',myOnClickItem)