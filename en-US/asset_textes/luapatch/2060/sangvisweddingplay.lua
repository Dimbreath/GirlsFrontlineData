local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisWeddingPlay)
local Awake = function(self)
	self:Awake();
	self.transform:Find("Pics/Background"):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = CS.CommonController.LoadJpgCreateSprite("AtlasClips2060/sangvis_marry_bg_up");
	self.transform:Find("Pics/Image"):GetComponent(typeof(CS.UnityEngine.UI.Image)).sprite = CS.CommonController.LoadJpgCreateSprite("AtlasClips2060/sangvis_marry_bg_down");
end
util.hotfix_ex(CS.SangvisWeddingPlay,'Awake',Awake)