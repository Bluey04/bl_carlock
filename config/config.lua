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
-- Supported: "qb", "okok", "mythic", "ox", "print"
Config.Notify = "ox"

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
