local util = require 'xlua.util'
xlua.private_accessible(CS.DormGunDetailController)

local DormGunDetailController_RefreshCommanderUI = function(self)
	self:RefreshCommanderUI();
	if self.m_Friend == nil then
		if CS.GameData.userInfo.gender == CS.GenderType.male then
			self.m_ToggleCommanderNoGroupSex.isOn = true;
		else
			self.m_ToggleCommanderNoGroupSex.isOn = false;
		end	
	else
		if self.m_Friend.gender == CS.GenderType.male then
			self.m_ToggleCommanderNoGroupSex.isOn = true;
		else
			self.m_ToggleCommanderNoGroupSex.isOn = false;
		end	
	end
end
local DormGunDetailController_Clean = function(self)
	self:Clean();
	self.m_Friend=nil;
end
local DormGunDetailController_RefreshAdjutantUI = function(self)
	self:RefreshAdjutantUI();
	if self.gunInfo ~= nil then
		self.m_ImageAdjutantGunType.color = CS.ColorData.GunRankColor(self.gunInfo.rank_display);
	end
end
util.hotfix_ex(CS.DormGunDetailController,'RefreshCommanderUI',DormGunDetailController_RefreshCommanderUI)
util.hotfix_ex(CS.DormGunDetailController,'Clean',DormGunDetailController_Clean)
util.hotfix_ex(CS.DormGunDetailController,'RefreshAdjutantUI',DormGunDetailController_RefreshAdjutantUI)