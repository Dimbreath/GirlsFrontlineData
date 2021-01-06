local util = require 'xlua.util'
xlua.private_accessible(CS.MallGoodResController)
xlua.private_accessible(CS.ConnectionController)

local myRequestMallListHandler = function(self, www)
	local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text)
	if (jsonData:Contains("mall_list")) then
		CS.GameData.listMallGood:RemoveAll(function(s)
			return s.type == CS.GoodType.gemToDress;
		end)
	end
    self:RequestMallListHandler(www)
end
util.hotfix_ex(CS.MallGoodResController,'RequestMallListHandler',myRequestMallListHandler)