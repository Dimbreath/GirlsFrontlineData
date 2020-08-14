local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMission2)
local RefreshUI = function(self)
	self:RefreshUI();
	local iter = CS.GameData.missionKeyNum:GetEnumerator();
	while iter:MoveNext() do
		local key = iter.Current.Key;
		local num = iter.Current.Value;
		if not CS.SpecialActivityController.missionkey_num:ContainsKey(key) then
			CS.SpecialActivityController.missionkey_num:Add(key,num);
		else
			CS.SpecialActivityController.missionkey_num[key] = num;
		end
	end
	if self.currentMission ~= nil and not CS.System.String.IsNullOrEmpty(self.currentMission.missionInfo.drop_key_info) then
		self.clockCheck.gameObject:SetActive(true);
		self:CheckDropMissionkeyInfo(self.clockText);
	end
end
util.hotfix_ex(CS.OPSPanelMission2,'RefreshUI',RefreshUI)