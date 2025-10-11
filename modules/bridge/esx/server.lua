-- Utils module for ESX framework
local Utils = {}

function Utils.Notify(playerId, message, type, time)
    local data = {
        title = locale('notifyTitle'),
        description = message,
        type = type or 'inform',
        duration = time or 5000
    }
    
    TriggerClientEvent('ox_lib:notify', playerId, data)
end

return Utils
