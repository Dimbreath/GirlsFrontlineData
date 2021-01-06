local util = require 'xlua.util'
xlua.private_accessible(CS.Package)
xlua.private_accessible(CS.CommonIconController)
xlua.private_accessible("CommonIconController+CommonIconControllerBuilder")
xlua.private_accessible(CS.ItemPackage)
local Package_GetMailRewardBuilders = function(self)
	local listIconBuilders = self:GetMailRewardBuilders();
	local itemInfo;
	if self.listItemPackage.Count > 0 then
		for i = 0, self.listItemPackage.Count - 1 do
			print(string.format("id:%d,amount:%d,lastGetNum:%d",self.listItemPackage[i].info.id,self.listItemPackage[i].amount,self.listItemPackage[i].lastGetNum));
			if self.listItemPackage[i].info.type == 9 and self.listItemPackage[i].lastGetNum >= 0 and self.listItemPackage[i].lastGetNum < self.listItemPackage[i].amount then
				print('try to set num '..tostring(self.listItemPackage[i].lastGetNum));
				
				for j = 0, listIconBuilders.Count - 1 do
					itemInfo = xlua.access(listIconBuilders[j], "itemInfo");
					if itemInfo ~= nil and itemInfo.id == self.listItemPackage[i].info.id then
						print('set num ok');
						listIconBuilders[j]:SetItemNum(self.listItemPackage[i].lastGetNum, true);
						break;
					end
				end
			end
		end
	end
	itemInfo = nil;
	return listIconBuilders;
end
local ItemPackage_GetItems = function(self,isMailReward)
	if isMailReward then
		self.lastGetNum = self.amount;
	end
	self:GetItems(isMailReward);
end
util.hotfix_ex(CS.Package,'GetMailRewardBuilders',Package_GetMailRewardBuilders)
util.hotfix_ex(CS.ItemPackage,'GetItems',ItemPackage_GetItems)