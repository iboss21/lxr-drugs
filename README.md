```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs - Immersive Drug System for RedM

**The most advanced and immersive drug consumption system for RedM servers**

[![Framework](https://img.shields.io/badge/Framework-Multi%20Support-blue.svg)](docs/frameworks.md)
[![LXR-Core](https://img.shields.io/badge/LXR--Core-Supported-green.svg)](https://github.com/iBoss21/lxr-core)
[![RSG-Core](https://img.shields.io/badge/RSG--Core-Supported-green.svg)](https://github.com/Rexshack-RedM/rsg-core)
[![VORP](https://img.shields.io/badge/VORP-Supported-green.svg)](https://github.com/VORPCORE/vorp-core-lua)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-orange.svg)](fxmanifest.lua)

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
Access:      Discord & Whitelisted

Developer:   iBoss21 / The Lux Empire
Website:     https://www.wolves.land
Discord:     https://discord.gg/CrKcWdfd3A
GitHub:      https://github.com/iBoss21
Store:       https://theluxempire.tebex.io
Server:      https://servers.redm.net/servers/detail/8gj7eb

═══════════════════════════════════════════════════════════════════════════════
```

---

## 📋 Overview

LXR-Drugs is a comprehensive drug consumption system designed specifically for RedM servers, providing **immersive animations**, **realistic visual effects**, and **engaging gameplay mechanics** for various drug types. Built for **The Land of Wolves** server with multi-framework support and anti-abuse protection.

### 🎯 What Makes LXR-Drugs Special?

- **🎬 Authentic Animations** - Native RedM animations with prop systems
- **🌈 Stunning Visual Effects** - Screen distortions, camera manipulation, hallucinations
- **👻 Dynamic Hallucinations** - Spawn random NPCs and animals during trips
- **🔧 Multi-Framework** - LXR-Core, RSG-Core, and VORP support with auto-detection
- **🔒 Security First** - Rate limiting, cooldowns, anti-abuse protection
- **⚡ Performance Optimized** - 0.00-0.01ms idle, minimal resource usage
- **🌍 Multi-Language** - English, Georgian (🇬🇪), Spanish

---

## ✨ Features

### 💊 Three Unique Drug Types

#### 🚬 Joint (Cannabis)
- Authentic smoking animation with cigarette prop
- Mild screen distortion effects
- Drunk walking simulation
- Health core boost and hunger reduction
- **Overdose Protection**: Max 3 joints per hour
- **Duration**: 30 seconds
- **Risk**: Hallucinations and ragdoll if overdosed

#### 🌬️ Opium (Pipe Smoking)
- Requires pipe item to consume
- Pipe smoking animation
- Intense hallucination effects
- 20 random NPCs/animals spawn around player
- Maximum drunk level for immersion
- **Duration**: 60 seconds
- **Hallucinations**: Giant creatures, wild animals, strange NPCs

#### 🍄 Mushroom (Psychedelic)
- Eating animation with mushroom prop
- Extreme camera manipulation
- Multi-phase trip sequence
- Sky transition effects with camera pitched to sky
- 20 hallucination peds spawning in the air
- Character falls unconscious during trip
- **Duration**: ~90 seconds (multi-phase)
- **Effect**: Most intense and cinematic experience

### 🎮 Core Features

- **Immersive Animations**: Authentic RedM native animations for all consumption types
- **Prop System**: Dynamic prop spawning and attachment (cigarettes, pipes, mushrooms)
- **Visual Effects**: Screen distortion, color shifts, camera manipulation
- **Hallucination System**: Configurable NPC/animal spawns with scale manipulation
- **Framework Agnostic**: Works with LXR-Core, RSG-Core, VORP Core, or standalone
- **Security**: Rate limiting, cooldowns, item validation, anti-spam
- **Performance**: Optimized for minimal resource usage (0.00-0.01ms)
- **Customizable**: Fully configurable via `config.lua`
- **Multi-Language**: English, Georgian, Spanish (easy to add more)

---

## 🚀 Quick Start

### Requirements

