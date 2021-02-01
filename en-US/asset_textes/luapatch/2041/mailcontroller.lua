local util = require 'xlua.util'
xlua.private_accessible(CS.MailController)
local InitUIElements = function(self)
	self:InitUIElements();
	self.transform:GetChild(0).anchoredPosition = CS.UnityEngine.Vector2(0,0);
end
local myStart = function(self)
	self:Start(self);
	self.movePosX = CS.UnityEngine.Vector3(800, 0, 0); 
    self.changeMovePos = CS.UnityEngine.Vector2(800, 0);
	print("ads");
end
util.hotfix_ex(CS.MailController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.MailController,'Start',myStart)