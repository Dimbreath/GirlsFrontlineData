local util = require 'xlua.util'
xlua.private_accessible(CS.AVGController)
xlua.private_accessible(CS.ResManager)
xlua.private_accessible(CS.Extensions)
local Awake = function(self)
    CS.ConnectionController.CloseConsole()
    self:Awake()
    self.isPlayback = false;
end
local InitializeData = function(self,str)
	self:InitializeData(str)
	local enumerator = self.linkedListData:GetEnumerator()
	while (enumerator:MoveNext()) do
		local value = enumerator.Current.content
		if string.match(value,'<va11>')~= nil then
			self.transform:Find("Skip").gameObject:SetActive(false)
			break
		end
	end
end
local InitDialogueContent = function(self)
	local lineContent = self.currentNode.Value.content
	print("InitDialogueContent "..lineContent)
	local perfectStr
	local goodStr
	if string.match(lineContent,'<va11>') ~= nil then
		local arrLine = Split(lineContent,'+')
		local expectLine = Split(lineContent,'+<va11>')[0]
		print("expectLine "..expectLine)
		mt = {}           
		for i=0,#arrLine do
			mt[i] = {}		
		end
		self.arrAVGContent = mt
		for i=0,#arrLine do
			if string.match(arrLine[i],'<va11>')~= nil then
				if string.match(arrLine[i],'<perfect>')~= nil then
					if string.match(arrLine[i],'<good>')~= nil then
						local index = string.find(arrLine[i],'<perfect>')
						index = index + 9
						local index2 = string.find(arrLine[i],'<good>')
						perfectStr = string.sub(arrLine[i], index , index2-1)
						index2 = index2 + 6
						goodStr = string.sub(arrLine[i], index2,string.len(arrLine[i]))
					else
						local index = string.find(arrLine[i],'<perfect>')
						index = index + 9
						perfectStr = string.sub(arrLine[i], index,string.len(arrLine[i]))
					end
					if(perfectStr ~= nil) then
						CS.UnityEngine.PlayerPrefs.SetString('VA11Perfect',perfectStr)
					else
						CS.UnityEngine.PlayerPrefs.SetString('VA11Perfect',"-1")
					end
					if(goodStr ~= nil)then
						CS.UnityEngine.PlayerPrefs.SetString('VA11Good',goodStr)
					else
						CS.UnityEngine.PlayerPrefs.SetString('VA11Good',"-1")
					end
					self.currentNode.Value.selectNum = -11			
				else
					print("Not Contains Perfact")
				end	
				break
			else
				self.arrAVGContent[i] = self:CheckContainsRichText(arrLine[i])
			end
		end
		self.currentNode.Value.content = expectLine 
		CS.UnityEngine.PlayerPrefs.SetString('VA11expectLine',expectLine)
		self.textDialogueName.text = self.currentNode.Value.dialogueName;
        self:DialogueShowContent();
        self.canDialoguePlay = true;
	else
		self:InitDialogueContent()
	end
    
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
local DialogueShowContent = function(self)
	if self.isTypeWriterPlaying == true then
	
	else
		if self.curContentId <= self.arrAVGContent.Length-1 then
		
		else
			self.curContentId = 0;
			self.curWordCount = 0;
			self.canDialoguePlay = false;
			if(self:isExistBranch(self.currentNode.Value)) then
				self:InitBranchBar()
				return			
			end
			if self.currentNode.Value.selectNum == -11 then
				if(self.isAutoPlay == true) then
					self.isRecoverAuto = true;
					self:OnClickAutoPlay()
				end
	

				self.transform:Find("AutoPlay").gameObject:SetActive(false)
				self.transform:Find("ShowLog").gameObject:SetActive(false)
				self.transform:Find("Skip").gameObject:SetActive(false)
				--加载预制体
				CS.UnityEngine.PlayerPrefs.SetString('VA11Branch',"-1")
				local Va11GameObject = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("Va11Prefabs/VA11Hall-AMenu"))
				Va11GameObject.transform:SetParent(self.transform, false)

				return
			end	
			self:PlayDialogueBoxDisappear();
			return
		end
	end
	self:DialogueShowContent()
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
local FixedUpdate = function(self)
	local VA11Branch = CS.UnityEngine.PlayerPrefs.GetString('VA11Branch',"-1")

	if VA11Branch  ~= "-1" then
		self.currentBranchNum = tonumber(VA11Branch)
		self.currentNode.Value.selectNum = tonumber(VA11Branch)
		CS.UnityEngine.PlayerPrefs.SetString('VA11Branch',"-1")
		CS.UnityEngine.PlayerPrefs.SetString('VA11Perfect',"-1")
		CS.UnityEngine.PlayerPrefs.SetString('VA11Good',"-1")
		self.transform:Find("AutoPlay").gameObject:SetActive(true)
		self.transform:Find("ShowLog").gameObject:SetActive(true)
		if(self.isRecoverAuto) then 
			self.isRecoverAuto = false
			self:OnClickAutoPlay()
		end
		self:PlayDialogueBoxDisappear();
	end
	self:FixedUpdate()
end
function Split(szFullString, szSeparator)
	local nFindStartIndex = 0
	local nSplitIndex = 0
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end


util.hotfix_ex(CS.AVGController,'Awake',Awake)
util.hotfix_ex(CS.AVGController,'InitializeData',InitializeData)
util.hotfix_ex(CS.AVGController,'InitDialogueContent',InitDialogueContent)
util.hotfix_ex(CS.AVGController,'CheckContainsRichText',CheckContainsRichText)
util.hotfix_ex(CS.AVGController,'DialogueShowContent',DialogueShowContent)
util.hotfix_ex(CS.AVGController,'Start',Start)
util.hotfix_ex(CS.AVGController,'DestoryAVG',DestoryAVG)
util.hotfix_ex(CS.AVGController,'FixedUpdate',FixedUpdate)