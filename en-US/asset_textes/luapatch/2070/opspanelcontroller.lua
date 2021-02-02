local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local ShowContainerReturn = function(self,show)
	self:ShowContainerReturn(show);
	if self.campaionId == -44 and self.gotoObj ~= nil and not self.gotoObj:isNull() then
		self.gotoObj:SetActive(self.containerReturn.gameObject.activeSelf and CS.OPSPanelBackGround.currentContainerId == -1);
	end
end

local ReturnContainer = function(self)
	self:ReturnContainer();
	if self.campaionId == -44 and self.gotoObj ~= nil and not self.gotoObj:isNull() then
		self.gotoObj:SetActive(self.containerReturn.gameObject.activeSelf and CS.OPSPanelBackGround.currentContainerId == -1);
	end
end
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',ShowContainerReturn)
util.hotfix_ex(CS.OPSPanelController,'ReturnContainer',ReturnContainer)

