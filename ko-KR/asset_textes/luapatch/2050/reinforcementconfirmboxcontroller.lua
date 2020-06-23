local util = require 'xlua.util'
xlua.private_accessible(CS.ReinforcementConfirmBoxController)

local ReinforcementConfirmBoxController_InitForDeployment = function(self,gun)
	for i=0,CS.GameData.listSpotAction.Count-1 do
		local spotAction = CS.GameData.listSpotAction:GetDataByIndex(i);
		if spotAction.sangvisTeamId ~= 0 then
			spotAction.friendlyTeamId = spotAction.sangvisTeamId;
		end
	end
	self:InitForDeployment(gun);
	for i=0,CS.GameData.listSpotAction.Count-1 do
		local spotAction = CS.GameData.listSpotAction:GetDataByIndex(i);
		if spotAction.sangvisTeamId ~= 0 then
			spotAction.friendlyTeamId = 0;
		end
	end
end
local InitUIElements = function(self)
	self:InitUIElements();
	-- 补充语言包
	self.uiHolder:GetUIElement("NormalFixNode/Normal/Repair", typeof(CS.ExText)).text = CS.Data.GetLang(50011);
	self.uiHolder:GetUIElement("NormalFixNode/background/TexGrid/Text_修复契约", typeof(CS.ExText)).text = CS.Data.GetLang(33063);
end
local RefreshQuickFixRequire = function(self)
	self:RefreshQuickFixRequire();
	self.uiHolder:GetUIElement("NormalFixNode/Normal/Repair", typeof(CS.ExText)).text = CS.System.String.Format(CS.Data.GetLang(50015), self.needQuickFix);
end
util.hotfix_ex(CS.ReinforcementConfirmBoxController,'InitForDeployment',ReinforcementConfirmBoxController_InitForDeployment)
util.hotfix_ex(CS.ReinforcementConfirmBoxController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.ReinforcementConfirmBoxController,'RefreshQuickFixRequire',RefreshQuickFixRequire)