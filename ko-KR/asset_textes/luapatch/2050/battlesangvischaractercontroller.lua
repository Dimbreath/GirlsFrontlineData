local util = require 'xlua.util'
xlua.private_accessible(CS.BattleSangvisCharacterController)
local Die = function(self)
	self:Die()
	if CS.GF.Battle.BattleController.Instance.IsPerformBattle == false then
		math.randomseed(os.time())
		local randnum = math.random(1,2)
		local VoiceType = "_DEAD01_"
		if randnum == 2 then
			VoiceType = "_DEAD02_"
		end	
		CS.CommonAudioController.PlayCharacterVoice(self.gun:GetVoiceCode(),VoiceType)
	end
end
util.hotfix_ex(CS.BattleSangvisCharacterController,'Die',Die)