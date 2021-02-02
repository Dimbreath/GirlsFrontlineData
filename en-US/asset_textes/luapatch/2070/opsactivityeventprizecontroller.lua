local util = require 'xlua.util'
xlua.private_accessible(CS.OPSActivityEventPrizeController)

local Start = function(self)
	self:Start();
	self.rightParent.gameObject:SetActive(false);
	self.transform:Find("SideBar/ScrollRect").gameObject:SetActive(false);
	self.transform:Find("SideBar/btnShowRewards").gameObject:SetActive(false);
end
local InitRight = function(self)
	self:InitRight();
	self.rightParent.gameObject:SetActive(false);
	self.transform:Find("SideBar/ScrollRect").gameObject:SetActive(false);
	self.transform:Find("SideBar/btnShowRewards").gameObject:SetActive(false);
end

util.hotfix_ex(CS.OPSActivityEventPrizeController,'Start',Start)
util.hotfix_ex(CS.OPSActivityEventPrizeController,'InitRight',InitRight)

