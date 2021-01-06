local util = require 'xlua.util'
xlua.private_accessible(CS.CommonSendSkinToGunController)

local OnPerformanceEnd = function(self)
	self:OnPerformanceEnd();
	if CS.DormController.instance ~=nil then
		for i = 0, CS.DormController.instance.listCharacterCurrentFloor.Count - 1 do
			if CS.DormController.instance.listCharacterCurrentFloor[i].loveItem ~= nil then
					CS.DormController.instance.listCharacterCurrentFloor[i].loveItem:UpdateData();
			end
		end
	end
end
util.hotfix_ex(CS.CommonSendSkinToGunController,'OnPerformanceEnd',OnPerformanceEnd)