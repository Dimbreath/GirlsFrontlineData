local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local ShowContainerReturn = function(self,show)
	self:ShowContainerReturn(show);
	if self.campaionId == -44 then
		local targetMall = self.transform:Find("Left/MirrorStage_GotoMall(Clone)");
		local targetPoint = self.transform:Find("Left/MirrorStage_PointExchange(Clone)");
		local show =  self.containerReturn.gameObject.activeSelf and CS.OPSPanelBackGround.currentContainerId == -1;
		targetPoint.gameObject:SetActive(show);
		targetMall.gameObject:SetActive(not show);
	end
end

local ReturnContainer = function(self)
	self:ReturnContainer();
	if self.campaionId == -44 then
		local targetMall = self.transform:Find("Left/MirrorStage_GotoMall(Clone)");
		local targetPoint = self.transform:Find("Left/MirrorStage_PointExchange(Clone)");
		local show =  self.containerReturn.gameObject.activeSelf and CS.OPSPanelBackGround.currentContainerId == -1;
		targetPoint.gameObject:SetActive(show);
		targetMall.gameObject:SetActive(not show);
	end
end

local InitSpots = function(self)
	self:InitSpots();
	if self.containerBackground ~= nil and not self.containerBackground:isNull() then
		for i=0,self.containerBackground.transform.childCount-1 do
			self.containerBackground.transform:GetChild(i).gameObject:SetActive(false);
		end
		self.containerBackground.transform:Find("Static").gameObject:SetActive(true);
	end
end
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',ShowContainerReturn)
util.hotfix_ex(CS.OPSPanelController,'ReturnContainer',ReturnContainer)
util.hotfix_ex(CS.OPSPanelController,'InitSpots',InitSpots)

