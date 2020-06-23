local util = require 'xlua.util'
xlua.private_accessible(CS.BingoController)
local ShowSmallPic = function(self)
	self:ShowSmallPic();
	self.goSmallPic:SetActive(false);
end

util.hotfix_ex(CS.BingoController,'ShowSmallPic',ShowSmallPic)