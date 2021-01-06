local util = require 'xlua.util'
xlua.private_accessible(CS.GashaponController)
local _InitGashaData = function(self)
	if CS.GameData.listGashaInfo ~= nil and CS.GameData.listGashaInfo.Count>0 and self.firstGashaPrizePoolList.Count==0 then
		CS.GameData.listGashaInfo:Clear();
		CS.GameData.listGashaPrizeInfo:Clear();
		self:InitGashaData();	
	else	
		self:InitGashaData();
	end
end
util.hotfix_ex(CS.GashaponController,'InitGashaData',_InitGashaData)