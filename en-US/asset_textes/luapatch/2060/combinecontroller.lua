local util = require 'xlua.util'
xlua.private_accessible(CS.CombineController)
local _RequestCombineHandle = function(self,www)
	print("combine");
	if CS.ConnectionController.CheckONE(www.text) then
		for i=0,self.arrItem.Length-1 do
			if self.arrItem[i].gun ~=nil then
				local effect = self.arrItem[i].gun.special_effect;
				if effect ~= 0 then
					print("combine effect recome");
					if CS.GameData.dictItem:ContainsKey(effect) then
						CS.GameData.dictItem[effect].amount=CS.GameData.dictItem[effect].amount+1;
					end
				end
			end
		end
	end
	self:RequestCombineHandle(www);
end
util.hotfix_ex(CS.CombineController,'RequestCombineHandle',_RequestCombineHandle)
