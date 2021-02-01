local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)

local Awake = function(self)
	self:Awake();
	local gobj = CS.UnityEngine.GameObject.Find("Live2DCamera");
	if gobj ~= nil then
		gobj:GetComponent(typeof(CS.UnityEngine.Camera)).orthographicSize = 28;
	end
end
util.hotfix_ex(CS.HomeController,'Awake',Awake)