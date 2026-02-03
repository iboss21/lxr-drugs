--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
                                                                             
    🐺 LXR Drugs - Server Script
    
    This server script handles drug consumption registration and server-side logic.
    It registers usable items, validates consumption, removes items from inventory,
    and triggers client-side effects with proper security validation.
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 SERVER-SIDE SECURITY & VALIDATION
-- ═══════════════════════════════════════════════════════════════════════════════

local playerCooldowns = {}
local playerUsageCount = {}

-- Clean up old cooldowns every 5 minutes
CreateThread(function()
    while true do
        Wait(300000) -- 5 minutes
        local currentTime = GetGameTimer()
        for playerId, data in pairs(playerCooldowns) do
            if currentTime - data.lastUse > Config.Security.cooldownBetweenUses then
                playerCooldowns[playerId] = nil
            end
        end
        -- Reset usage counters every minute
        playerUsageCount = {}
    end
end)

-- Validate player is not spamming
local function ValidateConsumption(source)
    if not Config.Security.enabled then return true end
    
    local playerId = source
    local currentTime = GetGameTimer()
    
    -- Check rate limiting
    if playerUsageCount[playerId] == nil then
        playerUsageCount[playerId] = 0
    end
    
    playerUsageCount[playerId] = playerUsageCount[playerId] + 1
    
    if playerUsageCount[playerId] > Config.Security.maxConsumptionPerMinute then
        if Config.Security.logSuspiciousActivity then
            print(string.format('[LXR-Drugs] SECURITY: Player %s exceeded consumption rate limit', playerId))
        end
        return false
    end
    
    -- Check cooldown
    if playerCooldowns[playerId] and (currentTime - playerCooldowns[playerId].lastUse) < Config.Security.cooldownBetweenUses then
        return false
    end
    
    playerCooldowns[playerId] = {
        lastUse = currentTime
    }
    
    return true
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 JOINT CONSUMPTION HANDLER
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    while not Framework.Ready do Wait(100) end
    
    Framework.RegisterUsableItem(Config.Joint.itemName, function(data)
        local source = data.source
        
        -- Validate consumption
        if not ValidateConsumption(source) then
            Framework.Notify(source, 'You need to wait before using this again', 'error', 3000)
            return
        end
        
        -- Close inventory
        if Config.Security.requireInventoryClose then
            Framework.CloseInventory(source)
        end
        
        -- Validate item ownership
        if Config.Security.validateItemOwnership then
            if not Framework.HasItem(source, Config.Joint.itemName, 1) then
                if Config.Security.logSuspiciousActivity then
                    print(string.format('[LXR-Drugs] SECURITY: Player %s tried to use joint without having it', source))
                end
                return
            end
        end
        
        -- Remove item
        Framework.RemoveItem(source, Config.Joint.itemName, 1)
        
        -- Apply hunger reduction (VORP metabolism)
        if Framework.Name == 'vorp_core' and Config.Joint.hungerReduction then
            TriggerClientEvent("vorpmetabolism:changeValue", source, "Hunger", -Config.Joint.hungerReduction)
        end
        
        -- Notify player
        local message = Config.Locale[Config.Lang].joint_consumed or 'You smoked a joint'
        Framework.Notify(source, message, 'info', 3000)
        
        -- Trigger client animation and effects
        TriggerClientEvent('lxr-drugs:client:joint', source)
        
        if Config.Debug then
            print(string.format('[LXR-Drugs] Player %s consumed a joint', source))
        end
    end)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 OPIUM CONSUMPTION HANDLER
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    while not Framework.Ready do Wait(100) end
    
    Framework.RegisterUsableItem(Config.Opium.itemName, function(data)
        local source = data.source
        
        -- Validate consumption
        if not ValidateConsumption(source) then
            Framework.Notify(source, 'You need to wait before using this again', 'error', 3000)
            return
        end
        
        -- Close inventory
        if Config.Security.requireInventoryClose then
            Framework.CloseInventory(source)
        end
        
        -- Check for pipe requirement
        local hasPipe = Framework.GetItemCount(source, Config.Opium.pipeItem) >= 1
        if not hasPipe then
            local message = Config.Locale[Config.Lang].opium_need_pipe or 'You need a pipe to smoke opium'
            Framework.Notify(source, message, 'error', 3000)
            return
        end
        
        -- Validate item ownership
        if Config.Security.validateItemOwnership then
            if not Framework.HasItem(source, Config.Opium.itemName, 1) then
                if Config.Security.logSuspiciousActivity then
                    print(string.format('[LXR-Drugs] SECURITY: Player %s tried to use opium without having it', source))
                end
                return
            end
        end
        
        -- Remove item
        Framework.RemoveItem(source, Config.Opium.itemName, 1)
        
        -- Notify player
        local message = Config.Locale[Config.Lang].opium_consumed or 'You smoked opium'
        Framework.Notify(source, message, 'info', 3000)
        
        -- Trigger client animation and effects
        TriggerClientEvent('lxr-drugs:client:opium', source)
        
        if Config.Debug then
            print(string.format('[LXR-Drugs] Player %s consumed opium', source))
        end
    end)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 MUSHROOM CONSUMPTION HANDLER
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    while not Framework.Ready do Wait(100) end
    
    Framework.RegisterUsableItem(Config.Mushroom.itemName, function(data)
        local source = data.source
        
        -- Validate consumption
        if not ValidateConsumption(source) then
            Framework.Notify(source, 'You need to wait before using this again', 'error', 3000)
            return
        end
        
        -- Close inventory
        if Config.Security.requireInventoryClose then
            Framework.CloseInventory(source)
        end
        
        -- Validate item ownership
        if Config.Security.validateItemOwnership then
            if not Framework.HasItem(source, Config.Mushroom.itemName, 1) then
                if Config.Security.logSuspiciousActivity then
                    print(string.format('[LXR-Drugs] SECURITY: Player %s tried to use mushroom without having it', source))
                end
                return
            end
        end
        
        -- Remove item
        Framework.RemoveItem(source, Config.Mushroom.itemName, 1)
        
        -- Notify player
        local message = Config.Locale[Config.Lang].mushroom_consumed or 'You ate a mushroom'
        Framework.Notify(source, message, 'info', 3000)
        
        -- Trigger client animation and effects
        TriggerClientEvent('lxr-drugs:client:mushroom', source)
        
        if Config.Debug then
            print(string.format('[LXR-Drugs] Player %s consumed mushroom', source))
        end
    end)
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 SERVER STARTUP MESSAGE
-- ═══════════════════════════════════════════════════════════════════════════════

CreateThread(function()
    Wait(3000)
    print([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        🐺 LXR-DRUGS SERVER - READY
        ═══════════════════════════════════════════════════════════════════════════════
        
        Drug handlers registered:
        - Joint (]] .. Config.Joint.itemName .. [[)
        - Opium (]] .. Config.Opium.itemName .. [[)
        - Mushroom (]] .. Config.Mushroom.itemName .. [[)
        
        Security:    ]] .. (Config.Security.enabled and 'ENABLED ✓' or 'DISABLED ✗') .. [[
        Framework:   ]] .. Framework.Name .. [[
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]])
end)
