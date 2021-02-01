local util = require 'xlua.util'
xlua.private_accessible(CS.CommonClothesColorLabelController)
local Start = function(self)
	self:Start();
	local compo = self.gameObject:AddComponent(typeof(CS.UnityEngine.Canvas));
	compo.overrideSorting = true;
	compo.sortingOrder = 2;
	self.gameObject:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster));
	
	compo = self.textColorranRandom.gameObject:AddComponent(typeof(CS.UnityEngine.UI.Shadow));
	compo.effectColor = CS.UnityEngine.Color(0.678,0.678,0.678,0.867);
	compo.effectDistance = CS.UnityEngine.Vector2(2.0,2.0);
	
	compo = self.textColorranSpecify.gameObject:AddComponent(typeof(CS.UnityEngine.UI.Shadow));
	compo.effectColor = CS.UnityEngine.Color(0.678,0.678,0.678,0.867);
	compo.effectDistance = CS.UnityEngine.Vector2(2.0,2.0);
	
	compo = nil;
end
util.hotfix_ex(CS.CommonClothesColorLabelController,'Start',Start)