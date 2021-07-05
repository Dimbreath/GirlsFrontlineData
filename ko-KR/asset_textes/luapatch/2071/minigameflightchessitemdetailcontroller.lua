local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.MiniGameFlightChessItemDetailController)

local InitUIElements = function(self)
	self:InitUIElements()
	self.transform:Find("SafeRect/FrameLayout/SkillState/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(280459)
end
util.hotfix_ex(CS.GF.FlightChess.MiniGameFlightChessItemDetailController,'InitUIElements',InitUIElements)

