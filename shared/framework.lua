--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
                                                                             
    🐺 LXR Drugs - Framework Adapter/Bridge
    
    This module provides a unified interface for multi-framework support.
    It automatically detects the running framework and provides consistent
    functions for notifications, inventory, and player data across all frameworks.
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 FRAMEWORK DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

Framework = {}
Framework.Name = 'unknown'
Framework.Core = nil
Framework.Inventory = nil
Framework.Ready = false

-- Detect active framework
local function DetectFramework()
    if Config.Framework ~= 'auto' then
        Framework.Name = Config.Framework
        if Config.Debug then
            print('[LXR-Drugs] Manual framework: ' .. Framework.Name)
        end
        return Framework.Name
    end
    
    -- Priority order: LXR-Core > RSG-Core > VORP
    local frameworks = {
        {name = 'lxr-core', resource = 'lxr-core'},
        {name = 'rsg-core', resource = 'rsg-core'},
        {name = 'vorp_core', resource = 'vorp_core'}
    }
    
    for _, fw in ipairs(frameworks) do
        local state = GetResourceState(fw.resource)
        if state == 'started' or state == 'starting' then
            Framework.Name = fw.name
            if Config.Debug then
                print('[LXR-Drugs] Detected framework: ' .. Framework.Name)
            end
            return Framework.Name
        end
    end
    
    Framework.Name = 'standalone'
    if Config.Debug then
        print('[LXR-Drugs] No framework detected, running standalone')
    end
    return Framework.Name
end

-- Initialize framework-specific objects
local function InitializeFramework()
    if Framework.Name == 'lxr-core' then
        -- LXR-Core initialization
        if IsDuplicityVersion() then -- Server
            Framework.Core = exports['lxr-core']:GetCoreObject()
        else -- Client
            Framework.Core = exports['lxr-core']:GetCoreObject()
        end
        Framework.Inventory = exports['lxr-inventory']
        
    elseif Framework.Name == 'rsg-core' then
        -- RSG-Core initialization
        if IsDuplicityVersion() then -- Server
            Framework.Core = exports['rsg-core']:GetCoreObject()
        else -- Client
            Framework.Core = exports['rsg-core']:GetCoreObject()
        end
        Framework.Inventory = exports['rsg-inventory']
        
    elseif Framework.Name == 'vorp_core' then
        -- VORP initialization
        if IsDuplicityVersion() then -- Server
            TriggerEvent("getCore", function(core)
                Framework.Core = core
            end)
        else -- Client
            TriggerEvent("getCore", function(core)
                Framework.Core = core
            end)
        end
        Framework.Inventory = exports.vorp_inventory:vorp_inventoryApi()
    end
    
    Framework.Ready = true
end

