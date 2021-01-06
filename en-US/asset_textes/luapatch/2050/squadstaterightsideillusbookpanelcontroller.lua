local util = require 'xlua.util'
xlua.private_accessible(CS.SquadStateRightSideIllusBookPanelController)
local _Init = function(self,bundle)
	 self:Init(bundle);
	 if self.isIllus then
	 	self.gameObject:SetActive(true);
	 end
end
local _InitUIElements = function(self)
	 --self:Init(bundle);
	 self.goMaxAdvance.gameObject:SetActive(true);
     self.goLowAdvance.gameObject:SetActive(false);
end
util.hotfix_ex(CS.SquadStateRightSideIllusBookPanelController,'Init',_Init)
util.hotfix_ex(CS.SquadStateRightSideIllusBookPanelController,'InitUIElements',_InitUIElements)