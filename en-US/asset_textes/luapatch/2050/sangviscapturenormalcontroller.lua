local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisCaptureNormalController)
local myInit = function(self, sangvisGun, pack)
    self:Init(sangvisGun, pack)
	local isSucc = sangvisGun ~= nil;
	if(isSucc) then
		print("播放了1");
		CS.CommonAudioController.PlayUI("UI_chieve_success");
	else
		print("播放了2");
		CS.CommonAudioController.PlayUI("UI_chieve_fall");
	end
	
end
util.hotfix_ex(CS.SangvisCaptureNormalController,'Init',myInit)