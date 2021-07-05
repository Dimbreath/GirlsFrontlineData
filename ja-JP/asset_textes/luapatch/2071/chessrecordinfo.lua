local util = require 'xlua.util'
xlua.private_accessible(CS.GF.FlightChess.ChessRecordInfo)
local _ChessRecordInfo = function(self,jsonData,listType,isDetail)
	self.totalScore = jsonData:GetValue("total_score").Int;
end
util.hotfix_ex(CS.GF.FlightChess.ChessRecordInfo,'.ctor',_ChessRecordInfo)

