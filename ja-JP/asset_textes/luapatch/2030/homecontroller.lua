local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)
local Live2DCustomHitEvent = function(self,mCommonLive2DController,hitarea)
    return false
end
util.hotfix_ex(CS.HomeController,'Live2DCustomHitEvent',Live2DCustomHitEvent)