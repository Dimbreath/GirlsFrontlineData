local util = require 'xlua.util'
xlua.private_accessible(CS.MallSkinDisplayController)

local listGiftSkinGoodDataNew = CS.System.Collections.Generic.List(CS.MallSkinItemData)();
local soldOutList = CS.System.Collections.Generic.List(CS.MallSkinItemData)();

local InitData_New = function(self)
	--CS.NDebug.LogError("InitData_New")

	if CS.MallController.Instance == nil or CS.MallController.Instance.listGiftSkinGoodData.Count == 0 then
		return
	end

	if self.findDefault == false then
		--CS.NDebug.LogError("findDefault")

		listGiftSkinGoodDataNew:Clear()
		soldOutList:Clear()

		for i=0,CS.MallController.Instance.listGiftSkinGoodData.Count-1 do
			if CS.MallController.Instance.listGiftSkinGoodData[i].goods.isRec == false or CS.MallController.Instance.listGiftSkinGoodData[i].skinClassTheme == -1 then
				if CS.MallController.Instance.listGiftSkinGoodData[i].goods.restNumber > 0 then
					listGiftSkinGoodDataNew:Add(CS.MallController.Instance.listGiftSkinGoodData[i])
				else
					soldOutList:Add(CS.MallController.Instance.listGiftSkinGoodData[i])					
				end
			end
		end	

		listGiftSkinGoodDataNew:AddRange(soldOutList)	

		self.selectIndex = 0
		for i=0,listGiftSkinGoodDataNew.Count-1 do
			if listGiftSkinGoodDataNew[i].goods.restNumber > 0 then
				self.selectIndex = listGiftSkinGoodDataNew[i].dataIndex
				break
			end
		end	

		local initData_generic = xlua.get_generic_method(CS.CommonListController, 'InitData', 1)
		local initData_func = initData_generic(CS.MallSkinItemData)
		initData_func(self.skinListController, listGiftSkinGoodDataNew, "UGUIPrefabs/SkinShow/SkinDisplayItem")
        self:MoveToSelect()
		self.findDefault = true
	end	
end

local MoveToSelect_New = function(self)
	--CS.NDebug.LogError("MoveToSelect_New")

	for i=0,listGiftSkinGoodDataNew.Count-1 do
		if listGiftSkinGoodDataNew[i].dataIndex == self.selectIndex then
			local itemToLeftOffset = i * self.gridLayout.cellSize.x + i * self.gridLayout.spacing.x
			local listPos = self.skinListController:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition
			self.skinListController:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = CS.UnityEngine.Vector2(-itemToLeftOffset * self.skinListController.transform.localScale.x, listPos.y)
			self.skinListController:UpdateUI()
			return
		end
	end		
end

local UpdateState_New = function(self)
	--CS.NDebug.LogError("UpdateState_New")

	self:UpdateState()
	if self.currGood ~= nil and self.currGood.restNumber == 0 then
		self.btnBuy:SetLock()
	else
		self.btnBuy:SetUnlock()
	end			
end

local UpdateSelectedItem_New = function(self, skinItem)
	--CS.NDebug.LogError("UpdateSelectedItem_New")
	local find = false
	local tmpIndex = skinItem.mallGoodIndex

	for i=0,listGiftSkinGoodDataNew.Count-1 do
		if listGiftSkinGoodDataNew[i].dataIndex == skinItem.mallGoodIndex then
			find = true
			break
		end
	end	

	if find == false then
		for i=0,listGiftSkinGoodDataNew.Count-1 do
			if listGiftSkinGoodDataNew[i].goods == skinItem.mallGood then
				skinItem.mallGoodIndex = listGiftSkinGoodDataNew[i].dataIndex
				--CS.NDebug.LogError("跳转推荐的index，"..listGiftSkinGoodDataNew[i].dataIndex)
				break
			end
		end

		--CS.NDebug.LogError("跳转推荐的index，skinItem.mallGoodIndex = "..skinItem.mallGoodIndex)
	end		

	self:UpdateSelectedItem(skinItem)

	self.currSkinGoodController = self.transform:GetComponent(typeof(CS.MallSkinGoodController))
	if self.currSkinGoodController == nil then
		self.currSkinGoodController = self.gameObject:AddComponent(typeof(CS.MallSkinGoodController))
	end
	self.currSkinGoodController:Init(self.currGood)
	
	skinItem.mallGoodIndex = tmpIndex
end

util.hotfix_ex(CS.MallSkinDisplayController,'InitData',InitData_New)
util.hotfix_ex(CS.MallSkinDisplayController,'MoveToSelect',MoveToSelect_New)
util.hotfix_ex(CS.MallSkinDisplayController,'UpdateState',UpdateState_New)
util.hotfix_ex(CS.MallSkinDisplayController,'UpdateSelectedItem',UpdateSelectedItem_New)



