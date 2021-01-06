local util = require 'xlua.util'
xlua.private_accessible(CS.CommonListController)
xlua.private_accessible(CS.CommonListHolder)
local inst;
local MethodUpdateUI = function()
	if inst ~= nil then
		inst:UpdateUI();
		inst = nil;
	end
end
local InitData = function(self,controller,info)
	local initData_generic = xlua.get_generic_method(CS.CommonListHolder, 'InitData');
	local initData = initData_generic(info:GetType());
	initData(self,controller,info);
	if inst == nil then
		inst = controller;
		CS.CommonController.Invoke(MethodUpdateUI, 0.1, self, true);
	end
end
util.hotfix_ex(CS.CommonListHolder,'InitData',InitData)
