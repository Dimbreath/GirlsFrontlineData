local util = require 'xlua.util'
--xlua.private_accessible(CS.SangvisFormaionController)

local OnSelect = function(self, selectGun)
    self:OnSelectLeaderSangvis(selectGun)

	if selectGun ~= nil and selectGun.sangvisInfo.type == CS.SangvisGunType.boss then
		local index = math.random(3)
		local voiceType = "_FORMATION0" .. tostring(index) .. "_"
		local voiceCode = selectGun:GetVoiceCode()

		CS.CommonAudioController.PlayCharacterVoice(voiceCode, voiceType)
	end		
end
util.hotfix_ex(CS.SangvisFormaionController,'OnSelectLeaderSangvis',OnSelect)