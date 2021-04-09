local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionActivityBar)

local Init = function(self,config)
	self:Init(config);
	local textUI = self.transform:Find("MissionShow/Center/UI_Text"):GetComponent(typeof(CS.ExText));
	local imageUI = self.transform:Find("MissionShow/Center"):GetComponent(typeof(CS.ExImage));
	textUI.color = config.titleColor;
	imageUI.color = CS.UnityEngine.Color(config.titleColor.r,config.titleColor.g,config.titleColor.b,0.5);
end

util.hotfix_ex(CS.MissionSelectionActivityBar,'Init',Init)