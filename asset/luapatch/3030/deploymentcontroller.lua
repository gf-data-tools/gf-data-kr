local util = require 'xlua.util'
xlua.private_accessible(CS.DeploymentController)
xlua.private_accessible(CS.GameData)

local RequestEndAllFriendTurnHandle = function(self,data)
	if data.jsonData:Contains("spot_trans") then
		local json = data.jsonData:GetValue("spot_trans");
		CS.GameData.missionAction:LoadSpotTransData(json);
	end
	self:RequestEndAllFriendTurnHandle(data);
end
local TriggerStartMissionEvent = function()
	if CS.DeploymentAutoBattleController.isDailyMissionInfo(CS.DailyMapHexType.Squad) then
		if CS.DeploymentController.Instance.SquadTeamsCount == 0 then
			CS.CommonController.MessageBox(CS.Data.GetLang(30556));
			return;
		end
	elseif CS.DeploymentAutoBattleController.isDailyMissionInfo(CS.DailyMapHexType.Vehicle) then
		if CS.DeploymentController.Instance.VehicleTeamCount == 0 then
			CS.CommonController.MessageBox(CS.Data.GetLang(30556));
			return;
		end
	end
	CS.DeploymentController.TriggerStartMissionEvent();
end

local RequestStartEnemyTurnHandle = function(self,data)
	self:RequestStartEnemyTurnHandle(data);
	if CS.GameData.AnalysisMissionResult(self.startEnemyTurnJsonData,true) then
		print("win");
	end
end
local TriggerFinishMissionEvent = function()
	CS.DeploymentController.TriggerFinishMissionEvent();
end
local RequestEndEnemyTurn = function(self)
	if CS.GameData.missionResult ~= nil then
		self:AddAndPlayPerformance(nil);
		self:AddAndPlayPerformance(TriggerFinishMissionEvent);
		return;
	end
	self:RequestEndEnemyTurn();
end
util.hotfix_ex(CS.DeploymentController,'RequestEndAllFriendTurnHandle',RequestEndAllFriendTurnHandle)
util.hotfix_ex(CS.DeploymentController,'TriggerStartMissionEvent',TriggerStartMissionEvent)
util.hotfix_ex(CS.DeploymentController,'RequestStartEnemyTurnHandle',RequestStartEnemyTurnHandle)
util.hotfix_ex(CS.DeploymentController,'RequestEndEnemyTurn',RequestEndEnemyTurn)