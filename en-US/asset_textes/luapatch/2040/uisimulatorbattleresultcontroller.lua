local util = require 'xlua.util'
xlua.private_accessible(CS.UISimulatorBattleResultController)
local OnClick = function(self)
	if CS.GameData.currentSelectedMissionInfo.costbp > CS.GameData.userInfo.bp then
		CS.CommonController.GotoScene("MissionSelection", 2, 3);
	else
		self:OnClick();
	end
end
util.hotfix_ex(CS.UISimulatorBattleResultController,"OnClick",OnClick)