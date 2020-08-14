local util = require 'xlua.util'
xlua.private_accessible(CS.BattleBossSkillBackgroundController)

local TriggerSkillFlow3 = function(self,spine)
	self:TriggerSkillFlow3(spine)
	self.transform.DestroyChildren(self.picImage.transform)
	self.picImage:GetComponent(typeof(CS.ExImage)).enabled = true
end

util.hotfix_ex(CS.BattleBossSkillBackgroundController,'TriggerSkillFlow3',TriggerSkillFlow3)