local util = require 'xlua.util'
xlua.private_accessible(CS.MallGoodController)
local myProceedSunbornPayment = function(self, orderId)
	print("%s", this.good.thirdProductId);
	print("%s", CS.ConnectionController.currentServer.worldId);
	print("%s", this.good.giftName);
    self:ProceedSunbornPayment(orderId)
end
util.hotfix_ex(CS.MallGoodController,'ProceedSunbornPayment',myProceedSunbornPayment)