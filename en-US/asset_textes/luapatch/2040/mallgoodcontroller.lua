local util = require 'xlua.util'
xlua.private_accessible(CS.MallGoodController)
xlua.private_accessible(CS.UserInfo)

local OnClick = function(self)
	print(self.good.type)
    local gem = -1
    if self.good.type == CS.GoodType.gemToGiftbag then
        gem = CS.GameData.userInfo.gem
        CS.GameData.userInfo._gem = 100000
    end
    self:OnClick()
    if gem ~= -1 and self.good.type == CS.GoodType.gemToGiftbag then
        CS.GameData.userInfo._gem = gem
    end
end
util.hotfix_ex(CS.MallGoodController, 'OnClick', OnClick)
