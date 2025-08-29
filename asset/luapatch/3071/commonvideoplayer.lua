local util = require 'xlua.util'
xlua.private_accessible(CS.CommonVideoPlayer)
xlua.private_accessible(CS.CriWare.CriManaMovieControllerForUI)
xlua.private_accessible(CS.GFCriServerWrapper)
local SetBattleMode = function(self, order)
	self.movieController.previousOnApplicationPauseStatus = true
	self:SetBattleMode(order)
end

local OnApplicationFocus = function(self,flag)
	if CS.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsPlayer then
		if not CS.ConfigData.soundBackground then
			if not flag then
				CS.CommonAudioController.SetBGMSoundVolume(0);
				CS.CommonAudioController.SetVoiceSoundVolueme(0);
				CS.CommonAudioController.SetSoundVolume(0);
			else
				CS.CommonAudioController.SetBGMSoundVolume(CS.ConfigData.BGMValue);
				CS.CommonAudioController.SetVoiceSoundVolueme(CS.ConfigData.VoiceValue);
				CS.CommonAudioController.SetSoundVolume(CS.ConfigData.EffectValue);
			end
		end
		return;
	end
	self:OnApplicationFocus(flag);
end

local OnApplicationPause = function(self,flag)
	if CS.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsPlayer then
		if not CS.ConfigData.soundBackground then
			if flag then
				CS.CommonAudioController.SetBGMSoundVolume(0);
				CS.CommonAudioController.SetVoiceSoundVolueme(0);
				CS.CommonAudioController.SetSoundVolume(0);
			else
				CS.CommonAudioController.SetBGMSoundVolume(CS.ConfigData.BGMValue);
				CS.CommonAudioController.SetVoiceSoundVolueme(CS.ConfigData.VoiceValue);
				CS.CommonAudioController.SetSoundVolume(CS.ConfigData.EffectValue);
			end
		end
		return;
	end
	self:OnApplicationPause(flag);
end
util.hotfix_ex(CS.CommonVideoPlayer,'SetBattleMode',SetBattleMode)
util.hotfix_ex(CS.GFCriServerWrapper,'OnApplicationFocus',OnApplicationFocus)
util.hotfix_ex(CS.GFCriServerWrapper,'OnApplicationPause',OnApplicationPause)