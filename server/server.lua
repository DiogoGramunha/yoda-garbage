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
    local maxBins = 19  -- Maximum number of bins per round
    local maxPaymentPerRound = (maxBins * Config.GarbageValue.value) + Config.Context.value  -- Maximum amount that can be paid per round of trash

    local player
    -- Get the player based on the framework used
    if Config.FRAMEWORK == 'QB' then
        player = QBCore.Functions.GetPlayer(_source)
    elseif Config.FRAMEWORK == 'ESX' then
        player = ESX.GetPlayerFromId(_source)
    end

    -- Get the time of the last payment
    local lastPaymentTime = player.PlayerData.lastPaymentTime or 0  -- Time of the last payment (in seconds)
    local currentTime = os.time()
    local timeDiff = currentTime - lastPaymentTime  -- Time difference since the last payment, in seconds

    -- Check if the deposited bins are valid (maximum of 19)
    if binsDeposited <= 0 or binsDeposited > maxBins then
        print(('[Yoda-Garbage] Exploit Attempt: Player %s tried to deposit an invalid number of bins (%d).'):format(player, binsDeposited))
        TriggerClientEvent('yoda-garbage:paymentFail', _source)
        return
    end

    -- Calculate the expected total payment
    local totalPayment = (payment * binsDeposited) + Config.Context.value

    -- Check if the total payment exceeds the expected limit for the round
    if totalPayment > maxPaymentPerRound then
        print(('[Yoda-Garbage] Exploit Attempt: Player %s tried to claim an invalid payment (Total Payment: %d).'):format(player, totalPayment))
        TriggerClientEvent('yoda-garbage:paymentFail', _source)
        return
    end

    -- Check the payment frequency (e.g., if the player is trying to receive payment too quickly, in less than 1 minute)
    if timeDiff < 60 then
        print(('[Yoda-Garbage] Exploit Attempt: Player %s tried to receive payment too quickly (Time since last payment: %d seconds).'):format(player, timeDiff))
        TriggerClientEvent('yoda-garbage:paymentFail', _source)
        return
    end

    -- If all validations pass, perform the payment
    if INVENTORY == 'OX' then
        exports.ox_inventory:AddItem(_source, 'cash', totalPayment)
        TriggerClientEvent('yoda-garbage:Payment', _source, totalPayment)
    else
        if Config.FRAMEWORK == 'QB' then
            player.Functions.AddMoney('cash', totalPayment)
        elseif Config.FRAMEWORK == 'ESX' then
            player.addMoney(totalPayment)
        end
        TriggerClientEvent('yoda-garbage:Payment', _source, totalPayment)
    end

    -- Update the last payment time to prevent rapid sequential payments
    player.PlayerData.lastPaymentTime = currentTime
end)

