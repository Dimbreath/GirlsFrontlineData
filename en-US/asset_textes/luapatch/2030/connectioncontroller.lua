local util = require 'xlua.util'
xlua.private_accessible(CS.ConnectionController)
local cacheReqFunction = '';
local cacheReqContent = '';
local cacheReqTime = -100000
local EnqueueAndRequest = function(request)
    if request ~= nil then
        if request.functionName == cacheReqFunction and cacheReqContent == request.content and CS.UnityEngine.Time.realtimeSinceStartup - cacheReqTime < 0.1 then
            local stackTrace = tostring(CS.System.Diagnostics.StackTrace());
            CS.UnityEngine.Debug.LogError("发生网络请求并发: "..request.functionName.."\n"..stackTrace);
            CS.ConnectionController.ProcessExceptionReport("发生网络请求并发: "..request.functionName, stackTrace, CS.UnityEngine.LogType.Exception);
            stackTrace = nil;
        end
        cacheReqFunction = request.functionName;
        cacheReqContent = request.content;
        cacheReqTime = CS.UnityEngine.Time.realtimeSinceStartup;
        CS.ConnectionController.EnqueueAndRequest(request);
    else
        CS.ConnectionController.EnqueueAndRequest(request);
    end
end
util.hotfix_ex(CS.ConnectionController,'EnqueueAndRequest',EnqueueAndRequest)