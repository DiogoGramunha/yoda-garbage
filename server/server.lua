local ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('yoda-chopshop:RentVeh', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local rentVeh = false
    
    if xPlayer.getMoney() >= Config.Context.value then
        xPlayer.removeMoney(Config.Context.value)
        rentVeh = true
    elseif xPlayer.getAccount('bank').money >= Config.Context.value then
        xPlayer.removeAccountMoney('bank', Config.Context.value)
        rentVeh = true
    end

    TriggerClientEvent('yoda-chopshop:RentVehResponse', source, rentVeh)
end)
