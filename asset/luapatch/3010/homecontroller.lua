local util = require 'xlua.util'
xlua.private_accessible(CS.HomeController)
xlua.private_accessible(CS.ResCenter)
--修正home界面下载对话框显示
local SevenLoginHandler = function(self)
	self:SevenLoginHandler(); 
	if CS.ResCenter.instance.currentDownloadState ~= CS.ResCenter.DownloadAddState.DownloadAddInHome and 
		CS.ResCenter.instance.currentDownloadVoiceState ~= CS.ResCenter.DownloadVoiceState.DownloadInHome then
		return;
	end
	if CS.ResCenter.instance.resDownload ~= nil and not CS.ResCenter.instance.resDownload:isNull() then
		CS.ResCenter.instance.resDownload:Hide();
	end
end

util.hotfix_ex(CS.HomeController,'SevenLoginHandler',SevenLoginHandler)




