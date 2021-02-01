local util = require 'xlua.util'
xlua.private_accessible(CS.DormEstablishmentController)
xlua.private_accessible(CS.GF.ExploreDrama.ExploreDramaController)

local OnDestroy = function(self)

	self:OnDestroy()	
	if ((CS.GF.ExploreDrama.ExploreDramaController.instance ~=nil and (not CS.GF.ExploreDrama.ExploreDramaController.instance:isNull()))
	and (CS.DormController.instance ~=nil and (not CS.DormController.instance:isNull()))
	and (CS.DormController.currentRoom ~= CS.EstablishRoom.ExploreRoom or DormController.instance.currentMode ~= CS.DormController.DormMode.Establish)) then
		CS.GF.ExploreDrama.ExploreDramaController._instance = nil
	end
	
end
util.hotfix_ex(CS.DormEstablishmentController,'OnDestroy',OnDestroy)
