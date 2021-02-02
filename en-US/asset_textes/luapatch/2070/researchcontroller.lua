local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchController)

local Start_New = function(self)
	self:Start()
	local camera = CS.UnityEngine.GameObject.Find("Main Camera")
	if camera ~= nil then
		camera.transform.position = CS.UnityEngine.Vector3(camera.transform.position.x,camera.transform.position.y,-10)
	end
end

util.hotfix_ex(CS.ResearchController,'Start',Start_New)


