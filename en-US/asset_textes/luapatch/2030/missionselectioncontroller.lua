local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionController)
local InitUIElements = function(self)
    self:InitUIElements()
    if self.btnSpecialOPSS.image.enabled then
        local elem = self.btnSpecialOPSS.gameObject:AddComponent(typeof(CS.UnityEngine.UI.LayoutElement));
        elem.preferredWidth = 298
        elem.preferredHeight = 149
        elem = nil
    end
end
util.hotfix_ex(CS.MissionSelectionController,'InitUIElements',InitUIElements)