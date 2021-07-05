local util = require 'xlua.util'
-- for 2050
xlua.private_accessible(CS.HomeController)
local GetAdjutantGunId = function()
	-- 2050
	--local adj = CS.GameData.userRecord.adjutant;
	-- 2060
	local adj = CS.Data.GetHomeAdjutantInfo()[0];
	print(adj:GetID())
	if adj ~= nil and adj.GetAdjutantType == CS.AdjutantInfo.AdjutantType.GUN then
		local gunId = adj:GetID();
		if gunId >= 20000 and gunId < 30000 then
			return gunId - 20000;
		else
			return gunId;
		end
	elseif adj ~= nil and adj.GetAdjutantType == CS.AdjutantInfo.AdjutantType.NPC then
		-- 2050
		-- return -1;
		-- 2060
		return adj:GetID();
	else
		print('当前副官不是人形');
		return 0;
	end
end
local OnAVGEnd = function()
	CS.HomeController.Instance.transformLive2dRoot.gameObject:SetActive(true);
	CS.CommonAudioController.PlayBGM('BGM_Home');
end
local OnClickHomeTalk = function()
	local adjId = GetAdjutantGunId();
	print('adjId'..tostring(adjId));
	if adjId ~= 0 then
		local txtAVG = CS.ResManager.GetObjectByPath("AVGTxt/Anniversary/"..tostring(adjId),".txt");
		if txtAVG == nil then
			print("未找到周年庆剧本====gunid: "..tostring(adjId));
			CS.CommonController.LightMessageTips(CS.Data.GetLang(20090));
		else
			CS.HomeController.Instance.transformLive2dRoot.gameObject:SetActive(false);
			CS.AVGController.Instance.transform:SetParent(CS.CommonController.MainCanvas.transform, false);
			CS.AVGController.Instance:InitializeData(txtAVG);
			CS.AVGController.Instance.onEnd = OnAVGEnd;
			txtAVG = nill;
		end
	else
		CS.CommonController.LightMessageTips(CS.Data.GetLang(20090));
	end
	adjId = nil;
end
local InitUIElements = function(self)
	self:InitUIElements();
	local anniversary_guns_avg_switch = CS.Data.GetInt("anniversary_guns_avg_switch");
	-- if in event
	if anniversary_guns_avg_switch ~= 0 then
		local prefab = CS.ResManager.GetObjectByPath("Prefabs/HomeTalk");
		if self.btnOpration.gameObject.activeSelf then
			prefab = CS.UnityEngine.Object.Instantiate(prefab, self.btnOpration.transform);
		else
			prefab = CS.UnityEngine.Object.Instantiate(prefab, self.btnOpration.transform.parent);
			prefab.transform.localPosition = CS.UnityEngine.Vector3(0,0,-25);
		end
		prefab:GetComponent(typeof(CS.ExButton)):AddOnClick(OnClickHomeTalk);
	end
end

util.hotfix_ex(CS.HomeController,'InitUIElements',InitUIElements)