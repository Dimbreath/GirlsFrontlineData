local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryDevelopLogController)
-- xlua.private_accessible(CS.FactoryDevelopLogListLabelHolderController)

local myRequestGunCollectionListHandle = function(self,www)
	self:RequestGunCollectionListHandle(www)
    self:OnListMove();
end
local myCreateOfficialFormulaList = function(self)
	self:CreateOfficialFormulaList()
	for i = 0 , self.listHolder.Count -1 , 1 do
		self.listHolder[i]:UpdateInfo();
	end
end

util.hotfix_ex(CS.FactoryDevelopLogController,'CreateOfficialFormulaList',myCreateOfficialFormulaList)
util.hotfix_ex(CS.FactoryDevelopLogController,'RequestGunCollectionListHandle',myRequestGunCollectionListHandle)