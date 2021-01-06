local util = require 'xlua.util'
xlua.private_accessible(CS.MallTopController)
xlua.private_accessible(CS.CommonItemIconController)
local Init = function(self, listItemInfo)
	self:Init(listItemInfo);
	if self.listItemIcon.Count > 3 then
		local tipComp;
		for i = 0, self.listItemIcon.Count - 1 do
			tipComp = self.listItemIcon[i].gameObject:AddComponent(typeof(CS.CommonShowTip));
			tipComp.strTitle = listItemInfo[i].name;
			tipComp:SetOffset(CS.UnityEngine.Vector3(0,100,0));
			self.listItemIcon[i].txItemName.text = '';
		end
		tipComp = nil;
	end
end
util.hotfix_ex(CS.MallTopController,'Init',Init)