-- server.lua

local FRAMEWORK = Config.FRAMEWORK
local INVENTORY = Config.INVENTORY

-- Initialize the framework
if FRAMEWORK == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
else
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Function to give vehicle keys
local function giveVehicleKeys(vehicleNetId, vehicle)
    local playerId = source
    local currentVehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    Wait(1000)
    if currentVehicle and DoesEntityExist(currentVehicle) then
        local plate = GetVehicleNumberPlateText(currentVehicle)
        if Config.vehicleKeySystem == 'qb' then
            TriggerClientEvent("vehiclekeys:client:SetOwner", playerId, plate)
        elseif Config.vehicleKeySystem == 'qbx' then
            exports['qbx_vehiclekeys']:GiveKeys(playerId, plate)
        end
        print("Keys given to vehicle with plate: " .. plate)
    else
        print("Vehicle does not exist or network ID is invalid.")
    end
end

-- Event handler for giving vehicle keys
RegisterNetEvent('yoda-garbage:giveKeys')
AddEventHandler('yoda-garbage:giveKeys', function(vehicleNetId, vehicle)
    giveVehicleKeys(vehicleNetId, vehicle)
end)

-- Event handler for renting a vehicle
RegisterNetEvent('yoda-garbage:RentVeh')
AddEventHandler('yoda-garbage:RentVeh', function()
    local rentVeh = false

    if FRAMEWORK == 'ESX' then
        local xPlayer = ESX.GetPlayerFromId(source)
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
            QBCore.Functions.Notify('You have rented a vehicle with cash.', 'success', 5000)
            rentVeh = true
        elseif player.PlayerData.money.bank >= Config.Context.value then
            player.Functions.RemoveMoney('bank', Config.Context.value)
            QBCore.Functions.Notify('You have rented a vehicle with bank money.', 'success', 5000)
            rentVeh = true
        else
            QBCore.Functions.Notify('You do not have enough money to rent a vehicle.', 'error', 5000)
            rentVeh = false
        end
    end

    TriggerClientEvent('yoda-garbage:RentVehResponse', source, rentVeh)
end)

-- Event handler for getting payment
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
            TriggerClientEvent('yoda-garbage:Payment', _source, totalPayment)
        else
            TriggerClientEvent('yoda-garbage:paymentFail', _source)
            local player = QBCore.Functions.GetPlayer(_source)
            player.Functions.AddMoney('cash', Config.Context.value)
        end
    end
end)