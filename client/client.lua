-- client.lua

local currentVehicle = nil
local PlayerProps = nil
local PlayerHasProp = false
local payment = 0
local binsDeposited = 0 
local currentGarbages = {}
local isInteracting = {}
local trunk = nil
local isCarryingGarbage = false
local NPC = Config.NPC
local Context = Config.Context
local onjob = false
local onDuty = false
local FRAMEWORK = Config.FRAMEWORK
local NOTIFY = Config.NotifyType
local TARGET = Config.TARGET
local FRAMEWORK = Config.FRAMEWORK

if FRAMEWORK == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
else
    QBCore = exports['qb-core']:GetCoreObject()
end

local GarbageJobBlip = AddBlipForCoord(Config.CarSpawn.coordx, Config.CarSpawn.coordy, Config.CarSpawn.coordz)
    SetBlipSprite(GarbageJobBlip, 318)
    SetBlipColour(GarbageJobBlip, 2)
    SetBlipScale(GarbageJobBlip, 0.6)
    SetBlipAsShortRange(GarbageJobBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Garbage Center")
    EndTextCommandSetBlipName(GarbageJobBlip)

function clearBlipsAndTargets()
    for _, garbage in pairs(currentGarbages) do
        if garbage.blip then
            RemoveBlip(garbage.blip)
        end
        if TARGET == 'OX' then
            if garbage.targetId then
                exports.ox_target:removeZone(garbage.targetId)
            end
        else
            if garbage.targetName then
                exports['qb-target']:RemoveZone(garbage.targetName)
            end
        end
    end
    RemoveBlip(zoneBlip)
    currentGarbages = {}
    isInteracting = {}
end

function deleteCurrentVehicle()
    if currentVehicle then
        if DoesEntityExist(currentVehicle) then
            DeleteEntity(currentVehicle)
        end
        currentVehicle = nil
    end
end



RegisterNetEvent('yoda-garbage:OpenMenu', function(args)
    exports.ox_lib:registerContext({
        id = 'Job_Menu',
        title = Context.title,
        options = {
            {
                title = 'On Duty',
                description = '',
                icon = Context.iconAlone,
                onSelect = function()
                    onDuty = true
                end,
                metadata = {
                    {label = Context.labelAlone, value = Context.value}
                },
            },
            {
                title = Context.titleAlone,
                description = Context.descriptionAlone,
                icon = Context.iconAlone,
                onSelect = function()
                    TriggerServerEvent('yoda-garbage:RentVeh')
                    onjob = true
                end,
                metadata = {
                    {label = Context.labelAlone, value = Context.value}
                },
            },
            {
                title = Context.titleFriend,
                description = Context.descriptionFriend,
                icon = Context.iconFriend,
                disabled = true,
                onSelect = function()
                    TriggerServerEvent('yoda-garbage:RentVeh')
                    onjob = true
                end,
                metadata = {
                    {label = Context.labelFriend, value = Context.value}
                },
            },
        }
    })
    exports.ox_lib:registerContext({
        id = 'Job_Menu2',
        title = Context.title,
        options = {
            {
                title = Context.titleAbort,
                description = Context.descriptionAbort,
                icon = Context.iconAbort,
                onSelect = function()
                    TriggerServerEvent('yoda-garbage:getPayment', payment, binsDeposited)
                    clearBlipsAndTargets()
                    deleteCurrentVehicle()
                    onjob = false
                end,
            },
        }
    })
    exports.ox_lib:registerContext({
        id = 'Job_Menu3',
        title = Context.title,
        options = {
            {
                title = Context.titleFinish,
                description = Context.descriptionFinish,
                icon = Context.iconFinish,
                onSelect = function()
                    TriggerServerEvent('yoda-garbage:getPayment', payment, binsDeposited)
                    clearBlipsAndTargets()
                    deleteCurrentVehicle()
                    onjob = false
                end,
            },
        }
    })
    if onDuty then
        disabled = false
    else 
        disabled = true
    end
    
    if not onjob then
    exports.ox_lib:showContext('Job_Menu')
    elseif binsDeposited == 0 then
    exports.ox_lib:showContext('Job_Menu2')
    else 
    exports.ox_lib:showContext('Job_Menu3')
    end
end)

RegisterNetEvent('yoda-garbage:RentVehResponse', function(rentVeh)
    if rentVeh then
        local CarSpawn = Config.CarSpawn
        RequestModel('trash')
        while not HasModelLoaded('trash') do 
            Wait(500)
        end
        currentVehicle = CreateVehicle(GetHashKey('trash'), CarSpawn.coordx, CarSpawn.coordy, CarSpawn.coordz, CarSpawn.heading, true, true)
        
        if currentVehicle and DoesEntityExist(currentVehicle) then
            print("Vehicle created successfully with ID: " .. currentVehicle)
            if FRAMEWORK == 'QB' then
                local vehicleNetId = NetworkGetNetworkIdFromEntity(currentVehicle)
                Wait(1000)
                TriggerServerEvent('yoda-garbage:giveKeys', vehicleNetId, currentVehicle)
            end
        else
            print("Failed to create vehicle.")
        end

        if NOTIFY == 'OX' then
            exports.ox_lib:notify(Config.Notify.JobStarted)
        else
            QBCore.Functions.Notify(Config.Notify.JobStarted.description, 'success', 5000)
        end

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            while true do
                Citizen.Wait(1000)
                if IsPedInVehicle(playerPed, currentVehicle, false) then
                    TriggerEvent('yoda-garbage:garbageLocation')
                    break
                end
            end
        end)
    else
        if NOTIFY == 'OX' then
            exports.ox_lib:notify(Config.Notify.NotEnoughMoney)
        else
            QBCore.Functions.Notify(Config.Notify.NotEnoughMoney.description, 'error', 5000)
        end
    end
end)