-- Run detection and initialization
DetectFramework()
CreateThread(function()
    Wait(500) -- Give frameworks time to initialize
    InitializeFramework()
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 UNIFIED NOTIFICATION INTERFACE
-- ═══════════════════════════════════════════════════════════════════════════════

function Framework.Notify(source, message, type, duration)
    if not Framework.Ready then
        print('[LXR-Drugs] Framework not ready, skipping notification')
        return
    end
    
    duration = duration or 3000
    type = type or 'info'
    
    if IsDuplicityVersion() then -- Server
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            TriggerClientEvent('ox_lib:notify', source, {
                description = message,
                type = type,
                duration = duration
            })
        elseif Framework.Name == 'vorp_core' then
            local notifType = 'tip'
            if type == 'error' then notifType = 'error' end
            if type == 'success' then notifType = 'success' end
            Framework.Core.NotifyLeft(source, 'LXR Drugs', message, 'generic_textures', 'tick', duration, 'COLOR_PURE_WHITE')
        elseif Framework.Name == 'standalone' then
            TriggerClientEvent('chat:addMessage', source, {
                args = {'[LXR-Drugs]', message}
            })
        end
    else -- Client
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            exports.ox_lib:notify({
                description = message,
                type = type,
                duration = duration
            })
        elseif Framework.Name == 'vorp_core' then
            TriggerEvent('vorp:TipBottom', message, duration)
        elseif Framework.Name == 'standalone' then
            print('[LXR-Drugs] ' .. message)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 UNIFIED INVENTORY INTERFACE (SERVER ONLY)
-- ═══════════════════════════════════════════════════════════════════════════════

if IsDuplicityVersion() then -- Server only
    
    function Framework.AddItem(source, item, amount, metadata)
        if not Framework.Ready then return false end
        
        amount = amount or 1
        metadata = metadata or {}
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            Framework.Core.Functions.AddItem(source, item, amount, metadata)
            return true
        elseif Framework.Name == 'vorp_core' then
            Framework.Inventory.addItem(source, item, amount, metadata)
            return true
        end
        
        return false
    end
    
    function Framework.RemoveItem(source, item, amount)
        if not Framework.Ready then return false end
        
        amount = amount or 1
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            Framework.Core.Functions.RemoveItem(source, item, amount)
            return true
        elseif Framework.Name == 'vorp_core' then
            Framework.Inventory.subItem(source, item, amount)
            return true
        end
        
        return false
    end
    
    function Framework.HasItem(source, item, amount)
        if not Framework.Ready then return false end
        
        amount = amount or 1
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            local playerItems = Framework.Core.Functions.GetPlayer(source).PlayerData.items
            local itemCount = 0
            for _, invItem in pairs(playerItems) do
                if invItem.name == item then
                    itemCount = itemCount + invItem.amount
                end
            end
            return itemCount >= amount
        elseif Framework.Name == 'vorp_core' then
            local itemCount = Framework.Inventory.getItemCount(source, item)
            return itemCount >= amount
        end
        
        return false
    end
    
    function Framework.GetItemCount(source, item)
        if not Framework.Ready then return 0 end
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            local playerItems = Framework.Core.Functions.GetPlayer(source).PlayerData.items
            local itemCount = 0
            for _, invItem in pairs(playerItems) do
                if invItem.name == item then
                    itemCount = itemCount + invItem.amount
                end
            end
            return itemCount
        elseif Framework.Name == 'vorp_core' then
            return Framework.Inventory.getItemCount(source, item)
        end
        
        return 0
    end
    
    function Framework.CloseInventory(source)
        if not Framework.Ready then return end
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            -- Close via client event
            TriggerClientEvent('inventory:client:closeInv', source)
        elseif Framework.Name == 'vorp_core' then
            Framework.Inventory.CloseInv(source)
        end
    end
    
    -- Register usable item
    function Framework.RegisterUsableItem(itemName, callback)
        if not Framework.Ready then
            CreateThread(function()
                while not Framework.Ready do Wait(100) end
                Framework.RegisterUsableItem(itemName, callback)
            end)
            return
        end
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            Framework.Core.Functions.CreateUseableItem(itemName, callback)
        elseif Framework.Name == 'vorp_core' then
            Framework.Inventory.RegisterUsableItem(itemName, callback)
        end
    end
    
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 UNIFIED PLAYER INTERFACE (SERVER ONLY)
-- ═══════════════════════════════════════════════════════════════════════════════

if IsDuplicityVersion() then -- Server only
    
    function Framework.GetPlayer(source)
        if not Framework.Ready then return nil end
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            return Framework.Core.Functions.GetPlayer(source)
        elseif Framework.Name == 'vorp_core' then
            return Framework.Core.getUser(source)
        end
        
        return nil
    end
    
    function Framework.GetIdentifier(source)
        if not Framework.Ready then return nil end
        
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            local player = Framework.Core.Functions.GetPlayer(source)
            return player and player.PlayerData.citizenid or nil
        elseif Framework.Name == 'vorp_core' then
            local user = Framework.Core.getUser(source)
            return user and user.getIdentifier() or nil
        end
        
        return GetPlayerIdentifiers(source)[1]
    end
    
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 UNIFIED METADATA INTERFACE (CLIENT ONLY)
-- ═══════════════════════════════════════════════════════════════════════════════

if not IsDuplicityVersion() then -- Client only
    
    function Framework.TriggerServerCallback(name, callback, ...)
        if Framework.Name == 'lxr-core' or Framework.Name == 'rsg-core' then
            Framework.Core.Functions.TriggerCallback(name, callback, ...)
        elseif Framework.Name == 'vorp_core' then
            TriggerServerEvent(name, callback, ...)
        end
    end
    
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 FRAMEWORK INFO LOGGING
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    Wait(2000)
    if Config.Debug or IsDuplicityVersion() then
        print(string.format([[
            
            ═══════════════════════════════════════════════════════════════════
            🐺 LXR-DRUGS FRAMEWORK ADAPTER
            ═══════════════════════════════════════════════════════════════════
            
            Detected:    %s
            Ready:       %s
            Side:        %s
            
            ═══════════════════════════════════════════════════════════════════
            
        ]], Framework.Name, Framework.Ready and 'YES' or 'NO', IsDuplicityVersion() and 'SERVER' or 'CLIENT'))
    end
end)

return Framework
