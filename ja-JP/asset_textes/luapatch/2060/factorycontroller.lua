local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryController)
xlua.private_accessible(CS.FeedController)
xlua.private_accessible(CS.TweenFade)
local _OnClickLeft = function(self,type)
	if type ~= CS.FactoryUIType.Feed and CS.FeedController.inst ~=nil  then
		CS.FeedController.inst.expBarStartMove = false;
	end
	self:OnClickLeft(type);
end
local _OnClickFeed = function(self)
	if CS.FeedController.inst ~=nil  then
		if CS.FeedController.inst.tweenFadePow:GetCanvasGroup() ~=nil then
			CS.FeedController.inst.tweenFadePow:GetCanvasGroup().alpha = 1.0;
		end
		if CS.FeedController.inst.tweenFadeHit:GetCanvasGroup() ~=nil then
			CS.FeedController.inst.tweenFadeHit:GetCanvasGroup().alpha = 1.0;
		end
		if CS.FeedController.inst.tweenFadeDodge:GetCanvasGroup() ~=nil then
			CS.FeedController.inst.tweenFadeDodge:GetCanvasGroup().alpha = 1.0;
		end
		if CS.FeedController.inst.tweenFadeRate:GetCanvasGroup() ~=nil then
			CS.FeedController.inst.tweenFadeRate:GetCanvasGroup().alpha = 1.0;
		end
    	--CS.FeedController.inst.tweenFadeHit:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
    	--CS.FeedController.inst.tweenFadeDodge:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
    	--CS.FeedController.inst.tweenFadeRate:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
	end
	self:OnClickFeed();
end
util.hotfix_ex(CS.FactoryController,'OnClickFeed',_OnClickFeed)
util.hotfix_ex(CS.FactoryController,'OnClickLeft',_OnClickLeft)