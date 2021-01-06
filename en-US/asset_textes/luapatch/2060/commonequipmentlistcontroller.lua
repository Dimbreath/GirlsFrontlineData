local util = require 'xlua.util'
xlua.private_accessible(CS.CommonEquipmentListController)
xlua.private_accessible(CS.FactoryController)
local _OnDisable = function(self)
	if self.listType == CS.EquipListType.StrengthenFeed then
		self.clickCount = 0;
		self.textIntelligentConfirmTips.text = CS.System.String.Format(CS.Data.GetLang(32120),CS.Data.GetLang(32179));
	end
	if CS.CommonCharacterListController.Instance == nil then
		self.listType = CS.EquipListType.Formation;
	end
	self:OnDisable();
	if CS.FactoryController.Instance ~=nil and CS.FactoryController.Instance.currentType == CS.FactoryUIType.Retire then
		CS.FactoryController.Instance.toggleChoose:SetActive(false);		 
	end 
end
local myCreateList = function(self, ...)
	for i = 0, self.arrGoCategory.Length - 1, 1 do
        self.arrGoCategory[i]:SetActive(true);
	end
	self:CreateList(...);
	
end
local _OnDestroy = function(self)
	self.transform.SwitchSidebar("", false);
	self:OnDestroy();
end
local _InitUIElements = function(self)
	self:InitUIElements();
	self.transform.SwitchSidebar("", true);
end
local myRefreshSuitData = function(self)
	local gun = nil;
    if CS.GunStateController.Instance ~= nil then
        gun = CS.GunStateController.Instance.gun;
    elseif CS.UISimulatorFormation.isExist then
        gun = CS.UISimulatorFormation.Instance.canvasBoxSelectedGun;
    elseif CS.FormationController.Instance ~= nil then
        gun = CS.FormationController.Instance.canvasBoxSelectedGun;
    end
	if(gun ~= nil) then
			for i = 0, 3, 1 do
				local e = CS.Equip();
				e.id = -1000;
				e.info = CS.EquipInfo();
				e.info.equip_group_id = 0;
				gun.equipList:Add(e);
			end
	end
	self:RefreshSuitData();
	gun.equipList:RemoveAll(
	function(s) 
		return s.id == -1000;
	end);
end
util.hotfix_ex(CS.CommonEquipmentListController,'OnDisable',_OnDisable)
util.hotfix_ex(CS.CommonEquipmentListController,'CreateList',myCreateList)
util.hotfix_ex(CS.CommonEquipmentListController,'OnDestroy',_OnDestroy)
util.hotfix_ex(CS.CommonEquipmentListController,'InitUIElements',_InitUIElements)
util.hotfix_ex(CS.CommonEquipmentListController,'RefreshSuitData',myRefreshSuitData)