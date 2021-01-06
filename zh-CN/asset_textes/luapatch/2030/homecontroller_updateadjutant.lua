local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)
local HomeController_UpdateAdjutant = function(self)
    self:UpdateAdjutant();
    print('HomeController_UpdateAdjutant');
    if self.picController ~= nil and self.picController.imagePic ~= nil then
        self.picController.imagePic.raycastTarget = true;
    end
end
util.hotfix_ex(CS.HomeController,'UpdateAdjutant',HomeController_UpdateAdjutant)