local util = require 'xlua.util'
xlua.private_accessible(CS.CommonMessageBoxController)
local ShowRewardListItem = function(self,content,condition)
	local packageInfo = {};
	for i = 0,content.listItemPackage.Count-1 do
		if content.listItemPackage[i].info.id == 9006 or content.listItemPackage[i].info.id == 9007 then
			table.insert(packageInfo,content.listItemPackage[i]);	
		end
	end
	for i = 1, #(packageInfo) do
		content.listItemPackage:Remove(packageInfo[i]);
	end
	self:ShowRewardListItem(content,condition);
end
util.hotfix_ex(CS.CommonMessageBoxController,'ShowRewardListItem',ShowRewardListItem)