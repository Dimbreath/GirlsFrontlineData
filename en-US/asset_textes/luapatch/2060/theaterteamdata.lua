local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterTeamData)
local ChangeLifeToOrigin = function(self)
	self:ChangeLifeToOrigin();
	local iter = self.dictOriginalLifeWithSwuId:GetEnumerator();
	local gun;
	while iter:MoveNext() do
		gun = CS.GameData.listSangvisGun:GetDataById(iter.Current.Key);
		if gun ~= nil then
			print('change life', iter.Current.Key, iter.Current.Value);
			gun.life = iter.Current.Value;
		end
	end
	iter = nil;
end
local tableNumberS;
local tableNumberG;
local ChangeGunNumberToOne = function(self)
	print('ChangeGunNumberToOne');
	tableNumberS = {};
	tableNumberG = {};
	local iter = self.dictTeamGun:GetEnumerator();
	local gun = nil;
	while iter:MoveNext() do
		for i = 0, iter.Current.Value.Count - 1 do
			gun = iter.Current.Value[i];
			if gun ~= nil then
				if gun.sangvisInfo ~= nil then
					tableNumberS[gun.id] = gun.number;
				else
					tableNumberG[gun.id] = gun.number;
				end
				gun.number = 1;
			end
		end
	end
	iter = nil;
	gun = nil;
end
local ChangeGunNumberToOrigin = function(self)
	print('ChangeGunNumberToOrigin');
	local iter = self.dictTeamGun:GetEnumerator();
	local gun = nil;
	while iter:MoveNext() do
		for i = 0, iter.Current.Value.Count - 1 do
			gun = iter.Current.Value[i];
			if gun ~= nil then
				if gun.sangvisInfo ~= nil then
					if tableNumberS[gun.id] ~= nil then
						gun.number = tableNumberS[gun.id];
					end
				else
					if tableNumberG[gun.id] ~= nil then
						gun.number = tableNumberG[gun.id];
					end
				end
			end
		end
	end
	iter = nil;
	gun = nil;
	tableNumberS = nil;
	tableNumberG = nil;
end
util.hotfix_ex(CS.TheaterTeamData,'ChangeLifeToOrigin',ChangeLifeToOrigin)
util.hotfix_ex(CS.TheaterTeamData,'ChangeGunNumberToOne',ChangeGunNumberToOne)
util.hotfix_ex(CS.TheaterTeamData,'ChangeGunNumberToOrigin',ChangeGunNumberToOrigin)