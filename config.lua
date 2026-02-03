--[[
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
                                                                             
    🐺 LXR Drugs - Configuration
    
    This configuration file controls the drug consumption system for RedM.
    Players can consume various drugs with unique visual effects, animations,
    and gameplay impacts. Each drug has configurable effects, durations, and limits.
    
    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════
    
    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted
    
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    Version: 1.0.0
    Performance Target: Optimized for smooth visual effects and minimal overhead
    
    Tags: RedM, Georgian, SeriousRP, Whitelist, Drugs, Immersion, Roleplay
    
    Framework Support:
    - LXR Core (Primary)
    - RSG Core (Primary)
    - VORP Core (Supported)
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    
    Script Author: iBoss21 / The Lux Empire for The Land of Wolves
    Original Concept: Xakra
    Inspired by: Immersive drug mechanics and visual effects
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-drugs"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════
        
        Expected: %s
        Got: %s
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.
        
        🐺 wolves.land - The Land of Wolves
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    tagline = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type = 'Serious Hardcore Roleplay',
    access = 'Discord & Whitelisted',
    
    -- Contact & Links
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    github = 'https://github.com/iBoss21',
    store = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    
    -- Developer Info
    developer = 'iBoss21 / The Lux Empire',
    
    -- Tags
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Drugs', 'Immersion', 'Roleplay'}
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXR-Core (Primary)
    2. RSG-Core (Primary)
    3. VORP Core (Supported)
]]

Config.Framework = 'auto' -- 'auto' or manual: 'lxr-core', 'rsg-core', 'vorp_core'

