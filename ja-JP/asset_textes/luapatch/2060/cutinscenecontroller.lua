local util = require 'xlua.util'
xlua.private_accessible(CS.CutinSceneController)
local Overturn = function(self)
	if self.offsetIndex == 0 then
		self:Overturn();
	end
end

util.hotfix_ex(CS.CutinSceneController,'Overturn',Overturn)