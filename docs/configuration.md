```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs Configuration Guide

**Complete Reference for config.lua**

---

## Server Information

- **Server:** The Land of Wolves 🐺
- **Developer:** iBoss21 / The Lux Empire
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Website:** https://www.wolves.land

---

## 📋 Table of Contents

1. [Server Branding](#server-branding)
2. [Framework Configuration](#framework-configuration)
3. [Language Configuration](#language-configuration)
4. [General Settings](#general-settings)
5. [Joint Configuration](#joint-configuration)
6. [Opium Configuration](#opium-configuration)
7. [Mushroom Configuration](#mushroom-configuration)
8. [Animation Configuration](#animation-configuration)
9. [Security Settings](#security-settings)
10. [Performance Settings](#performance-settings)
11. [Debug Settings](#debug-settings)

---

## 🏷️ Server Branding

### Config.ServerInfo

Server information displayed in startup banner and metadata.

```lua
Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    tagline = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!',
    type = 'Serious Hardcore Roleplay',
    access = 'Discord & Whitelisted',
    
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    github = 'https://github.com/iBoss21',
    store = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    
    developer = 'iBoss21 / The Lux Empire',
    
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Drugs', 'Immersion', 'Roleplay'}
}
```

**Customization:**
- Change `name` to your server name
- Update `tagline` with your server motto
- Modify `description` for your identity
- Update all links to your community
- Keep `developer` credit (appreciated!)

---

## 🔧 Framework Configuration

### Config.Framework

Framework selection and auto-detection settings.

```lua
Config.Framework = 'auto'
```

**Options:**
- `'auto'` - Automatically detect framework (recommended)
- `'lxr-core'` - Force LXR-Core
- `'rsg-core'` - Force RSG-Core
- `'vorp_core'` - Force VORP Core

**Detection Priority:**
1. LXR-Core
2. RSG-Core
3. VORP Core
4. Standalone fallback

**Example - Manual Selection:**
```lua
Config.Framework = 'rsg-core'  -- Force RSG-Core
```

### Config.FrameworkSettings

Framework-specific configuration for each supported framework.

```lua
Config.FrameworkSettings = {
    ['lxr-core'] = {
        resource = 'lxr-core',
        notifications = 'ox_lib',
        inventory = 'lxr-inventory',
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
```

**Customization:**
- Change `resource` names if using forks
- Modify `inventory` name if using custom inventory
- Update `events` format if framework uses different naming

---

## 🌍 Language Configuration

### Config.Lang

Active language for notifications and messages.

```lua
Config.Lang = 'en'
```

**Options:**
- `'en'` - English
- `'ge'` - Georgian (ქართული)
- `'es'` - Spanish (Español)

### Config.Locale

Translation strings for all languages.

```lua
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
```

**Adding New Language:**
```lua
Config.Locale.fr = {
    joint_consumed = 'Vous avez fumé un joint',
    opium_consumed = 'Vous avez fumé de l\'opium',
    opium_need_pipe = 'Vous avez besoin d\'une pipe pour fumer de l\'opium',
    mushroom_consumed = 'Vous avez mangé un champignon',
    effects_starting = 'Vous vous sentez étrange...',
    effects_ending = 'Les effets s\'estompent...'
}
```

Then set: `Config.Lang = 'fr'`

---

## ⚙️ General Settings

### Config.General

Global settings for the drug system.

```lua
Config.General = {
    enableEffects = true,           -- Enable visual effects
    enableSounds = true,            -- Enable sound effects
    requireAnimation = true,        -- Require consumption animation
    clearEffectsOnDeath = true,     -- Clear effects when player dies
    clearEffectsOnLogout = true     -- Clear effects when player logs out
}
```

**Options Explained:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enableEffects` | boolean | `true` | Master toggle for all visual effects |
| `enableSounds` | boolean | `true` | Enable drug-related sound effects |
| `requireAnimation` | boolean | `true` | Play animation before effects |
| `clearEffectsOnDeath` | boolean | `true` | Remove effects when player dies |
| `clearEffectsOnLogout` | boolean | `true` | Remove effects when player disconnects |

**Example - Disable Effects:**
```lua
Config.General = {
    enableEffects = false,  -- No visual effects, only animations
    enableSounds = false,
    requireAnimation = true,
    clearEffectsOnDeath = true,
    clearEffectsOnLogout = true
}
```

---

## 🚬 Joint Configuration

### Config.Joint

Cannabis joint settings and effects.

```lua
Config.Joint = {
    itemName = 'joint',             -- Item name in inventory
    limit = 3,                      -- Limit before negative effects
    timeLimitMs = 3600000,          -- Reset time (1 hour)
    effectDurationMs = 30000,       -- Effect duration (30 seconds)
    hungerReduction = 200,          -- Hunger reduction (VORP metabolism)
    healthBoost = true,             -- Boost health core
    drunkLevel = 0.5                -- Drunk effect level (0.0-1.0)
}
```

**Options Explained:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `itemName` | string | `'joint'` | Item name in framework inventory |
| `limit` | integer | `3` | Max joints before overdose effects |
| `timeLimitMs` | integer | `3600000` | Time until limit resets (ms) |
| `effectDurationMs` | integer | `30000` | How long effects last (ms) |
| `hungerReduction` | integer | `200` | Hunger reduced (VORP only) |
| `healthBoost` | boolean | `true` | Boost health core to 100 |
| `drunkLevel` | float | `0.5` | Drunk walk intensity (0.0-1.0) |

**Time Conversions:**
- 1 second = 1000ms
- 1 minute = 60000ms
- 1 hour = 3600000ms

**Examples:**

**Shorter Effects:**
```lua
Config.Joint = {
    itemName = 'joint',
    limit = 5,
    timeLimitMs = 1800000,      -- 30 minutes
    effectDurationMs = 15000,   -- 15 seconds
    hungerReduction = 100,
    healthBoost = true,
    drunkLevel = 0.3            -- Milder effect
}
```

**Stronger Effects:**
```lua
Config.Joint = {
    itemName = 'joint',
    limit = 2,                  -- Overdose after 2
    timeLimitMs = 7200000,      -- 2 hours
    effectDurationMs = 60000,   -- 1 minute
    hungerReduction = 300,
    healthBoost = true,
    drunkLevel = 0.8            -- Stronger drunk effect
}
```

**Custom Item Name:**
```lua
Config.Joint.itemName = 'weed_joint'  -- If your server uses different name
```

---

## 💨 Opium Configuration

### Config.Opium

Opium smoking settings with hallucinations.

```lua
Config.Opium = {
    itemName = 'opium',             -- Item name in inventory
    pipeItem = 'pipe',              -- Required pipe item
    effectDurationMs = 60000,       -- Effect duration (60 seconds)
    pedQuantity = 20,               -- Number of hallucination peds
    drunkLevel = 1.0,               -- Drunk effect level (0.0-1.0)
    healthBoost = true,             -- Boost health core
    pedModels = {
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
```

**Options Explained:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `itemName` | string | `'opium'` | Opium item name |
| `pipeItem` | string | `'pipe'` | Required pipe item name |
| `effectDurationMs` | integer | `60000` | Effect duration (60 seconds) |
| `pedQuantity` | integer | `20` | Number of hallucination peds |
| `drunkLevel` | float | `1.0` | Maximum drunk effect |
| `healthBoost` | boolean | `true` | Boost health core |
| `pedModels` | table | (see above) | Random ped models to spawn |

**Examples:**

**More Hallucinations:**
```lua
Config.Opium.pedQuantity = 40  -- 40 peds instead of 20
```

**Shorter Duration:**
```lua
Config.Opium.effectDurationMs = 30000  -- 30 seconds
```

**No Pipe Requirement:**
```lua
Config.Opium.pipeItem = ''  -- Empty string disables check
-- Or modify server/server.lua to remove pipe validation
```

**Custom Ped Models:**
```lua
Config.Opium.pedModels = {
    'A_C_Wolf',
    'A_C_Bear_01',
    'A_C_Cougar_01',
    'CS_BEAR_LEGENDARY',
    'MP_A_C_WOLF_LEGENDARY'
}
```

---

## 🍄 Mushroom Configuration

### Config.Mushroom

Psychedelic mushroom effects with sky camera.

```lua
Config.Mushroom = {
    itemName = 'mushroom',          -- Item name in inventory
    pedQuantity = 20,               -- Number of hallucination peds
    drunkLevel = 1.0,               -- Drunk effect level (0.0-1.0)
    pedModels = {
        'A_C_Fox_01',
        'U_M_Y_ShackStarvingKid_01',
        -- ... (same 32 models as opium)
    }
}
```

**Options Explained:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `itemName` | string | `'mushroom'` | Mushroom item name |
| `pedQuantity` | integer | `20` | Number of sky hallucinations |
| `drunkLevel` | float | `1.0` | Maximum drunk effect |
| `pedModels` | table | (see above) | Random ped models in sky |

**Note:** Mushroom duration is hardcoded in phases (~90 seconds total)

**Examples:**

**Fewer Hallucinations:**
```lua
Config.Mushroom.pedQuantity = 10
```

**Different Peds:**
```lua
Config.Mushroom.pedModels = {
    'A_C_Eagle_01',
    'A_C_Vulture_01',
    'A_C_Crow_01'
}
```

---

## 🎬 Animation Configuration

### Config.Animations

Animation dictionaries and settings for each drug.

```lua
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
```

**Animation Structure:**
```lua
{
    dict = "animation_dictionary",
    anim = "animation_name",
    duration = -1,  -- -1 = full animation, >0 = milliseconds
    flag = 30       -- Animation flag
}
```

**Common Animation Flags:**
- `1` - Normal
- `2` - Repeat
- `30` - Looped + cancellable

**Customization:**
You can replace animations with any valid RedM animation dictionary. Test animations with:
```lua
/e [animation_name]
```

---

## 🔒 Security Settings

### Config.Security

Anti-abuse and validation settings.

```lua
Config.Security = {
    enabled = true,                 -- Enable security checks
    maxConsumptionPerMinute = 5,    -- Max drug uses per minute
    requireInventoryClose = true,   -- Require inventory to be closed
    validateItemOwnership = true,   -- Validate player has item before consumption
    logSuspiciousActivity = true,   -- Log suspicious behavior
    cooldownBetweenUses = 1000      -- Cooldown between uses (ms)
}
```

**Options Explained:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enabled` | boolean | `true` | Master security toggle |
| `maxConsumptionPerMinute` | integer | `5` | Max uses per 60 seconds |
| `requireInventoryClose` | boolean | `true` | Close inventory on use |
| `validateItemOwnership` | boolean | `true` | Verify player has item |
| `logSuspiciousActivity` | boolean | `true` | Log excessive use to console |
| `cooldownBetweenUses` | integer | `1000` | Milliseconds between uses |

**Examples:**

**Strict Security:**
```lua
Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 3,
    requireInventoryClose = true,
    validateItemOwnership = true,
    logSuspiciousActivity = true,
    cooldownBetweenUses = 5000  -- 5 second cooldown
}
```

**Relaxed Security:**
```lua
Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 10,
    requireInventoryClose = false,
    validateItemOwnership = true,
    logSuspiciousActivity = false,
    cooldownBetweenUses = 500
}
```

**Testing Mode (Disable Security):**
```lua
Config.Security.enabled = false  -- WARNING: Only for testing!
```

---

## ⚡ Performance Settings

### Config.Performance

Optimization and performance tuning.

```lua
Config.Performance = {
    cleanupPedsOnStop = true,       -- Clean up spawned peds on resource stop
    clearEffectsOnStop = true,      -- Clear effects on resource stop
    pedScaleLarge = 5.0,            -- Scale for large hallucination peds
    pedScaleSmall = 2.0,            -- Scale for small hallucination peds
    maxPedSpawnDistance = 20,       -- Max distance to spawn hallucination peds
    cameraHeight = 100              -- Height for mushroom camera effect
}
```

**Options Explained:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `cleanupPedsOnStop` | boolean | `true` | Delete peds on resource stop |
| `clearEffectsOnStop` | boolean | `true` | Clear screen effects on stop |
| `pedScaleLarge` | float | `5.0` | Scale for opium peds (giant) |
| `pedScaleSmall` | float | `2.0` | Scale for mushroom peds |
| `maxPedSpawnDistance` | integer | `20` | Max meters from player |
| `cameraHeight` | integer | `100` | Camera elevation for mushroom |

**Examples:**

**More Peds Nearby:**
```lua
Config.Performance.maxPedSpawnDistance = 30  -- 30 meters
```

**Smaller Hallucinations:**
```lua
Config.Performance.pedScaleLarge = 2.0  -- Less giant
Config.Performance.pedScaleSmall = 1.5
```

**Higher Sky Camera:**
```lua
Config.Performance.cameraHeight = 200  -- 200 meters high
```

---

## 🐛 Debug Settings

### Config.Debug

Debug logging and development mode.

```lua
Config.Debug = false
```

**Options:**
- `true` - Enable detailed console logging
- `false` - Disable debug output (production)

**When Enabled:**
- Prints framework detection details
- Logs drug consumption events
- Shows security validation
- Displays startup info

**Example Debug Output:**
```
[LXR-Drugs] Detected framework: lxr-core
[LXR-Drugs] Player 1 consumed a joint
[LXR-Drugs] SECURITY: Player 2 exceeded consumption rate limit
```

**Enable for Troubleshooting:**
```lua
Config.Debug = true
```

---

## 📝 Configuration Examples

### Hardcore Roleplay Server

```lua
-- Realistic, slow-paced effects
Config.Joint = {
    itemName = 'joint',
    limit = 2,
    timeLimitMs = 7200000,      -- 2 hours
    effectDurationMs = 60000,   -- 1 minute
    hungerReduction = 300,
    healthBoost = false,        -- No health boost
    drunkLevel = 0.6
}

Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 2,
    requireInventoryClose = true,
    validateItemOwnership = true,
    logSuspiciousActivity = true,
    cooldownBetweenUses = 10000  -- 10 seconds
}
```

### Casual/Fun Server

```lua
-- Fast, intense effects
Config.Joint = {
    itemName = 'joint',
    limit = 10,
    timeLimitMs = 600000,       -- 10 minutes
    effectDurationMs = 20000,   -- 20 seconds
    hungerReduction = 100,
    healthBoost = true,
    drunkLevel = 0.8
}

