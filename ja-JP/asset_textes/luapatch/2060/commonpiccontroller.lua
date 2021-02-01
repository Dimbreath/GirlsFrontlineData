local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPicController)
local SwitchDamaged = function(self,isHurt,image)
	self:SwitchDamaged(isHurt, image);
	if self.passData ~= nil and self.passData.enabled then
		if isHurt then
			local name = string.gsub(self.gameObject.name, 'big%(Clone%)', "");
			name = name.."Pass_D";
			local tex = CS.ResManager.GetObjectByPath("WorldCollide/TheDivision/"..name,".png");
			self.arrMat:SetTexture("_PassAnimTex", tex);
			tex = nil;
			name = nil;
		else
			self.arrMat:SetTexture("_PassAnimTex", self.passData.passAnimTex);
		end
	end
end
util.hotfix_ex(CS.CommonPicController,'SwitchDamaged',SwitchDamaged)