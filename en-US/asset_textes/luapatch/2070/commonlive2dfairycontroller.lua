local util = require 'xlua.util'
xlua.private_accessible(CS.CommonLive2DFairyController)

local setLive2D_New = function(self)
	self.randomWaitMotionDic:Clear()
	self:setLive2D()
end

util.hotfix_ex(CS.CommonLive2DFairyController,'setLive2D',setLive2D_New)


