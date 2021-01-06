local util = require 'xlua.util'
xlua.private_accessible(CS.CommonLiteMessageController)
local Show = function(self,msg)
    if msg == "当前该点禁止通行" then
        msg = CS.Data.GetLang(200127)
    end
    self:Show(msg)
end
util.hotfix_ex(CS.CommonLiteMessageController,'Show',Show)