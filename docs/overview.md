```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs System Overview

**Immersive Drug Consumption System for RedM**

---

## Server Information

- **Server:** The Land of Wolves 🐺
- **Tagline:** Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
- **Description:** ისტორია ცოცხლდება აქ! (History Lives Here!)
- **Type:** Serious Hardcore Roleplay
- **Website:** https://www.wolves.land
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Developer:** iBoss21 / The Lux Empire

---

## 📋 What is LXR-Drugs?

LXR-Drugs is a comprehensive drug consumption system designed for RedM servers, providing immersive animations, visual effects, and gameplay mechanics for various drug types. The system features multi-framework support, anti-abuse protection, and highly configurable effects to enhance roleplay experiences.

---

## 🎯 Key Features

### 🚬 Three Unique Drug Types
- **Joint (Cannabis)** - Smoking animation with mild visual distortion
- **Opium** - Pipe-based smoking with intense hallucinations
- **Mushroom (Psychedelic)** - Eating animation with extreme camera effects

### 🎬 Immersive Animations
- Authentic RedM native animations for consumption
- Prop attachment system (cigarettes, pipes, mushrooms)
- Smooth transitions and exit animations
- Character motion effects (ragdoll, drunk walking)

### 🌈 Visual Effects System
- Screen distortion and color shifts
- Camera manipulation for disorientation
- Animated sky transitions (mushrooms)
- Drunkness level simulation
- Post-processing effects (PlayerDrugsPoisonWell, playerdrugshalluc01, PlayerRPGCore)

### 👻 Hallucination System
- Spawns random NPC/animal peds around player
- Configurable quantity and models
- Scale manipulation (giant/small entities)
- Auto-cleanup after effects end
- 30+ unique hallucination models including foxes, eagles, swamp freaks, and more

### 🔧 Multi-Framework Support
- **LXR-Core** (Primary)
- **RSG-Core** (Primary)
- **VORP Core** (Supported)
- Automatic framework detection
- Unified API for all frameworks
- Standalone fallback mode

### 🔒 Security Features
- Rate limiting (max uses per minute)
- Cooldown system between uses
- Item ownership validation
- Inventory close requirement
- Suspicious activity logging
- Anti-spam protection

### ⚡ Performance Optimized
- Efficient ped spawning/cleanup
- Minimal resource usage (0.00-0.01ms)
- Automatic cleanup on resource stop
- Configurable performance settings
- No unnecessary threads

### 🌍 Multi-Language Support
- English (en)
- Georgian (ge) - მგლების მიწა native language
- Spanish (es)
- Easy to add more languages

---

## 💊 Drug Effects Breakdown

### Joint (Cannabis)
**Item:** `joint`

**Effects:**
- Mild screen distortion (PlayerDrugsPoisonWell)
- Drunk walking effect (0.5 drunk level)
- Health core boost
- Hunger reduction (VORP metabolism)
- Duration: 30 seconds

**Overdose Protection:**
- Limit: 3 joints per hour
- Overdose effects: Hallucinations + ragdoll
- Automatic reset after time limit

**Animation Sequence:**
1. Light cigarette (attach to mouth)
2. Hold in hand
3. Smoke animation
4. Drop cigarette with physics

### Opium (Pipe Smoking)
**Item:** `opium`  
**Requirement:** `pipe` item in inventory

**Effects:**
- Intense hallucinations (playerdrugshalluc01)
- Maximum drunk level (1.0)
- Health core boost
- 20 hallucination peds spawn
- Duration: 60 seconds

**Hallucinations:**
- Random ped models (animals, NPCs, creatures)
- Large scale (5.0x normal size)
- Spawn within 20 meter radius
- Auto-despawn after duration

**Animation Sequence:**
1. Equip pipe from inventory
2. Pipe smoking animation
3. Store pipe back
4. Effects begin

### Mushroom (Psychedelic)
**Item:** `mushroom`

**Effects:**
- Extreme camera manipulation
- Sky transition effects
- Maximum drunk level (1.0)
- 20 hallucination peds in sky
- Camera pitched to sky
- Duration: ~90 seconds (multi-phase)

**Effect Phases:**
1. Eating animation (3s)
2. Initial distortion (PlayerRPGCore) (10s)
3. Camera pitch down + fall animation (10s)
4. Sky camera view 100m above player (20s)
5. Random sky effect transition (20s)
6. Ped hallucinations spawn in sky (15s)
7. Wake up sequence (7s)

**Animation Sequence:**
1. Eat mushroom from hand
2. Fall unconscious (dead_fall_out)
3. Lie on ground during trip
4. Wake up and stand (kneel_get_up_plr)

---

## 🎮 How It Works

### Player Experience

1. **Obtain Drug Item** - Get joint, opium, or mushroom from dealers/crafting
2. **Use Item** - Open inventory and use the drug item
3. **Animation Plays** - Character performs consumption animation with props
4. **Effects Begin** - Visual distortion, hallucinations, and gameplay effects
5. **Duration** - Effects last 30-90 seconds depending on drug
6. **Recovery** - Effects fade, screen clears, character returns to normal

### Server Flow

1. **Item Registration** - Server registers usable items on startup
2. **Validation** - Security checks (cooldown, rate limit, ownership)
3. **Inventory Close** - Forces inventory closed for immersion
4. **Item Removal** - Removes drug from player inventory
5. **Client Trigger** - Sends effect event to player's client
6. **Effect Execution** - Client runs animations and visual effects
7. **Cleanup** - Auto-cleanup when effects end

---

## 🏗️ System Architecture

### File Structure
```
lxr-drugs/
├── config.lua          # Main configuration file
├── fxmanifest.lua      # Resource manifest
├── shared/
│   └── framework.lua   # Framework adapter/bridge
├── client/
│   └── client.lua      # Client-side effects
├── server/
│   └── server.lua      # Server-side handlers
└── docs/               # Documentation
```

### Component Breakdown

**config.lua**
- Server branding information
- Framework settings
- Language configuration
- Drug properties (items, effects, durations)
- Animation definitions
- Security settings
- Performance tuning

**shared/framework.lua**
- Framework detection (auto or manual)
- Unified notification system
- Inventory interface abstraction
- Player data access
- Cross-framework compatibility layer

**client/client.lua**
- Animation playback
- Prop spawning and attachment
- Visual effect triggers
- Camera manipulation
- Hallucination ped creation
- Resource cleanup handlers

**server/server.lua**
- Usable item registration
- Security validation (rate limit, cooldown)
- Item ownership verification
- Inventory management
- Event triggering to clients
- Usage logging

---

## 🎨 Customization Options

### Configurable Per Drug
- Item names
- Effect durations
- Drunk levels (0.0-1.0)
- Hallucination ped quantity
- Hallucination ped models
- Health core boosts
- Hunger/thirst impacts
- Animation dictionaries

### Visual Effects
- Enable/disable screen effects
- Enable/disable sounds
- Camera height for mushroom trip
- Ped spawn distance
- Ped scale multipliers

### Security Controls
- Max consumption per minute
- Cooldown between uses
- Require inventory close
- Validate item ownership
- Log suspicious activity
- Debug mode

---

## 📊 Performance Metrics

- **Idle:** 0.00ms
- **Active (animations):** 0.01-0.02ms
- **Peak (hallucinations):** 0.01-0.03ms
- **Memory:** ~1-2MB
- **Network:** Minimal (event-driven)

---

## 🎓 Use Cases

### Roleplay Scenarios
- Drug dealer operations
- Medical/pharmaceutical RP
- Underground trade economy
- Gang activities
- Police raids and arrests
- Addiction roleplay
- Overdose situations

### Server Features
- Illegal activity systems
- Economy sinks (consumables)
- Status effects for gameplay
- Immersive world interactions
- Player-driven content

---

## 📦 Dependencies

### Required
- RedM server
- One of: LXR-Core, RSG-Core, or VORP Core

### Optional
- ox_lib (for notifications on LXR/RSG)
- vorp_inventory (for VORP framework)

---

## 🔗 Related Documentation

- [Installation Guide](installation.md) - Setup instructions
- [Configuration Guide](configuration.md) - Detailed config options
- [Framework Support](frameworks.md) - Multi-framework details
- [Events Reference](events.md) - Client/server events
- [Security Features](security.md) - Anti-abuse measures
- [Performance Guide](performance.md) - Optimization tips
- [Screenshots Guide](screenshots.md) - Marketing materials

---

## 📝 License

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

---

## 🐺 About Wolves.Land

**The Land of Wolves** is a premium Georgian hardcore roleplay server for RedM, where history comes alive and immersion is paramount. This drug system was crafted specifically for our community to enhance realism and provide engaging gameplay mechanics.

Join our pack: **https://discord.gg/CrKcWdfd3A**
