local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisTwinChaosItemController)
xlua.private_accessible(CS.SangvisCaptureChaosBossDetailController)
local myTwStart = function(self)
	local obj = self.gameObject:GetComponent(typeof(CS.UnityEngine.Canvas)) ;
	if(obj == nil or obj:isNull()) then
		local canvas = self.gameObject:AddComponent(typeof(CS.UnityEngine.Canvas));
		self.gameObject:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster));
		canvas.overrideSorting = true;
		canvas.sortingOrder = 11;
	end
    self:Start()
end
local myStart = function(self)
	local obj = self.gameObject:GetComponent(typeof(CS.UnityEngine.Canvas)) ;
	if(obj == nil or obj:isNull()) then
		local canvas = self.gameObject:AddComponent(typeof(CS.UnityEngine.Canvas));
		self.gameObject:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster));
		canvas.overrideSorting = true;
		canvas.sortingOrder = 12;
	end
	self.gameObject.layer = 5;
	self:Start()
end

util.hotfix_ex(CS.SangvisTwinChaosItemController,'Start',myTwStart)
util.hotfix_ex(CS.SangvisCaptureChaosBossDetailController,'Start',myStart)
