local util = require 'xlua.util'
xlua.private_accessible(CS.BattleBossSkillBackgroundController)
local TweenEase = xlua.get_generic_method(CS.DG.Tweening.TweenSettingsExtensions, 'SetEase')
local TweenDelay = xlua.get_generic_method(CS.DG.Tweening.TweenSettingsExtensions, 'SetDelay') 
local SetEase = TweenEase(CS.DG.Tweening.Tweener)
local SetDelay = TweenDelay(CS.DG.Tweening.Tweener)
local SetLayer = function(self,trans,order)
	self:SetLayer(trans,order)
	if order == 11 and CS.BattleBossSkillBackgroundController.gun ~= nil then
		math.randomseed(os.time())
		local randnum = math.random(20,22)

		local isSangvis = (CS.BattleBossSkillBackgroundController.gun:GetType() == typeof(CS.SangvisGun))
		local VoiceType = "_SKILL01_"
		if isSangvis then
			VoiceType = "_SKILL01_"
			if randnum == 21 then
				VoiceType = "_SKILL02_"
			end
			if randnum == 22 then
				VoiceType = "_SKILL03_"
			end
		else
			VoiceType = "_SKILL1_"
			if randnum == 21 then
				VoiceType = "_SKILL2_"
			end
			if randnum == 22 then
				VoiceType = "_SKILL3_"
			end
		end
		if not CS.GF.Battle.BattleController.isPerformBattle then
			CS.CommonAudioController.PlayCharacterVoice(CS.BattleBossSkillBackgroundController.gun:GetVoiceCode(),VoiceType)
		end
		local picC = CS.CommonController.LoadBigPic(CS.BattleBossSkillBackgroundController.gun,self.picImage.transform);
		if picC ~= nil then
			print('11')
			local group = self.picImage.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
			if group == nil or group:isNull() then
				print('22')
				group = self.picImage.gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup));
			end
			picC:SwitchDamaged(false);
			self.picImage.enabled = false;
			local tween = typeof(CS.DG.Tweener)CS.DG.Tweening.ShortcutExtensions46.DOFade(group,1,0.5);
			SetEase(tween, CS.DG.Tweening.Ease.InCubic);
			SetDelay(tween, 0.5);
			--CS.DG.Tweening.TweenSettingsExtensions.SetEase(tween, CS.DG.Tweening.Ease.InCubic);
			--CS.DG.Tweening.TweenSettingsExtensions.SetDelay(tween, 0.5);	
			local tween1 = CS.DG.Tweening.ShortcutExtensions46.DOFade(group,0,0.3);
			SetEase(tween1, CS.DG.Tweening.Ease.OutCubic);
			SetDelay(tween1, 1.3);
			--CS.DG.Tweening.TweenSettingsExtensions.SetEase(tween1, CS.DG.Tweening.Ease.OutCubic);
			--CS.DG.Tweening.TweenSettingsExtensions.SetDelay(tween1, 1.3);
		end
	end
end
util.hotfix_ex(CS.BattleBossSkillBackgroundController,'SetLayer',SetLayer)