local util = require 'xlua.util'
xlua.private_accessible(CS.CommonCharacterListLabelControler)

local AddCharacterDisabledStatus = function(self,active,gun)	
	self:AddCharacterDisabledStatus(active,gun)
	if self.goStatus == nil or self.goStatus:isNull() then
	else
		self.goStatus:GetComponent(typeof(CS.UnityEngine.UI.Image)).raycastTarget = false
	end
end
local CommonCharacterListLabelControler_InitRemoveGunView = function(self, emptyGun)
    self:InitRemoveGunView(emptyGun);
	self.canSelect= "";
end
util.hotfix_ex(CS.CommonCharacterListLabelControler,'InitRemoveGunView',CommonCharacterListLabelControler_InitRemoveGunView)
util.hotfix_ex(CS.CommonCharacterListLabelControler,'AddCharacterDisabledStatus',AddCharacterDisabledStatus)