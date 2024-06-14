local currentBlips = {}
local currentTargets = {}
local currentVehicle = nil
local PlayerProps = nil
local PlayerHasProp = false
local payment = 0
local trunk = nil
local binsDeposited = 0 

local GarbageJobBlip = AddBlipForCoord(Config.CarSpawn.coordx, Config.CarSpawn.coordy, Config.CarSpawn.coordz)
    SetBlipSprite(GarbageJobBlip, 318)
    SetBlipColour(GarbageJobBlip, 2)
    SetBlipScale(GarbageJobBlip, 0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Garbage Center")
    EndTextCommandSetBlipName(GarbageJobBlip)

function clearBlipsAndTargets()
    if zoneBlip then
        RemoveBlip(zoneBlip)
    end
    for _, blip in ipairs(currentBlips) do
        RemoveBlip(blip.blip)
    end
    for _, target in ipairs(currentTargets) do
        if target.id then
            exports.ox_target:removeZone(target.id)
        end
    end
    currentBlips = {}
    currentTargets = {}
end

function deleteCurrentVehicle()
    if currentVehicle then
        if DoesEntityExist(currentVehicle) then
            DeleteEntity(currentVehicle)
        end
        currentVehicle = nil
    end
end

local NPC = Config.NPC
local Context = Config.Context
local onjob = false

local npczone = exports.ox_target:addBoxZone({
    coords = vec3(NPC.coordx, NPC.coordy, NPC.coordz + 1),
    size = vec3(1.5, 1.5, 1.5),
    rotation = 90,
    debug = drawZones,
    options = {{
        name = 'yoda-garbage:startJob',
        event = 'yoda-garbage:OpenMenu',
        icon = 'fa-solid fa-cube',
        label = 'Start Job'
    }}
})

RegisterNetEvent('yoda-garbage:OpenMenu', function(args)
    exports.ox_lib:registerContext({
        id = 'Job_Menu',
        title = Context.title,
        options = {
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
            --[[ {
                title = Context.titleFriend,
                description = Context.descriptionFriend,
                icon = Context.iconFriend,
                onSelect = function()
                    TriggerServerEvent('yoda-garbage:RentVeh')
                    onjob = true
                end,
                metadata = {
                    {label = Context.labelFriend, value = Context.value}
                },
            }, ]]
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
        exports.ox_lib:notify(Config.Notify.JobStarted)

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
        exports.ox_lib:notify(Config.Notify.NotEnoughMoney)
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
        exports.ox_lib:notify({type = 'error', description = 'No pick-up location set up!'})
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
                table.insert(currentBlips, {blip = garbageBlip, locx = garbage.locx, locy = garbage.locy, locz = garbage.locz, radius = 1.5})
                local targetOptions = { name = 'yoda-garbage:garbageTarget', onSelect = function() TriggerEvent('yoda-garbage:getGarbage') end, icon = 'fa-solid fa-trash', label = 'Pick up trash' }
                table.insert(currentTargets, { coords = vec3(garbage.locx, garbage.locy, garbage.locz), radius = 1.5, id = exports.ox_target:addSphereZone({ coords = vec3(garbage.locx, garbage.locy, garbage.locz), radius = 1.5, options = targetOptions }), event = 'yoda-garbage:garbageTarget' })
                table.remove(garbageKeys, randIndex)
            end
        end
    end
end)


RegisterNetEvent('yoda-garbage:getGarbage', function()
        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
        Citizen.Wait(5000)
        ClearPedTasks(PlayerPedId())
        if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
            RequestAnimDict("anim@heists@narcotics@trash")
        end
        AddBinsToPlayer()
        TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
        hasBin = true
        PlayerHasProp = true
    
    local function removeTarget()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        if currentTargets then
            for i, target in ipairs(currentTargets) do
                if target.coords and target.id and Vdist(target.coords.x, target.coords.y, target.coords.z, coords.x, coords.y, coords.z) <= target.radius then
                    exports.ox_target:removeZone(target.id)
                    table.remove(currentTargets, i)
                    break
                end
            end
        end
    end
    
    local function removeBlip()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        if currentBlips then
            for i, blip in ipairs(currentBlips) do
                if blip.locx and blip.locy and blip.locz and Vdist(blip.locx, blip.locy, blip.locz, coords.x, coords.y, coords.z) <= blip.radius then
                    RemoveBlip(blip.blip)
                    table.remove(currentBlips, i)
                    break
                end
            end
        end
    end
    removeTarget()
    removeBlip()

    TriggerEvent('yoda-garbage:giveGarbage')

end)

RegisterNetEvent('yoda-garbage:giveGarbage', function()
    if PlayerHasProp then
        local boneIndex = GetEntityBoneIndexByName(currentVehicle, "boot")
        if boneIndex ~= -1 then
            local bonePos = GetWorldPositionOfEntityBone(currentVehicle, boneIndex)
            trunk = exports.ox_target:addSphereZone({
                coords = bonePos,
                radius = 2,
                options = {{onSelect = function() interact() end, icon = 'fa-regular fa-hand', label = 'Deposit Bin',}}
            })
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
    binsDeposited = binsDeposited +1 
    if binsDeposited == numGarbages then
        exports.ox_lib:notify(Config.Notify.JobEnded)
    else
        exports.ox_lib:notify(Config.Notify.BinDeposited)
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
        exports.ox_target:removeZone(trunk)
        trunk = nil
    end
    if PlayerProps then
        DeleteEntity(PlayerProps)
        PlayerProps = nil
    end
    PlayerHasProp = false
end

RegisterNetEvent('yoda-garbage:paymentFail', function()
    exports.ox_lib:notify(Config.Notify.paymentFail)
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

    Citizen.Wait(10)
end)

