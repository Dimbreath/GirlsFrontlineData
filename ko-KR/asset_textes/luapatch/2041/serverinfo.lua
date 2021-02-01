local util = require 'xlua.util'
xlua.private_accessible(CS.ServerInfo)

local WaitForGetOrderResult = function(self, www, callback)
	print('WaitForGetOrderResult');
	return util.cs_generator(function()
		print('WaitForGetOrderResult2');
			local orderId = "";
			local channelJsonData = "";
			
		coroutine.yield(www);
		print(www.text);
			
			CS.ConnectionController.CloseConsole();
			local requestResult = CS.Request.RequestResult(www);
			--string orderId = "", channelJsonData = "";
			if requestResult.resultCode == CS.Request.ResultCode.OK then
				local formatJson = www.text;-- = www.text.Replace("\\", "").Replace(":\"{", ":{").Replace("}\",", "},").Trim();
				formatJson = string.gsub(formatJson, "\\","");
				formatJson = string.gsub(formatJson, ":\"{",":{");
				formatJson = string.gsub(formatJson, "}\",","},");
				print(formatJson);
				local jsonData = CS.LitJson.JsonMapper.ToObject(formatJson);
				
				orderId = jsonData:GetValue("order_dat"):GetValue("orderId").String;
				if jsonData:GetValue("order_dat"):Contains("channel") then
					channelJsonData = jsonData:GetValue("order_dat"):GetValue("channel"):ToJson();
				end
				callback(orderId, channelJsonData);
					
			else
				CS.CommonController.MessageBox(CS.Data.GetLang(71039) + requestResult.errorInfo);
				CS.MallPaymentSelectionController.currentPayType = CS.PayType.undefined;
			end
	end);
end
if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Normal and CS.ServerInfo.Instance.WaitForGetOrderResult ~= nil then
	util.hotfix_ex(CS.ServerInfo,'WaitForGetOrderResult',WaitForGetOrderResult)
end