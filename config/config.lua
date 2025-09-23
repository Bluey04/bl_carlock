Config = {}

-- Standalone Mode
Config.Standalone = false -- Set to true to run without any framework or inventory system

-- Framework
-- Supported: "qbcore" (for QBCore), "esx" (for ESX)
Config.Framework = Config.Standalone and nil or "qbcore" -- or "esx"

-- Inventory System
-- Supported: "ox", "qb", "qs"
Config.Inventory = "ox"

-- Notify System
-- Supported: "bl" "qb", "okok", "mythic", "ox", "print"
Config.Notify = "bl_notify"

-- Lock Settings
Config.LockCommand = "lock"
Config.Keybind = "L"
Config.MaxVehicleDistance = 4.0

-- Animations
Config.PlayLockAnimation = true
Config.FlashLights = true
Config.PlaySound = true

-- Debug
Config.Debug = false


-- ====== Discord Logging ======
Config.DiscordWebhook = "" -- put your Discord webhook URL here

Config.Discord = {
    username = "Car Lock Logs",
    lock_color = 16711680,    -- red
    unlock_color = 65280,     -- green
    default_color = 16776960, -- yellow
    action_title = "Car Lock",
    footer = "BL Carlock System"
}
