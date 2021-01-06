local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)
local DelayPlayLive = function(self)
	return util.cs_generator(function()
		coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01));
		if(self.isAdjutantLive2D and self.picController ~= nil) then
			local live2DController = self.picController;        
			local mLive2DMotionData = nil;
            if (live2DController:GetCurrLive2DType() == 0) then
                mLive2DMotionData = live2DController:getRandomMotionsData(live2DController.ENTERGAME);
            elseif (live2DController:GetCurrLive2DType() == 1) then
				mLive2DMotionData = live2DController:getRandomMotionsData(live2DController.D_ENTERGAME);
			end
            if (mLive2DMotionData ~= nil) then
                CS.CommonController.Invoke( 
					function() 
						live2DController:PlayMotions(CS.LAppDefine.MOTION_GROUP_DEFAULT, mLive2DMotionData.motion_name, CS.LAppDefine.PRIORITY_FORCE);
                        local r = live2DController:getRandomNumber(0, mLive2DMotionData.voiceList.Length);
                        live2DController:TryPlayExpression(mLive2DMotionData, r);
                        live2DController:TryPlayVoice(mLive2DMotionData, r);
                        local textEnterMall = live2DController:TryGetText(mLive2DMotionData, r);
                        if (textEnterMall ~= nil and textEnterMall ~= "") then
                            self:UpdateDialogText(textEnterMall, true);
                        else
                            self:HideDialogue();
						end
							self.RendererParent.gameObject:SetActive(false);
					end, 1, self);
			end
		else
			CS.CommonAudioController.PlayCharacterVoice(CS.Data.GetAdjutantInfo():GetVoiceCode(), CS.VoiceType._HELLO_);
		end
	end)
end
local myStart = function(self)	
	local isL = CS.HomeController.isLogin;
	CS.HomeController.isLogin = false;
	self:Start()
	CS.HomeController.isLogin = isL;
	if(CS.HomeController.isLogin and self.currAdjutantType ~= CS.AdjutantInfo.AdjutantType.FAIRY) then
		self:StartCoroutine(DelayPlayLive(self))
	end
end

util.hotfix_ex(CS.HomeController,'Start',myStart)
