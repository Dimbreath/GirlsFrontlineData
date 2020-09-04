local util = require 'xlua.util'
xlua.private_accessible(CS.SangvisGashaResultItemController)
xlua.private_accessible(CS.SangvisCaptureNormalController)
xlua.private_accessible(CS.CommonGetNewSangvisGunController)
local myInit = function(self,gun,followTarget,yPos)
    self:Init(gun,followTarget,yPos)
	self.spineObj:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sortingOrder = 13;
end
local myNormalInit = function(self,sangvisGun,pge)
    self:Init(sangvisGun,pge)
	if(self.isSuccess == true) then
		if(self.sangvisHolder.childCount > 0) then
			self.sangvisHolder:GetChild(0):GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sortingOrder = 13;
		end
	end
end
local mySetResolution = function(self,num,isFull)
	local obj = self:resolutionImgIndex(0):GetComponent(typeof(CS.UnityEngine.CanvasGroup));
	if(obj == nil or obj:isNull()) then
		self:resolutionImgIndex(0).gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup));
	end
	self:SetResolution(num,isFull)
end
local myInitWithSingleBossData = function(self, bosA)
	self:InitWithSingleBossData(bosA);
	
	if (self.certainObj ~= nil) then
		local obj = self.certainObj:GetComponent(typeof(CS.UnityEngine.Canvas)) ;
		if(obj == nil or obj:isNull()) then
			local canvas = self.certainObj:AddComponent(typeof(CS.UnityEngine.Canvas));
			self.certainObj:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster));
			canvas.overrideSorting = true;
			canvas.sortingOrder = 11;
		end
	end
end
local myStart = function(self)
    self:Start()
	local obj = self.canvas:GetComponent(typeof(CS.UnityEngine.Canvas));
	if(obj ~= nil and obj:isNull() == false) then
		obj.sortingOrder = 13;
	end
end
local myDrawStart = function(self)
    self:Start()
	local obj = self:GetComponent(typeof(CS.UnityEngine.Canvas));
	if(obj~= nil and obj:isNull() == false) then
		obj.sortingOrder = 12;
	else
		local canvas = self.gameObject:AddComponent(typeof(CS.UnityEngine.Canvas));
		self.gameObject:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster));
		canvas.overrideSorting = true;
		canvas.sortingOrder = 12;
	end
end
local myInitUIElements = function(self)
    self:InitUIElements()
	self.gameObject.layer = 5
	local obj = self:GetComponent(typeof(CS.UnityEngine.Canvas))
	if(obj ~= nil and obj:isNull() == false) then
		obj.sortingOrder = 12;
	else
		local canvas = self.gameObject:AddComponent(typeof(CS.UnityEngine.Canvas));
		self.gameObject:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster));
		canvas.overrideSorting = true;
		canvas.sortingOrder = 12;
	end
end
local mySetCommander = function(self)
	local commanderHolder;
	if(self.isSuccess == true) then
		commanderHolder = self.commanderSucessHolder;
	else
		commanderHolder = self.commanderFaildHolder;
	end
	
        local commanderSpine = CS.CommanderSpine.GetCommanderSpine(CS.GameData.commanderUserInfo);
        commanderSpine.transform.localScale = CS.UnityEngine.Vector3(150, 150, 150);
        commanderSpine.transform:SetParent(commanderHolder, false);
        local path = CS.Data.CheckCommanderSpineEffect(CS.GameData.commanderUserInfo.dressedUniformList);
        if (CS.System.String.IsNullOrEmpty(path) == false) then
            commanderSpine:AddUniformEffect(path, 1);
		end
        if (self.isSuccess == true) then
            commanderSpine.transform.localPosition = CS.UnityEngine.Vector3(0, -140, 0);
            commanderSpine:SetBodyAnimation("victory", false);
            commanderSpine:AddBodyAnimation("wait", true, 0);
        else
            commanderSpine.transform.localPosition = CS.UnityEngine.Vector3(0, -105, 0);
            commanderSpine:SetBodyAnimation("sit", true);
            local info = CS.GameData.listCommanderUniformInfo:GetDataById(9920);
            if (info ~= null) then
               commanderSpine:ChangeClothes(info, info.color_normal, false);
			end
		end
        commanderSpine:SetLayer("UI");
        commanderSpine:SetOrderInLayer(12);
        CS.SangvisCaptureResultContainer.Instance:CanClose();
end

util.hotfix_ex(CS.SangvisGashaResultItemController,'Init',myInit)
util.hotfix_ex(CS.SangvisCaptureNormalController,'Init',myNormalInit)
util.hotfix_ex(CS.SangvisCaptureNormalController,'SetCommander',mySetCommander)
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'SetResolution',mySetResolution)
util.hotfix_ex(CS.SangvisCaptureBossAreaController,'InitWithSingleBossData',myInitWithSingleBossData)
util.hotfix_ex(CS.CommonGetNewSangvisGunController,'Start',myStart)
util.hotfix_ex(CS.SangvisGashaponDrawBoxController,'Start',myDrawStart)
util.hotfix_ex(CS.SangvisCaptureResultContainer,'InitUIElements',myInitUIElements)

