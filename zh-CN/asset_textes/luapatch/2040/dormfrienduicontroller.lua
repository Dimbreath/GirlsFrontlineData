local util = require 'xlua.util'
xlua.private_accessible(CS.DormFriendUIController)
local Init = function(self)
	self:Init();
	if CS.GameData.listFurniture == nil then
		local createConnection = xlua.get_generic_method(CS.ConnectionController, 'CreateConnection');
		local createRequestDorm = createConnection(CS.RequestSelfDormInfo);
		createRequestDorm(CS.RequestSelfDormInfo(), function(req)
				self:Init();
			end, nil);
		createConnection = nil;
		createRequestDorm = nil;
	end
end
util.hotfix_ex(CS.DormFriendUIController,'Init',Init)