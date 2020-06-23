--列车炮镜头摇晃
local util = require 'xlua.util'
local mainCamera = nil
Awake = function()	
	mainCamera = CS.UnityEngine.Camera.main
	CS.DG.Tweening.ShortcutExtensions.DOShakePosition(mainCamera,1,1,15,90)
	CS.UnityEngine.Object.Destroy(self.gameObject)
end

OnDestroy =function()
	mainCamera = nil
end


