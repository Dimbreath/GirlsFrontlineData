local util = require 'xlua.util'
xlua.private_accessible(CS.ShowGunLoveItem)
local ShowGunLoveItem_CanAIShowEmoji = function(self)
	return self.aiController.forceShowEmoji or self.aiController:CanDormModeShowEmoji();
end
local ShowGunLoveItem_ShowEmoji = function(self)
	if self.aiController:CanShowEmoji() then
		self:ShowEmoji();
	end
end
util.hotfix_ex(CS.ShowGunLoveItem,'ShowEmoji',ShowGunLoveItem_ShowEmoji)
xlua.hotfix(CS.ShowGunLoveItem,'CanAIShowEmoji',ShowGunLoveItem_CanAIShowEmoji)