local util = require 'xlua.util'
xlua.private_accessible(CS.ExploreMall)
xlua.private_accessible(CS.Package)

local RequestExchangeHandle = function(self,www)
	local jsonData = CS.ConnectionController.DecodeAndMapJson(www.text)
	local a = jsonData:Contains("status") == false
	if (a) then	
		self:ConnectionAlert(nil)
	else
		self.num = self.exchangeNum + self.num
		if (jsonData:Contains("prize")) then
			for var=1,jsonData:GetValue("prize").Count,1 do
				self.package.jsonData = jsonData:GetValue("prize")[var-1]
				self.package:GetPackage("ExploreMall", nil, true, false)
			end
			CS.UIManager.Instance:DequeuePerformance()
		else
			for var=1,self.exchangeNum,1 do
				self.package:GetPackage("ExploreMall")
			end
		end
		if (self.type == 4) then
			local t = 0
			for key, value in pairs(self.coinDic) do
				if (t == self.tag)
				then
					CS.GameData.AddItem(tonumber(key), -tonumber(value) * self.exchangeNum)
				end
				t = t+1
			end
		else
			for key, value in pairs(self.coinDic) do
				CS.GameData.AddItem(tonumber(key), -tonumber(value) * self.exchangeNum)
			end
		end
		self.exchangeNum = 1;
		local action = self["requestExchangeGoodsHandle"]
		if (action ~= nil) then
			action(true)
		end
	end
end
util.hotfix_ex(CS.ExploreMall,'RequestExchangeHandle',RequestExchangeHandle)