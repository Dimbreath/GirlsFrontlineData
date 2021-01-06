local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.CSkillInstance)
local _HandleMovementtEvent = function(self,pEvent)
    self:_HandleMovementtEvent(pEvent)
    if self.mMovementCtrl ~= nil then
        self.mMovementCtrl.DesPos = CS.UnityEngine.Vector3(self.mMovementCtrl.DesPos.x, 0, self.mMovementCtrl.DesPos.z);
        self.mMovementCtrl.CurPos = CS.UnityEngine.Vector3(self.mMovementCtrl.CurPos.x, 0, self.mMovementCtrl.CurPos.z);
    end
end
util.hotfix_ex(CS.GF.Battle.CSkillInstance,'_HandleMovementtEvent',_HandleMovementtEvent)