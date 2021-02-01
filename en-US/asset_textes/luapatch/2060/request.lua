local util = require 'xlua.util'
xlua.private_accessible(CS.RequestRetireSangvis)
xlua.private_accessible(CS.RequestAddSangvisResolution)
local _RetireSangvisSuccessHandleData = function(self,www)
	if CS.ConnectionController.CheckONE(www.text) then
		for i=0,self.listSangvisGun.Count-1 do
			if self.listSangvisGun[i].special_effect ~= 0 then
				if CS.GameData.dictItem:ContainsKey(self.listSangvisGun[i].special_effect) then
					CS.GameData.dictItem[self.listSangvisGun[i].special_effect].amount=CS.GameData.dictItem[self.listSangvisGun[i].special_effect].amount+1;
				end
			end
		end
	end
	self:SuccessHandleData(www);
end
local _ResolutionSuccessHandleData = function(self,www)
	if CS.ConnectionController.CheckONE(www.text) then
		if CS.GameData.listSangvisGun:GetDataById(self.materials[0]) ~=nil then
			local effect = CS.GameData.listSangvisGun:GetDataById(self.materials[0]).special_effect;
			if effect ~= 0  then
				if CS.GameData.dictItem:ContainsKey(effect) then
					CS.GameData.dictItem[effect].amount=CS.GameData.dictItem[effect].amount+1;
				end
			end
		end
	end
	self:SuccessHandleData(www);
end

local _RequestFriendListSuccessHandleData = function(self,www)
	self:SuccessHandleData(www);
	CS.FriendMessageUtility.LoadAllMessages();
end
util.hotfix_ex(CS.RequestRetireSangvis,'SuccessHandleData',_RetireSangvisSuccessHandleData)
util.hotfix_ex(CS.RequestAddSangvisResolution,'SuccessHandleData',_ResolutionSuccessHandleData)
util.hotfix_ex(CS.RequestFriendList,'SuccessHandleData',_RequestFriendListSuccessHandleData)

