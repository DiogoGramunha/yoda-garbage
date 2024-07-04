local FRAMEWORK = Config.FRAMEWORK
local INVENTORY = Config.INVENTORY

print(FRAMEWORK)
print(INVENTORY)

if FRAMEWORK == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
else
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('yoda-garbage:RentVeh')
AddEventHandler('yoda-garbage:RentVeh', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local rentVeh = false

    if FRAMEWORK == 'ESX' then
        if xPlayer.getInventoryItem('cash').count >= Config.Context.value then
            xPlayer.removeInventoryItem("cash", Config.Context.value)
            rentVeh = true
        elseif xPlayer.getAccount('bank').money >= Config.Context.value then
            xPlayer.removeAccountMoney('bank', Config.Context.value)
            rentVeh = true
        end
    else 
        local player = QBCore.Functions.GetPlayer(source)
        if player.Functions.GetItemByName('cash') and player.Functions.GetItemByName('cash').amount >= Config.Context.value then
            player.Functions.RemoveItem("cash", Config.Context.value)
            TriggerClientEvent('QBCore:Notify', source, 'You have rented a vehicle with cash.', 'success')
            rentVeh = true
        elseif player.PlayerData.money.bank >= Config.Context.value then
            player.Functions.RemoveMoney('bank', Config.Context.value)
            TriggerClientEvent('QBCore:Notify', source, 'You have rented a vehicle with bank money.', 'success')
            rentVeh = true
        else
            TriggerClientEvent('QBCore:Notify', source, 'You do not have enough money to rent a vehicle.', 'error')
            rentVeh = false
        end
    end



    TriggerClientEvent('yoda-garbage:RentVehResponse', source, rentVeh)
end)

RegisterNetEvent('yoda-garbage:getPayment')
AddEventHandler('yoda-garbage:getPayment', function(payment, binsDeposited)
    local _source = source
    if INVENTORY == 'OX' then
        if binsDeposited and binsDeposited > 0 then 
            local totalPayment = (payment * binsDeposited) + Config.Context.value
            exports.ox_inventory:AddItem(_source, 'cash', totalPayment)
            TriggerClientEvent('yoda-garbage:Payment', _source, totalPayment)
        else
            TriggerClientEvent('yoda-garbage:paymentFail', _source)
            exports.ox_inventory:AddItem(_source, 'cash', Config.Context.value)
        end
    else
        if binsDeposited and binsDeposited > 0 then 
            local totalPayment = (payment * binsDeposited) + Config.Context.value
            local player = QBCore.Functions.GetPlayer(_source)
            player.Functions.AddMoney('cash', totalPayment)
            TriggerClientEvent('yoda-garbag:Payment', _source)
        else
            TriggerClientEvent('yoda-garbage:paymentFail', _source)
            local player = QBCore.Functions.GetPlayer(_source)
            player.Functions.AddMoney('cash', Config.Context.value)
        end
    end
end)
