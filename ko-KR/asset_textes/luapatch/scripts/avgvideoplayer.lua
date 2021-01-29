local util = require 'xlua.util'

local OnVideoPlayEnd = function()
CS.AVGController.Instance.gameObject:GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = true;
end

Start = function()
	local videoCode = self.transform:GetChild(0).name;
	CS.CommonVideoPlayer.PlayVideo(CS.CommonVideoPlayer.GetFilePathVideo(videoCode),OnVideoPlayEnd,true,true,false,false,"",false,false);
	CS.AVGController.Instance.gameObject:GetComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster)).enabled = false;
end