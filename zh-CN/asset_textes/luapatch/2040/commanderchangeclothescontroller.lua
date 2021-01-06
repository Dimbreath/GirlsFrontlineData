local util = require 'xlua.util'
xlua.private_accessible(CS.CommanderChangeClothesController)
local CommanderChangeClothesController_ChangeSpineCloth = function(self,newCloth,colorPic)
	 if self.commanderSpine ~= nil then
	 	self.commanderSpine:ChangeClothes(newCloth, colorPic, false);
	 end
	 self:CheckButtonState();
end
local CommanderChangeClothesController_TryClothOn = function(self,newCloth)
	 self.clothLabel:TryClothOn(newCloth);
	 self:CheckStageAndSpineEffect(self:GetCurrentDress());
end
local CommanderChangeClothesController_OpenPresetList = function(self)
	if self.tweenPosPresetBtn ~= nil and self.tweenPosPresetBtn.from ~= self.buttonPreset.transform.localPosition then
		self.tweenPosPresetBtn.from = self.buttonPreset.transform.localPosition;
		self.tweenPosPresetBtn.to = CS.UnityEngine.Vector3(self.buttonPreset.transform.localPosition.x, self.buttonPreset.transform.localPosition.y+41.0,0);
	end
	if self.objectPresetList.activeSelf == false then
		self.tweenPosPresetBtn.ToFrom = false;
        self.tweenPosPresetBtn:Play();

        self.objectPresetList:SetActive(true);
        self.objectPresetList.transform:SetAsLastSibling();
        CS.CommanderPresetListController.Instance:InitView(true);
        CS.CommanderPresetListController.Instance:EntryAnimation();
	end
end
xlua.hotfix(CS.CommanderChangeClothesController,'ChangeSpineCloth',CommanderChangeClothesController_ChangeSpineCloth)
xlua.hotfix(CS.CommanderChangeClothesController,'TryClothOn',CommanderChangeClothesController_TryClothOn)
xlua.hotfix(CS.CommanderChangeClothesController,'OpenPresetList',CommanderChangeClothesController_OpenPresetList)