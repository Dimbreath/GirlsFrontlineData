local util = require 'xlua.util'
xlua.private_accessible(CS.SettingController)
local Start = function(self)
    self:Start()
    self.textClientVersion.text = self.textClientVersion.text..'patched'
    print("start")
end
util.hotfix_ex(CS.SettingController,'Start',Start)