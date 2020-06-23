local util = require 'xlua.util'
xlua.private_accessible(CS.DormAIController)

local DormAIController_SetBelongToFriend = function(self,friend)
	self:SetBelongToFriend(friend);
	if self.m_Friend ~= nil and self.m_Friend.uid == CS.GameData.userInfo.userId then
		self.m_Friend = nil;
	end
end
util.hotfix_ex(CS.DormAIController,'SetBelongToFriend',DormAIController_SetBelongToFriend)