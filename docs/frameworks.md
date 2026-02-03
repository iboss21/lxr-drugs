```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs Framework Support Guide

**Multi-Framework Compatibility & Adapter Documentation**

---

## Server Information

- **Server:** The Land of Wolves 🐺
- **Developer:** iBoss21 / The Lux Empire
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Website:** https://www.wolves.land

---

## 📋 Overview

LXR-Drugs features a **universal framework adapter** that provides seamless compatibility across multiple RedM frameworks. The system automatically detects your framework and provides a unified API, eliminating the need for framework-specific code.

---

## 🎯 Supported Frameworks

### Primary Support (Fully Tested)

#### LXR-Core
- **Status:** ✅ Primary (Fully Supported)
- **Resource:** `lxr-core`
- **Inventory:** `lxr-inventory`
- **Notifications:** `ox_lib`
- **Detection Priority:** #1

#### RSG-Core
- **Status:** ✅ Primary (Fully Supported)
- **Resource:** `rsg-core`
- **Inventory:** `rsg-inventory`
- **Notifications:** `ox_lib`
- **Detection Priority:** #2

### Extended Support

#### VORP Core
- **Status:** ✅ Supported
- **Resource:** `vorp_core`
- **Inventory:** `vorp_inventory`
- **Notifications:** `vorp` (native)
- **Detection Priority:** #3

### Standalone Mode
- **Status:** ✅ Fallback
- **Description:** Basic functionality without framework
- **Features:** Chat notifications, basic item system
- **Detection Priority:** #4 (if no framework found)

---

## 🔧 Framework Auto-Detection

### How It Works

The adapter automatically detects which framework is running on your server using a priority-based system.

**Detection Order:**
1. **LXR-Core** - Checks if `lxr-core` resource is started
2. **RSG-Core** - Checks if `rsg-core` resource is started
3. **VORP Core** - Checks if `vorp_core` resource is started
4. **Standalone** - Falls back if no framework detected

**Detection Code:**
```lua
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
        return Framework.Name
    end
end
```

### Configuration

**Automatic Detection (Recommended):**
```lua
Config.Framework = 'auto'
```

**Manual Override:**
```lua
-- Force specific framework
Config.Framework = 'lxr-core'   -- LXR-Core
Config.Framework = 'rsg-core'   -- RSG-Core
Config.Framework = 'vorp_core'  -- VORP Core
```

**When to Use Manual:**
- Testing specific framework behavior
- Running multiple frameworks (edge case)
- Troubleshooting detection issues

---

## 🏗️ Framework Adapter Architecture

### Unified Interface

The adapter provides consistent functions regardless of framework:

```lua
Framework = {
    Name = 'detected-framework',
    Core = nil,              -- Framework core object
    Inventory = nil,         -- Inventory export
    Ready = false,           -- Initialization status
    
    -- Functions (server-side)
    Notify(source, message, type, duration)
    AddItem(source, item, amount, metadata)
    RemoveItem(source, item, amount)
    HasItem(source, item, amount)
    GetItemCount(source, item)
    CloseInventory(source)
    RegisterUsableItem(itemName, callback)
    GetPlayer(source)
    GetIdentifier(source)
    
    -- Functions (client-side)
    Notify(message, type, duration)
    TriggerServerCallback(name, callback, ...)
}
```

### Initialization Process

**Server-Side:**
```lua
-- Step 1: Detect framework
DetectFramework()  -- Returns 'lxr-core', 'rsg-core', etc.

-- Step 2: Initialize core object
if Framework.Name == 'lxr-core' then
    Framework.Core = exports['lxr-core']:GetCoreObject()
    Framework.Inventory = exports['lxr-inventory']
elseif Framework.Name == 'rsg-core' then
    Framework.Core = exports['rsg-core']:GetCoreObject()
    Framework.Inventory = exports['rsg-inventory']
elseif Framework.Name == 'vorp_core' then
    TriggerEvent("getCore", function(core)
        Framework.Core = core
    end)
    Framework.Inventory = exports.vorp_inventory:vorp_inventoryApi()
end

