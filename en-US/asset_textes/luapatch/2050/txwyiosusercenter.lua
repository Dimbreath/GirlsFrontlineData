local util = require 'xlua.util'
if (CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea or CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Tw) and CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.IPhonePlayer then
	xlua.private_accessible(CS.TxwyiOSUserCenter)
	local myOnGetItemsPriceInfo = function(self,msg)
		local count = CS.TxwyiOSUserCenter.identifiers.Length;
		local stringList = {}
		for i = 0, count - 1, 1 do
			if(string.find(CS.TxwyiOSUserCenter.identifiers[i], "raw") ~= nil) then
			else
				table.insert(stringList, CS.TxwyiOSUserCenter.identifiers[i]);
			end
		end
		CS.TxwyiOSUserCenter.identifiers = stringList;
		self:OnGetItemsPriceInfo(msg);
	end
	util.hotfix_ex(CS.TxwyiOSUserCenter,'OnGetItemsPriceInfo',myOnGetItemsPriceInfo)
else
print("---");
end
