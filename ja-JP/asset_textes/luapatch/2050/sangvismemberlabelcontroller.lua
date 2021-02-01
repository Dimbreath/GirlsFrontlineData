local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisMemberLabelController)
local SangvisMemberLabelController_LoadSpine = function(self)
    self:LoadSpine();
	local obj = self.picHolder:GetChild(0);
	if obj ~= nil then
		local mat = obj:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sharedMaterial;
		mat.shader = CS.UnityEngine.Shader.Find("Spine/SkeletonGhost");
	end
end

util.hotfix_ex(CS.SangvisMemberLabelController,'LoadSpine',SangvisMemberLabelController_LoadSpine)