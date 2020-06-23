local util = require 'xlua.util'
xlua.private_accessible(CS.CafeGunMemoirListController)
xlua.private_accessible(CS.DormCafeController)
xlua.private_accessible(CS.DormUIController)
xlua.private_accessible(CS.DormEstablishmentController)
local Va11EventOpen = function()
	if CS.OPSConfig.ContainCampaigns:Contains(-32) then
		local stamp = CS.GameData.GetCurrentTimeStamp();
		if stamp >= CS.OPSConfig.startTime and stamp < CS.OPSConfig.endTime then
			return true;
		end
		stamp = nil;
	end
	return false;
end
local GotoAVG = function(self,id,msg)
	if id == 114514 then
		self.msgAVG = msg
		CS.DormUIController.Instance.gameObject:GetComponent("Canvas").enabled = false
		local fakeGunInfo = CS.GunInfo()
		fakeGunInfo.code = msg
		CS.DormCafeController.instance.CallMemoirCustomer(fakeGunInfo)
		self.fCounter = CS.DormController.instance.listFurnitureControllerCurrentFloor:Find(function(f)
			return type(f) == typeof(CS.DormEstablishmentController) and f.establish.info.id == 40005
		end
		)
		CS.DormUIController.Instance.interactionController:SetLookAtTarget(self.fCounter.transform,CS.UnityEngine.Vector3.up)
		CS.CommonController.Invoke(function()
			if not self.fCounter == nil then
				self.fCounter.arrPieceController[0]:PlayAnim("action")
			end
		end,1,CS.DormUIController.Instance)
		CS.CommonController.Invoke(self:SkipStartAVG(),4.5,CS.DormUIController.Instance)
	else
		self:GotoAVG(id,msg)
	end
end
local InitUIElements = function(self)
	self:InitUIElements();
	if Va11EventOpen() then
		self.transform:Find("Image").gameObject:SetActive(false);
		local bartender = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11_Bartender"));
		bartender.transform:SetParent(self.transform, false);
		bartender.transform:SetSiblingIndex(6);
		bartender = nil;
	end
end
util.hotfix_ex(CS.CafeGunMemoirListController,'GotoAVG',GotoAVG)
util.hotfix_ex(CS.CafeGunMemoirListController,'InitUIElements',InitUIElements)