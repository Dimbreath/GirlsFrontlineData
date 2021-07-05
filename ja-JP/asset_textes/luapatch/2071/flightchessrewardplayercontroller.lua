local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.FlightChessRewardPlayerController)

local Init = function(self, info, rank)
	self:Init(info, rank)
	self.cansShowCard = not(CS.GF.FlightChess.FlightChessData.currentRoom.isSingle)
	
end
local InitAsRecord = function(self, info)
	self:InitAsRecord(info)
	if self.upgradeNumber ~= 9999 and self.upgradeNumber < 0 then
		self.textChangeScore.text = "-" .. tostring(math.floor(-self.upgradeNumber));
	end
	
end
util.hotfix_ex(CS.GF.FlightChess.FlightChessRewardPlayerController,'Init',Init)
util.hotfix_ex(CS.GF.FlightChess.FlightChessRewardPlayerController,'InitAsRecord',InitAsRecord)
