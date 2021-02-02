local util = require 'xlua.util'
xlua.private_accessible(CS.OPSActivityEventPrizeController)

local Start = function(self)
	self:Start();
	self.rightParent:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(-120,-400);
	self.transform:Find("SideBar/ScrollRect").gameObject:SetActive(false);
	self.transform:Find("SideBar/btnShowRewards").gameObject:SetActive(false);
	self.transform:Find("Top/HorizontalLayout/Tile").gameObject:SetActive(false);
end


util.hotfix_ex(CS.OPSActivityEventPrizeController,'Start',Start)
--util.hotfix_ex(CS.OPSActivityEventPrizeController,'InitRight',InitRight)