-- Step 3: Set ready flag
Framework.Ready = true
```

---

## 📊 Framework-Specific Details

### LXR-Core Integration

**Core Object:**
```lua
Framework.Core = exports['lxr-core']:GetCoreObject()
```

**Notifications:**
```lua
-- Uses ox_lib
TriggerClientEvent('ox_lib:notify', source, {
    description = message,
    type = type,
    duration = duration
})
```

**Item Registration:**
```lua
Framework.Core.Functions.CreateUseableItem(itemName, function(source)
    -- Callback logic
end)
```

**Inventory:**
```lua
Framework.Core.Functions.AddItem(source, item, amount)
Framework.Core.Functions.RemoveItem(source, item, amount)
```

**Player Data:**
```lua
local Player = Framework.Core.Functions.GetPlayer(source)
local citizenid = Player.PlayerData.citizenid
```

### RSG-Core Integration

**Core Object:**
```lua
Framework.Core = exports['rsg-core']:GetCoreObject()
```

**Notifications:**
```lua
-- Uses ox_lib
TriggerClientEvent('ox_lib:notify', source, {
    description = message,
    type = type,
    duration = duration
})
```

**Item Registration:**
```lua
Framework.Core.Functions.CreateUseableItem(itemName, function(source)
    -- Callback logic
end)
```

**Inventory:**
```lua
Framework.Core.Functions.AddItem(source, item, amount)
Framework.Core.Functions.RemoveItem(source, item, amount)
```

**Player Data:**
```lua
local Player = Framework.Core.Functions.GetPlayer(source)
local citizenid = Player.PlayerData.citizenid
```

### VORP Core Integration

**Core Object:**
```lua
TriggerEvent("getCore", function(core)
    Framework.Core = core
end)
```

**Notifications:**
```lua
-- Uses VORP native notifications
Framework.Core.NotifyLeft(source, 'LXR Drugs', message, 'generic_textures', 'tick', duration, 'COLOR_PURE_WHITE')
```

**Item Registration:**
```lua
Framework.Inventory.RegisterUsableItem(itemName, function(data)
    local source = data.source
    -- Callback logic
end)
```

**Inventory:**
```lua
Framework.Inventory.addItem(source, item, amount, metadata)
Framework.Inventory.subItem(source, item, amount)
local count = Framework.Inventory.getItemCount(source, item)
```

**Player Data:**
```lua
local User = Framework.Core.getUser(source)
local identifier = User.getIdentifier()
```

---

## 🔄 Adapter Functions Reference

### Server Functions

#### Framework.Notify(source, message, type, duration)
Send notification to player.

**Parameters:**
- `source` (integer) - Player server ID
- `message` (string) - Notification text
- `type` (string) - 'info', 'success', 'error'
- `duration` (integer) - Milliseconds to display

**Example:**
```lua
Framework.Notify(source, 'You smoked a joint', 'info', 3000)
```

#### Framework.AddItem(source, item, amount, metadata)
Add item to player inventory.

**Example:**
```lua
Framework.AddItem(source, 'joint', 5, {quality = 100})
```

#### Framework.RemoveItem(source, item, amount)
Remove item from player inventory.

**Example:**
```lua
Framework.RemoveItem(source, 'joint', 1)
```

#### Framework.HasItem(source, item, amount)
Check if player has item.

**Returns:** boolean

**Example:**
```lua
if Framework.HasItem(source, 'pipe', 1) then
    -- Player has pipe
end
```

#### Framework.GetItemCount(source, item)
Get item quantity.

**Returns:** integer

**Example:**
```lua
local jointCount = Framework.GetItemCount(source, 'joint')
```

#### Framework.CloseInventory(source)
Force close player inventory.

**Example:**
```lua
Framework.CloseInventory(source)
```

#### Framework.RegisterUsableItem(itemName, callback)
Register item as usable.

**Example:**
```lua
Framework.RegisterUsableItem('joint', function(data)
    local source = data.source
    -- Consumption logic
end)
```

#### Framework.GetPlayer(source)
Get framework player object.

**Returns:** Player object or nil

**Example:**
```lua
local Player = Framework.GetPlayer(source)
```

#### Framework.GetIdentifier(source)
Get unique player identifier.

**Returns:** string (citizenid/identifier)

**Example:**
```lua
local id = Framework.GetIdentifier(source)
```

### Client Functions

#### Framework.Notify(message, type, duration)
Display notification on client.

**Example:**
```lua
Framework.Notify('Effects starting...', 'info', 3000)
```

#### Framework.TriggerServerCallback(name, callback, ...)
Trigger server callback.

**Example:**
```lua
Framework.TriggerServerCallback('lxr-drugs:getStatus', function(status)
    print(status)
end)
```

---

## 🛠️ Custom Framework Integration

### Adding New Framework Support

If you need to add support for a custom framework:

**Step 1: Add Framework Config**
```lua
-- In config.lua
Config.FrameworkSettings['my-custom-framework'] = {
    resource = 'my-custom-framework',
    notifications = 'custom_notify',
    inventory = 'custom_inventory',
    events = {
        server = 'custom:server:%s',
        client = 'custom:client:%s'
    }
}
```

**Step 2: Add Detection**
```lua
-- In shared/framework.lua, add to frameworks table
local frameworks = {
    {name = 'lxr-core', resource = 'lxr-core'},
    {name = 'rsg-core', resource = 'rsg-core'},
    {name = 'vorp_core', resource = 'vorp_core'},
    {name = 'my-custom-framework', resource = 'my-custom-framework'}  -- Add here
}
```

**Step 3: Add Initialization**
```lua
-- In shared/framework.lua
elseif Framework.Name == 'my-custom-framework' then
    Framework.Core = exports['my-custom-framework']:GetCore()
    Framework.Inventory = exports['custom_inventory']
