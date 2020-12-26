local util = require 'xlua.util'
xlua.private_accessible(CS.SpecialOPSController)

local OpenDetailPanel = function(self,mission)
	self.MMissionInfoPanel.transform:SetParent(self.transform,false);
	self:OpenDetailPanel(mission);
end

local LoadGoto = function(self)
	self:LoadGoto();
	local iter = CS.OPSConfig.Instance.OPSGoto:GetEnumerator() 	
	while iter:MoveNext() do
		local v = iter.Current.Value;
		local obj = self.leftMain:GetChild(self.leftMain.childCount-1);
		local button = obj:GetComponent(typeof(CS.ExButton));
		if button ~= nil then
			button.onClick:RemoveAllListeners();
			button:AddOnClick(function()
					if v == 0 then
						CS.MallController.JumpToMall(6);
					elseif v == 1 then
						CS.SpecialOPSController.openEventForce = true;
						CS.CommonController.GotoScene("Home", 1);
					elseif v == 2 then
						CS.CommonController.GotoScene("ActivityEventPrize");
					end
			end
			)
		end	                               
	end
end
util.hotfix_ex(CS.SpecialOPSController,'OpenDetailPanel',OpenDetailPanel)
util.hotfix_ex(CS.SpecialOPSController,'LoadGoto',LoadGoto)