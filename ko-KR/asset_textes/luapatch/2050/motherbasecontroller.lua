local util = require 'xlua.util'
xlua.private_accessible(CS.MotherBaseController)
xlua.private_accessible(CS.MotherBaseUIInfo)
local InitSangvis = function(self)
	self:InitSangvis();
	self.sangvisInfo.textNameEn.text = 'Protocol Control Center';
end
util.hotfix_ex(CS.MotherBaseController,'InitSangvis',InitSangvis)