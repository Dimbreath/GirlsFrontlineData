local util = require 'xlua.util'
local panelController = require("2060/OPSPanelController")
xlua.private_accessible(CS.OPSPanelEchoMessagebox)
xlua.private_accessible(CS.OPSPanelController)

local echospotInfo = nil;
local InitUIElements = function(self)
	local btn = self.transform:Find("Image"):GetComponent(typeof(CS.ExButton));
	btn:AddOnClick(function()
		self:Hide();
	end
	)
end

local ShowEchoInfo = function(self,info)
	echospotInfo = CS.OPSPanelController.Instance.MissionEchoSpotInfo:GetComponent(typeof(CS.UnityEngine.Canvas));
	echospotInfo.sortingLayerName = "UI";
	if infoimage ~= nil and not infoimage:isNull() then
		infoimage.sortingLayerName = "UI";
	end
	if infoline ~= nil and not infoline:isNull() then
		infoline.sortingLayerName = "UI";
	end
	if infospine ~= nil and not infospine:isNull() then
		infospine.sortingLayerName = "UI";
	end
	self:ShowEchoInfo(info);
	CS.CommonAudioController.PlayUI("UI_Division_Echo");
	self.canvasGroup:DOKill();
	self.canvasGroup:DOFade(1, 1.5);
end

local Hide = function(self)
	self:Hide();
	if echospotInfo ~= nil  and not echospotInfo:isNull() then
		echospotInfo.sortingLayerName = "Spine";
	end
	if infoimage ~= nil and not infoimage:isNull()then
		infoimage.sortingLayerName = "Spine";
	end
	if infoline ~= nil and not infoline:isNull()then
		infoline.sortingLayerName = "Spine";
	end
	if infospine ~= nil and not infospine:isNull() then
		infospine.sortingLayerName = "Default";
	end
	CS.OPSPanelController.Instance:CloseEchoInfo();
	if echospot ~= nil and not echospot:isNull() then
		echospot:HideEffect();
		echospot = nil;
		CS.CommonAudioController.PlayUI("UI_Division_Echo_Off");
	end
	local image = self.transform:Find("Image"):GetComponent(typeof(CS.UnityEngine.UI.Image));
	image:DOColor(CS.UnityEngine.Color(0,0,0,0),0.3);
end
util.hotfix_ex(CS.OPSPanelEchoMessagebox,'ShowEchoInfo',ShowEchoInfo)
util.hotfix_ex(CS.OPSPanelEchoMessagebox,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.OPSPanelEchoMessagebox,'Hide',Hide)