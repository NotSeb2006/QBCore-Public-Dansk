--[[
 ______ _           __  __      _ _    
|  ____(_)         |  \/  |    | | |   
| |__   ___   _____| \  / |  __| | | __
|  __| | \ \ / / _ \ |\/| | / _` | |/ /
| |    | |\ V /  __/ |  | || (_| |   < 
|_|    |_| \_/ \___|_|  |_(_)__,_|_|\_\

Vores sider:
  • Hjemmesiden: https://fivem.dk
  • Patreon: https://patreon.com/dkfivem
  • Facebook: https://facebook.com/dkfivem
  • Discord: https://discord.gg/dkfivem
  • DybHosting: https://dybhosting.eu/ - Rabatkode: dkfivem10
]]

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end

            if ((Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                AmbulanceCount = AmbulanceCount + 1
            end
        end
    end

    cb(PoliceCount, AmbulanceCount)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = QBCore.Functions.IsOptin(Player.PlayerData.source)
        end
    end
    cb(players)
end)

RegisterServerEvent('qb-scoreboard:server:SetActivityBusy')
AddEventHandler('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)