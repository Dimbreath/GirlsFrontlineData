local util = require 'xlua.util'
xlua.private_accessible(CS.SquadGetPerformance)
local DoStar = function(self)
	if self.starIndex < self.starNum then
		self:DoStar();
		local trans = self:starHolder(self.starIndex - 1);
		local transSub = nil;
		if trans.childCount > 0 then
			for i = 0, trans.childCount - 1 do
				transSub = trans:GetChild(i);
				transSub.gameObject.layer = self.gameObject.layer;
				if transSub.childCount > 0 then
					for j = 0, transSub.childCount - 1 do
						transSub:GetChild(j).gameObject.layer = self.gameObject.layer;
					end
				end
			end
		end
		trans = nil;
		transSub = nil;
	end
end
util.hotfix_ex(CS.SquadGetPerformance,'DoStar',DoStar)