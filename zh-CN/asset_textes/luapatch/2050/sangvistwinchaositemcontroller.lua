local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisTwinChaosItemController)

local myPlayVideoToRectTransform = function(self,iconHolder,rewards,isYLMB)
	local pathList = CS.System.Collections.Generic.List(CS.System.String)();
	for i=0, rewards.sangvisCaptureGashaRewardInfo.sangvisCantureGunInfoList.Count - 1, 1 do
		local code =  rewards.sangvisCaptureGashaRewardInfo.sangvisCantureGunInfoList[i].gunInfo.code;
		if code ~= nil and code ~= "" then
			local namePath = string.format("%s%s", code, "_buhuo");
			local path = CS.CommonVideoPlayer.GetFilePathVideo(namePath);
			if(path ~= nil and path ~= "") then
				pathList:Add(path);
			end
		end
	end
	self.video:PlayVideoList(pathList, iconHolder, true);
end
local Start = function(self)
	self:Start();
	local mask = self.iconHolder:GetComponent(typeof(CS.UnityEngine.UI.Mask));
	if mask ~= nil then
		CS.UnityEngine.Object.Destroy(mask);
	end
	mask = nil;
end
util.hotfix_ex(CS.SangvisTwinChaosItemController,'PlayVideoToRectTransform',myPlayVideoToRectTransform)
util.hotfix_ex(CS.SangvisTwinChaosItemController,'Start',Start)