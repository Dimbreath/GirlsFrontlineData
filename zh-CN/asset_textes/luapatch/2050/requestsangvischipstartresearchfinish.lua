local util = require 'xlua.util'
xlua.private_accessible(CS.RequestSangvisChipStartResearchFinish)
local mySuccessHandleData = function(self,www)
	self:SuccessHandleData(www);
	if CS.ConnectionController.CheckONE(www.text) then
		local info = CS.GameData.listSangvisChipInfos:GetDataById(self.chipId);
		if info ~= nil then
			CS.GameData.userInfo.buildCoin = CS.GameData.userInfo.buildCoin - info.dev_battery_num;
			CS.DormUIController.Instance:UpdateBuildCoinDisplay();
		end
		info = nil;
	end
end
util.hotfix_ex(CS.RequestSangvisChipStartResearchFinish,'SuccessHandleData',mySuccessHandleData)