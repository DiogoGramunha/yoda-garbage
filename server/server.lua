local ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('yoda-garbage:RentVeh')
AddEventHandler('yoda-garbage:RentVeh', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local rentVeh = false

    if xPlayer.getInventoryItem('cash').count >= Config.Context.value then
        xPlayer.removeInventoryItem("cash", Config.Context.value)
        rentVeh = true
    elseif xPlayer.getAccount('bank').money >= Config.Context.value then
        xPlayer.removeAccountMoney('bank', Config.Context.value)
        rentVeh = true
    end

    TriggerClientEvent('yoda-garbage:RentVehResponse', source, rentVeh)
end)

RegisterNetEvent('yoda-garbage:getPayment')
AddEventHandler('yoda-garbage:getPayment', function(payment, binsDeposited)
    local _source = source
    if binsDeposited and binsDeposited > 0 then 
        local totalPayment = (payment * binsDeposited) + Config.Context.value
        TriggerClientEvent('yoda-garbage:Payment', _source, totalPayment)
    else
        TriggerClientEvent('yoda-garbage:paymentFail', _source)
    end
end)
