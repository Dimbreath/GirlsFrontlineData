local util = require 'xlua.util'
xlua.private_accessible(CS.DormController)
local RefreshAllInteractPoint = function()
	CS.DormController.instance:GetInteractPointList();
end
local DormController_InitEstablishRoom = function(self)
	self:InitEstablishRoom();
	RefreshAllInteractPoint();
end
local DormController_LoadDorm = function(self,floor)
	self:LoadDorm(floor);
	CS.DormController.instance:SetInteractPointStateDirty();
	RefreshAllInteractPoint();
end
local DormController_EnterEditMode = function(self)
	self:EnterEditMode();
	if self.m_CommanderSpine ~= nil then
		self.m_CommanderSpine:PauseAI();
	end
	self.commandSpineHolder.gameObject:SetActive(false);
end
local DormController_ExitEditMode = function(self)
	self:ExitEditMode();
	self.commandSpineHolder.gameObject:SetActive(true);
	if self.m_CommanderSpine ~= nil then
		self.m_CommanderSpine:ResumeAI();
	end
	RefreshAllInteractPoint();
end
local DormController_LoadTeam = function(self,teamId)
	if teamId == 101 then
		self.listCharacterCurrentFloor:Clear();
	else
		self:LoadTeam(teamId);
	end
end
local DormController_LoadCommander = function(self,teamId)
	if teamId < 100 then
		self:LoadCommander(teamId);
	end
end
util.hotfix_ex(CS.DormController,'InitEstablishRoom',DormController_InitEstablishRoom)
util.hotfix_ex(CS.DormController,'LoadDorm',DormController_LoadDorm)
util.hotfix_ex(CS.DormController,'EnterEditMode',DormController_EnterEditMode)
util.hotfix_ex(CS.DormController,'ExitEditMode',DormController_ExitEditMode)
util.hotfix_ex(CS.DormController,'LoadTeam',DormController_LoadTeam)
util.hotfix_ex(CS.DormController,'LoadCommander',DormController_LoadCommander)