local util = require 'xlua.util'
xlua.private_accessible(CS.DrawEventController)
local OnClickDraw1 = function(self)
	if CS.GameData.listFurniture == nil then
		local createConnection = xlua.get_generic_method(CS.ConnectionController, 'CreateConnection');
		local createRequestDorm = createConnection(CS.RequestSelfDormInfo);
		createRequestDorm(CS.RequestSelfDormInfo(), function(req)
			self:OnClickDraw1();
		end, nil);
		createConnection = nil;
		createRequestDorm = nil;
	else
		self:OnClickDraw1();
	end
end
local OnClickDraw10 = function(self)
	if CS.GameData.listFurniture == nil then
		local createConnection = xlua.get_generic_method(CS.ConnectionController, 'CreateConnection');
		local createRequestDorm = createConnection(CS.RequestSelfDormInfo);
		createRequestDorm(CS.RequestSelfDormInfo(), function(req)
			self:OnClickDraw10();
		end, nil);
		createConnection = nil;
		createRequestDorm = nil;
	else
		self:OnClickDraw10();
	end
end
util.hotfix_ex(CS.DrawEventController,'OnClickDraw1',OnClickDraw1)
util.hotfix_ex(CS.DrawEventController,'OnClickDraw10',OnClickDraw10)