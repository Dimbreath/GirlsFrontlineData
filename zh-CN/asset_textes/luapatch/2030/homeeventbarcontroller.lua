local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventBarController)
local OpenUrlWindow = function(self,url)
    local s = string.find(url,"+");
    if s == 1 then
        CS.UnityEngine.Application.OpenURL(string.sub(url, 2));
    else
        self:OpenUrlWindow(url);
    end
end
util.hotfix_ex(CS.HomeEventBarController,'OpenUrlWindow',OpenUrlWindow)