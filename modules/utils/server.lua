local Utils = {}
function Utils.Notify(message, type, time)
    local data = {
        title = locale('notifyTitle'),
        description = message,
        type = type or 'inform',
        duration = time or 5000
    }
    
    TriggerClientEvent('ox_lib:notify', source, data)
end

return Utils
