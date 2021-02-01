local util = require 'xlua.util'
xlua.private_accessible(CS.CommonFairyListLabelController)
local Awake = function(self)
	if self.arrTeamId.Length <= 10 then
		local cacheArr = self.arrTeamId;
		local newArr = {};
		for i = 1, 10 do
			table.insert(newArr, i, cacheArr[i - 1]);
		end
		local tempSprite;
		local tempT2d;
		for i = 11, 14 do
			tempT2d = CS.ResManager.GetObjectByPath("DaBao/AtlasClips2050/fairy_team_"..tostring(i),".png");
			tempSprite = CS.ExSprite.Create(tempT2d, CS.UnityEngine.Rect(0,0,81,95), CS.UnityEngine.Vector2(40.5,47.5));
			table.insert(newArr, i, tempSprite);
		end
		self.arrTeamId = newArr;
		cacheArr = nil;
		newArr = nil;
	end
	self:Awake();
end
util.hotfix_ex(CS.CommonFairyListLabelController,'Awake',Awake)