Config.Opium.pedQuantity = 40   -- More hallucinations
Config.Mushroom.pedQuantity = 40

Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 10,
    requireInventoryClose = false,
    validateItemOwnership = true,
    logSuspiciousActivity = false,
    cooldownBetweenUses = 500
}
```

### Testing/Development

```lua
Config.Debug = true
Config.Security.enabled = false
Config.Joint.effectDurationMs = 10000   -- 10 seconds for quick testing
Config.Opium.effectDurationMs = 15000
```

---

## 🎯 Quick Reference

### Common Modifications

**Change Item Names:**
```lua
Config.Joint.itemName = 'weed_joint'
Config.Opium.itemName = 'opium_raw'
Config.Mushroom.itemName = 'shroom'
```

**Adjust Effect Duration:**
```lua
Config.Joint.effectDurationMs = 45000      -- 45 seconds
Config.Opium.effectDurationMs = 90000      -- 90 seconds
```

**Change Hallucination Intensity:**
```lua
Config.Opium.pedQuantity = 30
Config.Mushroom.pedQuantity = 30
```

**Modify Security:**
```lua
Config.Security.maxConsumptionPerMinute = 3
Config.Security.cooldownBetweenUses = 5000
```

**Set Language:**
```lua
Config.Lang = 'es'  -- Spanish
```

---

## ✅ Configuration Checklist

- [ ] Set correct framework (`Config.Framework`)
- [ ] Choose language (`Config.Lang`)
- [ ] Set item names to match your inventory
- [ ] Adjust effect durations for your server pace
- [ ] Configure security settings
- [ ] Set hallucination quantities
- [ ] Customize ped models if desired
- [ ] Test with `Config.Debug = true`
- [ ] Disable debug for production

---

## 🆘 Help & Support

**Discord:** https://discord.gg/CrKcWdfd3A  
**Developer:** iBoss21 / The Lux Empire

---

**🐺 Configure your perfect drug system for your server!**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved