local util = require 'xlua.util'
xlua.private_accessible(CS.RetireController)
local _RequestRetireGunHandle = function(self,www)
	if CS.ConnectionController.CheckONE(www.text) then
		for i=0,self.listFactorySmallGunItemController.Count-1 do
			local effect = self.listFactorySmallGunItemController[i].gun.special_effect;
			if effect ~= 0 then
				print("effect recome");
				if CS.GameData.dictItem:ContainsKey(effect) then
					CS.GameData.dictItem[effect].amount=CS.GameData.dictItem[effect].amount+1;
				end
			end
		end
	end
	self:RequestRetireGunHandle(www);
end
util.hotfix_ex(CS.RetireController,'RequestRetireGunHandle',_RequestRetireGunHandle)
