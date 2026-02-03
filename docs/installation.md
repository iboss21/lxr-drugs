```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs Installation Guide

**Complete Setup Instructions for RedM Servers**

---

## Server Information

- **Server:** The Land of Wolves 🐺
- **Developer:** iBoss21 / The Lux Empire
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Website:** https://www.wolves.land

---

## 📋 Prerequisites

Before installing LXR-Drugs, ensure you have:

### Required
- ✅ **RedM Server** (latest artifact recommended)
- ✅ **One Framework:**
  - LXR-Core (recommended)
  - RSG-Core (recommended)
  - VORP Core (supported)

### Recommended
- ✅ **ox_lib** - For enhanced notifications (LXR/RSG frameworks)
- ✅ **txAdmin** - For server management
- ✅ **Database** - MySQL/MariaDB (for framework)

---

## 📥 Step 1: Download the Resource

### Option A: GitHub Release (Recommended)
```bash
# Navigate to your resources folder
cd /path/to/your/server/resources

# Download latest release
wget https://github.com/iBoss21/lxr-drugs/archive/refs/heads/main.zip

# Extract the archive
unzip main.zip

# Rename folder to lxr-drugs (IMPORTANT!)
mv lxr-drugs-main lxr-drugs
```

### Option B: Git Clone
```bash
# Navigate to your resources folder
cd /path/to/your/server/resources

# Clone the repository
git clone https://github.com/iBoss21/lxr-drugs.git

# Folder will automatically be named lxr-drugs
```

### ⚠️ Critical: Resource Name Protection

**The resource MUST be named `lxr-drugs` exactly.**

The script has built-in resource name validation. If renamed, you'll see:
```
═══════════════════════════════════════════════════════════════════════════════
❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
═══════════════════════════════════════════════════════════════════════════════

Expected: lxr-drugs
Got: your-folder-name

This resource is branded and must maintain the correct name.
Rename the folder to "lxr-drugs" to continue.

🐺 wolves.land - The Land of Wolves
═══════════════════════════════════════════════════════════════════════════════
```

**To fix:** Rename the folder to `lxr-drugs`

---

## 📂 Step 2: Verify File Structure

Ensure your installation looks like this:

```
resources/
└── lxr-drugs/
    ├── client/
    │   └── client.lua
    ├── server/
    │   └── server.lua
    ├── shared/
    │   └── framework.lua
    ├── docs/
    │   ├── overview.md
    │   ├── installation.md
    │   ├── configuration.md
    │   ├── frameworks.md
    │   ├── events.md
    │   ├── security.md
    │   ├── performance.md
    │   └── screenshots.md
    ├── config.lua
    ├── fxmanifest.lua
    ├── README.md
    └── LICENSE
```

---

## ⚙️ Step 3: Add Items to Your Framework

### For LXR-Core / RSG-Core

**File:** `[framework]/shared/items.lua`

Add these items to your items table:

```lua
-- Joint (Cannabis)
joint = {
    name = 'joint',
    label = 'Joint',
    weight = 10,
    type = 'item',
    image = 'joint.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'A rolled cannabis cigarette'
},

-- Opium
opium = {
    name = 'opium',
    label = 'Opium',
    weight = 50,
    type = 'item',
    image = 'opium.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'Raw opium resin, requires a pipe'
},

-- Pipe (Required for Opium)
pipe = {
    name = 'pipe',
    label = 'Smoking Pipe',
    weight = 100,
    type = 'item',
    image = 'pipe.png',
    unique = false,
    useable = false,
    shouldClose = true,
    combinable = nil,
    description = 'A wooden smoking pipe'
},

-- Mushroom (Psychedelic)
mushroom = {
    name = 'mushroom',
    label = 'Strange Mushroom',
    weight = 20,
    type = 'item',
    image = 'mushroom.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'A peculiar looking mushroom with psychedelic properties'
},
```

### For VORP Core

**File:** `vorp_inventory/shared/items.lua`

Add these items:

```lua
-- Joint
['joint'] = {
    label = 'Joint',
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    limit = 10,
    desc = 'A rolled cannabis cigarette'
},

-- Opium
['opium'] = {
    label = 'Opium',
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    limit = 5,
    desc = 'Raw opium resin, requires a pipe'
},

-- Pipe
['pipe'] = {
    label = 'Smoking Pipe',
    weight = 0.10,
    canBeDropped = true,
    canBeUsed = false,
    limit = 1,
    desc = 'A wooden smoking pipe'
},

