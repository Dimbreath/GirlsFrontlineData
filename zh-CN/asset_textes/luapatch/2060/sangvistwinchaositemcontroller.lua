local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisTwinChaosItemController)
local myPlayVideoToRectTransform = function(self,iconHolder,rewards,isYLMB)
    self:PlayVideoToRectTransform(iconHolder,rewards,isYLMB)
	if(iconHolder.childCount > 0) then
		local canvas = iconHolder:GetChild(0):GetComponent(typeof(CS.UnityEngine.Canvas))
		canvas.overrideSorting = true;
		canvas.sortingOrder = 10;
	end
end
util.hotfix_ex(CS.SangvisTwinChaosItemController,'PlayVideoToRectTransform',myPlayVideoToRectTransform)