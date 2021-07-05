local util = require 'xlua.util'
xlua.private_accessible(CS.FlightChessMiniGameBagUIController)

local InitUIElements = function(self)
	self:InitUIElements()
	self.transform:Find("Main/CardBagTip/UI_Text"):GetComponent(typeof(CS.ExText)).text = CS.Data.GetLang(280280)
end
util.hotfix_ex(CS.FlightChessMiniGameBagUIController,'InitUIElements',InitUIElements)

