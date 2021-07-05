local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelBackGround)

local InitMap = function(self)
	self:InitMap();
	self:CheckShowMoveOffset();
	self.mainCamera.farClipPlane = 10000;
end

local OnPointerDown = function(self)
	self:OnPointerDown();
	--local trigger = false;
	--local hit = CS.UnityEngine.RaycastHit();
	--local ray = CS.UnityEngine.Camera.main:ScreenPointToRay(CS.UnityEngine.Input.mousePosition);
	--trigger,hit = CS.UnityEngine.Physics.Raycast(ray);
	--if trigger then
	--	print(hit.collider.gameObject.name);
	--end		
end
util.hotfix_ex(CS.OPSPanelBackGround,'InitMap',InitMap)
util.hotfix_ex(CS.OPSPanelBackGround,'OnPointerDown',OnPointerDown)
