local util = require 'xlua.util'
xlua.private_accessible(CS.BattleBossSkillBackgroundController)

local TriggerSkillFlow1 = function(self,spine,pic,skillName,gunType,gunCode,originalPos)
	self.transform.DestroyChildren(self.picImage.transform);
	self.picImage:GetComponent(typeof(CS.ExImage)).enabled = true;
	originalPos = self:TriggerSkillFlow1(spine,pic,skillName,gunType,gunCode,originalPos);
	return originalPos;
end

util.hotfix_ex(CS.BattleBossSkillBackgroundController,'TriggerSkillFlow1',TriggerSkillFlow1)