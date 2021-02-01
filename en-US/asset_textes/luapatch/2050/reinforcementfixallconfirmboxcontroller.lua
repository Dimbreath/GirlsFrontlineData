local util = require 'xlua.util'
xlua.private_accessible(CS.ReinforcementFixAllConfirmBoxController)

local ReinforcementFix_RefreshData = function(self)
	self:RefreshData();
	if CS.GameData.listSpotAction:Exists(function(g) return g.friendlyTeamId == self.teamId or g.sangvisTeamId == self.teamId; end) then
		self.inBattle = true;
	else
		self.inBattle = false;		
	end
	if self.inBattle then
		self.mp = self.mp*2;
		self.ammo = self.ammo*2;
		self.mre = self.mre*2;
		self.part = self.part*2;
	end
	self.boxController:RefreshUI();
end

util.hotfix_ex(CS.ReinforcementFixAllConfirmBoxController.Data,'RefreshData',ReinforcementFix_RefreshData)