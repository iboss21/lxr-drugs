```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🎬 Client-Side - LXR-Drugs

**Client scripts for animations, visual effects, and player experience**

---

## 🌍 Server Information

```
═══════════════════════════════════════════════════════════════════════════════
SERVER INFORMATION
═══════════════════════════════════════════════════════════════════════════════

Server:      The Land of Wolves 🐺
Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
Type:        Serious Hardcore Roleplay

Developer:   iBoss21 / The Lux Empire
Website:     https://www.wolves.land
Discord:     https://discord.gg/CrKcWdfd3A

═══════════════════════════════════════════════════════════════════════════════
```

---

## 📋 Overview

The client folder contains the client-side scripts responsible for the visual and interactive aspects of the drug consumption system. This includes animations, prop management, screen effects, camera manipulation, and hallucination spawning.

---

## 📁 Files in This Folder

### `client.lua`
**Main client-side script - handles all player-facing drug effects**

**Core Responsibilities:**
- 🎬 **Animation Management** - Plays consumption animations with proper timing
- 🎭 **Prop System** - Spawns and attaches props (cigarettes, pipes, mushrooms)
- 🌈 **Visual Effects** - Applies screen distortions and post-processing
- 📷 **Camera Control** - Manipulates camera for mushroom trips
- 👻 **Hallucination System** - Spawns and manages hallucination NPCs
- 🎮 **Player State** - Controls drunk levels, ragdoll, movement
- 🧹 **Cleanup** - Removes effects and entities on completion

---

## 🎯 Key Functions

### Drug Consumption Handlers

#### `consumeJoint()`
Handles joint/cannabis consumption effects:
- Triggers smoking animation sequence (enter → hold → exit)
- Spawns cigarette prop and attaches to player's mouth
- Applies mild screen distortion (`PlayerDrugsPoisonWell`)
- Sets drunk level to 0.5 for slight impairment
- Drops cigarette prop with physics after animation
- Clears effects after 30 seconds

#### `consumeOpium()`
Handles opium pipe smoking effects:
- Validates player has pipe item in inventory
- Plays pipe smoking animation
- Spawns 20 hallucination peds (NPCs/animals) around player
- Scales peds to 5.0x (giant size) for intimidation
- Applies intense hallucination effect (`playerdrugshalluc01`)
- Sets drunk level to 1.0 (maximum impairment)
- Auto-removes hallucinations after 60 seconds

#### `consumeMushroom()`
Handles psychedelic mushroom effects with multi-phase sequence:

**Phase 1: Consumption (3s)**
- Eating animation with mushroom prop
- Initial screen effect

**Phase 2: Initial Distortion (10s)**
- Applies `PlayerRPGCore` effect
- Character starts feeling effects

**Phase 3: Collapse (10s)**
- Camera pitches down
- Plays fall animation (dead_fall_out)
- Character collapses to ground

**Phase 4: Sky View (20s)**
- Camera moves 100m above player
- Looks down at character from sky perspective

**Phase 5: Sky Transition (20s)**
- Triggers random sky/weather effect
- Cinematic sky visuals

**Phase 6: Hallucinations (15s)**
- Spawns 20 peds in the sky around camera
- Creates "raining peds" effect
- Entities appear to float/fall

**Phase 7: Wake Up (7s)**
- Camera returns to normal
- Character stands up (kneel_get_up_plr)
- Effects clear
- Player regains control

Total Duration: ~90 seconds

---

## 🔧 Technical Details

### Animation System

**Animation Loading:**
```lua
RequestAnimDict(animDict)
while not HasAnimDictLoaded(animDict) do
    Wait(100)
