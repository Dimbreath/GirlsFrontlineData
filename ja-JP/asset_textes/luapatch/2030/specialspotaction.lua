local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialSpotAction)
local ShowEffect = function(target,effectInfo,autoDestroy,effectObj,lastdelayTime,playsound)
    effectObj = CS.SpecialSpotAction.ShowEffect(target,effectInfo,autoDestroy,effectObj,lastdelayTime,true)
    return effectObj
end
util.hotfix_ex(CS.SpecialSpotAction,'ShowEffect',ShowEffect)