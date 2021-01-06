local util = require 'xlua.util'
xlua.private_accessible(CS.BattleUILifeBarController)
local Init = function(self,character,showLifeBar)
	self:Init(character,showLifeBar)
	self:UpdateInfo(character)
	if character.gun.code == "Eliza_boss" then
		self.source = character.holder
	end
end

util.hotfix_ex(CS.BattleUILifeBarController,'Init',Init)