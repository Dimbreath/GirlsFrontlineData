local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionEchelonController)
local OnClickRulePanel = function(self)
	CS.CommonController.ShowRuleBox(CS.Data.GetLang(40217), self.transform);
end
xlua.hotfix(CS.MissionSelectionEchelonController,'OnClickRulePanel',OnClickRulePanel)