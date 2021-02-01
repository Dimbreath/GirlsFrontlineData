local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisLeaderLabelController)
local _SetExpBar = function(self)
	self:SetExpBar();
	if self.gun:IsLevelMax() == false then
		self.imgGunBackExpBar.fillAmount = CS.GameData.SangvisGetExpBarFillAmount(self.gun.experience, self.gun.level);
		self.imgGunFrontExpBar.fillAmount = CS.GameData.SangvisGetExpBarFillAmount(self.gun.experience, self.gun.level);
	end
end

local _InitUIElements = function(self)
	self:InitUIElements();
	self.transformGunRank:GetComponent(typeof(CS.ExImage)).autoSetNativeSizeOnAwake = false;
end

util.hotfix_ex(CS.SangvisLeaderLabelController,'InitUIElements',_InitUIElements)
util.hotfix_ex(CS.SangvisLeaderLabelController,'SetExpBar',_SetExpBar)