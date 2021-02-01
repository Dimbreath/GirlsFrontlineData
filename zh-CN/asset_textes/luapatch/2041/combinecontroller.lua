local util = require 'xlua.util'
xlua.private_accessible(CS.CombineController)
local myAwake = function(self)
    self:Awake()
	for i = 0, self.arrItem.Length - 1 do
		local btn = self.arrItem[i]:GetComponent(typeof(CS.UnityEngine.UI.Button));
		btn.onClick:RemoveAllListeners();
		local k = i;
		btn.onClick:AddListener(function ()
			self:OnClickAdd(k);
		end)
	end
end
util.hotfix_ex(CS.CombineController,'Awake', myAwake);
