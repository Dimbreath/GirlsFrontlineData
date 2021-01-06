local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderUniformListController)
local CommanderUniformListController_OnClickCollection = function(self)
	self:OnClickCollection();
	 if self.showByCollection == false then
	 	self:RefreshFilterList(self.currentUnformType);
	 end 
end
local CommanderUniformListController_FilterList = function(self,index)
	self:FilterList(index);
	 if self.currentUnformType == CS.UniformType.None then
	 	CS.CommanderChangeClothesController.Instance:UpdateClothLabelState(self.currentUnformType);
	 	CS.CommanderChangeClothesController.Instance:UpdateColorLabelState(nil);
	 end 
end
util.hotfix_ex(CS.CommanderUniformListController,'OnClickCollection',CommanderUniformListController_OnClickCollection)
util.hotfix_ex(CS.CommanderUniformListController,'FilterList',CommanderUniformListController_FilterList)
