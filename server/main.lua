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
