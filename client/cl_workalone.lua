local currentLocationKey = nil

RegisterNetEvent('yoda-chopshop:garbageLocation', function()
    local locations = {}
    for key, _ in pairs(Config.GarbLocation) do
        table.insert(locations, key)
    end

    if #locations > 0 then
        local randomIndex = math.random(1, #locations)
        currentLocationKey = locations[randomIndex]
        local randomLocation = Config.GarbLocation[currentLocationKey].Location

        SetNewWaypoint(randomLocation.locx, randomLocation.locy)
        TriggerEvent('yoda-chopshop:createZone&GarbageBlips', currentLocationKey)
    else
        exports.ox_lib:notify({type = 'error', description = 'No pick-up location set up!'})
    end
end)

RegisterNetEvent('yoda-chopshop:createZone&GarbageBlips', function(locationKey)
    if locationKey then
        local zoneConfig = Config.GarbLocation[locationKey].Zone
        local garbageBlips = Config.GarbLocation[locationKey].Garbages

        local zoneBlip = AddBlipForRadius(zoneConfig.locx, zoneConfig.locy, zoneConfig.locz, 100.0)
        SetBlipSprite(zoneBlip, 9)
        SetBlipAlpha(zoneBlip, 100)
        SetBlipColour(zoneBlip, 1)

        for _, garbage in pairs(garbageBlips) do
            local garbageBlip = AddBlipForCoord(garbage.locx, garbage.locy, garbage.locz)
            SetBlipSprite(garbageBlip, 1)
            SetBlipColour(garbageBlip, 2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Garbage Pickup")
            EndTextCommandSetBlipName(garbageBlip)
        end
    end
end)
