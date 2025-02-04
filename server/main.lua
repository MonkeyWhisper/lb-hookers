local QBCore = exports['qb-core']:GetCoreObject()
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Get Money / Remove money
RegisterServerEvent('lb-hookers:pay')
AddEventHandler('lb-hookers:pay', function(boolean)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local check = Player.PlayerData.money.cash
    local price, event

    if (boolean == true) then
        price = Config.BlowjobPrice
        event = 'startBlowjob'
    else
        price = Config.SexPrice
        event = 'startSex'
    end

    if check >= price then
        Player.Functions.RemoveMoney('cash', price)
        TriggerClientEvent('lb-hookers:' .. event, src)
        TriggerClientEvent('QBCore:Notify', src, 'You Paid!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money', 'error')
        TriggerClientEvent('lb-hookers:noMoney', src)
    end
end)

RegisterServerEvent("lb-hookers:startBlowjob")
AddEventHandler("lb-hookers:startBlowjob", function(playerId)
    local playerPed = GetPlayerPed(playerId)

    TriggerClientEvent("lb-hookers:startBlowjob", playerId, playerPed, hookerPed)
    TriggerServerEvent('hud:server:RelieveStress', playerId, math.random(50, 100))
end)


function hookerAnim(ped, animDict, animName)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(ped, animDict, animName, 1.0, -1, -1, 49, 0, 0, 0, 0)
end

function playerAnim(ped, animDict, animName)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(ped, animDict, animName, 1.0, -1, -1, 49, 0, 0, 0, 0)
end