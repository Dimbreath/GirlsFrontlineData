local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSangvisCharacterListController)
xlua.private_accessible("CommonSangvisCharacterListController+UISetting")
local _RefreshList = function(self,setActive)
	if self.currentSetting ~= nil and self.currentSetting.listType == CS.CommonSangvisCharacterListController.ListType.Retire and self.listSelectedGun.Count > self.currentSetting.maxSelectCount then
		self.listSelectedGun:RemoveRange(self.currentSetting.maxSelectCount, self.listSelectedGun.Count - self.currentSetting.maxSelectCount);
	end
	self:_RefreshList(setActive);
end
local get_maxSelectCount = function(self)
	if self.listType == CS.CommonSangvisCharacterListController.ListType.Retire then
		return CS.RetireController.MAX_RETIRE_NUM - CS.RetireController.Instance.listFactorySmallSangvisItemController.Count;
	else
		return self.maxSelectCount;
	end
end
util.hotfix_ex(CS.CommonSangvisCharacterListController,'_RefreshList',_RefreshList)
util.hotfix_ex(CS.CommonSangvisCharacterListController.UISetting,'get_maxSelectCount',get_maxSelectCount)