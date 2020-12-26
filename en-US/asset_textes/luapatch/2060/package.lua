local util = require 'xlua.util'
xlua.private_accessible(CS.Package)

local GetAutoMissionPackge = function(self,...)
	self.listGunCache:Clear();
	self.listEquipCache:Clear();
	self:GetAutoMissionPackge(...);
end

util.hotfix_ex(CS.Package,'GetAutoMissionPackge',GetAutoMissionPackge)
