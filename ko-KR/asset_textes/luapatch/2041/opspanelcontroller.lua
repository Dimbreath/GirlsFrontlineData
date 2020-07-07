local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local OPSPanelController_LoadUI = function(self,campaion)
	self:LoadUI(campaion);
	if campaion == -31 then
		self:LoadItemUI();
	end
end

local OPSPanelController_RefreshUI = function(self)
	self:RefreshUI();
	if self.txtItemNum ~= nil then
		local parent = self.txtItemNum.transform.parent;
		parent:Find("LimitAmount").gameObject:SetActive(true);
		parent:Find("BG").gameObject:SetActive(false);
		parent:Find("UI_Text").gameObject:SetActive(false);
		parent:Find("Tex_Point ").gameObject:SetActive(false);
		--parent:Find("LimitAmount/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(0.94,0.28,0.312,1);
		local itemInfo = self.item_use[CS.OPSPanelController.showItemId[0]];
		self.txtItemLimit.text = itemInfo.ItemTodayCost..'+'..itemInfo.ItemResetLimitNum;
	end
	print(self.campaion);
	if self.itemuiObj ~= nil then
		self.itemuiObj.transform:Find("Btn_TextGroup/Image_Touch").gameObject:SetActive(false);		
		self.itemuiObj.transform:Find("Btn_TextGroup/Btn_Info"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(0,0,0,0);
		self.itemuiObj.transform:Find("Btn_TextGroup/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,0.4687,0.234,1);
		self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Image"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,0.4687,0.234,1);
		self.itemuiObj.transform:Find("SecretLayout/Group_0/ProgressBar/Img_Value"):GetComponent(typeof(CS.ExImage)).color = CS.UnityEngine.Color(1,0.4687,0.234,1);
	end
end

util.hotfix_ex(CS.OPSPanelController,'LoadUI',OPSPanelController_LoadUI)
--util.hotfix_ex(CS.OPSPanelController,'RefreshItemNum',OPSPanelController_RefreshItemNum)
util.hotfix_ex(CS.OPSPanelController,'RefreshUI',OPSPanelController_RefreshUI)
