local util = require 'xlua.util'
xlua.private_accessible(CS.FlightChessLobbyMainController)

local InitUIElements = function(self)
	self:InitUIElements();
	self.btnDebugGame.gameObject:SetActive(true);
end

util.hotfix_ex(CS.FlightChessLobbyMainController,'InitUIElements',InitUIElements)
