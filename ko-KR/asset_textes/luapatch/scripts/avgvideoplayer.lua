local util = require 'xlua.util'
local endBG = 0;
local OnVideoPlayEnd = function()
	CS.AVGController.Instance.gameObject:GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = true;
	if endBG > 0 then
		local bgCon = CS.AVGController.Instance.backgroundController;
		bgCon:ChangeBackgroundImage(bgCon.imageBackground,endBG);
	end
end

Awake = function()
	print('Awake');
end

Start = function()
	print('play video');
	if self.transform.childCount > 0 then
		local videoCode = self.transform:GetChild(0).name;
		CS.CommonVideoPlayer.PlayVideo(CS.CommonVideoPlayer.GetFilePathVideo(videoCode),OnVideoPlayEnd,true,true,false,false,"",false,false);
		CS.AVGController.Instance.gameObject:GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = false;
		if self.transform.childCount > 1 then
			endBG = tonumber(self.transform:GetChild(1).name);
		end
	end
	
end