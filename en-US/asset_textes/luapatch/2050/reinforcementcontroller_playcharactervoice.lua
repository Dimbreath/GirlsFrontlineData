local util = require 'xlua.util'
xlua.private_accessible(CS.ReinforcementController)

local OnRequst = function(self, request)
    self:OnRequestSangvisFixStartHandler(request)

    local bossList = CS.System.Collections.Generic.List(CS.SangvisGun)();
    for i=0,self.listSangvisGun.Count-1 do
		if self.listSangvisGun[i].sangvisInfo.type == CS.SangvisGunType.boss then
			bossList:Add(self.listSangvisGun[i])
		end		
	end

	if bossList.Count > 0 then
		local num = math.random(bossList.Count)
		CS.CommonAudioController.PlayCharacterVoice(bossList[num - 1]:GetVoiceCode(), "_FIX_")
	end
	
end
util.hotfix_ex(CS.ReinforcementController,'OnRequestSangvisFixStartHandler',OnRequst)