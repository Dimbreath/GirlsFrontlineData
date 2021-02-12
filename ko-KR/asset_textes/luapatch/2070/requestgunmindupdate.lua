local util = require 'xlua.util'
xlua.private_accessible(CS.RequestGunMindupdate)
local SuccessHandleData = function(self, www)
	local eqTable = {};
	if self.gun.mod == 2 then
		for i = 0, self.gun.equipList.Count - 1 do
			eqTable[i+1] = self.gun.equipList[i].id;
		end
	end
    self:SuccessHandleData(www)
	if self.gun.mod == 3 then
		for i = 0, self.gun.equipList.Count - 1 do
			local existInOld = false;
			for j = 1, #eqTable do
				if self.gun.equipList[i].id == eqTable[j] then
					existInOld = true;
					break;
				end
			end
			if not existInOld then
				CS.GameData.equipRealGunMap[self.gun.equipList[i].id] = self.gun.id;
				CS.GameData.equipRealGunSoltMap[self.gun.equipList[i].id] = self.gun.equipList[i].slotWithGun;
			end
			existInOld = nil;
		end
	end
	eqTable = nil;
end
util.hotfix_ex(CS.RequestGunMindupdate,'SuccessHandleData',SuccessHandleData)