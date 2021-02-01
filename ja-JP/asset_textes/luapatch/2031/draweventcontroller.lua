local util = require 'xlua.util'
xlua.private_accessible(CS.Data)
local Init = function(self,info)
	local sameflag = false
	local tempID
	if (not CS.DrawEventController.realNum == -1) and (self.info.id == info.id) then
		sameflag = true
	end
	if not sameflag then
		CS.DrawEventController.realNum = -1
		tempID = CS.Data.GetDrawEvents()[0].id
		CS.Data.GetDrawEvents()[0].id = info.id
	end
	self:Init(info)
	CS.Data.GetDrawEvents()[0].id = tempID
end

util.hotfix_ex(CS.DrawEventController,'Init',Init)
