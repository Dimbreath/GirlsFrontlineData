local util = require 'xlua.util'
xlua.private_accessible(CS.ImageBufferBlurCameraController)

local SetCanvas = function(self, blurcanvas,layer)
	if layer == nil then
		local check = false;
		if not blurcanvas.parentIsCanvasMain and blurcanvas.canvasParent ~= nil and blurcanvas.canvas.rootCanvas ~= CS.ImageBufferBlurRefraction.MessageboxCanvas then
			blurcanvas.parentIsCanvasMain = true;
			check = true;
		end	
		self:SetCanvas(blurcanvas);
		if check then
			blurcanvas.parentIsCanvasMain = false;
		end
		CS.ImageBufferBlurRefraction.MessageboxCanvas.worldCamera = CS.ImageBufferBlurRefraction.depthonlyCamain;	
		if blurcanvas.canvas.transform.parent == CS.ImageBufferBlurRefraction.MessageboxCanvas.transform then
			print("设置"..blurcanvas.canvas.gameObject.name);
			if blurcanvas.canvasParent ~= nil and not blurcanvas.canvasParent:isNull() and blurcanvas.canvasParent.name == "MainController" then
				blurcanvas.canvas.transform:SetParent(self.messageboxRectTransform, false);
				blurcanvas.canvas.transform:SetSiblingIndex(blurcanvas.index);
			end
		end
	else
		self:SetCanvas(blurcanvas,layer);	
	end
end

local RevertCanvas = function(self,blurcanvas)
	self:RevertCanvas(blurcanvas);
	if blurcanvas == nil or blurcanvas.canvas == nil then
		 return;
	end
	CS.ImageBufferBlurRefraction.MessageboxCanvas.worldCamera = CS.ImageBufferBlurRefraction.depthonlyCamain;	
	if blurcanvas.canvasParent ~= nil and not blurcanvas.canvasParent:isNull() and blurcanvas.canvas.transform.parent == blurcanvas.canvasParent then
		print("还原"..blurcanvas.canvas.gameObject.name..blurcanvas.index);
		blurcanvas.canvas.transform:SetSiblingIndex(blurcanvas.index);
	end
end

local AddBuffCanvas = function(blurcanvas)
	CS.ImageBufferBlurCameraController.AddBuffCanvas(blurcanvas);
	if not blurcanvas.hasblurEffect then
		blurcanvas.index = blurcanvas.canvas.transform:GetSiblingIndex();
	end
end
util.hotfix_ex(CS.ImageBufferBlurCameraController,'SetCanvas',SetCanvas)
util.hotfix_ex(CS.ImageBufferBlurCameraController,'RevertCanvas',RevertCanvas)
util.hotfix_ex(CS.ImageBufferBlurCameraController,'AddBuffCanvas',AddBuffCanvas)
