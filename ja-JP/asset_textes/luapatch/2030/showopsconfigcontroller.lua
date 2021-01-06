local util = require 'xlua.util'
xlua.private_accessible(CS.ShowOPSConfigController)
local AppplyConfig = function(self)
    self:AppplyConfig()
    if self.quad ~= nil then
        self.quad.transform.localPosition = CS.UnityEngine.Vector3(0,0,20)
        self.quad.transform.localScale = CS.UnityEngine.Vector3(100,100,1)
    end
end
util.hotfix_ex(CS.ShowOPSConfigController,'AppplyConfig',AppplyConfig)