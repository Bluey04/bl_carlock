local function AddVehicleTargets()
    -- Add target options for QB framework
    if Config.Target == "qb" then
        exports['qb-target']:AddGlobalVehicle({
            options = {
                -- Lock Vehicle Option
                {
                    icon = "fas fa-lock",
                    label = Locales['target_lock'],
                    action = function(entity)
                        TriggerServerEvent("bl_carlock:server:toggleLock", GetVehicleNumberPlateText(entity), VehToNet(entity))
                    end
                },
                -- Unlock Vehicle Option
                {
                    icon = "fas fa-unlock",
                    label = Locales['target_unlock'],
                    action = function(entity)
                        TriggerServerEvent("bl_carlock:server:toggleLock", GetVehicleNumberPlateText(entity), VehToNet(entity))
                    end
                },
                -- Give Key Option
                {
                    icon = "fas fa-key",
                    label = Locales['target_give_key'],
                    action = function(entity)
                        local closestPlayer, _ = GetClosestPlayer()
                        if closestPlayer ~= -1 then
                            TriggerServerEvent("bl_carlock:server:giveKey", GetPlayerServerId(closestPlayer), GetVehicleNumberPlateText(entity))
                        else
                            Notify(Locales['no_players_nearby'], 'error')
                        end
                    end
                }
            },
            distance = 2.5
        })

    -- Add target options for ox_target
    elseif Config.Target == "ox" then
        exports.ox_target:addGlobalVehicle({
            {
                label = Locales['target_lock'],
                icon = 'fas fa-lock',
                onSelect = function(data)
                    TriggerServerEvent("bl_carlock:server:toggleLock", GetVehicleNumberPlateText(data.entity), VehToNet(data.entity))
                end
            },
            {
                label = Locales['target_unlock'],
                icon = 'fas fa-unlock',
                onSelect = function(data)
                    TriggerServerEvent("bl_carlock:server:toggleLock", GetVehicleNumberPlateText(data.entity), VehToNet(data.entity))
                end
            },
            {
                label = Locales['target_give_key'],
                icon = 'fas fa-key',
                onSelect = function(data)
                    local closestPlayer, _ = GetClosestPlayer()
                    if closestPlayer ~= -1 then
                        TriggerServerEvent("bl_carlock:server:giveKey", GetPlayerServerId(closestPlayer), GetVehicleNumberPlateText(data.entity))
                    else
                        Notify(Locales['no_players_nearby'], 'error')
                    end
                end
            }
        })
    end
end

-- This ensures that target is only added once the network session is active
CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(100) end
    AddVehicleTargets()
end)

-- Function to get the closest player
function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestPlayer, closestDistance = -1, 999.0
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)

    for _, player in pairs(players) do
        local targetPed = GetPlayerPed(player)
        if targetPed ~= plyPed then
            local targetCoords = GetEntityCoords(targetPed)
            local dist = #(plyCoords - targetCoords)
            if dist < closestDistance then
                closestPlayer = player
                closestDistance = dist
            end
        end
    end
    return closestPlayer, closestDistance
end

-- Notification function (use localized message based on config)
function Notify(msg, type)
    local t = type or "inform"

    if Config.Notify == "qb" then
        TriggerEvent('QBCore:Notify', msg, t)
    elseif Config.Notify == "okok" then
        TriggerEvent('okokNotify:Alert', 'Car Lock', msg, 5000, t)
    elseif Config.Notify == "mythic" then
        TriggerEvent('mythic_notify:client:SendAlert', {
            type = t,
            text = msg,
            style = { ["background-color"] = "#000", ["color"] = "#fff" }
        })
    elseif Config.Notify == "ox" then
        lib.notify({ description = msg, type = t })
    else
        print("[Notify][" .. t .. "]: " .. msg)
    end
end
