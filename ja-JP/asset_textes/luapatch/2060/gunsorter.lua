local util = require 'xlua.util'
xlua.private_accessible(CS.GunSorter)
local _GunSorter = function(self,sortType,listType,desc)
	
	if sortType == CS.SortType.damage then
		self.desc = not desc;
	end
end
util.hotfix_ex(CS.GunSorter,'.ctor',_GunSorter)