local util = require 'xlua.util'
xlua.private_accessible(CS.HomeEventController)
local OnClickSubmitCDKey = function(self)
	if CS.GameData.listFurniture == nil then
		local createConnection = xlua.get_generic_method(CS.ConnectionController, 'CreateConnection');
		local createRequestDorm = createConnection(CS.RequestSelfDormInfo);
		createRequestDorm(CS.RequestSelfDormInfo(), function(req)
			self:OnClickSubmitCDKey();
		end, nil);
		createConnection = nil;
		createRequestDorm = nil;
	else
		self:OnClickSubmitCDKey();
	end
end
util.hotfix_ex(CS.HomeEventController,'OnClickSubmitCDKey',OnClickSubmitCDKey)