local util = require 'xlua.util'
xlua.private_accessible(CS.DormController)
local CreateFurniture = function(self,furniture)
    local f = self:CreateFurniture(furniture)
    if f ~= nil and furniture.info.placeType == CS.FurniturePlaceType.Wall then
        f.transform:SetParent(self.wallHolder)
        f.transform.localEulerAngles = CS.UnityEngine.Vector3(0,0,0)
    end
    return f
end
util.hotfix_ex(CS.DormController,'CreateFurniture',CreateFurniture)