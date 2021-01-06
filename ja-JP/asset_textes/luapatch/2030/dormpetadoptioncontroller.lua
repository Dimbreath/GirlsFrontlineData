local util = require 'xlua.util'
xlua.private_accessible(CS.DormPetAdoptionController)
local Init = function(self,name,code,coinCost,gemCost,coinBuy,gemBuy)
    self:Init(name,code,coinCost,gemCost,coinBuy,gemBuy)
    if self.transformSpineHolder.childCount > 0 then
        local spine = self.transformSpineHolder:GetChild(self.transformSpineHolder.childCount-1):GetComponent(typeof(CS.SkeletonAnimation))
        if spine ~= nil and spine.state.Data.SkeletonData:FindAnimation("sit") ~= nil then
            spine.state:SetAnimation(0,"sit",true)
        end
        spine = nil
    end
end
util.hotfix_ex(CS.DormPetAdoptionController,'Init',Init)