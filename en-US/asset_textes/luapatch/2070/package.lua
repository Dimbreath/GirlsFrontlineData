local util = require 'xlua.util'
xlua.private_accessible(CS.Package)

local GetPackage = function(self,...)
	local noFurn = false;
	if CS.GameData.listFurniture == nil or CS.GameData.listFurniture.Count == 0 then
		noFurn = true;
	end
	self:GetPackage(...);
	if noFurn then
		CS.GameData.listFurniture:Clear();
	end
end

util.hotfix_ex(CS.Package,'GetPackage',GetPackage)
