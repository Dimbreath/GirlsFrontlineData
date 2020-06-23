local util = require 'xlua.util'
xlua.private_accessible(CS.ItemPackage)
local get_CanGetAmount = function(self)
    CS.Data.UpdateDailyData()
    return self.CanGetAmount
end
util.hotfix_ex(CS.ItemPackage,'get_CanGetAmount',get_CanGetAmount)