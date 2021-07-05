local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessFlyBoxController)

local InitUIElements = function(self)
	self:InitUIElements()
	self.transform:Find("Main/FrameTitle/Text_Tip"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(280458)
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessFlyBoxController,'InitUIElements',InitUIElements)

