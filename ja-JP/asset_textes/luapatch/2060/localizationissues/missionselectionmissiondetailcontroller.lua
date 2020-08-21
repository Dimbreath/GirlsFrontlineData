local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionMissionDetailController)

local UpdateEventData = function(self)
	self:UpdateEventData();
	string.gsub(self.textLevelCondition.text,"推荐人形等级",CS.Data.GetLang(40241));
	string.gsub(self.textGriffinCondition.text,"推荐梯队效能",CS.Data.GetLang(40242));
end
util.hotfix_ex(CS.MissionSelectionMissionDetailController,'UpdateEventData',UpdateEventData)