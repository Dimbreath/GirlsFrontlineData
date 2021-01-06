local util = require 'xlua.util'
xlua.private_accessible(CS.BattleUIPauseController)
local OnClickWithdraw = function(self)
	-- 时间停止状态不让撤退
	if CS.BattleFrameManager.IsStopTime() then
		return;
	end
	if CS.GameData.currentSelectedMissionInfo ~= nil and CS.GameData.currentSelectedMissionInfo.duplicateType == 4 then
		CS.CommonController.ConfirmBox(CS.Data.GetLang(10066), function()
			self:TriggerLose()
		end)
	else
		if CS.GameData.currentSelectedMissionInfo ~= nil and CS.GameData.currentSelectedMissionInfo.duplicateType == 6 then
			CS.CommonController.ConfirmBox(CS.Data.GetLang(210149), function()
				self:TriggerLose()
			end)
		else
			self:TriggerLose();
		end
	end
end

xlua.hotfix(CS.BattleUIPauseController,'OnClickWithdraw',OnClickWithdraw)