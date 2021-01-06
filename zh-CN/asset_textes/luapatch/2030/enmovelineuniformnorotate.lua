local util = require 'xlua.util'
xlua.private_accessible(CS.GF.Battle.ENMoveLineUniformNoRotate)
local InitData = function(self,effect,speed)
    self:InitData(effect,speed)
    if effect:GetSender():GetCharacter():IsSquad() then
        effect:GetSender():GetCharacter():Scout()
    end
end
util.hotfix_ex(CS.GF.Battle.ENMoveLineUniformNoRotate,'InitData',InitData)