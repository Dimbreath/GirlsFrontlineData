local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessManualChipController)

local Init = function(self)
	self.textRankFilter.text = CS.Data.GetLang(280148)
	self.textGunTypeFilter.text = CS.Data.GetLang(280148)
	self:Init()
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessManualChipController,'Init',Init)

