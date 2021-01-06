local util = require 'xlua.util'
xlua.private_accessible(CS.Badge)
xlua.private_accessible(CS.CafeGunMemoirListLabelController)
local InitMod = function(self)
	self:InitMod();
	if self.canUnlockNextStage then
		self.btnMain.badge.GoBadge.transform.anchoredPosition = CS.UnityEngine.Vector2(-180,5);
	end
end
util.hotfix_ex(CS.CafeGunMemoirListLabelController,'InitMod',InitMod)