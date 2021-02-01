local util = require 'xlua.util'
xlua.private_accessible(CS.GunStateController)
local ChangePic = function(self,info)
	if pcall(function() self:ChangePic(info) end) then
	else
		if CS.FormationEffectItemController.Instance ~= nil and (not CS.FormationEffectItemController.Instance:isNull()) and CS.FormationEffectItemController.Instance.gameObject.activeSelf then
			local skinId = 0;
			if info ~= nil then
				skinId = info.id;
			end
			CS.FormationEffectItemController.Instance:SetData(self.gun, skinId);
			skinId = nil;
		end
	end
end
util.hotfix_ex(CS.GunStateController,'ChangePic',ChangePic)