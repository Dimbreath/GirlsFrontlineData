local util = require 'xlua.util'
xlua.private_accessible(CS.BattleUIDamageController)
xlua.private_accessible(CS.BattleDamageTextController)
local PreloadText = function(self)
	self:PreloadText();
	local text = self.listTextPool:Peek();
	if text.images == nil then
		text:Awake();
	end
	text = nil;
end
util.hotfix_ex(CS.BattleUIDamageController,'PreloadText',PreloadText)