end
```

**Animation Playback:**
```lua
TaskPlayAnim(playerPed, animDict, animName, 
    8.0,    -- Blend in speed
    8.0,    -- Blend out speed
    duration, -- Duration (-1 = loop)
    flag,   -- Animation flags
    0.0,    -- Playback rate
    false, false, false
)
```

**Common Animation Flags:**
- `1` = Normal
- `2` = Looped + freeze last frame
- `30` = Upper body only + looped

### Prop Management

**Prop Spawning:**
```lua
local prop = CreateObject(model, x, y, z, true, true, false)
SetEntityCollision(prop, false, false)
SetEntityAlpha(prop, 0, false)
-- Fade in
for alpha = 0, 255, 51 do
    SetEntityAlpha(prop, alpha, false)
    Wait(50)
end
```

**Prop Attachment:**
```lua
AttachEntityToEntity(
    prop, ped,
    GetPedBoneIndex(ped, boneId), -- Bone: jaw, right hand, etc.
    offsetX, offsetY, offsetZ,    -- Position offset
    rotX, rotY, rotZ,             -- Rotation offset
    true, true, false, true, 1, true
)
```

**Prop Cleanup:**
```lua
DetachEntity(prop, true, true)
DeleteEntity(prop)
DeleteObject(prop)
```

### Visual Effects System

**Screen Effects:**
```lua
-- Apply effect
StartScreenEffect(effectName, duration, looped)

-- Available effects:
-- "PlayerDrugsPoisonWell" - Mild distortion (joints)
-- "playerdrugshalluc01" - Hallucinations (opium)
-- "PlayerRPGCore" - RPG core effect (mushroom initial)

-- Remove effect
StopScreenEffect(effectName)
StopAllScreenEffects()
```

### Camera Manipulation

**Mushroom Sky Camera:**
```lua
local camCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, 100.0)
local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
PointCamAtEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
SetCamActive(cam, true)
RenderScriptCams(true, true, 1000, true, true)

