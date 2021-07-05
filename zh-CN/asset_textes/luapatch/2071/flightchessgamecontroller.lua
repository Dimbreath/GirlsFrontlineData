local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessGameController)

local DoChessGameActionEnterBattle = function(self, attacker, defender, atkDiceNum, defDiceNum)
	if attacker ~= nil and  defender ~= nil then
		self.battleManager.isBattleProceed = true
	end
	self:DoChessGameActionEnterBattle(attacker, defender, atkDiceNum, defDiceNum)
end
local _InitGame = function(self)
	self:InitGame();
	CS.GF.FlightChess.FlightChessEventTriggerController.hasAddLastRoundEvent=false;
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessGameController,'DoChessGameActionEnterBattle',DoChessGameActionEnterBattle)
util.hotfix_ex(CS.GF.FlightChess.FlightChessGameController,'InitGame',_InitGame)
