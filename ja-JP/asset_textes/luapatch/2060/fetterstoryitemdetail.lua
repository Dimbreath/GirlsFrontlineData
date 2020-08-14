local util = require 'xlua.util'
xlua.private_accessible(CS.FetterStoryItemDetail)

local UpdateTrophy_New = function(self, data)
	self:UpdateTrophy(data)
	self.trophy.transform.localPosition = CS.UnityEngine.Vector3(720.2, -240.2, 0)
	self.trophy.transform.localScale = CS.UnityEngine.Vector3(0.9, 0.9, 0.9)
end
util.hotfix_ex(CS.FetterStoryItemDetail,'UpdateTrophy',UpdateTrophy_New)