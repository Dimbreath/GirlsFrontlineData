local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialActivityController)

local ShowLockObj = function(self,campion,campionObj)
	self:ShowLockObj(campion,campionObj);
	local lock = campionObj.transform:Find("Lock");
	if lock ~= nil then
		lock.gameObject:SetActive(true);
	end
end

local UIInit = function(self)
	self:UIInit();
	local iter = self.CampaignsExToggle:GetEnumerator();
	while iter:MoveNext() do
		local campaion = iter.Current.Key;
		local temp = iter.Current.Value;
		local num = self.spots:FindAll(
			function(s)
				return s.mission.missionInfo.campaign == campaion
			end);
		temp.gameObject:SetActive(num.Count>0);
	end
end
util.hotfix_ex(CS.SpecialActivityController,'ShowLockObj',ShowLockObj)
util.hotfix_ex(CS.SpecialActivityController,'UIInit',UIInit)
