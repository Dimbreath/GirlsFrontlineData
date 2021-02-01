local util = require 'xlua.util'
xlua.private_accessible(CS.CommonGiftListLabelController)
local myRequestGiveGunGiftHandler = function(self,request)
	if(CS.ResCenter.instance.currentSceneName == "MissionSelection") then
		self:RefreshUI(request);
	else
		self:RequestGiveGunGiftHandler(request)
	end
end
util.hotfix_ex(CS.CommonGiftListLabelController,'RequestGiveGunGiftHandler',myRequestGiveGunGiftHandler)