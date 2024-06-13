local NPC = Config.NPC
local Context = Config.Context

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
                    local car = 'trash'
                    local CarSpawn = Context.CarSpawn
                    RequestModel('trash')
                    while not HasModelLoaded('trash') do 
                        Wait(500)
                    end
                    car = CreateVehicle(GetHashKey('trash'), CarSpawn.coordx, CarSpawn.coordy, CarSpawn.coordz, CarSpawn.heading, true, true)
                end,
                metadata = {
                    {label = Context.labelFriend, value = Context.value}
                },
            },
        }
    })
    exports.ox_lib:showContext('Job_Menu')
end)

RegisterNetEvent('yoda-chopshop:RentVehResponse', function(rentVeh)
    if rentVeh then
        local car = 'trash'
        local CarSpawn = Config.CarSpawn
        RequestModel('trash')
        while not HasModelLoaded('trash') do 
            Wait(500)
        end
        car = CreateVehicle(GetHashKey('trash'), CarSpawn.coordx, CarSpawn.coordy, CarSpawn.coordz, CarSpawn.heading, true, true)
        exports.ox_lib:notify(Config.Notify.JobStarted)
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
        print("Falha ao carregar o modelo: " .. NPC.model)
        return
    end
    local ped = CreatePed(1, model, NPC.coordx, NPC.coordy, NPC.coordz, NPC.heading, false, false, 0)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetEntityInvincible(ped, true)
    print("NPC criado com sucesso: " .. NPC.model)
    Citizen.Wait(10)
end)
