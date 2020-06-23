local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisNormalCaptureController)
local DoSangvisNormalCapture = function()
	if CS.GF.Battle.BattleController.Instance == nil then
		CS.CommonAudioController.PlayBGM("m_sf_recap_battle")
	end
	if CS.GameData.currentSangvisDuplicateData ~= nil then
		CS.GameData.currentSangvisDuplicateData = nil
	end
	CS.SangvisNormalCaptureController.DoSangvisNormalCapture()
end
util.hotfix_ex(CS.SangvisNormalCaptureController,'DoSangvisNormalCapture',DoSangvisNormalCapture)