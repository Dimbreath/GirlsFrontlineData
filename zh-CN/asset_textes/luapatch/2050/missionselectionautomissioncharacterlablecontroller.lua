local util = require 'xlua.util'
xlua.private_accessible(CS.MissionSelectionAutoMissionCharacterLableController)
local Init = function(self,id,clearButtonEvent)
	self:Init(id,clearButtonEvent);
	if self.arrSpriteTeamId.Length <= 10 then
		local cacheArr = self.arrSpriteTeamId;
		local newArr = {};
		for i = 1, 10 do
			table.insert(newArr, i, cacheArr[i - 1]);
		end
		local tempSprite;
		local tempT2d;
		for i = 11, 14 do
			tempT2d = CS.ResManager.GetObjectByPath("DaBao/AtlasClips2050/auto_team_"..tostring(i),".png");
			tempSprite = CS.ExSprite.Create(tempT2d, CS.UnityEngine.Rect(0,0,67,54), CS.UnityEngine.Vector2(33.5,27));
			table.insert(newArr, i, tempSprite);
		end
		self.arrSpriteTeamId = newArr;
		cacheArr = nil;
		newArr = nil;
	end
end
util.hotfix_ex(CS.MissionSelectionAutoMissionCharacterLableController,'Init',Init)