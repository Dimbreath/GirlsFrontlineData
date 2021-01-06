local util = require 'xlua.util'
xlua.private_accessible(CS.CommonClothesColorLabelController)
local CommonClothesColorLabelController_InitUIElements = function(self)
	self:InitUIElements();
	local goodList = CS.GameData.listMallGood;
	if goodList~=nil and goodList.Count>0 then
		for i=0,goodList.Count-1 do
	  		if goodList[i].package ~= nil and goodList[i].package.listItemPackage.Count>0  then
	  			if goodList[i].package.listItemPackage[0].info.id == self.RandomColorantItemId and goodList[i].package.listItemPackage[0].amount==1 then
	  				self.RandomColorantGoodId=goodList[i].id;
	  			elseif  goodList[i].package.listItemPackage[0].info.id == self.SpecifyColorantItemId and goodList[i].package.listItemPackage[0].amount==1 then
	  				self.SpecifyColorantGoodId=goodList[i].id;
	  			end
	  		end
		end
		goodList=nil;
	end
end
util.hotfix_ex(CS.CommonClothesColorLabelController,'InitUIElements',CommonClothesColorLabelController_InitUIElements)