local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMission)
xlua.private_accessible(CS.SpecialMissionInfoController)
local Click = function(self)
    self:Click();
    if not CS.OPSPanelBackGround.Instance.isDrag then
        CS.CommonAudioController.PlayUI("UI_selete");
    end
end
local ChickShowDrop = function(self,choose)
    self:ChickShowDrop(choose);
    if choose then
        CS.CommonAudioController.PlayUI("UI_default");
    end
end
util.hotfix_ex(CS.OPSPanelMission,'Click',Click)
util.hotfix_ex(CS.SpecialMissionInfoController,'ChickShowDrop',ChickShowDrop)