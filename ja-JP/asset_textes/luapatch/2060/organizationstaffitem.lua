local util = require 'xlua.util'
xlua.private_accessible(CS.OrganizationStaffItem)
local InitData = function(self,staff)
	self:InitData(staff);
	if staff ~= nil and staff.type == CS.FetterActorType.sangvis then
		self.strDescTip = CS.PLTable.Instance:GetTableLang(self.strDescTip);
	end

	if staff ~= nil and staff.type == CS.FetterActorType.squad then
		local squadInfo = CS.GameData.listSquadInfo:GetDataById(staff.id)
		local imgType = 1
		if squadInfo.type == 1 then
			imgType = 3
		elseif squadInfo.type == 2 then
			imgType = 2
		elseif squadInfo.type == 3 then
			imgType = 1
		end
		self.gunType.sprite = self.gunSpriteHolder.listSprite[9 + imgType];
	end
end
util.hotfix_ex(CS.OrganizationStaffItem,'InitData',InitData)