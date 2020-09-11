local util = require 'xlua.util'
xlua.private_accessible(CS.ServerInfo)
xlua.private_accessible(CS.LoginController)
xlua.private_accessible(CS.CommonConnectionLogController)
local myStart = function(self)    
 	return util.cs_generator(function()
                while true do
                    coroutine.yield(CS.UnityEngine.WaitForSecondsRealtime(CS.ServerInfo.Instance.heartTime));
                    if(CS.GameData.userInfo ~= nil and (CS.ConnecttionController.sign ~= nil or CS.ConnecttionController.sign ~= "")) then
						CS.ServerInfo.Instance:SendHeartBeatPacket();
					end
                end
            end);
end
local _LStart = function(self)   
 	self:Start();
 	self:StartCoroutine(myStart());
end
local loginStart = function(self)   
 	self:Start();
 	CS.CommonConnectionLogController.Instance:Start();
end
util.hotfix_ex(CS.CommonConnectionLogController,'Start',_LStart)
util.hotfix_ex(CS.LoginController,'Start',loginStart)

