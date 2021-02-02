local util = require 'xlua.util'

local updateData = false;
local UpdateInfo = function(self,jsonData)
	updateData = true;
	self:UpdateInfo(jsonData);
end

local PlayEffect = function(self)
	local id = self.missionBuffInfo.birth_effect;
	if updateData then
		self.missionBuffInfo.birth_effect = 0;
	end
	self:PlayEffect();
	self.missionBuffInfo.birth_effect = id;
end

util.hotfix_ex(CS.BuffAction,'UpdateInfo',UpdateInfo)
util.hotfix_ex(CS.BuffAction,'PlayEffect',PlayEffect)