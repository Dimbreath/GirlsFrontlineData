local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisFeedMainController)
local myRequestSangvisSangvisAdvance = function(self,request)
    self:RequestSangvisSangvisAdvance(request)
	local gun = CS.GameData.listSangvisGun:GetDataById(request.sangvis_with_user_id)
	if(request.isSuccess and request.needBossPerform == false and gun.sangvisInfo.type == CS.SangvisGunType.boss) then
		CS.CommonAudioController.PlayCharacterVoice(gun:GetVoiceCode(), CS.VoiceType._BREAKTHROUGH01_);
	end
end
util.hotfix_ex(CS.SangvisFeedMainController,'RequestSangvisSangvisAdvance',myRequestSangvisSangvisAdvance)