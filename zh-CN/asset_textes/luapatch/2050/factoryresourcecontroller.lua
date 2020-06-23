local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryResourceController)
local OnCommitClicked = function(self)
	self.package = nil
	self:OnCommitClicked()
end
util.hotfix_ex(CS.FactoryResourceController,'OnCommitClicked',OnCommitClicked)