local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent('cash')
AddEventHandler('cash', function(price)
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.ceil(price)

    if price > 0 then
        Player.Functions.RemoveMoney('cash', amount)
    end
end)
