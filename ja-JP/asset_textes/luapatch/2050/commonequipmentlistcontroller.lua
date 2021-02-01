local util = require 'xlua.util'
xlua.private_accessible(CS.CommonEquipmentListController)
xlua.private_accessible(CS.ResearchEquipmentStrengthenController)

local OnClickReturn = function()
	CS.CommonEquipmentListController.Instance:OnClickReturn();
end
local OnEnable = function(self)
	if (self.listType == CS.EquipListType.Store or CS.Utility.loadedLevelName == "StoreRoom") and (self.listType ~= CS.EquipListType.GunState and CS.GunStateController.Instance == nil) then
		return;
	end
	local parentTran;
	if CS.UISimulatorFormation.isExist then
		parentTran = CS.UISimulatorFormation.Instance.transform;
	else
		parentTran = CS.CommonController.MainCanvas.transform;
	end	
	if self.listType == CS.EquipListType.GunState or CS.GunStateController.Instance ~= nil then
		CS.ResearchController.TriggerShowTopLogoEvent(true);
	end
	parentTran:Find("Top/ButtonCancel").gameObject:SetActive(true);
	if (CS.FormationController.Instance ~= null) then
		parentTran:Find("Top/ToggleNode").gameObject:SetActive(false);
	end
	local btnCancel = parentTran:Find("Top/ButtonCancel").gameObject:GetComponent(typeof(CS.ExButton));
	btnCancel.onClick:RemoveAllListeners();
	btnCancel:AddOnClickBack(OnClickReturn);
	if CS.FactoryController.Instance ~= nil and (not CS.FactoryController.Instance:isNull()) then
		CS.FactoryController.Instance.toggleChoose.gameObject:SetActive(false);
	end
	parentTran = nil;
	btnCancel = nil;
end
local OnDisable = function(self)
	
	if (self.listType == CS.EquipListType.Store or CS.Utility.loadedLevelName == "StoreRoom") and (self.listType ~= CS.EquipListType.GunState and CS.GunStateController.Instance == nil) then
		return;
	end
	if (self.listType == CS.EquipListType.StrengthenFeed) then
		self.clickCount = 0;
		self.textIntelligentConfirmTips.text = CS.System.String.Format(CS.Data.GetLang(32179), CS.Data.GetLang(2));
	end
	local parentTran;
	if (CS.UISimulatorFormation.isExist) then
		parentTran = CS.UISimulatorFormation.Instance.transform;
	else
		parentTran = CS.CommonController.MainCanvas.transform;
	end
	parentTran:Find("Top/ButtonCancel").gameObject:SetActive(false);
	parentTran:Find("Top/ButtonCancel").gameObject:GetComponent(typeof(CS.UnityEngine.UI.Button)).onClick:RemoveAllListeners();
	if (CS.FormationController.Instance ~= null) then
		parentTran:Find("Top/ToggleNode").gameObject:SetActive(true);
	end
	self.goLeft:SetActive(false);
	if (self.listType == CS.EquipListType.GunState) then
		if CS.ResearchController.Instance ~= nil and (not CS.ResearchController.Instance:isNull()) and CS.CommonCharacterListController.Instance and (not CS.CommonCharacterListController.Instance:isNull()) and CS.CommonCharacterListController.Instance.listType ~= CS.ListType.mod then
			CS.ResearchController.TriggerShowTopLogoEvent(false);
		end
	end
end
local myOnClickConfirm = function(self)
	local count = self.listCheckedEquip.Count - 1;
	local list = CS.System.Collections.Generic.List(CS.System.Int32)();
	for i = count, 0, -1 do
		if list:Contains(self.listCheckedEquip[i].id) then
			self.listCheckedEquip:RemoveAt(i);
		else
			list:Add(self.listCheckedEquip[i].id);
		end
	end
	self:OnClickConfirm();
end 
local temp = nil
local OnClickIntelligent = function(self)

	if self.listType == CS.EquipListType.StrengthenFeed then
		temp = 0
		for i = 0,self.listCheckedEquip.Count-1 do 
			local item = self.listCheckedEquip[i]
			if item.info.rank == CS.EquipRank.White then
				temp = temp + CS.GameData.GetBasicEquipExpByRarity(2)
			end
			if item.info.rank == CS.EquipRank.Blue then
				temp = temp + CS.GameData.GetBasicEquipExpByRarity(3)
			end
			if item.info.rank == CS.EquipRank.Green then
				temp = temp + CS.GameData.GetBasicEquipExpByRarity(4)
			end
			if item.info.rank == CS.EquipRank.Gold then
				temp = temp + CS.GameData.GetBasicEquipExpByRarity(5)
			end
		end			
	end
	CS.ResearchEquipmentStrengthenController.inst.expCapsule = CS.ResearchEquipmentStrengthenController.inst.expCapsule + temp
	self:OnClickIntelligent()
	CS.ResearchEquipmentStrengthenController.inst.expCapsule = CS.ResearchEquipmentStrengthenController.inst.expCapsule - temp
	temp = nil
end 
local GetLevelToBeAdded = function(self,expAdded)
	if temp ~= nil then
		expAdded = expAdded - self.expCapsule
	end
	return self:GetLevelToBeAdded(expAdded)
end
xlua.hotfix(CS.CommonEquipmentListController,'OnEnable',OnEnable)
util.hotfix_ex(CS.CommonEquipmentListController,'OnDisable',OnDisable)
util.hotfix_ex(CS.CommonEquipmentListController,'OnClickConfirm',myOnClickConfirm)
util.hotfix_ex(CS.CommonEquipmentListController,'OnClickIntelligent',OnClickIntelligent)
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'GetLevelToBeAdded',GetLevelToBeAdded)
