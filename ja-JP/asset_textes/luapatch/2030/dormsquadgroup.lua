local util = require 'xlua.util'
xlua.private_accessible(CS.DormSquadGroup)
xlua.private_accessible(CS.BattleFieldTeamHolder)
local CreateGroupAI = function(self,posStart,tweenScale)
    CS.GF.Battle.BattleController.Instance.friendlyTeamHolder.listCharacter:Clear();
    self:CreateGroupAI(posStart,tweenScale);
end
util.hotfix_ex(CS.DormSquadGroup,'CreateGroupAI',CreateGroupAI)