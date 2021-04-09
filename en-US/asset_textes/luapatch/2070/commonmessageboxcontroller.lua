local util = require 'xlua.util'
xlua.private_accessible(CS.CommonMessageBoxController)
local ShowRewardListItem = function(self,content,condition)
	local packageInfo = {};
	for i = 0,content.listItemPackage.Count-1 do
		if content.listItemPackage[i].info.type == 9 and content.listItemPackage[i].lastGetNum == 0 then
			table.insert(packageInfo,content.listItemPackage[i]);	
		end
	end
	for i = 1, #(packageInfo) do
		content.listItemPackage:Remove(packageInfo[i]);
	end
	self:ShowRewardListItem(content,condition);
end

local Show = function(self,delay)
	self:Show(delay);
	if CS.SpecialActivityController.Instance ~= nil and not CS.SpecialActivityController.Instance:isNull() then
		local canvas = self.transform:GetComponent(typeof(CS.UnityEngine.Canvas));
		canvas.planeDistance = 0.05;
	end
end

util.hotfix_ex(CS.CommonMessageBoxController,'ShowRewardListItem',ShowRewardListItem)
util.hotfix_ex(CS.CommonMessageBoxController,'Show',Show)
