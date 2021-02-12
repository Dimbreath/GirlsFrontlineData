local codeVideo1 = "TheDivisionLoading1_2";
local codeVideo2 = "TheDivisionLoading2_2";
local startTime = 0;
local leastVideoTime = 7.0;
local backgroundPic = {
	'WorldCollide/TheDivision/LoadingScreen/TheDivision1',
	'WorldCollide/TheDivision/LoadingScreen/TheDivision2',
};
local DestroyVideo = function()
	-- 黑幕渐变
	local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("WorldCollide/TheDivision/LoadingScreen/TheDivisionLoadingCover"));
	local canvasg = gobj:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
	canvasg:DOFade(1.0,0.3);
	canvasg:DOFade(0.0,0.3):SetDelay(0.5);
	canvasg = nil;
	CS.UnityEngine.Object.Destroy(CS.CommonVideoPlayer.Instance.gameObject,0.3);
	CS.UnityEngine.Object.Destroy(gobj,2.0);
	gobj = nil;
	-- 音效
	CS.CommonAudioController.PlayUI("Stop_UI_loop");
end
local LoadBG = function()
	-- 异步CanvasGroup动画，防止被C#鲨了
	xlua.private_accessible(CS.LoadingScreenController);
	local loadInst = CS.LoadingScreenController.instance;
	loadInst.canvasGroupContent:DOFade(1.0, loadInst.timePicFadeIn):SetEase(CS.DG.Tweening.Ease.OutExpo):SetDelay(loadInst.timePicFadeInDelay):Play();
	loadInst = nil;
end
Awake = function()
	if CS.OPSPanelController.OpenCompaions.Count == 0 or CS.OPSPanelController.OpenCompaions[0] ~= -43 then
		CS.CommonController.Invoke(LoadBG, 0.05, CS.ResCenter.instance);
		return;
	end
	-- 用签到刷新时间做重复判断
	local cached_tomorrow = CS.UnityEngine.PlayerPrefs.GetInt("cached_tomorrow",0);
	if cached_tomorrow ~= CS.Data._serverTomorrowZero then
		CS.UnityEngine.PlayerPrefs.SetInt("cached_tomorrow",CS.Data._serverTomorrowZero);
		-- 视频
		CS.CommonVideoPlayer.PlayVideo(CS.CommonVideoPlayer.GetFilePathVideo(codeVideo1),nil,true,false,false,false,CS.CommonVideoPlayer.GetFilePathVideo(codeVideo2),true,false);
		CS.UnityEngine.Object.DontDestroyOnLoad(CS.CommonVideoPlayer.Instance.gameObject);
		CS.CommonVideoPlayer.Instance:SetAsExpandCanvas();
		-- 指挥官名字
		local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("WorldCollide/TheDivision/LoadingScreen/TheDivisionLoading"), CS.CommonVideoPlayer.Instance.transform);
		gobj.transform:GetChild(0):GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.name;
		gobj.transform:GetChild(1):GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.name;
		gobj = nil;
		startTime = CS.UnityEngine.Time.time;
		-- 音效
		CS.CommonAudioController.PlayUI("UI_Division_Loading");
	else
		-- 替换背景
		xlua.private_accessible(CS.LoadingScreenController);
		local loadInst = CS.LoadingScreenController.instance;
		local code = backgroundPic[math.random(1,#backgroundPic)];
		local tex = CS.ResManager.GetObjectByPath(code..".1",".jpg");
		loadInst:OnLoadTextureLeft(tex);
		local tex = CS.ResManager.GetObjectByPath(code..".2",".jpg");
		loadInst:OnLoadTextureRight(tex);
		code = nil;
		tex = nil;
		-- 指挥官名字
		local gobj = CS.UnityEngine.Object.Instantiate(CS.ResManager.GetObjectByPath("WorldCollide/TheDivision/LoadingScreen/CommanderName"), self.transform);
		gobj.transform:Find("Tex_Name"):GetComponent(typeof(CS.ExText)).text = CS.GameData.userInfo.name;
		-- tips
		gobj.transform:Find("Tex_Tips"):GetComponent(typeof(CS.ExText)).text = CS.ResManager.tips[math.random(0,CS.ResManager.tips.Count-1)];
		loadInst.textTips.transform.localScale = CS.UnityEngine.Vector3(0,0,0);
		gobj = nil;
		loadInst = nil;
		CS.CommonController.Invoke(LoadBG, 0.05, CS.ResCenter.instance);
	end
end

OnDestroy = function()
	if CS.CommonVideoPlayer.Instance ~= nil and not CS.CommonVideoPlayer.Instance:isNull() then
		CS.CommonController.Invoke(DestroyVideo, leastVideoTime - CS.UnityEngine.Time.time + startTime, CS.CommonVideoPlayer.Instance);
	end
	-- 换回原图
	xlua.private_accessible(CS.LoadingScreenController);
	local loadInst = CS.LoadingScreenController.instance;
	if loadInst.timer ~= nil then
		loadInst:StopCoroutine(loadInst.timer);
		loadInst.timer = nil;
	end
	loadInst:LoadRandomTexture();
	loadInst.textTips.transform.localScale = CS.UnityEngine.Vector3(1,1,1);
	loadInst = nil;
end