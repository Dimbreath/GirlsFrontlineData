local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessSkillAnimationController)
xlua.private_accessible(CS.GF.FlightChess.FlightChessBattleManager)

local PlayGetScoreAnim = function(self, parent,value, target, source, finalValue)
	self:PlayGetScoreAnim(parent,value, target, source, finalValue)
	if CS.GF.FlightChess.FlightChessGameController.Instance.battleManager.isBattleProceed and CS.GF.FlightChess.FlightChessBattleUIController.Instance == nil then
		local animGetScore = nil
		animGetScore = parent:GetAnimationActionList()[parent:GetAnimationActionList().Count-1]
		if animGetScore ~= nil and animGetScore.animationName == "GetScoreAnim" then
			CS.GF.FlightChess.FlightChessGameController.Instance.battleManager:AddNewBattleFinishAnim(animGetScore)
			parent:GetAnimationActionList():Remove(animGetScore)
		end
	end
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessSkillAnimationController,'PlayGetScoreAnim',PlayGetScoreAnim)

