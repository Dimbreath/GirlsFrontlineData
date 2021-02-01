local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterExerciseAction)
local GetCurrentActiveAdvantageArea = function(self)
	return CS.GameData.listTheaterAreaInfo:GetDataById(self.theater_area_id)
end
xlua.hotfix(CS.TheaterExerciseAction,'GetCurrentActiveAdvantageArea',GetCurrentActiveAdvantageArea)