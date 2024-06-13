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
        event = 'yoda-chopshop:OpenMenu',
        icon = 'fa-solid fa-cube',
        label = 'Start Job'
    }}
})

RegisterNetEvent('yoda-chopshop:OpenMenu', function(args)
    exports.ox_lib:registerContext({
        id = 'Job_Menu',
        title = Context.title,
        options = {
            {
                title = Context.titleAlone,
                description = Context.descriptionAlone,
                icon = Context.iconAlone,
                onSelect = function()
                    TriggerServerEvent('yoda-chopshop:RentVeh')
                    onjob = true
                end,
                metadata = {
                    {label = Context.labelAlone, value = Context.valueAlone}
                },
            },
            {
                title = Context.titleFriend,
                description = Context.descriptionFriend,
                icon = Context.iconFriend,
                onSelect = function()
                    TriggerServerEvent('yoda-chopshop:RentVeh')
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
                title = Context.titleFinish,
                description = Context.descriptionFinish,
                icon = Context.iconFinish,
                onSelect = function()
                    onjob = false
                end,
            },
            {
                title = Context.titleAbort,
                description = Context.descriptionAbort,
                icon = Context.iconAbort,
                onSelect = function()
                    onjob = false
                end,
            },
        }
    })
    if not onjob then
        exports.ox_lib:showContext('Job_Menu')
    else
        exports.ox_lib:showContext('Job_Menu2')
    end
end)

RegisterNetEvent('yoda-chopshop:RentVehResponse', function(rentVeh)
    if rentVeh then
        local CarSpawn = Config.CarSpawn
        RequestModel('trash')
        while not HasModelLoaded('trash') do 
            Wait(500)
        end
        local car = CreateVehicle(GetHashKey('trash'), CarSpawn.coordx, CarSpawn.coordy, CarSpawn.coordz, CarSpawn.heading, true, true)
        exports.ox_lib:notify(Config.Notify.JobStarted)

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            while true do
                Citizen.Wait(1000)
                if IsPedInVehicle(playerPed, car, false) then
                    TriggerEvent('yoda-chopshop:garbageLocation')
                    break
                end
            end
        end)
    else
        exports.ox_lib:notify(Config.Notify.NotEnoughMoney)
    end
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

RegisterNetEvent('yoda-chopshop:FinishJob', function()
    
end)

RegisterNetEvent('yoda-chopshop:AbortJob', function()

end)