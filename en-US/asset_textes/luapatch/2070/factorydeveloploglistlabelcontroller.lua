local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryDevelopLogListLabelController)

local InitUIElements = function(self)
	self:InitUIElements();
	local texIcon = nil;
	if self.arrSpriteEquipType.Length > 15 then
		texIcon = CS.ResManager.GetObjectByPath("AtlasClips2070/EquipType16",".png");
		if texIcon ~= nil then
			self.arrSpriteEquipType[15] = CS.ExSprite.Create(texIcon,CS.UnityEngine.Rect(0,0,128,128),CS.UnityEngine.Vector2(0.5,0.5));
		end
		texIcon = nil;
	end
	if self.arrSpriteEquipType.Length > 16 then
		texIcon = CS.ResManager.GetObjectByPath("AtlasClips2070/EquipType17",".png");
		if texIcon ~= nil then
			self.arrSpriteEquipType[16] = CS.ExSprite.Create(texIcon,CS.UnityEngine.Rect(0,0,128,128),CS.UnityEngine.Vector2(0.5,0.5));
		end
		texIcon = nil;
	end
end

util.hotfix_ex(CS.FactoryDevelopLogListLabelController,'InitUIElements',InitUIElements)


