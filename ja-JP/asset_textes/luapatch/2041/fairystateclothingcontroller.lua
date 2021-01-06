local util = require 'xlua.util'
xlua.private_accessible(CS.FairyStateClothingController)
local myOnClickFairyChangeCloth = function(self, isLeft)
	isLeft = false;
    self:OnClickFairyChangeCloth(isLeft)
end
util.hotfix_ex(CS.FairyStateClothingController,'OnClickFairyChangeCloth',myOnClickFairyChangeCloth)