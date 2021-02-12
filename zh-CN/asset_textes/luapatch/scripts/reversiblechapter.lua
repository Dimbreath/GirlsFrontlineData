local util = require 'xlua.util'
local timePerformanceWait = 0.0;
local mat;
local dictTime={};
local DoMosaicEffect = function()
    mat:SetColor("_MaskColor",CS.UnityEngine.Color(1,1,0,0));
    mat:SetFloat("_Range",0.4);
    CS.CommonController.Invoke(function()
        mat:SetFloat("_Range",1.0);
        mat:SetColor("_MaskColor",CS.UnityEngine.Color(0,1,0,0));
    end, 0.15, self);
    CS.CommonController.Invoke(function()
        mat:SetColor("_MaskColor",CS.UnityEngine.Color(0,0,0,0));
    end, 0.3, self);

end
Start = function()
    local image = self:GetComponent(typeof(CS.ExImage));
    mat = CS.UnityEngine.Object.Instantiate(image.material);
    image.material = mat;
    if mat ~= nil then
        timePerformanceWait = CS.UnityEngine.Time.time;
    else
        timePerformanceWait = 0;
    end
end
Update = function()
    if timePerformanceWait > 0 and CS.UnityEngine.Time.time > timePerformanceWait then
        DoMosaicEffect();
        timePerformanceWait = timePerformanceWait + math.random(5.0, 15.0);
    end
end
OnDestroy = function()
    CS.CommonController.CancelInvoke(self);
    timePerformanceWait = nil;
end