- **RedM Server** (latest build)
- **One of the following frameworks:**
  - [LXR-Core](https://github.com/iBoss21/lxr-core) (Recommended)
  - [RSG-Core](https://github.com/Rexshack-RedM/rsg-core)
  - [VORP Core](https://github.com/VORPCORE/vorp-core-lua)

### Installation

1. **Download the resource**
   ```bash
   cd resources
   git clone https://github.com/iBoss21/lxr-drugs.git
   ```

2. **Add to server.cfg**
   ```cfg
   ensure lxr-drugs
   ```

3. **Configure the system**
   - Edit `config.lua` to your preferences
   - Set your framework (or use 'auto')
   - Customize drug items, effects, and durations

4. **Add items to your database**
   
   **For LXR-Core / RSG-Core:**
   ```sql
   -- Add to items table
   INSERT INTO `items` (`name`, `label`, `weight`, `type`, `image`, `unique`, `useable`, `shouldClose`, `combinable`, `description`) VALUES
   ('joint', 'Joint', 0.1, 'item', 'joint.png', 0, 1, 1, NULL, 'A rolled cannabis cigarette'),
   ('opium', 'Opium', 0.2, 'item', 'opium.png', 0, 1, 1, NULL, 'Raw opium for smoking'),
   ('pipe', 'Pipe', 0.3, 'item', 'pipe.png', 0, 0, 0, NULL, 'A smoking pipe'),
   ('mushroom', 'Magic Mushroom', 0.1, 'item', 'mushroom.png', 0, 1, 1, NULL, 'A psychedelic mushroom');
   ```

   **For VORP:**
   ```sql
   -- Add to items table
   INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
   ('joint', 'Joint', 10, 1, 'item_standard', 1),
   ('opium', 'Opium', 5, 1, 'item_standard', 1),
   ('pipe', 'Pipe', 1, 1, 'item_standard', 0),
   ('mushroom', 'Magic Mushroom', 5, 1, 'item_standard', 1);
   ```

5. **Restart your server**
   ```bash
   restart lxr-drugs
   ```

---

## 📖 Documentation

Comprehensive documentation available in the `/docs` folder:

- **[Overview](docs/overview.md)** - System architecture and features
- **[Installation Guide](docs/installation.md)** - Detailed setup instructions
- **[Configuration](docs/configuration.md)** - Complete config reference
- **[Framework Support](docs/frameworks.md)** - Multi-framework integration
- **[Events Reference](docs/events.md)** - Client/server event documentation
- **[Security](docs/security.md)** - Anti-abuse and protection features
- **[Performance](docs/performance.md)** - Optimization and tuning
- **[Screenshots](docs/screenshots.md)** - Visual examples and demos

---

## 📁 Project Structure

```
lxr-drugs/
├── 📄 README.md              # This file - main documentation
├── 📄 LICENSE                # License information
├── 📄 fxmanifest.lua         # Resource manifest
├── 📄 config.lua             # Main configuration file
│
├── 📂 client/                # Client-side scripts
│   ├── 📄 README.md          # Client documentation
│   └── 📄 client.lua         # Main client logic
│
├── 📂 server/                # Server-side scripts
│   ├── 📄 README.md          # Server documentation
│   └── 📄 server.lua         # Main server logic
│
├── 📂 shared/                # Shared scripts
│   ├── 📄 README.md          # Shared documentation
│   └── 📄 framework.lua      # Framework adapter
│
├── 📂 docs/                  # Documentation
│   ├── overview.md
│   ├── installation.md
│   ├── configuration.md
│   ├── frameworks.md
│   ├── events.md
│   ├── security.md
│   ├── performance.md
│   └── screenshots.md
│
└── 📂 img/                   # Item images
    ├── joint.png
    ├── opium.png
    ├── pipe.png
    └── mushroom.png
```

---

## 🎬 Demo & Screenshots

### Video Demonstration
📺 **Original Concept Demo**: [Watch on YouTube](https://youtu.be/W9SlGFGByBQ)

### Screenshots
See the [Screenshots Guide](docs/screenshots.md) for visual examples of:
- Drug consumption animations
- Visual effects in action
- Hallucination system
- Camera manipulation effects
- Multi-phase mushroom trip

---

## ⚙️ Configuration Highlights

```lua
-- Framework (auto-detection or manual)
Config.Framework = 'auto' -- 'lxr-core', 'rsg-core', 'vorp_core'

-- Drug Items
Config.Joint = {
    itemName = 'joint',
    limit = 3,                  -- Max per hour
    effectDurationMs = 30000,   -- 30 seconds
    drunkLevel = 0.5
}

Config.Opium = {
    itemName = 'opium',
    pipeItem = 'pipe',          -- Required item
    effectDurationMs = 60000,   -- 60 seconds
    pedQuantity = 20            -- Hallucination count
}

Config.Mushroom = {
    itemName = 'mushroom',
    pedQuantity = 20,           -- Hallucination count
    drunkLevel = 1.0            -- Maximum effect
}

-- Security
Config.Security = {
    maxConsumptionPerMinute = 5,
    cooldownBetweenUses = 1000  -- 1 second
}
```

See [Configuration Guide](docs/configuration.md) for full options.

---

## 🔒 Security Features

- **Rate Limiting**: Maximum consumption per minute
- **Cooldown System**: Prevent spam usage
- **Item Validation**: Server-side ownership verification
- **Inventory Close**: Forces inventory closed during consumption
- **Activity Logging**: Suspicious behavior tracking
- **Anti-Abuse**: Multiple protection layers

See [Security Documentation](docs/security.md) for details.

---

## ⚡ Performance

- **Idle**: 0.00ms (no active effects)
- **Active**: 0.01-0.02ms (animations playing)
- **Peak**: 0.01-0.03ms (hallucinations spawning)
- **Memory**: ~1-2MB
- **Network**: Minimal (event-driven architecture)

See [Performance Guide](docs/performance.md) for optimization tips.

---

## 🤝 Support

### Get Help

- **Discord**: [Join The Land of Wolves](https://discord.gg/CrKcWdfd3A)
- **GitHub Issues**: [Report bugs or request features](https://github.com/iBoss21/lxr-drugs/issues)
- **Documentation**: Check the `/docs` folder first
- **Store**: [Browse more scripts](https://theluxempire.tebex.io)

### Community

Join **The Land of Wolves** community:
- **Discord**: https://discord.gg/CrKcWdfd3A
- **Server**: https://servers.redm.net/servers/detail/8gj7eb
- **Website**: https://www.wolves.land

---

## 🏆 Credits

### Development
- **Script Author**: iBoss21 / The Lux Empire
- **Server**: The Land of Wolves (wolves.land)
- **Original Concept**: Xakra
- **Inspired By**: Immersive drug mechanics and visual effects

### Special Thanks
- **The Land of Wolves Community** - Testing and feedback
- **Framework Developers** - LXR-Core, RSG-Core, VORP Core teams
- **RedM Community** - Continuous support and inspiration

---

## 📜 License

```
© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

This resource is proprietary software developed for The Land of Wolves server.
Unauthorized copying, distribution, or modification is strictly prohibited.

For licensing inquiries, contact: https://discord.gg/CrKcWdfd3A
```

---

## 🐺 About The Land of Wolves

**The Land of Wolves** (მგლების მიწა) is a premium Georgian hardcore roleplay server for RedM, where history comes alive and immersion is paramount. This drug system was crafted specifically for our community to enhance realism and provide engaging gameplay mechanics.

### Server Features
- 🇬🇪 **Georgian & International RP** - Bilingual community
- 🎭 **Hardcore Roleplay** - Serious, immersive experiences
- 🔒 **Whitelisted** - Quality player base
- ⚡ **Custom Systems** - Unique scripts and features
- 🏆 **Active Staff** - Dedicated administration team

### Join Our Pack
**Website**: https://www.wolves.land  
**Discord**: https://discord.gg/CrKcWdfd3A  
**Server**: https://servers.redm.net/servers/detail/8gj7eb

---

<div align="center">

**Made with ❤️ by iBoss21 for The Land of Wolves 🐺**

*ისტორია ცოცხლდება აქ! (History Lives Here!)*

</div>
