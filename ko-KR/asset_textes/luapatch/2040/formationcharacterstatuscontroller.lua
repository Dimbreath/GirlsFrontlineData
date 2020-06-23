local util = require 'xlua.util'
xlua.private_accessible(CS.FormationCharacterStatusController)
local FormationCharacterStatusController_ChangeEquip = function(self,equip)
	 if equip ~= nil and equip.gun ~= nil and equip.gun.status == CS.GunStatus.exploring then
	 	 CS.CommonController.LightMessageTips(CS.Data.GetLang(31849));
	 else
	 	 self:ChangeEquip(equip);
	 end
end
local FormationCharacterStatusController_InitUIElements = function(self)
	self:InitUIElements();
	if self.type == CS.StateType.gun and CS.GameData.listFurniture == nil then
		local createConnection = xlua.get_generic_method(CS.ConnectionController, 'CreateConnection');
		local createRequestDorm = createConnection(CS.RequestSelfDormInfo);
		createRequestDorm(CS.RequestSelfDormInfo(), nil, nil);
		createConnection = nil;
		createRequestDorm = nil;
	end
end
local FormationCharacterStatusController_OnGiveDressFlowEnd = function(self,isConfirmed,isNew)
	self:OnGiveDressFlowEnd(isConfirmed, isNew);
	if isConfirmed then
		self:FavourAndGunData();
	end
end
local FormationCharacterStatusController_OnClickQuickSendGift = function(self) 
 	if CS.ResCenter.instance.currentUsePath == CS.HotUpdateController.UsePath.UsePersistentDataPath and CS.ResCenter.instance.currentDownloadState ~= CS.ResCenter.DownloadAddState.HasDownload then
        CS.CommonController.MessageBox(CS.Data.GetLang(52107));
    else
        self:OnClickQuickSendGift();
    end  
end
util.hotfix_ex(CS.FormationCharacterStatusController,'ChangeEquip',FormationCharacterStatusController_ChangeEquip)
util.hotfix_ex(CS.FormationCharacterStatusController,'InitUIElements',FormationCharacterStatusController_InitUIElements)
util.hotfix_ex(CS.FormationCharacterStatusController,'OnGiveDressFlowEnd',FormationCharacterStatusController_OnGiveDressFlowEnd)
util.hotfix_ex(CS.FormationCharacterStatusController,'OnClickQuickSendGift',FormationCharacterStatusController_OnClickQuickSendGift)
