local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterBattleTeamSelectionUIController)
local EnterTween = function(self)
	-- do nothing
end
xlua.hotfix(CS.TheaterBattleTeamSelectionUIController,'EnterTween',EnterTween)