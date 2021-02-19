local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventListItemController)

local _Awake = function(self)
	self:Awake();
	if self.isNewType==false then
		if self.type == CS.DailyEventType.SevenSupply then
			local name = CS.DailyEventType.SevenSupply:ToString()..self.subId;
			--print(name);
			CS.ResCenter.instance:SetImageTexture(self.gameObject:GetComponent(typeof(CS.UnityEngine.UI.Image)), name);
		elseif self.type == CS.DailyEventType.attendance and self.subId==2 then
			local name = CS.DailyEventType.attendance:ToString()..self.subId;
			--print(name);
			CS.ResCenter.instance:SetImageTexture(self.gameObject:GetComponent(typeof(CS.UnityEngine.UI.Image)), name);
		end
	end
	
end

util.hotfix_ex(CS.HomeEventListItemController,'Awake',_Awake)
