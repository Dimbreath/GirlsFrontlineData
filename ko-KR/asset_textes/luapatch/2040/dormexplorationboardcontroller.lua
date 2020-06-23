local util = require 'xlua.util'
xlua.private_accessible(CS.DormExplorationBoardController)
local InitUIElements = function(self)
	self:InitUIElements();
	CS.CommonAudioController.PlayBGM("AMB_tvmusic_random");
end
local Close = function(self)
	self:Close();
	CS.CommonAudioController.PlayBGM("m_sys_explorationroom");
end
util.hotfix_ex(CS.DormExplorationBoardController,'InitUIElements',InitUIElements)
util.hotfix_ex(CS.DormExplorationBoardController,'Close',Close)