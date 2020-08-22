local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGashaResultItemController)
xlua.private_accessible(CS.SangvisCaptureNormalController)
xlua.private_accessible(CS.CommonGetNewSangvisGunController)
local myInit = function(self,gun,followTarget,yPos)
    self:Init(gun,followTarget,yPos)
	print("spPrint");
	self.spineObj:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sortingOrder = 12;
end
local myNormalInit = function(self,sangvisGun,pge)
    self:Init(sangvisGun,pge)
	if(self.isSuccess == true) then
		if(self.sangvisHolder.childCount > 0) then
			print("normalPrint");
			self.sangvisHolder:GetChild(0):GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sortingOrder = 12;
		end
	end
end
local mySetResolution = function(self,num,isFull)
	if(self:resolutionImgIndex(0):GetComponent(typeof(CS.UnityEngine.CanvasGroup)) == nil) then
		self:resolutionImgIndex(0).gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup));
	end
	print("setResolution");
	self:SetResolution(num,isFull)
end
util.hotfix_ex(CS.SangvisGashaResultItemController,'Init',myInit)
util.hotfix_ex(CS.SangvisCaptureNormalController,'Init',myNormalInit)
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'SetResolution',mySetResolution)
