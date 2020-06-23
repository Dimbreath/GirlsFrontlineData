local util = require 'xlua.util'
xlua.private_accessible(CS.SquadListController)
local InitUIElements = function(self)
    local fitter = self.squadListParent.gameObject:AddComponent(typeof(CS.UnityEngine.UI.ContentSizeFitter));
    fitter.verticalFit = CS.UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize;
    fitter = nil;
end
util.hotfix_ex(CS.SquadListController,'InitUIElements',InitUIElements)