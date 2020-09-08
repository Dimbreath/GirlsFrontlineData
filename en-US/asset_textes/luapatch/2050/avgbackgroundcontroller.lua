local util = require 'xlua.util'
xlua.private_accessible(CS.AVGBackgroundController)

local InvokeEffect = function(self,arrObject)
	self:InvokeEffect(arrObject);
	self.dialogBox.material = nil;
end

xlua.hotfix(CS.AVGBackgroundController,'InvokeEffect',InvokeEffect)