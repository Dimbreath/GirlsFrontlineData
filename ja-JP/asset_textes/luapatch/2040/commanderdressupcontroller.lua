local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderDressupController)
local CommanderDressupController_ReturnFromChangeCloth = function(self)
	 self:ReturnFromChangeCloth();
	 self.userPreviewController:InitClothesIcon();
end
util.hotfix_ex(CS.CommanderDressupController,'ReturnFromChangeCloth',CommanderDressupController_ReturnFromChangeCloth)
