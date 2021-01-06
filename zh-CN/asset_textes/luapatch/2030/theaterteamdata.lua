local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterTeamData)
local DecodeTeamFairy = function(self,jsonFairy)
	self:DecodeTeamFairy(jsonFairy);
	local iter = self.dictTeamFairy:GetEnumerator();
	while iter:MoveNext() do
		if iter.Current.Key > self.maxTeamEdited then
			self.maxTeamEdited = iter.Current.Key;
		end
	end
	iter = nil;
	self:RefreshAllFairyList();
end

util.hotfix_ex(CS.TheaterTeamData,'DecodeTeamFairy',DecodeTeamFairy)