Utils = {}
function Utils.Notify(message, type, time)
    lib.notify({
        title = locale('notifyTitle'),
        description = message,
        type = type or 'inform',
        duration = time or 5000
    })
end

return Utils
