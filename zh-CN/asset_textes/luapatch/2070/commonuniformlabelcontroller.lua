local util = require 'xlua.util'
xlua.private_accessible(CS.CommonUniformLabelController)
xlua.private_accessible(CS.MallController)
local myOnPointerExit = function(self,eventData)
    print("手势退出了")
    self:OnPointerExit(eventData)
end
local myOpenChangeClothByJumpType = function(self)
    print("打开商店")
    self:OpenChangeClothByJumpType()
end
util.hotfix_ex(CS.CommonUniformLabelController,'OnPointerExit',myOnPointerExit)
util.hotfix_ex(CS.MallController,'OpenChangeClothByJumpType',myOpenChangeClothByJumpType)