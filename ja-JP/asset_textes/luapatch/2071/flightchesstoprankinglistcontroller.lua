local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessTopRankingListController)

local InitUIElements = function(self)
	self:InitUIElements()
	self.transform:Find("Main/BottomBackground/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(280169)
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessTopRankingListController,'InitUIElements',InitUIElements)

