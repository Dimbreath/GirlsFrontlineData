local util = require 'xlua.util'
xlua.private_accessible(CS.OPSConfig)
local GoToScene = function(self,campaionid)
    if campaionid == nil then
        campaionid = CS.OPSConfig.ContainCampaigns[0]
    end
    CS.CommonAudioController.PlayBGM('Campaion'..campaionid)
    self:GoToScene(campaionid)
end
util.hotfix_ex(CS.OPSConfig,'GoToScene',GoToScene)