-- Framework-specific settings
Config.FrameworkSettings = {
    ['lxr-core'] = {
        resource = 'lxr-core',
        notifications = 'ox_lib', -- notification system to use
        inventory = 'lxr-inventory',
        -- Event naming convention
        events = {
            server = 'lxr-core:server:%s',
            client = 'lxr-core:client:%s',
            callback = 'lxr-core:callback:%s'
        }
    },
    ['rsg-core'] = {
        resource = 'rsg-core',
        notifications = 'ox_lib',
        inventory = 'rsg-inventory',
        events = {
            server = 'RSGCore:Server:%s',
            client = 'RSGCore:Client:%s',
            callback = 'RSGCore:Callback:%s'
        }
    },
    ['vorp_core'] = {
        resource = 'vorp_core',
        notifications = 'vorp',
        inventory = 'vorp_inventory',
        events = {
            server = 'vorp:server:%s',
            client = 'vorp:client:%s'
        }
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE CONFIGURATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Lang = 'en' -- Language for notifications (en, ge, es)

Config.Locale = {
    en = {
        joint_consumed = 'You smoked a joint',
        opium_consumed = 'You smoked opium',
        opium_need_pipe = 'You need a pipe to smoke opium',
        mushroom_consumed = 'You ate a mushroom',
        effects_starting = 'You feel strange...',
        effects_ending = 'The effects are wearing off...'
    },
    ge = {
        joint_consumed = 'გამოიწევე სიგარეტი',
        opium_consumed = 'გამოიწევე ოპიუმი',
        opium_need_pipe = 'ოპიუმის მოსაწევად საჭიროა ჩიბუხი',
        mushroom_consumed = 'შეჭამე სოკო',
        effects_starting = 'უცნაურად გრძნობ თავს...',
        effects_ending = 'ეფექტი სუსტდება...'
    },
    es = {
        joint_consumed = 'Fumaste un porro',
        opium_consumed = 'Fumaste opio',
        opium_need_pipe = 'Necesitas una pipa para fumar opio',
        mushroom_consumed = 'Comiste un hongo',
        effects_starting = 'Te sientes extraño...',
        effects_ending = 'Los efectos están desapareciendo...'
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ GENERAL SETTINGS ██████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.General = {
    enableEffects = true,           -- Enable visual effects
    enableSounds = true,            -- Enable sound effects
    requireAnimation = true,        -- Require consumption animation
    clearEffectsOnDeath = true,     -- Clear effects when player dies
    clearEffectsOnLogout = true     -- Clear effects when player logs out
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DRUG ITEMS CONFIGURATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Joint Configuration
Config.Joint = {
    itemName = 'joint',             -- Item name in inventory
    limit = 3,                      -- Limit before negative effects
    timeLimitMs = 3600000,          -- Reset time (1 hour)
    effectDurationMs = 30000,       -- Effect duration (30 seconds)
    hungerReduction = 200,          -- Hunger reduction (VORP metabolism)
    healthBoost = true,             -- Boost health core
    drunkLevel = 0.5                -- Drunk effect level (0.0-1.0)
}

-- Opium Configuration
Config.Opium = {
    itemName = 'opium',             -- Item name in inventory
    pipeItem = 'pipe',              -- Required pipe item
    effectDurationMs = 60000,       -- Effect duration (60 seconds)
    pedQuantity = 20,               -- Number of hallucination peds
    drunkLevel = 1.0,               -- Drunk effect level (0.0-1.0)
    healthBoost = true,             -- Boost health core
    pedModels = {                   -- List of random ped models for hallucinations
        'A_C_Fox_01',
        'U_M_Y_ShackStarvingKid_01',
        'U_M_M_CircusWagon_01',
        'RE_WILDMAN_01',
        'RE_NAKEDSWIMMER_MALES_01',
        'CS_SwampFreak',
        'CS_genstoryfemale',
        'CS_genstorymale',
        'U_F_M_RhdNudeWoman_01',
        'A_C_HorseMulePainted_01',
        'A_C_Eagle_01',
        'A_C_Badger_01',
        'A_C_Snake_01',
        'A_C_Crab_01',
        'A_C_Buck_01',
        'A_C_Buffalo_01',
        'A_C_Bull_01',
        'A_C_Cat_01',
        'A_C_Chicken_01',
        'A_C_DogHusky_01',
        'A_C_Goat_01',
        'A_C_Horse_Arabian_White',
        'A_C_Moose_01',
        'A_C_Pig_01',
        'A_C_Rabbit_01',
        'A_C_Raccoon_01',
        'MP_A_C_BOAR_01',
        'MP_A_C_BUCK_01',
        'MP_A_C_BIGHORNRAM_01',
        'MP_A_C_BEAVER_01',
        'A_C_FrogBull_01',
        'A_C_GilaMonster_01'
    }
}

-- Mushroom Configuration
Config.Mushroom = {
    itemName = 'mushroom',          -- Item name in inventory
    pedQuantity = 20,               -- Number of hallucination peds
    drunkLevel = 1.0,               -- Drunk effect level (0.0-1.0)
    pedModels = {                   -- List of random ped models for hallucinations
        'A_C_Fox_01',
        'U_M_Y_ShackStarvingKid_01',
        'U_M_M_CircusWagon_01',
        'RE_WILDMAN_01',
        'RE_NAKEDSWIMMER_MALES_01',
        'CS_SwampFreak',
        'CS_genstoryfemale',
        'CS_genstorymale',
        'U_F_M_RhdNudeWoman_01',
        'A_C_HorseMulePainted_01',
        'A_C_Eagle_01',
        'A_C_Badger_01',
        'A_C_Snake_01',
        'A_C_Crab_01',
        'A_C_Buck_01',
        'A_C_Buffalo_01',
        'A_C_Bull_01',
        'A_C_Cat_01',
        'A_C_Chicken_01',
        'A_C_DogHusky_01',
        'A_C_Goat_01',
        'A_C_Horse_Arabian_White',
        'A_C_Moose_01',
        'A_C_Pig_01',
        'A_C_Rabbit_01',
        'A_C_Raccoon_01',
        'MP_A_C_BOAR_01',
        'MP_A_C_BUCK_01',
        'MP_A_C_BIGHORNRAM_01',
        'MP_A_C_BEAVER_01',
        'A_C_FrogBull_01',
        'A_C_GilaMonster_01'
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ ANIMATION CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Animations = {
    joint = {
        smoking = {
            dict = "amb_rest@world_human_smoking@male_c@stand_enter",
            anim = "enter_back_rf",
            duration = 9400
        },
        base = {
            dict = "amb_rest@world_human_smoking@male_c@base",
            anim = "base",
            duration = -1,
            flag = 30
        },
        exit = {
            dict = "amb_rest@world_human_smoking@male_a@stand_exit",
            anim = "exit_back",
            duration = -1,
            flag = 1
        }
    },
    opium = {
        smoke = {
            dict = "amb_wander@code_human_smoking_wander@male_b@trans",
            anim = "nopipe_trans_pipe",
            duration = -1,
            flag = 30
        },
        exit = {
            dict = "amb_wander@code_human_smoking_wander@male_b@trans",
            anim = "pipe_trans_nopipe",
            duration = -1,
            flag = 30
        }
    },
    mushroom = {
        eat = {
            dict = "mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese",
            anim = "quick_right_hand",
            duration = -1,
            flag = 30
        },
        fall = {
            dict = "veh_train@trolly@exterior@rl@exit@to@land@normal@get_out_start@male",
            anim = "dead_fall_out",
            duration = -1,
            flag = 2
        },
        getup = {
            dict = "script_proc@robberies@shop@rhodes@gunsmith@outside_reshoot",
            anim = "kneel_get_up_plr",
            duration = -1,
            flag = 2
        }
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SECURITY & ANTI-ABUSE █████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Security = {
    enabled = true,                 -- Enable security checks
    maxConsumptionPerMinute = 5,    -- Max drug uses per minute
    requireInventoryClose = true,   -- Require inventory to be closed
    validateItemOwnership = true,   -- Validate player has item before consumption
    logSuspiciousActivity = true,   -- Log suspicious behavior
    cooldownBetweenUses = 1000      -- Cooldown between uses (ms)
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ PERFORMANCE OPTIMIZATION ██████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Performance = {
    cleanupPedsOnStop = true,       -- Clean up spawned peds on resource stop
    clearEffectsOnStop = true,      -- Clear effects on resource stop
    pedScaleLarge = 5.0,            -- Scale for large hallucination peds
    pedScaleSmall = 2.0,            -- Scale for small hallucination peds
    maxPedSpawnDistance = 20,       -- Max distance to spawn hallucination peds
    cameraHeight = 100              -- Height for mushroom camera effect
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG SETTINGS ████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = false -- Enable debug prints and extra logging

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ END OF CONFIGURATION ██████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

-- Startup banner
CreateThread(function()
    Wait(1000)
    print([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        
            ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
            ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
            ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
            ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
            ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
            ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
        
        ═══════════════════════════════════════════════════════════════════════════════
        🐺 DRUG SYSTEM - SUCCESSFULLY LOADED
        ═══════════════════════════════════════════════════════════════════════════════
        
        Version:     1.0.0
        Server:      ]] .. Config.ServerInfo.name .. [[
        
        Framework:   ]] .. Config.Framework .. [[
        Language:    ]] .. Config.Lang .. [[
        
        Drugs:       Joint, Opium, Mushroom
        Effects:     ]] .. (Config.General.enableEffects and 'ENABLED ✓' or 'DISABLED ✗') .. [[
        Security:    ]] .. (Config.Security.enabled and 'ENABLED ✓' or 'DISABLED ✗') .. [[
        Debug:       ]] .. (Config.Debug and 'ENABLED' or 'DISABLED') .. [[
        
        ═══════════════════════════════════════════════════════════════════════════════
        
        Developer:   iBoss21 / The Lux Empire
        Website:     https://www.wolves.land
        Discord:     https://discord.gg/CrKcWdfd3A
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]])
end)
