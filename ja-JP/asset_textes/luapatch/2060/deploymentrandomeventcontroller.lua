local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentRandomEventController)

local OnClick = function(self)
	if self.checkSpotAction.isRandom then
		self:OnClick();
	end
end

util.hotfix_ex(CS.DeploymentRandomEventController,'OnClick',OnClick)