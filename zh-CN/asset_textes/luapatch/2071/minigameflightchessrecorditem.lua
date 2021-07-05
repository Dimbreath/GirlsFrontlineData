local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.MiniGameFlightChessRecordItem)
local Init = function(self,recordInfo)
	self:Init(recordInfo)
	for i = 0, CS.GameData.listChessScoreLevel.Count -1 do
		local scoreLevel = CS.GameData.listChessScoreLevel[i]
		if recordInfo.totalScore >= scoreLevel.score_floor and (scoreLevel.score_ceilling < 0 or recordInfo.totalScore <= scoreLevel.score_ceilling) then
			CS.CommonController.LoadImageIcon(self.imgScoreIcon, scoreLevel.iconPath);
			break
		end
	end
end
util.hotfix_ex(CS.GF.FlightChess.MiniGameFlightChessRecordItem,'Init',Init)

