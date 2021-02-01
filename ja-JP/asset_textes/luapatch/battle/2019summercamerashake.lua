--列车炮镜头摇晃
local util = require 'xlua.util'
local mainCamera = nil
Awake = function()	
	mainCamera = CS.UnityEngine.Camera.main
	local eulerAngles = self.transform.rotation.eulerAngles
	local scale = self.transform.localScale
	mainCamera:DOShakePosition(eulerAngles.x,eulerAngles.y,scale.x,scale.y);
	--CS.DG.Tweening.ShortcutExtensions.DOShakePosition(mainCamera,eulerAngles.x,eulerAngles.y,scale.x,scale.y)
	CS.UnityEngine.Object.Destroy(self.gameObject)
end

OnDestroy =function()
	mainCamera = nil
end


