local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterUIController)
local OnAVGEnd = function()
	CS.UnityEngine.PlayerPrefs.SetString('theater_guide_avg',CS.ConnectionController.uid);
end
local InitTheater = function(self,info)
	self:InitTheater(info);
	local btnSelf = self:GetComponent(typeof(CS.ExButton));
	if btnSelf ~= nil then
		btnSelf.enabled = false;
		btnSelf = nil;
	end
	if CS.GameData.mTheaterExerciseAction == nil then
		local cacheUID = CS.UnityEngine.PlayerPrefs.GetString('theater_guide_avg','0');
		if cacheUID ~= CS.ConnectionController.uid then
			local textAsset = CS.ResManager.GetObjectByPath("AVGTxt/Theater/TheaterGuide",".txt");
			CS.AVGController.Instance.transform:SetParent(CS.CommonController.MainCanvas.transform, false);
			CS.AVGController.Instance:InitializeData(textAsset);
			CS.AVGController.Instance.onEnd = OnAVGEnd;
			textAsset = nil;
			cacheUID = nil;
		end
	end
end

util.hotfix_ex(CS.TheaterUIController,'InitTheater',InitTheater)