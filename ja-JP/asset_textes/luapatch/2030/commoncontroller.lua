local util = require 'xlua.util'
xlua.private_accessible(CS.CommonController)
local QuickJump = function(gotoPageInfo)
    if gotoPageInfo ~= nil then
        local count = 0
        string.gsub(gotoPageInfo.mGotoSceneInfo, "SpecialOPSPanel", function(w)
            count = count + 1
        end)
        string.gsub(gotoPageInfo.mGotoSceneInfo, "SpecialOPS", function(w)
            count = count + 1
        end)
        string.gsub(gotoPageInfo.mGotoSceneInfo, "SpecialActivity", function(w)
            count = count + 1
        end)
        if count == 0 then
            self:QuickJump(gotoPageInfo)
        else
            CS.OPSConfig.Instance:GoToScene()
        end
    end
end
util.hotfix_ex(CS.CommonController,'QuickJump',QuickJump)