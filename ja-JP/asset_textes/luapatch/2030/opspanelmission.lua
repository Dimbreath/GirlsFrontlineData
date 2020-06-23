local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMission)
local ShowUnclockOther = function(self)
    self.currentMission = nil
    self:ShowUnclockOther();
    self.lockObj:Find("Img_LockShadow").gameObject:SetActive(true)
    self.lockObj:Find("Img_Lock"):GetComponent(typeof(CS.ExImage)).enabled = true
    self.lockObj:Find("Point"):GetComponent(typeof(CS.TweenPlay)):SetFromValue()
    print('ShowUnclockOther')
end
util.hotfix_ex(CS.OPSPanelMission,'ShowUnclockOther',ShowUnclockOther)