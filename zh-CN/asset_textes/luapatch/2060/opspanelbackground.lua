local util = require 'xlua.util'
local panelController = require("2060/OPSPanelController")
xlua.private_accessible(CS.OPSPanelBackGround)

local OnPointerUp = function(self,eventData)
	CS.OPSPanelController.Instance:CancelMission();
end

local get_mapminScale = function(self)
	local a = self.CurrentWith / self.mapSize.x;
	--print("a"..a);
	local b = self.CurrentWith * self.ratio / self.mapSize.y;
	--print("b"..b);
	local scale = CS.UnityEngine.Mathf.Max(a, b);
	--print(scale);
	return CS.UnityEngine.Mathf.Max(scale,allowminscale);
end

local OnDrag = function(self)
	if CS.UnityEngine.Input.touchCount < 2 then
		local mousePos = CS.UnityEngine.Input.mousePosition;
		local x = mousePos.x - self.startPointerPos.x;
		local y = mousePos.y - self.startPointerPos.y;
		x = x+y*0.8;
		self.targetPosition = self.targetPosition + CS.UnityEngine.Vector2(x,y)*self.CurrentWith/CS.UnityEngine.Screen.width;
		self.startPointerPos = CS.UnityEngine.Vector2(mousePos.x,mousePos.y);
		self:UpdateScalePos();
	end
end
util.hotfix_ex(CS.OPSPanelBackGround,'OnPointerUp',OnPointerUp)
util.hotfix_ex(CS.OPSPanelBackGround,'get_mapminScale',get_mapminScale)
util.hotfix_ex(CS.OPSPanelBackGround,'OnDrag',OnDrag)
