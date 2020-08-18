local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisWeddingPlay)
local Awake = function(self)
	self:Awake();
	self.transform:Find("Pics/Background"):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = CS.CommonController.LoadJpgCreateSprite("AtlasClips2060/sangvis_marry_bg_up");
	self.transform:Find("Pics/Image"):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = CS.CommonController.LoadJpgCreateSprite("AtlasClips2060/sangvis_marry_bg_down");
	
	if CS.UISimulatorFormation.Instance ~= nil then
		CS.UISimulatorFormation.Instance.gameObject:SetActive(false);
	end
end
local DoDestroy = function(self)
	CS.CommonController.GetRaycasterMainCanvas().enabled = true;
	self:DoDestroy();
end
util.hotfix_ex(CS.SangvisWeddingPlay,'Awake',Awake)
util.hotfix_ex(CS.SangvisWeddingPlay,'DoDestroy',DoDestroy)