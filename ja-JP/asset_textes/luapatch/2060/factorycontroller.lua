local util = require 'xlua.util'
xlua.private_accessible(CS.FactoryController)
xlua.private_accessible(CS.FeedController)
local _OnClickLeft = function(self,type)
	if type ~= CS.FactoryUIType.Feed and CS.FeedController.inst ~=nil  then
		CS.FeedController.inst.expBarStartMove = false;
	end
	self:OnClickLeft(type);
end
local _OnClickFeed = function(self)
	if CS.FeedController.inst ~=nil  then
		CS.FeedController.inst.tweenFadePow:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
    	CS.FeedController.inst.tweenFadeHit:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
    	CS.FeedController.inst.tweenFadeDodge:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
    	CS.FeedController.inst.tweenFadeRate:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1.0;
	end
	self:OnClickFeed();
end
util.hotfix_ex(CS.FactoryController,'OnClickFeed',_OnClickFeed)
util.hotfix_ex(CS.FactoryController,'OnClickLeft',_OnClickLeft)