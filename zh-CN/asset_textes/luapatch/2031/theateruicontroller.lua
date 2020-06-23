local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterUIController)
local Start = function(self)
	self.mTextTotalScore.text = 'N/A';
	self:Start();
end
util.hotfix_ex(CS.TheaterUIController,'Start',Start)