local currentLocationKey = nil

RegisterNetEvent('yoda-garbage:garbageLocation', function()
    local locations = {}
    for key, _ in pairs(Config.GarbLocation) do
        table.insert(locations, key)
    end

    if #locations > 0 then
        local randomIndex = math.random(1, #locations)
        currentLocationKey = locations[randomIndex]
        local randomLocation = Config.GarbLocation[currentLocationKey].Location

        SetNewWaypoint(randomLocation.locx, randomLocation.locy)
        TriggerEvent('yoda-garbage:createZone&GarbageBlips', currentLocationKey)
    else
        if NOTIFY == 'OX' then
            exports.ox_lib:notify({type = 'error', description = 'No pick-up location set up!'})
        else 
            QBCore.Functions.Notify('No pick-up location set up!', 'error', 5000)
        end
    end
end)

RegisterNetEvent('yoda-garbage:createZone&GarbageBlips', function(locationKey)
    payment = 0
    binsDeposited = 0
    numGarbages = 0
    if locationKey then
        clearBlipsAndTargets()

        local zoneConfig = Config.GarbLocation[locationKey].Zone
        local garbageBlips = Config.GarbLocation[locationKey].Garbages

        zoneBlip = AddBlipForRadius(zoneConfig.locx, zoneConfig.locy, zoneConfig.locz, 100.0)
        SetBlipSprite(zoneBlip, 9)
        SetBlipAlpha(zoneBlip, 100)
        SetBlipColour(zoneBlip, 5)

        numGarbages = math.random(1, 19)

        local garbageKeys = {}
        for k in pairs(garbageBlips) do
            table.insert(garbageKeys, k)
        end

        for i = 1, numGarbages do
            if #garbageKeys > 0 then
                local randIndex = math.random(1, #garbageKeys)
                local garbage = garbageBlips[garbageKeys[randIndex]]
                local garbageBlip = AddBlipForCoord(garbage.locx, garbage.locy, garbage.locz)
                SetBlipSprite(garbageBlip, 318)
                SetBlipColour(garbageBlip, 33)
                SetBlipScale(garbageBlip, 0.5)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Garbage Pickup")
                EndTextCommandSetBlipName(garbageBlip)
                
                currentGarbages[i] = { blip = garbageBlip, targetId = targetId, coords = vector3(garbage.locx, garbage.locy, garbage.locz) }
                isInteracting[i] = false
                
                if TARGET == 'OX' then
                    local targetOptions = { 
                        name = 'yoda-garbage:garbageTarget', 
                        onSelect = function() 
                            if not isInteracting[i] and not isCarryingGarbage then
                                TriggerEvent('yoda-garbage:getGarbage', i) 
                            end
                        end, 
                        icon = 'fa-solid fa-trash', 
                        label = 'Pick up trash'
                    }
                    local targetId = exports.ox_target:addSphereZone({ 
                        coords = vector3(garbage.locx, garbage.locy, garbage.locz), 
                        radius = 1.5, 
                        options = targetOptions 
                    })
                    currentGarbages[i] = { blip = garbageBlip, targetId = targetId, coords = vector3(garbage.locx, garbage.locy, garbage.locz) }
                    isInteracting[i] = false
                else 
                    local name = 'target' .. i
                    local targetId = exports['qb-target']:AddCircleZone(name, vector3(garbage.locx, garbage.locy, garbage.locz), 2.0, {
                        name = name, debugPoly = false , useZ = true}, {
                            options = {{label = 'Pick up trash', icon = 'fa-solid fa-trash', 
                            action = function () 
                                if not isInteracting[i] and not isCarryingGarbage then
                                    TriggerEvent('yoda-garbage:getGarbage', i) 
                                end

                            end}},
                            distance = 2.0
                    })
                    currentGarbages[i] = { blip = garbageBlip, targetId = targetId, targetName = name, coords = vector3(garbage.locx, garbage.locy, garbage.locz) }
                    isInteracting[i] = false
                end

                table.remove(garbageKeys, randIndex)
            end
        end
    end
end)

RegisterNetEvent('yoda-garbage:getGarbage', function(index)
    isInteracting[index] = true
    isCarryingGarbage = true
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
        RequestAnimDict("anim@heists@narcotics@trash")
    end
    AddBinsToPlayer()
    TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0, -1, 49, 0, 0, 0, 0)
    hasBin = true
    PlayerHasProp = true

    local function removeTargetAndBlip(index)
        if currentGarbages[index] then
            local garbage = currentGarbages[index]

            if TARGET == 'OX' then
                if garbage.targetId then
                    exports.ox_target:removeZone(garbage.targetId)
                end
            else
                if garbage.targetName then
                    exports['qb-target']:RemoveZone(garbage.targetName)
                end
            end

            if garbage.blip then
                RemoveBlip(garbage.blip)
            end

            currentGarbages[index] = nil
            isInteracting[index] = nil
        end
    end

    removeTargetAndBlip(index)

    TriggerEvent('yoda-garbage:giveGarbage')
end)

RegisterNetEvent('yoda-garbage:giveGarbage', function()
    if PlayerHasProp then
        local boneIndex = GetEntityBoneIndexByName(currentVehicle, "boot")
        if boneIndex ~= -1 then
            if TARGET == 'OX' then
                local bonePos = GetWorldPositionOfEntityBone(currentVehicle, boneIndex)
                trunk = exports.ox_target:addSphereZone({
                    coords = bonePos,
                    radius = 2,
                    options = {{onSelect = function() interact() end, icon = 'fa-regular fa-hand', label = 'Deposit Bin',}}
                })
            else
                local bonePos = GetWorldPositionOfEntityBone(currentVehicle, boneIndex)
                trunk = exports['qb-target']:AddCircleZone('trunktarget', vector3(bonePos.x, bonePos.y, bonePos.z), 2.0, {
                    name = 'trunktarget', debugPoly = false , useZ = true}, {
                    options = {{label = 'Deposit Bin', icon ='fa-regular fa-hand', 
                    action = function ()
                        interact()
                    end}},
                    distance = 2.0
                })
            end
        else
            print("Trunk bone not found!")
        end
    end
end)

function interact()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
    Citizen.Wait(1000)
    DestroyBins()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    binsDeposited = binsDeposited + 1
    isCarryingGarbage = false

    if binsDeposited == numGarbages then
        RemoveBlip(zoneBlip)
        if NOTIFY == 'OX' then
            exports.ox_lib:notify(Config.Notify.JobEnded)
        else
            QBCore.Functions.Notify(Config.Notify.JobEnded.description, 'success', 5000)
        end

        SetNewWaypoint(Config.CarSpawn.coordx, Config.CarSpawn.coordy, Config.CarSpawn.coordz)
    else
        if NOTIFY == 'OX' then
            exports.ox_lib:notify(Config.Notify.BinDeposited)
        else
            QBCore.Functions.Notify(Config.Notify.BinDeposited.description, 'success', 5000)
        end
    end

    payment = payment + Config.GarbageValue.value
end

function AddBinsToPlayer()
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
    local model = GetHashKey("hei_prop_heist_binbag")


    if not HasModelLoaded(model) then
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(10)
        end
    end
    prop =  CreateObject(model, 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
    PlayerProps = prop
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(model)
end

function DestroyBins()
    if trunk then
        if TARGET == 'OX' then
            exports.ox_target:removeZone(trunk)
        else
            exports['qb-target']:RemoveZone('trunktarget')
        end
        trunk = nil
    end
    if PlayerProps then
        DeleteEntity(PlayerProps)
        PlayerProps = nil
    end
    PlayerHasProp = false
end

RegisterNetEvent('yoda-garbage:paymentFail', function()
    if NOTIFY == 'OX' then
        exports.ox_lib:notify(Config.Notify.paymentFail)
    else 
        QBCore.Functions.Notify(Config.Notify.paymentFail.description, 'error', 5000)
    end
end)

RegisterNetEvent('yoda-garbage:Payment', function()
    exports.ox_lib:notify(Config.Notify.Payment)
end)

Citizen.CreateThread(function()
    local model = GetHashKey(NPC.model)
    RequestModel(model)
    local timeout = 10000
    local timer = 0
    while not HasModelLoaded(model) and timer < timeout do
        Citizen.Wait(10)
        timer = timer + 10
    end
    if not HasModelLoaded(model) then
        return
    end
    local ped = CreatePed(1, model, NPC.coordx, NPC.coordy, NPC.coordz, NPC.heading, false, false, 0)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetEntityInvincible(ped, true)

    if TARGET == 'OX' then
        npczone = exports.ox_target:addBoxZone({
            coords = vec3(NPC.coordx, NPC.coordy, NPC.coordz + 1),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 45,
            debug = false,
            options = {{
                name = 'yoda-garbage:startJob',
                event = 'yoda-garbage:OpenMenu',
                icon = 'fa-solid fa-cube',
                label = 'Start Job'
            }}
        })
    else 
        npczone = exports['qb-target']:AddCircleZone('targetBoxStartJob', vec3(NPC.coordx, NPC.coordy, NPC.coordz + 1), 2.0, {
            name = 'targetBoxStartJob', debugPoly = false, useZ = true}, {
            options = {{label = 'Start Job', icon = 'fa-solid fa-cube', action = function() TriggerEvent('yoda-garbage:OpenMenu') end }},
            distance = 2.0
        })
    end

    Citizen.Wait(10)
end)

