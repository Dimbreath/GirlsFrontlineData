local util = require 'xlua.util'
xlua.private_accessible(CS.AVGBackgroundController)

local Awake = function(self)
	self:Awake();
	self.matRemin = nil;
end

xlua.hotfix_ex(CS.AVGBackgroundController,'Awake',Awake)