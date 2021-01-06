local util = require 'xlua.util'
xlua.private_accessible(CS.FormationCharacterStatusController)
local OnClickBack = function(self)
    if self.currentLoadLevel == CS.LoadLevel.Deployment and CS.DeploymentController.Instance ~= nil then
        CS.UnityEngine.Camera.main.orthographic = false;
    end
    self:OnClickBack();
end
local ShowFairy = function(self,skin_code)
    if CS.DeploymentController.Instance ~= nil then
        CS.UnityEngine.Camera.main.orthographic = true;
    end
    self:ShowFairy(skin_code);
end
local FormationCharacterStatusController_OnGiveDressFlowEnd = function(self,isConfirmed,isNew)
	self:OnGiveDressFlowEnd(isConfirmed, isNew);
	if isConfirmed then
		self:FavourAndGunData();
	end
end
util.hotfix_ex(CS.FormationCharacterStatusController,'ShowFairy',ShowFairy)
util.hotfix_ex(CS.FormationCharacterStatusController,'OnClickBack',OnClickBack)
util.hotfix_ex(CS.FormationCharacterStatusController,'OnGiveDressFlowEnd',FormationCharacterStatusController_OnGiveDressFlowEnd)
