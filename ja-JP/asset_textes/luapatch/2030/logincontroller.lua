local util = require 'xlua.util'
xlua.private_accessible(CS.LoginController)
local RequestGetNBVersion = function(self)
    CS.ConnectionController.currentServer.conditon = CS.ServerCondition.normal
    self:RequestGetNBVersion()
end
util.hotfix_ex(CS.LoginController,'RequestGetNBVersion',RequestGetNBVersion)