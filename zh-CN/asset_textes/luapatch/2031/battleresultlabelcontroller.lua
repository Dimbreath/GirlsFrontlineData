local util = require 'xlua.util'
xlua.private_accessible(CS.BattleResultLabelController)
local UpdateExp = function(self)
    self:UpdateExp();
    if self.imageLevelUp.gameObject.activeSelf then
        self.imageLevelUp.color = CS.UnityEngine.Color.white;
    end
    if self.getExp <= 0 then
        self:CancelInvoke('UpdateExp');
    end
end

util.hotfix_ex(CS.BattleResultLabelController,'UpdateExp',UpdateExp)
