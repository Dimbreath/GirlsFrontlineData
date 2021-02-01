local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentExplainItem)
local RefreshMain = function(self)
	self:RefreshMain();
	local text = self.winTypeInfo.describle;
	if text ~= nil and text ~= '' then
		self.txt_Deco.text = text;
	end
	text = nil;
	if self.winTypeInfo.type == 2302 and self.winTypeInfo.arguments == '0' then
		self.txt_Main.text = self.txt_Deco.text;
		if self.showParent ~= nil then
			self.showParent:Find("Image_Enemy").gameObject:SetActive(true);
		end
	elseif self.winTypeInfo.type == 2403 and self.winTypeInfo.arguments == '0' then
		self.txt_Main.text = self.txt_Deco.text;
		if self.showParent ~= nil then
			self.showParent:Find("Image_Nodraw").gameObject:SetActive(true);
		end
	end
end
local RefreshSmall = function(self,gold,medal)
	local showWin, showFail = self:RefreshSmall(gold,medal);
	local text = self.winTypeInfo.describle;
	if text ~= nil and text ~= '' then
		if self.txt_Deco ~= nil then
			self.txt_Deco.text = text;
		end
		if self.txt_DecoSmall ~= nil then
			self.txt_DecoSmall.text = text;
		end
	end
	text = nil;
	return showWin, showFail;
end

util.hotfix_ex(CS.DeploymentExplainItem,'RefreshMain',RefreshMain)
util.hotfix_ex(CS.DeploymentExplainItem,'RefreshSmall',RefreshSmall)