local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPicController)
local CheckPos = function(self)
	if CS.ConfigData.hexie then
		self.hurt = false;
	end
	self:CheckPos();
end

local GetCurrentPosData = function(self,sceneName,fatherName,rootName)
	if sceneName == "Home" and fatherName == "Live2DCanvas" and rootName == "btnPicHolder/Live2DCanvas/" then
		fatherName = "Canvas";
		rootName = "btnPicHolder/Canvas/";
	end	
	return  self:GetCurrentPosData(sceneName,fatherName,rootName);
end
util.hotfix_ex(CS.CommonPicController,'CheckPos',CheckPos)
util.hotfix_ex(CS.CommonPicController,'GetCurrentPosData',GetCurrentPosData)