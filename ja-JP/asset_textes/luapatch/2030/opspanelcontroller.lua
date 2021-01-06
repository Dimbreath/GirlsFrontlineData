local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)
local CancelMission = function(self)
    if self.currentChoose ~= nil then
        self.currentChoose.currentMission = nil
    end
    self:CancelMission(jsonData);
end
local Awake = function(self)
    self:Awake()
    CS.OPSPanelController.diffclutyRecord = CS.UnityEngine.Mathf.Min(CS.OPSPanelController.diffclutyRecord, CS.OPSPanelController.diffcluteNum - 1);
    CS.OPSPanelController.difficulty = CS.OPSPanelController.diffclutyRecord;
end
local RequestUnClockCampaigns = function(self,data)
    self:RequestUnClockCampaigns(data)
    self:ShowProcess()
end
util.hotfix_ex(CS.OPSPanelController,'CancelMission',CancelMission)
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelController,'RequestUnClockCampaigns',RequestUnClockCampaigns)