local util = require 'xlua.util'
xlua.private_accessible(CS.CommonPicLoader.Builder)
local Build = function(self,holder,instantiateImmediately)
	local type = xlua.access(self, "type");
	local skinId = xlua.access(self, "skinId");
	local code = xlua.access(self, "code");
	local finalcode = xlua.access(self, "code_final");
	if type == CS.CommonPicLoader.Builder.LoaderType.GUN_SMALL then
		if string.match(code,'_mod') ~= nil then
			code = string.gsub(code, "_mod", "");
			self:SetGunSmall(code,skinId,finalcode);
		end
	end

	return self:Build(holder, instantiateImmediately);
end
util.hotfix_ex(CS.CommonPicLoader.Builder,'Build',Build)