local util = require 'xlua.util'
xlua.private_accessible(CS.AdjutantGunListController)

local InitUIElements_New = function(self)
	self:InitUIElements()
	self.goFairyFliterNew.transform:Find("Itemtypes/list/CategoryLive2D_Dynamic/TypeButtonGridLayout/Animated/UI_Text"):GetComponent(typeof(CS.ExText)).text = "ANIMATED"
end

util.hotfix_ex(CS.AdjutantGunListController,'InitUIElements',InitUIElements_New)