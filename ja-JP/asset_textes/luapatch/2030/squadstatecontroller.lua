local util = require 'xlua.util'
xlua.private_accessible(CS.SquadStateController)
local LoadPic = function(self)
    self:LoadPic()
    if self.imagePic:GetComponentInChildren(typeof(CS.LAppModelProxy),true) ~= nil then
        self.imagePicBackground:GetComponent(typeof(CS.UnityEngine.Canvas)).sortingOrder = 0
        self.imageBackgroud:SetActive(false)
    end
end
util.hotfix_ex(CS.SquadStateController,'LoadPic',LoadPic)