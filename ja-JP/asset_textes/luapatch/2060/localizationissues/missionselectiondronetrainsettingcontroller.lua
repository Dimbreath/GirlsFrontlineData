local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionDroneTrainSettingController)

local InitUIElements = function(self)
	self.transform:Find("Main/AimSettingGroup/BaseSettingGroup/Damage_Switch/Switch_Off/UI_Text1"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(40322);
	self.transform:Find("Main/AimSettingGroup/BaseSettingGroup/Damage_Switch/Switch_Off/UI_Text2"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(40323);
	self.transform:Find("Main/AimSettingGroup/DifficultSetting/CommandLevel/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(40305);
	
	self.transform:Find("Main/AimSettingGroup/DifficultSetting/EnemyPower/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220090);--目标作战效能
	self.transform:Find("Main/AimSettingGroup/SpecialRecordingGroup/UI_Text_Score"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220087);--我的最佳成绩
	self.transform:Find("Main/AimSettingGroup/SpecialRecordingGroup/UI_Text_Rank"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(220088);--当前排名
	self.transform:Find("Main/AimSettingGroup/EnemySetting/Enemy_DayOrNightSetting/Day_Group/DayOrNight_CantSetting/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(40304);--环境
	self.TextDayNightFixed.text = CS.Data.GetLang(1063);--昼战
end
util.hotfix_ex(CS.MissionSelectionDroneTrainSettingController,'InitUIElements',InitUIElements)