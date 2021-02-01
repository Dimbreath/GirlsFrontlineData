local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPetListController)
local DataFilter = function(self,furniture)
	if furniture.info == nil or furniture.info.type ~= CS.FurnitureType.Pet then
		return false;
	else
		return self:DataFilter(furniture);
	end
end
util.hotfix_ex(CS.CommonPetListController,'DataFilter',DataFilter)