
-- ====== Discord Logging Helper ======
local function sendToDiscord(title, description, color)
    if not Config.DiscordWebhook or Config.DiscordWebhook == "" then return end
    local embed = {{
        ["title"] = title or (Config.Discord and Config.Discord.action_title or "Car Lock"),
        ["description"] = description,
        ["color"] = color or (Config.Discord and Config.Discord.default_color or 16776960),
        ["footer"] = {{ ["text"] = (Config.Discord and Config.Discord.footer or "Carlock") .. " | " .. os.date("%Y-%m-%d %H:%M:%S") }}
    }}
    PerformHttpRequest(Config.DiscordWebhook, function() end, 'POST', json.encode({
        username = Config.Discord and Config.Discord.username or "Car Lock Logs",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end



-- ====== Safe Config defaults ======
Config = Config or {}
Config.RequireKeyItem = Config.RequireKeyItem ~= nil and Config.RequireKeyItem or false
Config.KeyItemName = Config.KeyItemName or 'vehiclekey'
Config.Inventory = Config.Inventory or 'qb' -- 'qb' | 'ox' | 'qs' (only used if QBCore)
Config.Debug = Config.Debug or false

local function dbg(msg)
    if Config.Debug then
        print(('[bl_carlock][DEBUG] %s'):format(msg))
    end
end

-- ====== Framework detection ======
local Framework = { type = 'standalone', QBCore = nil, ESX = nil }

local function tryGetQBCore()
    local state_qb = GetResourceState('qb-core')
    local state_qbx = GetResourceState('qbx-core')
    if state_qb == 'started' or state_qbx == 'started' then
        local ok, obj = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)
        if ok and obj then
            return obj
        end
    end
    return nil
end

local function tryGetESX()
    local esxNames = { 'es_extended', 'esx_framework' }
    for _, name in ipairs(esxNames) do
        if GetResourceState(name) == 'started' then
            local ok, obj = pcall(function()
                return exports[name]:getSharedObject()
            end)
            if ok and obj then
                return obj
            end
        end
    end
    return nil
end

CreateThread(function()
    Framework.QBCore = tryGetQBCore()
    if Framework.QBCore then
        Framework.type = 'qb'
        dbg('Detected QBCore')
        return
    end

    Framework.ESX = tryGetESX()
    if Framework.ESX then
        Framework.type = 'esx'
        dbg('Detected ESX')
        return
    end

    Framework.type = 'standalone'
    dbg('Running in Standalone mode')
end)

-- ====== Inventory check helpers ======
local function hasKeyItem_qb(src)
    if not Framework.QBCore then
        return false
    end
    local Player = Framework.QBCore.Functions.GetPlayer(src)
    if not Player then
        return false
    end
    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search(src, 'count', Config.KeyItemName)
        return (count or 0) > 0
    elseif Config.Inventory == 'qb' then
        local item = Player.Functions.GetItemByName(Config.KeyItemName)
        return item ~= nil
    elseif Config.Inventory == 'qs' then
        local qs = exports['qs-inventory']
        if qs and qs.GetItemCount then
            local count = qs:GetItemCount(src, Config.KeyItemName)
            return (count or 0) > 0
        end
        return false
    end
    return false
end

local function hasKeyItem_esx(src)
    if not Framework.ESX then
        return false
    end
    local xPlayer = Framework.ESX.GetPlayerFromId(src)
    if not xPlayer then
        return false
    end
    -- ESX inventory item
    local item = xPlayer.getInventoryItem and xPlayer:getInventoryItem(Config.KeyItemName) or nil
    if item and item.count and item.count > 0 then
        return true
    end
    return false
end

local function checkHasVehicleKey(src)
    if not Config.RequireKeyItem then
        return true
    end

    if Framework.type == 'qb' then
        return hasKeyItem_qb(src)
    elseif Framework.type == 'esx' then
        return hasKeyItem_esx(src)
    else
        -- Standalone --
        return false
    end
end

-- ====== QBCore callback (if available) ======
local function registerQBCoreCallback()
    if Framework.QBCore and Framework.QBCore.Functions and Framework.QBCore.Functions.CreateCallback then
        Framework.QBCore.Functions.CreateCallback('bl_carlock:server:hasVehicleKey', function(source, cb)
            local hasKey = checkHasVehicleKey(source)
            cb(hasKey)
        end)
        dbg('Registered QBCore callback bl_carlock:server:hasVehicleKey')
    end
end


CreateThread(function()
    Wait(500)
    registerQBCoreCallback()
end)

-- ====== Fallback ======
RegisterNetEvent('bl_carlock:server:hasVehicleKeyReq', function(token)
    local src = source
    local hasKey = checkHasVehicleKey(src)
    TriggerClientEvent('bl_carlock:client:hasVehicleKeyResp', src, token, hasKey)
end)

-- ====== Lock toggle relay ======
RegisterNetEvent('bl_carlock:server:toggleLock', function(plate, vehicleNet, newLockState)
    local src = source
    local playerName = GetPlayerName(src) or "unknown"
    local action = newLockState and "Unlocked" or "Locked"

    local hasKey = false
    if hasVehicleKeyDB then
        hasKey = hasVehicleKeyDB(src, plate)
    else
        -- Standalone: always allow locking/unlocking for owned vehicle (or disable DB check)
        hasKey = true
    end

    if hasKey then
        TriggerClientEvent('bl_carlock:client:setLockState', -1, newLockState, vehicleNet)
        sendToDiscord(
            Config.Discord.action_title,
            ("[%s] %s (%s) %s vehicle"):format(plate, playerName, src, action),
            newLockState and Config.Discord.unlock_color or Config.Discord.lock_color
        )
    else
        TriggerClientEvent('bl_carlock:client:noKeys', src)
    end
end)

-- ====== Optional stubs for key grant from shops (non-persistent by default) ======
RegisterNetEvent('bl_carlock:server:giveKey', function(playerId, plate)
    -- If you wire persistence later, insert a row here based on your DB and inventory
    dbg(('Key assigned (stub) plate=%s player=%s'):format(tostring(plate), tostring(playerId)))
end)

-- Compatibility hooks for common dealership resources
RegisterNetEvent('qb-vehicleshop:server:sellVehicle', function(vehicleData, playerId)
    if vehicleData and vehicleData.plate and playerId then
        TriggerEvent('bl_carlock:server:giveKey', playerId, vehicleData.plate)
    end
end)

RegisterNetEvent('esx_vehicleshop:buyVehicle', function(vehicleData)
    local playerId = source
    if vehicleData and vehicleData.plate then
        TriggerEvent('bl_carlock:server:giveKey', playerId, vehicleData.plate)
    end
end)

RegisterNetEvent('jg_dealerships:vehiclePurchased', function(playerId, vehicleData)
    if vehicleData and vehicleData.plate and playerId then
        TriggerEvent('bl_carlock:server:giveKey', playerId, vehicleData.plate)
    end
end)

RegisterNetEvent('qbx_vehicleshop:server:vehicleSold', function(playerData, vehicleData)
    if playerData and playerData.source and vehicleData and vehicleData.plate then
        TriggerEvent('bl_carlock:server:giveKey', playerData.source, vehicleData.plate)
    end
end)

RegisterNetEvent('jg_dealerships:server:vehicleSold', function(playerData, vehicleData)
    if playerData and playerData.source and vehicleData and vehicleData.plate then
        TriggerEvent('bl_carlock:server:giveKey', playerData.source, vehicleData.plate)
    end
end)
