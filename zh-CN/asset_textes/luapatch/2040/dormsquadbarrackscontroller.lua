local util = require 'xlua.util'
xlua.private_accessible(CS.DormSquadBarracksController)
local OnDisposed = function(self)
	self:OnDisposed();
	CS.DormSquadBarracksController._inst = nil;
end
util.hotfix_ex(CS.DormSquadBarracksController,"OnDisposed",OnDisposed)