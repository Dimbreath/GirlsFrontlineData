local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGetNewSangvisGunController)
xlua.private_accessible(CS.ImageBufferBlurCameraController)
local SwitchMessageBoxActive = function(isOn)
	if CS.ImageBufferBlurCameraController.instance ~= nil and not CS.ImageBufferBlurCameraController.instance:isNull() and CS.ImageBufferBlurCameraController.instance.messageBox ~= nil and not CS.ImageBufferBlurCameraController.instance.messageBox:isNull() then
		--print('SwitchMessageBoxActive '..tostring(isOn));
		CS.ImageBufferBlurCameraController.instance.messageBox:SetActive(isOn);
	end
end
local InitUIElements = function(self)
	self:InitUIElements();
	SwitchMessageBoxActive(false);
end
local Close = function(self)
	self:Close();
	SwitchMessageBoxActive(true);
end
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'Close',Close)