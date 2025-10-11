--[[ Start ox_lib.locale ]]
lib.locale()

shared = {}
shared.resource = GetCurrentResourceName()

--- Checks if the given resource is started.
---@param resourceName string
---@return boolean
function shared.IsResourceStart(resourceName)
    return GetResourceState(resourceName) == 'started'
end

--- Returns the name of the active framework ('qb', 'esx', 'qbx').
---@return FrameworkType|nil
function shared.GetFrameworkName()
    if shared.IsResourceStart('es_extended') then
        return 'esx'
    elseif shared.IsResourceStart('qbx_core') then
        return 'qbx'
    elseif shared.IsResourceStart('qb-core') then
        return 'qb'
    end
    return nil
end

--- Retrieves the core object of the active framework.
--- @return table|nil
function shared.GetFrameworkObject()
    local frameworkName = shared.GetFrameworkName()
    if not frameworkName then return nil end
    if frameworkName == 'esx' then
        return exports['es_extended']:getSharedObject()
    elseif frameworkName == 'qbx' then
        return exports['qb-core']:GetCoreObject()
    elseif frameworkName == 'qb' then
        return exports['qb-core']:GetCoreObject()
    end
end


shared.framework = shared.GetFrameworkName()
