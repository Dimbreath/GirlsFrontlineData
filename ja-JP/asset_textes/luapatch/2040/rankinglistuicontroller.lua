local util = require 'xlua.util'
xlua.private_accessible(CS.RankingListUIController)
local OpenRankingReward = function(self)
	self:OpenRankingReward();
	local canvas = self.WebWindow:GetComponent(typeof(CS.UnityEngine.Canvas));
	if canvas ~= nil then
		canvas.overrideSorting = true;
		canvas.sortingOrder = 200;
		canvas = nil;
	end
end
util.hotfix_ex(CS.RankingListUIController,'OpenRankingReward',OpenRankingReward)