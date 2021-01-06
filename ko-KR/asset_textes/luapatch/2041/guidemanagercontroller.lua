local util = require 'xlua.util'
xlua.private_accessible(CS.GuideManagerController)

local Awake = function(self)
	self:Awake();
	if self.parent:GetComponent(typeof(CS.FullScreenRectSetter)) == nil then
		self.parent:AddComponent(typeof(CS.FullScreenRectSetter));
	end
end
util.hotfix_ex(CS.GuideManagerController,'Awake',Awake)