```

**Step 4: Implement Functions**
```lua
-- In shared/framework.lua, implement each Framework function
-- for your custom framework
```

---

## 🔍 Troubleshooting

### Framework Not Detected

**Problem:** Shows "standalone" or wrong framework

**Solutions:**
1. Check framework resource is started before lxr-drugs
2. Verify resource name matches exactly (case-sensitive)
3. Use manual framework selection: `Config.Framework = 'lxr-core'`
4. Enable debug: `Config.Debug = true`

**Check Console:**
```
[LXR-Drugs] Detected framework: unknown
[LXR-Drugs] Ready: NO
```

### Framework Ready = NO

**Problem:** Framework detected but not initializing

**Solutions:**
1. Wait longer (500ms delay is normal)
2. Check framework exports are valid
3. Verify framework core object accessible
4. Check for Lua errors in console

### Inventory Functions Not Working

**Problem:** Items not adding/removing

**Solutions:**
1. Verify inventory resource name in Config.FrameworkSettings
2. Check inventory exports format
3. Test with framework-specific commands
4. Enable debug logging

### Notifications Not Showing

**Problem:** No notifications appear

**Solutions:**
1. Check ox_lib installed (LXR/RSG)
2. Verify notification system in Config.FrameworkSettings
3. Test notifications manually
4. Check notification type ('info', 'success', 'error')

---

## 📈 Framework Comparison

| Feature | LXR-Core | RSG-Core | VORP Core |
|---------|----------|----------|-----------|
| Auto-Detection | ✅ | ✅ | ✅ |
| Item System | ✅ | ✅ | ✅ |
| Notifications | ox_lib | ox_lib | VORP Native |
| Player Data | PlayerData | PlayerData | User Object |
| Callbacks | ✅ | ✅ | ✅ |
| Inventory Export | lxr-inventory | rsg-inventory | vorp_inventory |
| Metabolism | ❌ | ❌ | ✅ (hunger/thirst) |

---

## 🎓 Best Practices

### Framework-Agnostic Code

When extending lxr-drugs, use the Framework API instead of framework-specific code:

**✅ Good:**
```lua
Framework.Notify(source, 'Test message', 'info', 3000)
Framework.RemoveItem(source, 'joint', 1)
```

**❌ Bad:**
```lua
-- Don't do this:
if GetResourceState('lxr-core') == 'started' then
    exports['lxr-core']:GetCoreObject().Functions.Notify(...)
end
```

### Checking Framework Ready

Always wait for framework initialization:

```lua
CreateThread(function()
    while not Framework.Ready do Wait(100) end
    
    -- Now safe to use Framework functions
    Framework.RegisterUsableItem('joint', callback)
end)
```

### Testing Multiple Frameworks

Test on each framework you claim to support:
1. Start clean server with framework
2. Install lxr-drugs
3. Test all drug types
4. Verify notifications
5. Check inventory operations
6. Test security features

---

## 🔗 Related Documentation

- [Installation Guide](installation.md) - Framework-specific setup
- [Configuration Guide](configuration.md) - Framework settings
- [Events Reference](events.md) - Framework event patterns

---

## 📞 Support

**Discord:** https://discord.gg/CrKcWdfd3A  
**Developer:** iBoss21 / The Lux Empire

---

**🐺 Universal framework support for maximum compatibility!**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