-- Mushroom
['mushroom'] = {
    label = 'Strange Mushroom',
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = true,
    limit = 10,
    desc = 'A peculiar looking mushroom with psychedelic properties'
},
```

---

## 🖼️ Step 4: Add Item Images

Place drug item images in your inventory's image folder:

### LXR-Core / RSG-Core
```
[inventory-resource]/html/images/
├── joint.png
├── opium.png
├── pipe.png
└── mushroom.png
```

### VORP Core
```
vorp_inventory/html/img/items/
├── joint.png
├── opium.png
├── pipe.png
└── mushroom.png
```

**Image Requirements:**
- Format: PNG with transparency
- Size: 256x256 pixels recommended
- Style: Match your inventory UI theme

---

## 📝 Step 5: Configure server.cfg

Add lxr-drugs to your `server.cfg`:

```cfg
# ═══════════════════════════════════════════════════════════════
# LXR-Drugs - Immersive Drug System
# ═══════════════════════════════════════════════════════════════

ensure lxr-drugs
```

### Load Order (Important!)

Ensure proper load order in your `server.cfg`:

```cfg
# Load framework first
ensure lxr-core  # or rsg-core or vorp_core

# Load inventory
ensure lxr-inventory  # or rsg-inventory or vorp_inventory

# Load ox_lib (if using LXR/RSG)
ensure ox_lib

# Load lxr-drugs AFTER framework and inventory
ensure lxr-drugs
```

**Correct Load Order:**
1. Framework (lxr-core/rsg-core/vorp_core)
2. Inventory (lxr-inventory/rsg-inventory/vorp_inventory)
3. ox_lib (if applicable)
4. **lxr-drugs**

---

## ⚙️ Step 6: Configure the Resource

Edit `config.lua` to match your server setup:

### Framework Selection

**Auto-Detection (Recommended):**
```lua
Config.Framework = 'auto'  -- Automatically detects installed framework
```

**Manual Selection:**
```lua
Config.Framework = 'lxr-core'   -- Force specific framework
-- Options: 'lxr-core', 'rsg-core', 'vorp_core'
```

### Language Selection

```lua
Config.Lang = 'en'  -- Options: 'en', 'ge', 'es'
```

### Item Names (if different from defaults)

```lua
Config.Joint.itemName = 'joint'
Config.Opium.itemName = 'opium'
Config.Opium.pipeItem = 'pipe'
Config.Mushroom.itemName = 'mushroom'
```

**See [configuration.md](configuration.md) for detailed config options.**

---

## 🚀 Step 7: Start Your Server

### Restart Your Server

If server is running:
```bash
# In server console or txAdmin
restart lxr-drugs
```

Or restart entire server:
```bash
# Stop server
# Start server
# Or use txAdmin restart
```

### Verify Successful Startup

Look for this in your server console:

```
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
Server:      The Land of Wolves 🐺

Framework:   [your-framework]
Language:    en

Drugs:       Joint, Opium, Mushroom
Effects:     ENABLED ✓
Security:    ENABLED ✓
Debug:       DISABLED

═══════════════════════════════════════════════════════════════════════════════

Developer:   iBoss21 / The Lux Empire
Website:     https://www.wolves.land
Discord:     https://discord.gg/CrKcWdfd3A

═══════════════════════════════════════════════════════════════════════════════
```

And also:

```
═══════════════════════════════════════════════════════════════════════════════
🐺 LXR-DRUGS SERVER - READY
═══════════════════════════════════════════════════════════════════════════════

Drug handlers registered:
- Joint (joint)
- Opium (opium)
- Mushroom (mushroom)

Security:    ENABLED ✓
Framework:   [your-framework]

