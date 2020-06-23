local util = require 'xlua.util'
xlua.private_accessible(CS.FriendUserCardController)
local RequestDeleteFriend = function(self,result)
	CS.CommonController.LightMessageTips(CS.Data.GetLang(110025)); -- LanguageConfig.ELANS_TYPE_FRIEND.好友已移除_23
	self:Init();
	self:RefreshFriendController();
	if CS.FriendListController.Instance ~= nil then
		CS.FriendListController.Instance:RefreshFriendCount();
	end
end
xlua.hotfix(CS.FriendUserCardController,'RequestDeleteFriend',RequestDeleteFriend)