local util = require 'xlua.util'
xlua.private_accessible(CS.ShowEffectInfoBoxController)
xlua.private_accessible(CS.SpineEffectController)
local myShow = function(self,...)
    self:Show(...)
	local meshRenderer = self.effectDisplay:GetChild(0):GetComponent(typeof(CS.UnityEngine.MeshRenderer));
	meshRenderer.sortingOrder = meshRenderer.sortingOrder + 1;
	local efobj = meshRenderer.gameObject:GetComponent(typeof(CS.SpineEffectController));
    efobj:SetOrderInLayer(efobj.transform:GetChild(0).gameObject, 1);
end
local myCancel = function(self)
	self:Cancel()
	CS.UnityEngine.Object.Destroy(self.gameObject);
end
util.hotfix_ex(CS.ShowEffectInfoBoxController,'Show',myShow)
util.hotfix_ex(CS.ShowEffectInfoBoxController,'Cancel',myCancel)
