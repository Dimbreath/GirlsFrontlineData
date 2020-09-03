local util = require 'xlua.util'
xlua.private_accessible(CS.BattleSangvisResultController)
local Init = function(self,jsonData,spotAction)
	if spotAction.lastsangvisteamid > 0 then
		self.sangvisTema = CS.GameData.dictTeam[spotAction.lastsangvisteamid];
	elseif  spotAction.lastsangvisteamid < 0 then
		local friend = CS.GameData.missionAction.saveUid_Friend[-spotAction.lastsangvisteamid];
		self.sangvisTema = friend.sangvisTeam;
	end
	self:Init(jsonData,spotAction);	
	if self.battleController ~= nil then
		self.textEnemyDie.text = tostring(CS.System.String.Format(CS.Data.GetLang(10147),self.battleController.statistics.enemyDieNumber));
		self.textFriendlyDie.text = tostring(CS.System.String.Format(CS.Data.GetLang(10148),self.battleController.statistics.friendlyDieNumber));
	end
end
util.hotfix_ex(CS.BattleSangvisResultController,'Init',Init)