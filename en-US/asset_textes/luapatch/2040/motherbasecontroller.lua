local util = require 'xlua.util'
xlua.private_accessible(CS.MotherBaseController)
local Start = function(self)
	self:Start();
	self.terrainMat.renderQueue = 2000;
	self.groundMat.renderQueue = 2000;
	self.quadMat.renderQueue = 2000;
end

local CameraCheckAutoMove = function (self,delay)
	self.autoMove = false
end
util.hotfix_ex(CS.MotherBaseController,'Start',Start)
util.hotfix_ex(CS.MotherBaseController,'CameraCheckAutoMove',CameraCheckAutoMove)