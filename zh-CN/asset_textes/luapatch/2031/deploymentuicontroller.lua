local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentUIController)
local get_messageController = function(self)
	return self.uiHolder:GetUIElement("BattleMessage/Background/Main/NewItems", typeof(CS.CommonListController));
end
xlua.hotfix(CS.DeploymentUIController,'get_messageController',get_messageController)