local util = require 'xlua.util'
xlua.private_accessible(CS.DormExplorationFormationController)

local SaveAndClose = function(self)
	CS.ExploreData.SaveSettings(
		function()
			self:Close();
		end);
end

util.hotfix_ex(CS.DormExplorationFormationController,'SaveAndClose',SaveAndClose)
