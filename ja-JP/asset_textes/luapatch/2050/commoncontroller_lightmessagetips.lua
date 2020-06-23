local util = require 'xlua.util'
xlua.private_accessible(CS.CommonController)

local LightMessageTips = function(message)
	if message == "TODO已达等级上限" then
		message = CS.Data.GetLang(31886);
	end
	CS.CommonLiteMessageController.Instance:Init();
	CS.CommonLiteMessageController.Instance:Show(message);
end
util.hotfix_ex(CS.CommonController,'LightMessageTips',LightMessageTips)