═══════════════════════════════════════════════════════════════════════════════
```

---

## 🧪 Step 8: Test the Installation

### In-Game Testing

1. **Join Your Server**
2. **Get Test Items** (admin command or SQL):
   ```
   /giveitem [your-id] joint 5
   /giveitem [your-id] opium 3
   /giveitem [your-id] pipe 1
   /giveitem [your-id] mushroom 2
   ```

3. **Test Each Drug:**
   - Open inventory
   - Use joint → Should see smoking animation + mild effects
   - Use opium (with pipe) → Should see pipe animation + hallucinations
   - Use mushroom → Should see eating animation + extreme trip

4. **Verify Effects:**
   - ✅ Animations play correctly
   - ✅ Props attach to character
   - ✅ Screen effects activate
   - ✅ Notifications appear
   - ✅ Items removed from inventory
   - ✅ Effects end after duration

### Test Security Features

1. **Rapid Use Test:**
   - Use drug multiple times quickly
   - Should be blocked by cooldown

2. **Rate Limit Test:**
   - Use drugs repeatedly
   - Should be blocked after max per minute

3. **Pipe Requirement Test:**
   - Remove pipe from inventory
   - Try to use opium
   - Should show "need pipe" error

---

## 🛠️ Troubleshooting

### Issue: Resource Won't Start

**Error:** `Resource lxr-drugs failed to start`

**Solutions:**
1. Check resource name is exactly `lxr-drugs`
2. Verify file structure is correct
3. Check console for Lua errors
4. Ensure framework is loaded before lxr-drugs

### Issue: Items Not Usable

**Symptoms:** Using item doesn't trigger effects

**Solutions:**
1. Verify items added to framework's `shared/items.lua`
2. Check item names match config.lua
3. Restart framework resource: `restart [framework]`
4. Check server console for errors

### Issue: Framework Not Detected

**Error:** `No framework detected, running standalone`

**Solutions:**
1. Ensure framework is started before lxr-drugs
2. Check framework resource name matches exactly
3. Set manual framework: `Config.Framework = 'lxr-core'`
4. Restart both framework and lxr-drugs

### Issue: No Animations Playing

**Symptoms:** Effects work but no animations

**Solutions:**
1. Check `Config.General.requireAnimation = true`
2. Verify animation dictionaries are valid
3. Check F8 console for animation errors
4. Try different animation sets in config

### Issue: Hallucination Peds Not Spawning

**Symptoms:** Effects work but no peds appear

**Solutions:**
1. Check ped models are valid for RedM
2. Verify pedQuantity > 0 in config
3. Check performance settings (maxPedSpawnDistance)
4. Look for Lua errors in F8 console

### Issue: Opium Requires Pipe But Shouldn't

**Symptoms:** Want opium without pipe requirement

**Solution:**
Comment out pipe check in `server/server.lua`:
```lua
-- Check for pipe requirement
-- local hasPipe = Framework.GetItemCount(source, Config.Opium.pipeItem) >= 1
-- if not hasPipe then
--     local message = Config.Locale[Config.Lang].opium_need_pipe
--     Framework.Notify(source, message, 'error', 3000)
--     return
-- end
```

Or set different item:
```lua
Config.Opium.pipeItem = 'lighter'  -- Use any item you want
```

---

## 🔧 Advanced Configuration

### Custom Item Names

If your server uses different item names:

```lua
Config.Joint.itemName = 'weed_joint'
Config.Opium.itemName = 'opium_raw'
Config.Opium.pipeItem = 'opium_pipe'
Config.Mushroom.itemName = 'shroom_psychedelic'
```

### Disable Security for Testing

```lua
Config.Security.enabled = false  -- WARNING: Only for testing!
```

### Enable Debug Mode

```lua
Config.Debug = true  -- Shows detailed console logs
```

---

## 📊 Performance Verification

After installation, check resource performance:

### In-Game
Press F8 and type:
```
resmon
```

Look for `lxr-drugs`:
- Idle: 0.00ms (good)
- Active: 0.01-0.03ms (good)
- High: >0.05ms (check hallucination settings)

---

## ✅ Installation Checklist

- [ ] Downloaded lxr-drugs resource
- [ ] Named folder exactly `lxr-drugs`
- [ ] Verified file structure
- [ ] Added items to framework (shared/items.lua)
- [ ] Added item images to inventory
- [ ] Added `ensure lxr-drugs` to server.cfg
- [ ] Verified load order (framework → inventory → lxr-drugs)
- [ ] Configured config.lua (framework, language, items)
- [ ] Restarted server
- [ ] Verified startup messages in console
- [ ] Tested each drug in-game
- [ ] Verified animations work
- [ ] Verified effects work
- [ ] Verified security works
- [ ] Checked performance (resmon)

---

## 🆘 Getting Help

### Community Support

**Discord:** https://discord.gg/CrKcWdfd3A  
Join The Land of Wolves community for support

### Developer Contact

**Developer:** iBoss21 / The Lux Empire  
**GitHub:** https://github.com/iBoss21  
**Store:** https://theluxempire.tebex.io

### Documentation

- [Overview](overview.md) - System overview
- [Configuration](configuration.md) - Detailed config
- [Frameworks](frameworks.md) - Framework support
- [Events](events.md) - Event reference
- [Security](security.md) - Security features

---

## 📝 Next Steps

After successful installation:

1. **Read Configuration Guide** - [configuration.md](configuration.md)
2. **Understand Events** - [events.md](events.md)
3. **Review Security** - [security.md](security.md)
4. **Optimize Performance** - [performance.md](performance.md)
5. **Customize to Your Server** - Edit config.lua to fit your RP style

---

**🐺 Enjoy your immersive drug system from The Land of Wolves!**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
