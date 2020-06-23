local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterExerciseAction)
local ShowFurnitureInfo_Show = function(self,...)
	self.btn_Exchange.gameObject:SetActive(false);
	self:Show(...);
end
util.hotfix_ex(CS.ShowFurnitureInfo,'Show',ShowFurnitureInfo_Show)