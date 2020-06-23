local util = require 'xlua.util'
xlua.private_accessible(CS.BattleControllerLite)
xlua.private_accessible(CS.GF.Battle.BattleController)
local Awake = function(self)
    self:Awake()
    self._listFriendlyGun = CS.GF.Battle.Team()
end
util.hotfix_ex(CS.BattleControllerLite,'Awake',Awake)