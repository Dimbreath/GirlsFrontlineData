local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSangvisCharacterListController)
local IntelligentRetireFilter = function(self, gun)
	return gun.advance == 1 and
	(gun.isLocked == false) and
	gun.level == 1 and
	gun.sangvisShapeN >= 1 and
	gun.sangvisShapeN < 5 and
	gun.resolutionLevel == 0 and
	gun.status == CS.GunStatus.normal and
	(gun.isSpecialUnit == false)
end
util.hotfix_ex(CS.CommonSangvisCharacterListController,'IntelligentRetireFilter',IntelligentRetireFilter)