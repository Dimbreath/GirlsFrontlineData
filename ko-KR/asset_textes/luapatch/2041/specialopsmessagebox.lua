local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialOPSMessageBox)

local SpecialOPSMessageBox_InitUI = function(self)
	self:InitUIElements();
	self.transform:Find("SecretInfoFrame/Btn_Yes"):GetComponent(typeof(CS.ExButton)).onClick:AddListener(function()
		self:OnClickCancle();
	end)
end

local SpecialOPSMessageBox__ShowUnclockMission = function(self,num,handler)
	self:ShowUnclockMission(num,handler);
	self.transform:Find("SecretInfoFrame").gameObject:SetActive(false);
end

local SpecialOPSMessageBox_ShowDetailPanel = function(self)
	self:ShowDetailPanel();
	local itemRealNum = CS.OPSPanelController.Instance.item_use[CS.OPSPanelController.showItemId[0]].itemRealNum;
	local ItemTodayCost = CS.OPSPanelController.Instance.item_use[CS.OPSPanelController.showItemId[0]].ItemTodayCost;
	local ItemResetLimitNum = CS.OPSPanelController.Instance.item_use[CS.OPSPanelController.showItemId[0]].ItemResetLimitNum;
	local hasget = CS.OPSPanelController.Instance:HasUnclockItemNum(CS.OPSPanelController.showItemId[0]);
	local all = itemRealNum + hasget;
	print(itemRealNum);
	print(ItemTodayCost);
	print(ItemResetLimitNum);
	self.transform:Find("InfoFrame/Tex_Point "):GetComponent(typeof(CS.ExText)).text = itemRealNum;
	self.transform:Find("InfoFrame/LimitAmount/Score/Tex_ScoreSurplus"):GetComponent(typeof(CS.ExText)).text = ItemTodayCost;
	self.transform:Find("InfoFrame/LimitAmount/Score/Tex_ScoreAdd"):GetComponent(typeof(CS.ExText)).text = '+'..ItemResetLimitNum;
	self.transform:Find("InfoFrame/ExplainNode/Tex_CurrPointMessage"):GetComponent(typeof(CS.ExText)).text = CS.System.String.Format(CS.Data.GetLang(60042),all,hasget);
end
util.hotfix_ex(CS.SpecialOPSMessageBox,'InitUIElements',SpecialOPSMessageBox_InitUI)
util.hotfix_ex(CS.SpecialOPSMessageBox,'ShowUnclockMission',SpecialOPSMessageBox__ShowUnclockMission)
util.hotfix_ex(CS.SpecialOPSMessageBox,'ShowDetailPanel',SpecialOPSMessageBox_ShowDetailPanel)