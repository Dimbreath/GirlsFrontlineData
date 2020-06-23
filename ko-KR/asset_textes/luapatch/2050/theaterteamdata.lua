local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterTeamData)

local DecodeTeamFairy = function(self,jsonFairy)
	self:DecodeTeamFairy(jsonFairy);
	local maxChanged = false;
	for i = 1, 10 do
		if i > self.maxTeamEdited and self.dictTeamFairy:ContainsKey(i) then
			self.maxTeamEdited = i;
			maxChanged = true;
		end
	end
	if maxChanged then
		self:RefreshAllFairyList();
	end
	maxChanged = nil;
end

util.hotfix_ex(CS.TheaterTeamData,'DecodeTeamFairy',DecodeTeamFairy)
