```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs Events Reference

**Complete Client & Server Event Documentation**

---

## Server Information

- **Server:** The Land of Wolves 🐺
- **Developer:** iBoss21 / The Lux Empire
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Website:** https://www.wolves.land

---

## 📋 Overview

LXR-Drugs uses a simple event-based architecture for communication between server and client. This document details all available events and how to use them.

---

## 🎮 Client Events

Events triggered on the client (player) side.

### lxr-drugs:client:joint

Triggers joint smoking animation and effects.

**Type:** Client Event  
**Triggered By:** Server (after item validation)  
**Parameters:** None

**What It Does:**
1. Creates cigarette prop
2. Plays smoking animation
3. Attaches/detaches prop from hand/mouth
4. Applies screen effects (PlayerDrugsPoisonWell)
5. Sets drunk level (0.5)
6. Boosts health core
7. Checks for overdose (if limit exceeded)

**Example - Manual Trigger:**
```lua
-- From server
TriggerClientEvent('lxr-drugs:client:joint', source)

-- From client (testing only)
TriggerEvent('lxr-drugs:client:joint')
```

**Effect Sequence:**
```
1. Create cigarette prop (p_cigarette_dynamic_01x)
2. Attach to mouth (0ms)
3. Play enter animation (1000ms)
4. Attach to hand (2000ms)
5. Attach to mouth (3000ms)
6. Base smoking animation (6000ms)
7. Exit animation (8000ms)
8. Drop cigarette (9800ms)
9. Screen effects start (10000ms)
10. Effects end after Config.Joint.effectDurationMs
```

**Visual Effects:**
- `AnimpostfxPlay('PlayerDrugsPoisonWell')` - Green tint, slight blur
- `SetPedDrunkness(PlayerPedId(), true, 0.5)` - Mild drunk walking

**Overdose Effects (if limit exceeded):**
- `AnimpostfxPlay('playerdrugshalluc01')` - Intense hallucination
- `SetPedToRagdoll()` - Character falls down repeatedly
- Duration: effectDurationMs + 10000

---

### lxr-drugs:client:opium

Triggers opium pipe smoking with hallucinations.

**Type:** Client Event  
**Triggered By:** Server (after pipe validation)  
**Parameters:** None

**What It Does:**
1. Creates pipe prop
2. Plays pipe smoking animation
3. Spawns 20 hallucination peds
4. Applies intense screen effects
5. Sets maximum drunk level (1.0)
6. Boosts health core
7. Cleans up peds after duration

**Example - Manual Trigger:**
```lua
-- From server
TriggerClientEvent('lxr-drugs:client:opium', source)
```

**Effect Sequence:**
```
1. Create pipe prop (P_PIPE01X)
2. Attach to hand
3. Play pipe animation (8000ms)
4. Exit animation (8500ms)
5. Delete pipe
6. Screen effects start
7. Spawn 20 hallucination peds
8. Effects last Config.Opium.effectDurationMs
9. Cleanup peds
10. Clear screen effects
```

**Visual Effects:**
- `AnimpostfxPlay('PlayerWakeUpDrunk')` - Blur and distortion
- `AnimpostfxPlay('playerdrugshalluc01')` - Strong hallucination
- `SetPedDrunkness(PlayerPedId(), true, 1.0)` - Maximum drunk

**Hallucination System:**
```lua
-- Spawns 20 random peds from Config.Opium.pedModels
for i = 0, Config.Opium.pedQuantity do
    local model = Config.Opium.pedModels[math.random(#Config.Opium.pedModels)]
    CreateOpiumPed(model)  -- Spawn at random location near player
end
```

**Ped Properties:**
- Scale: 5.0x (giant)
- Distance: 0-20 meters from player
- Random outfits
- Ground-positioned

---

### lxr-drugs:client:mushroom

Triggers psychedelic mushroom effects with sky camera.

**Type:** Client Event  
**Triggered By:** Server (after item validation)  
**Parameters:** None

**What It Does:**
1. Creates mushroom prop
2. Plays eating animation
3. Applies extreme screen effects
4. Manipulates camera (pitch, elevation)
5. Shows sky transitions
6. Spawns peds in sky
7. Recovery sequence

**Example - Manual Trigger:**
```lua
-- From server
TriggerClientEvent('lxr-drugs:client:mushroom', source)
```

**Effect Sequence (Multi-Phase):**
```
PHASE 1: Eating (0-3s)
- Create mushroom prop (s_amedmush)
- Attach to hand
- Play eating animation
- Delete mushroom

PHASE 2: Initial Trip (3-13s)
- Set drunk level 1.0
- AnimpostfxPlay('PlayerRPGCore')
- Distortion begins

PHASE 3: Fall (13-23s)
- Camera pitch -90° (looking down)
- Fall animation (dead_fall_out)
- Player unconscious

PHASE 4: Sky View (23-43s)
- Create camera 100m above player
- Point camera straight down
- Player lying on ground

PHASE 5: Sky Transition (43-63s)
- Random sky effect from 43 options
- Visual distortion continues

PHASE 6: Sky Hallucinations (63-78s)
- Spawn 20 peds in the sky
- Peds appear to float above

PHASE 7: Recovery (78-90s)
- Destroy camera
- Return to normal view
- Play wake up animation (kneel_get_up_plr)
- Clean up effects
```

**Visual Effects:**
- `AnimpostfxPlay('PlayerRPGCore')` - Distortion and color shift
- `AnimpostfxPlay('PlayerWakeUpInterrogation')` - Fade transitions
- Random sky effects (skytl_0000_01clear, etc.)
- Camera manipulation

**Sky Hallucinations:**
```lua
-- Spawns peds 100m in the sky
for i = 0, Config.Mushroom.pedQuantity do
    local model = Config.Mushroom.pedModels[math.random(#Config.Mushroom.pedModels)]
    CreateMushroomPed(model, sky_coords)
end
```

**Ped Properties:**
- Scale: 2.0x
- Position: 100m above player
- Float in sky

---

## 🖥️ Server Events

Events on the server side (not directly triggered by clients).

### Internal Item Registration

Server automatically registers usable items on startup.

**Joint Registration:**
```lua
Framework.RegisterUsableItem(Config.Joint.itemName, function(data)
    local source = data.source
    -- Security validation
    -- Remove item
    -- Trigger client event
    TriggerClientEvent('lxr-drugs:client:joint', source)
end)
```

**Opium Registration:**
```lua
Framework.RegisterUsableItem(Config.Opium.itemName, function(data)
    local source = data.source
    -- Security validation
    -- Check for pipe
    -- Remove item
    -- Trigger client event
    TriggerClientEvent('lxr-drugs:client:opium', source)
end)
```

**Mushroom Registration:**
```lua
Framework.RegisterUsableItem(Config.Mushroom.itemName, function(data)
    local source = data.source
    -- Security validation
    -- Remove item
    -- Trigger client event
    TriggerClientEvent('lxr-drugs:client:mushroom', source)
end)
```

---

## 🔄 Framework Events

Events used by the framework adapter (not for external use).

### Framework Detection Events

**LXR-Core / RSG-Core:**
```lua
-- Core object retrieval
exports['lxr-core']:GetCoreObject()
exports['rsg-core']:GetCoreObject()
```

**VORP Core:**
```lua
-- Core object retrieval
TriggerEvent("getCore", function(core)
    Framework.Core = core
end)
```

### Framework Inventory Events

**Inventory Close:**
```lua
-- LXR/RSG
TriggerClientEvent('inventory:client:closeInv', source)

-- VORP
Framework.Inventory.CloseInv(source)
```

---

## 🎯 Custom Event Integration

### Hooking Into Drug Consumption

You can add custom logic when drugs are consumed by hooking the client events.

**Example - Add Drug Log:**
```lua
-- Server-side custom handler
AddEventHandler('lxr-drugs:client:joint', function()
    local source = source
    -- Log drug use to database
    MySQL.Async.execute('INSERT INTO drug_logs (player_id, drug_type, timestamp) VALUES (?, ?, ?)', {
        Framework.GetIdentifier(source),
        'joint',
        os.time()
    })
end)
```

**Example - Police Alert:**
```lua
-- Server-side custom handler
RegisterNetEvent('lxr-drugs:server:drugUsed')
AddEventHandler('lxr-drugs:server:drugUsed', function(drugType)
    local source = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    
    -- Alert nearby police
    TriggerClientEvent('police:drugAlert', -1, coords, drugType)
end)

-- Add to server/server.lua after RemoveItem
TriggerEvent('lxr-drugs:server:drugUsed', 'joint')
```

**Example - Addiction System:**
```lua
-- Track drug usage for addiction mechanic
local playerDrugUsage = {}

RegisterNetEvent('lxr-drugs:server:consumed')
AddEventHandler('lxr-drugs:server:consumed', function(drugType)
    local source = source
    local identifier = Framework.GetIdentifier(source)
    
    if not playerDrugUsage[identifier] then
        playerDrugUsage[identifier] = {joint = 0, opium = 0, mushroom = 0}
    end
    
    playerDrugUsage[identifier][drugType] = playerDrugUsage[identifier][drugType] + 1
    
    -- Check for addiction
    if playerDrugUsage[identifier][drugType] >= 10 then
        Framework.Notify(source, 'You feel addicted to ' .. drugType, 'error', 5000)
    end
end)
```

---

## 🛠️ Developer Functions

### Manually Trigger Drug Effects

For testing or custom scripts:

**Trigger Joint Effect:**
```lua
-- Client-side
TriggerEvent('lxr-drugs:client:joint')

-- Server-side (for specific player)
TriggerClientEvent('lxr-drugs:client:joint', playerId)
```

**Trigger Opium Effect:**
```lua
-- Client-side
TriggerEvent('lxr-drugs:client:opium')

-- Server-side
TriggerClientEvent('lxr-drugs:client:opium', playerId)
```

**Trigger Mushroom Effect:**
```lua
-- Client-side
TriggerEvent('lxr-drugs:client:mushroom')

-- Server-side
TriggerClientEvent('lxr-drugs:client:mushroom', playerId)
```

---

## 🎬 Animation Events

Animations are handled internally but use these natives:

**Animation Loading:**
```lua
RequestAnimDict(dict)
while not HasAnimDictLoaded(dict) do
    Wait(100)
end
```

**Animation Playback:**
```lua
TaskPlayAnim(actor, dict, anim, intro, exit, duration, flag, 1, false, false, false, 0, true)
```

**Animation Clearing:**
```lua
ClearPedTasks(PlayerPedId())
RemoveAnimDict(dict)
```

---

## 🔔 Native RedM Events

LXR-Drugs uses these RedM natives:

### Screen Effects
```lua
AnimpostfxPlay('effect_name')      -- Start screen effect
AnimpostfxStop('effect_name')      -- Stop screen effect
```

**Available Effects:**
- `PlayerDrugsPoisonWell` - Green poison effect
- `playerdrugshalluc01` - Hallucination distortion
- `PlayerRPGCore` - Intense visual distortion
- `PlayerWakeUpDrunk` - Blur and fade
- `PlayerWakeUpInterrogation` - Fade transition
- `CamTransitionBlinkSlow` - Blink effect
- `skytl_*` - Sky transition effects (43 variants)

### Character State
```lua
-- Drunk walking
Citizen.InvokeNative(0x406CCF555B04FAD3, ped, enabled, level)  -- SetPedDrunkness

-- Ragdoll
SetPedToRagdoll(ped, time1, time2, type, p4, p5, p6)
ResetPedRagdollTimer(ped)

-- Health core boost
Citizen.InvokeNative(0xC6258F41D86676E0, ped, core, value)      -- SetAttributeCoreValue
Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, core, value, overpowerEnabled)  -- EnableAttributeCoreOverpower
```

### Camera Manipulation
```lua
-- Set camera pitch
Citizen.InvokeNative(0x449995EA846D3FC2, pitch)  -- SetGameplayCamInitialPitch

-- Create scripted camera
cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', x, y, z, pitch, roll, yaw, fov, false, 0)
SetCamActive(cam, true)
RenderScriptCams(true, true, fadeTime, 1, 0)

-- Destroy camera
DestroyCam(cam, true)
RenderScriptCams(false, true, fadeTime, 1, 0)
```

---

## 📊 Event Flow Diagram

### Joint Consumption Flow
```
Player uses joint
    ↓
Server: Framework usable item callback
    ↓
Server: ValidateConsumption() - Security checks
    ↓
Server: Framework.RemoveItem('joint', 1)
    ↓
Server: TriggerClientEvent('lxr-drugs:client:joint', source)
    ↓
Client: Create cigarette prop
    ↓
Client: Play smoking animations
    ↓
Client: Apply screen effects
    ↓
Client: Wait effectDurationMs
    ↓
Client: Clear effects and cleanup
```

### Opium Consumption Flow
```
Player uses opium
    ↓
Server: Framework usable item callback
    ↓
Server: ValidateConsumption() - Security checks
    ↓
Server: Check for pipe item
    ↓
Server: Framework.RemoveItem('opium', 1)
    ↓
Server: TriggerClientEvent('lxr-drugs:client:opium', source)
    ↓
Client: Create pipe prop
    ↓
Client: Play pipe animations
    ↓
Client: Spawn 20 hallucination peds
    ↓
Client: Apply screen effects
    ↓
Client: Wait effectDurationMs
    ↓
Client: Delete peds and clear effects
```

### Mushroom Consumption Flow
```
Player uses mushroom
    ↓
Server: Framework usable item callback
    ↓
Server: ValidateConsumption() - Security checks
    ↓
Server: Framework.RemoveItem('mushroom', 1)
    ↓
Server: TriggerClientEvent('lxr-drugs:client:mushroom', source)
    ↓
Client: Eating animation (3s)
    ↓
Client: Initial trip effects (10s)
    ↓
Client: Fall animation + camera pitch (10s)
    ↓
Client: Sky camera view (20s)
    ↓
Client: Sky effect transition (20s)
    ↓
Client: Spawn sky peds (15s)
    ↓
Client: Wake up sequence (7s)
    ↓
Client: Cleanup and return to normal
```

---

## 🔒 Security Events

Internal security validation (not exposed):

**Rate Limiting:**
```lua
-- Tracks uses per minute per player
playerUsageCount[playerId] = playerUsageCount[playerId] + 1
if playerUsageCount[playerId] > Config.Security.maxConsumptionPerMinute then
    return false  -- Blocked
end
```

**Cooldown:**
```lua
-- Tracks last use time
if (currentTime - playerCooldowns[playerId].lastUse) < Config.Security.cooldownBetweenUses then
    return false  -- Blocked
end
```

**Logging:**
```lua
if Config.Security.logSuspiciousActivity then
    print(string.format('[LXR-Drugs] SECURITY: Player %s exceeded consumption rate limit', playerId))
end
```

---

## 🎓 Best Practices

### Event Triggering
- ✅ Always trigger from server for security
- ✅ Validate before triggering client events
- ✅ Use framework-specific callbacks
- ❌ Don't trigger client events directly from client (exploitable)

### Custom Events
- ✅ Use unique event names to avoid conflicts
- ✅ Validate all event data server-side
- ✅ Log important events for moderation
- ❌ Don't trust client-sent data without validation

### Performance
- ✅ Clean up spawned entities
- ✅ Stop animations when done
- ✅ Clear screen effects
- ❌ Don't spawn unlimited peds

---

## 📞 Support

**Discord:** https://discord.gg/CrKcWdfd3A  
**Developer:** iBoss21 / The Lux Empire

---

**🐺 Master the event system for advanced customization!**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
