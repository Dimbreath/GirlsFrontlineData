local util = require 'xlua.util'
local config = require 'collaboration/Va11/VA11Config'
xlua.private_accessible(CS.DormController)
xlua.private_accessible(CS.DormCafeController)
xlua.private_accessible(CS.DormCafeCustomerController)
xlua.private_accessible(CS.DormAIController)
xlua.private_accessible(CS.CafeGunMemoirListController)
xlua.private_accessible(CS.DormUIController)
xlua.private_accessible(CS.Utility)
xlua.private_accessible(CS.PLTable)
local pointer
local initFlag = false
--local Va11Table = {}
--local TableStruct =nil
local Va11EventOpen = function()
	if CS.OPSConfig.ContainCampaigns:Contains(-32) then
		local stamp = CS.GameData.GetCurrentTimeStamp();
		if stamp >= CS.OPSConfig.startTime and stamp < CS.OPSConfig.endTime then
			return true;
		end
		stamp = nil;
	end
	return false;
end

ShowReadHint = function(self)

	pointer = tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
	--特殊活动avg气泡
	local finalAVGCleared = false;
	if pointer == 8 then
		finalAVGCleared = CS.GameData.GetItem(Va11Table[pointer].item_id) > 0;
		if finalAVGCleared then
			local missionT = CS.GameData.listMission:GetDataById(10292);
			finalAVGCleared = missionT ~= nil and not missionT.clocked;
			missionT = nil;
		end
	end
	if Va11EventOpen() and (pointer > 0) and self.codeWithSkinId == Va11Table[pointer].gun_code and not finalAVGCleared then
		if not self.discBub == nil then
			CS.Utility:Destroy(self.discBub.gameObject)
		end
		self:CancelTwinkle()
		
		local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11DiscItem"))
		gobj.transform:SetParent(CS.DormUIController.Instance.ShowLoveParent,false);
		self.discBub = gobj:GetComponent(typeof(CS.DormFloatingController))
		self.discBub.transformTarget = self.transform
		self.discBub:SetOnClick(function()
			CallCustomerAnim(self)			
		end)
	else
		self:ShowReadHint()
	end
	finalAVGCleared = nil;
end
function CallCustomerAnim(self)
	leaveFlag = false
	--播放动画
	CS.Utility:Destroy(self.discBub.gameObject)
	CS.DormUIController.Instance.gameObject:GetComponent("Canvas").enabled = false
	--镜头拉到吧台*
	local fCounter = CS.DormController.instance.furnitureHolder:Find(CS.PLTable.Instance:GetTableLang("furniture-10040023"))
	CS.DormUIController.Instance.interactionController:SetLookAtTarget(fCounter,CS.UnityEngine.Vector3.up)	
	
	--AI进入
	if self.posCurrent.x <= 12 then
		self.aiSelf:SuspendCurrentState()
		self:PlanInteractWithCounter()
		self.aiSelf:StartNewState()

	else
		local duplicate = CS.DormCafeController.instance:CreateAndStartCafeCustomer(self.codeWithSkinId, true, true)
		CS.DormController.instance:UpdateAllAIList()
		CS.DormController.instance.listAllAIController:Add(duplicate)
		self:ExitCafeImmediately()	
	end
	pointer = tonumber(CS.UnityEngine.PlayerPrefs.GetString('VA11CafeCounter',"-1"))
	CS.DormController.instance:PlayGunMemoirAVG(114514,Va11Table[pointer].avg_txt)
		
end
local LoadAI = function(self, codeWithSkinId, walkIn, isMemoir)
	self:LoadAI(codeWithSkinId, walkIn, isMemoir);
	if Va11EventOpen() then
		self.mat:SetColor("_Color",CS.UnityEngine.Color(0.7,0.6,0.8));
	end
end

util.hotfix_ex(CS.DormCafeCustomerController,'ShowReadHint',ShowReadHint)
util.hotfix_ex(CS.DormCafeCustomerController,'LoadAI',LoadAI)