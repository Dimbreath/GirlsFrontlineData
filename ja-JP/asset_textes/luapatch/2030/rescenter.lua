local util = require 'xlua.util'
xlua.private_accessible(CS.ResCenter)
local ConvertData = function(self,data,readNew)
    local dic = CS.System.Activator.CreateInstance(CS.System.Type.GetType('System.Collections.Generic.Dictionary`2[[System.String, mscorlib],[UnityEngine.AssetBundle, UnityEngine]],mscorlib'))
	local iter = CS.ResManager.abpath_AB:GetEnumerator()	
    while iter:MoveNext() do
        dic:Add(iter.Current.Key,iter.Current.Value)
    end
    self:ConvertData(data,readNew)
    iter = dic:GetEnumerator()
    while iter:MoveNext() do
        CS.ResManager.abpath_AB:Add(iter.Current.Key,iter.Current.Value)
    end
    dic = nil
    iter = nil
end
util.hotfix_ex(CS.ResCenter,'ConvertData',ConvertData)