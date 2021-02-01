local util = require 'xlua.util'
xlua.private_accessible(CS.BattleBossSkillBackgroundController)
local SetLayer = function(self,...)
	self:SetLayer(...);
	CS.BattleUIDamageController.Instance.gameObject:SetActive(true);
end
util.hotfix_ex(CS.BattleBossSkillBackgroundController,'SetLayer',SetLayer)