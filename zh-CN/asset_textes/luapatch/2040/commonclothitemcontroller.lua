local util = require 'xlua.util'
xlua.private_accessible(CS.CommonClothItemController)
local CommonClothItemController_TryClothOn = function(self,newCloth)
	 self:TryClothOn(newCloth);
	 if self.trailOnCloth ~= nil and self:CheckUniformIDColorSame(newCloth, self.trailOnCloth)==true then
	 	self:RefreshColorLabel();
	 end
end
util.hotfix_ex(CS.CommonClothItemController,'TryClothOn',CommonClothItemController_TryClothOn)