local util = require 'xlua.util'
xlua.private_accessible(CS.ScanModelWithMaterial)
local ScanModelWithMaterial_Awake = function(self)
	self:Awake();
	local render = self.transform:GetComponent(typeof(CS.UnityEngine.MeshRenderer));
	local mat = CS.ResManager.GetObjectByPath("Va11Prefabs/Custom_Topomap",".mat");
	if mat ~= nil then
		render.sharedMaterial = mat;
		render.sharedMaterial:SetColor("_Color",CS.UnityEngine.Color(1,1,1,1));
		self.material = render.sharedMaterial;
	end
end
util.hotfix_ex(CS.ScanModelWithMaterial,'Awake',ScanModelWithMaterial_Awake)