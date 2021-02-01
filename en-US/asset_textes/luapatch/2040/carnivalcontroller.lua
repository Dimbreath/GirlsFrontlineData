local util = require 'xlua.util'
xlua.private_accessible(CS.CarnivalController)
local GetCarnivalInfoCallBack = function(self,request)
    self.imgBanner.color = CS.UnityEngine.Color(1,1,1,1);
    self:GetCarnivalInfoCallBack(request);
end
util.hotfix_ex(CS.CarnivalController,'GetCarnivalInfoCallBack',GetCarnivalInfoCallBack)