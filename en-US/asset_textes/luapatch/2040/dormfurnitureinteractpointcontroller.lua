local util = require 'xlua.util'
xlua.private_accessible(CS.DormFurnitureInteractPointController)
xlua.private_accessible(CS.DormController)
local RefreshAllInteractPoint = function()
	CS.DormController.instance:GetInteractPointList();
end
local DormFurnitureInteractPointController_onStateChanged = function(interactPointController)
	RefreshAllInteractPoint();
end
local DormFurnitureInteractPointController_Init = function(self,_index,_furnitureController,_interactPointInfo)
	self:Init(_index,_furnitureController,_interactPointInfo);
	self:onStateChanged("+", DormFurnitureInteractPointController_onStateChanged);
end
local DormFurnitureInteractPointController_DoAnim = function(self,actionInfo)
	if actionInfo ~= nil and actionInfo.furnitureAnim ~= nil then
		self.cacheAnim = actionInfo.furnitureAnim;
	else
		self.cacheAnim = self.interactPointInfo.furnitureAnim;
	end
	if self.cacheAnim ~= nil then
		for i=0,self.cacheAnim.Length-1 do
			self.furnitureController.arrPieceController[i]:PlayAnim(self.cacheAnim[i]);
		end
	end
end
local DormFurnitureInteractPointController_SetInteractingAI = function(self,_aiController)
	if CS.DormController.instance ~= nil and not CS.DormController.instance:isNull() then
		self:SetInteractingAI(_aiController);
	end
end
util.hotfix_ex(CS.DormFurnitureInteractPointController,'Init',DormFurnitureInteractPointController_Init)
util.hotfix_ex(CS.DormFurnitureInteractPointController,'SetInteractingAI',DormFurnitureInteractPointController_SetInteractingAI)
xlua.hotfix(CS.DormFurnitureInteractPointController,'DoAnim',DormFurnitureInteractPointController_DoAnim)
