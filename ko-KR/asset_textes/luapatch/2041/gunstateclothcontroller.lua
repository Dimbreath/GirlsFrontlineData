local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateClothController)

local GunStateClothController_OnClickQuickSendGift = function(self) 
 	if CS.ResCenter.instance.currentUsePath == CS.HotUpdateController.UsePath.UsePersistentDataPath and CS.ResCenter.instance.currentDownloadState ~= CS.ResCenter.DownloadAddState.HasDownload then
        CS.CommonController.MessageBox(CS.Data.GetLang(52107));
    else
        self:OnClickQuickSendGift();
    end  
end
local GunStateClothController_OnGiveDressFlowEnd = function(self, isConfirmed, isNew) 
	if CS.FormationEffectItemController.Instance ~= nil and CS.FormationEffectItemController.Instance.gameObject.activeSelf == false then
    	CS.FormationEffectItemController.Instance.gameObject:SetActive(true);
    end
 	self:OnGiveDressFlowEnd(isConfirmed, isNew); 
end
util.hotfix_ex(CS.GunStateClothController,'OnClickQuickSendGift',GunStateClothController_OnClickQuickSendGift)
util.hotfix_ex(CS.GunStateClothController,'OnGiveDressFlowEnd',GunStateClothController_OnGiveDressFlowEnd)