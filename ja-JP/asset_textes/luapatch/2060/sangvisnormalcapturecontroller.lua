local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisNormalCaptureController)
local gunNumberCache;
local DoSangvisNormalCapture = function()
	gunNumberCache = {};
	local tempGun;
	for i = 0, CS.GameData.listGun.Count - 1 do
		tempGun = CS.GameData.listGun:GetDataByIndex(i);
		if tempGun.number > 1 then
			gunNumberCache[tempGun.id] = tempGun.number;
		end
	end
	tempGun = nil;
	CS.SangvisNormalCaptureController.DoSangvisNormalCapture()
end
local SangvisCaptureFinish = function()
	if gunNumberCache ~= nil then
		local tempGun;
		for i = 0, CS.SangvisNormalCaptureController.SangvisGachaTeam.Count-1 do
			tempGun = CS.SangvisNormalCaptureController.SangvisGachaTeam[i];
			if tempGun ~= nil and tempGun.allyGunInfo == nil and gunNumberCache[tempGun.id] ~= nil then
				tempGun.number = gunNumberCache[tempGun.id];
			end
		end
		tempGun = nil;
		gunNumberCache = nil;
	end
	CS.SangvisNormalCaptureController.SangvisCaptureFinish();
end
util.hotfix_ex(CS.SangvisNormalCaptureController,'DoSangvisNormalCapture',DoSangvisNormalCapture)
util.hotfix_ex(CS.SangvisNormalCaptureController,'SangvisCaptureFinish',SangvisCaptureFinish)