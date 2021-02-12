local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneTrainSettingController)

local InitUIElements = function(self)
	self:InitUIElements();
	local tex = self.transform:Find("Main/AimSettingGroup/EnemySetting/Enemy_TitleGroup/EnemyInfoLayout/EnemyEmptyGroup/Txt_Tip"):GetComponent(typeof(CS.ExText));
	tex.text = CS.Data.GetLang(220096);
	tex.resizeTextForBestFit = true;
end

util.hotfix_ex(CS.MissionSelectionDroneTrainSettingController,'InitUIElements',InitUIElements)