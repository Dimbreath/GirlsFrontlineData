local util = require 'xlua.util'
xlua.private_accessible(CS.FormationEffectItemController)
xlua.private_accessible(CS.FormationCharacterStatusController)
local SetData = function(self,gun,skinId)
    if CS.FormationCharacterStatusController.Instance.listCurrentGunSkinInfo.Count == 0 then
        skinId = gun.currentSkinId;
    elseif CS.FormationCharacterStatusController.Instance.currentSelectSkinId < 0 or CS.FormationCharacterStatusController.Instance.currentSelectSkinId >= CS.FormationCharacterStatusController.Instance.listCurrentGunSkinInfo.Count then
        skinId = 0;
    else
        skinId = CS.FormationCharacterStatusController.Instance.listCurrentGunSkinInfo[CS.FormationCharacterStatusController.Instance.currentSelectSkinId].id;
    end
    self:SetData(gun,skinId);
end
util.hotfix_ex(CS.FormationEffectItemController,'SetData',SetData)
