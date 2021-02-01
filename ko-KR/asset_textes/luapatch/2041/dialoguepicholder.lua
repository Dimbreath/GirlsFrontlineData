local util = require 'xlua.util'
xlua.private_accessible(CS.DialoguePicHolder)

local DialoguePicHolder_SetSprite = function(self,image,order)
	self:SetSprite(image,order);
	local alphaTex = self:alphaTexture(order);
	if image.material ~= nil and alphaTex ~= nil then
		image.material = CS.UnityEngine.Object.Instantiate(self.ArrMat);
		image.material:SetTexture("_AlphaTex",alphaTex);
	end
end
util.hotfix_ex(CS.DialoguePicHolder,'SetSprite',DialoguePicHolder_SetSprite)