-- Return to normal
RenderScriptCams(false, true, 1000, true, true)
DestroyCam(cam, false)
```

### Hallucination Spawning

**Ped Creation:**
```lua
for i = 1, quantity do
    local model = pedModels[math.random(#pedModels)]
    local hash = GetHashKey(model)
    
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(100)
    end
    
    local coords = GetOffsetFromEntityInWorldCoords(
        playerPed, 
        math.random(-20, 20),  -- X offset
        math.random(-20, 20),  -- Y offset
        0.0
    )
    
    local ped = CreatePed(
        model, coords.x, coords.y, coords.z,
        0.0, false, false, false, false
    )
    
    SetPedScale(ped, 5.0) -- Giant size
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    
    table.insert(hallucinationPeds, ped)
end
```

**Ped Cleanup:**
```lua
for _, ped in ipairs(hallucinationPeds) do
    if DoesEntityExist(ped) then
        DeletePed(ped)
        DeleteEntity(ped)
    end
end
hallucinationPeds = {}
```

### Player State Management

**Drunk Effect:**
```lua
SetPedMotionBlur(playerPed, true)
SetPedIsDrunk(playerPed, true)
SetPedConfigFlag(playerPed, 100, true) -- Drunk walking
ShakeGameplayCam("DRUNK_SHAKE", 0.5)

-- Set drunk level
Citizen.InvokeNative(0x406CCF555B04FAD3, playerPed, drunkLevel, 0) -- 0.0-1.0
```

**Ragdoll Effect:**
```lua
SetPedToRagdoll(playerPed, 10000, 10000, 0, 0, 0, 0)
```

---

## 📡 Events

### Client Events (Received)

#### `lxr-drugs:client:useJoint`
Triggered when player uses joint item
```lua
RegisterNetEvent('lxr-drugs:client:useJoint')
AddEventHandler('lxr-drugs:client:useJoint', function()
    consumeJoint()
end)
```

#### `lxr-drugs:client:useOpium`
Triggered when player uses opium item
```lua
RegisterNetEvent('lxr-drugs:client:useOpium')
AddEventHandler('lxr-drugs:client:useOpium', function()
    consumeOpium()
end)
```

#### `lxr-drugs:client:useMushroom`
Triggered when player uses mushroom item
```lua
RegisterNetEvent('lxr-drugs:client:useMushroom')
AddEventHandler('lxr-drugs:client:useMushroom', function()
    consumeMushroom()
end)
```

---

## 🧹 Resource Lifecycle

### On Resource Start
- Loads shared config
- Initializes framework bridge
- Prepares animation dictionaries
- Sets up event handlers

### During Active Effects
- Manages animation playback
- Controls prop lifecycle
- Updates camera position
- Handles hallucination spawning
- Monitors effect timers

### On Resource Stop
```lua
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        -- Clean up all active effects
        StopAllScreenEffects()
        
        -- Remove all hallucination peds
        for _, ped in ipairs(hallucinationPeds) do
            DeletePed(ped)
            DeleteEntity(ped)
        end
        
        -- Remove all props
        for _, prop in ipairs(activeProps) do
            DeleteObject(prop)
        end
        
        -- Reset player state
        local playerPed = PlayerPedId()
        SetPedIsDrunk(playerPed, false)
        SetPedMotionBlur(playerPed, false)
        
        -- Reset camera
        RenderScriptCams(false, false, 0, true, true)
    end
end)
```

---

## 🎨 Customization

### Adding New Animations

1. Find animation dictionary and name using tools like [Pleb Masters: Useful Links](https://github.com/femga/rdr3_discoveries)
2. Add to `Config.Animations` in `config.lua`
3. Use in client with `TaskPlayAnim()`

### Creating Custom Visual Effects

1. Find effect name from RedM natives
2. Add duration to config
3. Apply with `StartScreenEffect(name, duration, looped)`

### Expanding Hallucination Models

1. Find ped model hashes
2. Add to `Config.Opium.pedModels` or `Config.Mushroom.pedModels`
3. Models automatically randomized during spawn

---

## ⚡ Performance Considerations

### Optimization Techniques

- **Animation Preloading**: Dictionaries loaded before use
- **Model Streaming**: Request and wait for models before spawn
- **Entity Cleanup**: Immediate deletion when effects end
- **Thread Management**: Effects run in isolated threads
- **Memory Management**: Props and peds removed from memory

### Performance Tips

- Limit hallucination ped count (default: 20)
- Reduce spawn distance if needed
- Use fewer complex models
- Cleanup on resource stop ensures no orphaned entities

### Performance Metrics

- **Idle**: 0.00ms (no active handlers)
- **Animation Active**: 0.01ms (prop + anim)
- **Hallucinations**: 0.02-0.03ms (20 peds)
- **Camera Effects**: 0.01ms (camera control)

---

## 🐛 Troubleshooting

### Animations Not Playing
- Check animation dictionary exists
- Verify animation name is correct
- Ensure proper flags are set
- Wait for animation dict to load

### Props Not Appearing
- Verify model hash is correct
- Request model before creating
- Check attachment bone ID
- Ensure collision is disabled

### Visual Effects Not Working
- Confirm effect name spelling
- Check if effect is looped correctly
- Verify duration is appropriate
- Stop old effects before starting new

### Hallucinations Not Spawning
- Check ped model hashes
- Ensure models are loaded
- Verify spawn distance
- Check if peds are being deleted prematurely

---

## 📚 Related Documentation

- **[Main README](../README.md)** - Project overview
- **[Server README](../server/README.md)** - Server-side logic
- **[Shared README](../shared/README.md)** - Framework adapter
- **[Configuration Guide](../docs/configuration.md)** - Config options
- **[Events Reference](../docs/events.md)** - Event documentation
- **[Performance Guide](../docs/performance.md)** - Optimization tips

---

## 🐺 About This Component

The client-side scripts are the heart of the visual experience in LXR-Drugs. Every animation, effect, and hallucination is carefully crafted to provide an immersive and memorable experience for players on **The Land of Wolves** server.

---

<div align="center">

**Made with ❤️ by iBoss21 for The Land of Wolves 🐺**

*Client-side magic that brings drugs to life*

</div>
