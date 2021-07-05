local util = require 'xlua.util'
xlua.private_accessible(CS.OPSActivityEventPrizeController)

local Start = function(self)
	self:Start();
	self.rightParent:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(-120,-400);
	self.transform:Find("SideBar/ScrollRect").gameObject:SetActive(false);
	self.transform:Find("SideBar/btnShowRewards").gameObject:SetActive(false);
	self.transform:Find("Top/HorizontalLayout/Tile").gameObject:SetActive(false);
end

local InitProcess = function(self,order)
	self:InitProcess(order);
	if order == 1 then
		local image = self.PackageProcessParent:GetChild(order):Find("imgProgress/imgProgressFilled"):GetComponent(typeof(CS.ExImage));
		local process = (self.currentEventPrizeData.Num -self.currentKeys[0])/(self.currentKeys[1]-self.currentKeys[0]);
		image.fillAmount = process;
	end
end

local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:SwitchSidebar("ActivityEventPrize",true);
	--CS.Extensions.InitNarrowScreenAdaption(self.transform);
	self.imageBackground.rectTransform.anchoredPosition = CS.UnityEngine.Vector2(110,-576);
end
util.hotfix_ex(CS.OPSActivityEventPrizeController,'Start',Start)
util.hotfix_ex(CS.OPSActivityEventPrizeController,'InitProcess',InitProcess)
util.hotfix_ex(CS.OPSActivityEventPrizeController,'InitUIElements',InitUIElements)

