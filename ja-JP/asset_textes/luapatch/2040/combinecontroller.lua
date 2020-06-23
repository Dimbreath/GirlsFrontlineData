local util = require 'xlua.util'
xlua.private_accessible(CS.CombineController)
local SpinePlayJoinAnime = function(self)
	local number = self.mainGunItem.gun.number;
	self.SpineGrounp[number - 1].gameObject:SetActive(true);
	self.listSpine[number - 1].state:SetAnimation(0,'wait',true)
	self.listSpine[number - 1].state:AddAnimation(0,'victory',false,1.0)
	self.listSpine[number - 1].state:AddAnimation(0,'wait',true,0)
	self.SpineAnimeGrounp[number - 1]:Play();
end
xlua.hotfix(CS.CombineController,'SpinePlayJoinAnime',SpinePlayJoinAnime)