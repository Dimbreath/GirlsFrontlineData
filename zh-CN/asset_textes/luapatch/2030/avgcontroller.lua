local util = require 'xlua.util'
xlua.private_accessible(CS.AVGController)
xlua.private_accessible(CS.Extensions)
local Awake = function(self)
    CS.ConnectionController.CloseConsole()
    self:Awake()
    self.isPlayback = false;
end
local CheckContainsRichText = function(self,str)
    str = string.gsub(str, "<b>", "<b=>")
    str = string.gsub(str, "<i>", "<i=>")
    local arr = self:CheckContainsRichText(str)
    for i=0,arr.Length-1 do
        arr[i] = string.gsub(arr[i], "=>", ">")
    end
    return arr;
end
local Start = function(self)
    self:Start()
    if CS.CommonSidebarController.Instance and CS.UnityEngine.Application.loadedLevelName == "SpecialOPSPanel" then
        CS.CommonSidebarController.Instance.gameObject:SetActive(true)
    end
end
local DestoryAVG = function(self)
    if CS.CommonSidebarController.Instance and CS.UnityEngine.Application.loadedLevelName == "SpecialOPSPanel" then
        CS.CommonSidebarController.Instance.gameObject:SetActive(false)
    end
    self:DestoryAVG()
end
util.hotfix_ex(CS.AVGController,'Awake',Awake)
util.hotfix_ex(CS.AVGController,'CheckContainsRichText',CheckContainsRichText)
util.hotfix_ex(CS.AVGController,'Start',Start)
util.hotfix_ex(CS.AVGController,'DestoryAVG',DestoryAVG)