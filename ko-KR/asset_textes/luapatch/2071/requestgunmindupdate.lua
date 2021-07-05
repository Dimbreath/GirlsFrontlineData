local util = require 'xlua.util'
xlua.private_accessible(CS.RequestGunMindupdate)
xlua.private_accessible(CS.Data)
xlua.private_accessible(CS.CommonTopController)
xlua.private_accessible(CS.GameData)
xlua.private_accessible(CS.ConnectionController)
xlua.private_accessible(CS.Package)

local mySuccessHandleData = function(self,www)
	if(self.gun.mod == 2) then
		CS.Data.ConsumeMindUpCost(self.gun);
		CS.CommonTopController.TriggerRefershResourceEvent();
		self.gun.mod = 3;
		self.gun.currentSkinId = 0;
		self.gun:UpdateData();
		self.gun.life = self.gun.maxLife;
		local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text);
		local package = CS.Package(jsonData:GetValue("prize_info"));
		package:GetPackage("mindupdate");
		local jsonEquip = jsonData:GetValue("equip_load");
		local modEquip;
		local tempEquip;
		
		for i = 0, self.gun.equipList.Count - 1, 1 do
			if(CS.GameData.equipRealGunMap:ContainsKey(self.gun.equipList[i].id)) then
				CS.GameData.equipRealGunMap:Remove(self.gun.equipList[i].id);
			end
			if (CS.GameData.equipRealGunSoltMap:ContainsKey(self.gun.equipList[i].id)) then
				CS.GameData.equipRealGunSoltMap:Remove(self.gun.equipList[i].id);
			end
		end
		for i = 1, 3, 1 do
			if(jsonEquip:Contains(tostring(i)) and jsonEquip:GetValue(tostring(i)) ~= nil) then
				modEquip = CS.GameData.listEquip:GetDataById(jsonEquip:GetValue(tostring(i)).Long);
				if (modEquip ~= nil) then
					for j = 0, self.gun.equipList.Count - 1, 1 do
						tempEquip = self.gun.equipList[j];
						if (tempEquip.slotWithGun == i) then
							tempEquip:TakeOffFromGun();
							break;
						end
					end
					modEquip:TakeUpToGun(self.gun, i);
					break;
				else
					print("专属装备获取失败，不存在的id:" + jsonEquip:GetValue(tostring(i)))
				end
			end
		end
		for i = 0, self.gun.equipList.Count - 1, 1 do
			CS.GameData.equipRealGunMap[self.gun.equipList[i].id] = self.gun.id;
			CS.GameData.equipRealGunSoltMap[self.gun.equipList[i].id] = self.gun.equipList[i].slotWithGun;
		end
		
		if (self.gun.info.maxMod < self.gun.mod) then
			self.gun.info.maxMod = self.gun.mod;
		end
	else
		self:SuccessHandleData(www)
	end
end
util.hotfix_ex(CS.RequestGunMindupdate,'SuccessHandleData',mySuccessHandleData)