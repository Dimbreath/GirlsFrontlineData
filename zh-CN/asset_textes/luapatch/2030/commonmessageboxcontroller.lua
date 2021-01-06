local util = require 'xlua.util'
xlua.private_accessible(CS.CommonMessageBoxController)
local Start = function(self)
    self:Start();
    if self.text.text == CS.Data.GetLang(100111) then
        self:GetComponent(typeof(CS.UnityEngine.Canvas)).renderMode = CS.UnityEngine.RenderMode.ScreenSpaceOverlay;
    end
end
util.hotfix_ex(CS.CommonMessageBoxController,'Start',Start)