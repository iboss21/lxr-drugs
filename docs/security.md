```
    ██╗     ██╗  ██╗██████╗       ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
```

# 🐺 LXR-Drugs Security Guide

**Anti-Abuse Features & Protection Mechanisms**

---

## Server Information

- **Server:** The Land of Wolves 🐺
- **Developer:** iBoss21 / The Lux Empire
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Website:** https://www.wolves.land

---

## 🔒 Overview

LXR-Drugs includes comprehensive server-side security features to prevent abuse, exploitation, and spam. All validation happens server-side where it cannot be bypassed by cheaters.

---

## 🛡️ Security Features

### 1. Rate Limiting

Prevents players from spamming drug consumption.

**How It Works:**
- Tracks drug uses per player per minute
- Blocks consumption if limit exceeded
- Counter resets every 60 seconds
- Separate tracking per player

**Configuration:**
```lua
Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 5  -- Max 5 drugs per minute
}
```

**Example Scenarios:**

| Time | Uses | Allowed? | Reason |
|------|------|----------|--------|
| 0:00 | 1 | ✅ Yes | First use |
| 0:10 | 2 | ✅ Yes | Under limit |
| 0:20 | 5 | ✅ Yes | At limit |
| 0:30 | 6 | ❌ No | Exceeded limit |
| 1:01 | 1 | ✅ Yes | Counter reset |

**Implementation:**
```lua
local playerUsageCount = {}

if playerUsageCount[playerId] == nil then
    playerUsageCount[playerId] = 0
end

playerUsageCount[playerId] = playerUsageCount[playerId] + 1

if playerUsageCount[playerId] > Config.Security.maxConsumptionPerMinute then
    return false  -- Blocked
end
```

**Customization:**

**Stricter Limit:**
```lua
Config.Security.maxConsumptionPerMinute = 3  -- Only 3 per minute
```

**More Relaxed:**
```lua
Config.Security.maxConsumptionPerMinute = 10  -- 10 per minute
```

**Disable Rate Limiting (NOT RECOMMENDED):**
```lua
Config.Security.maxConsumptionPerMinute = 999  -- Effectively unlimited
```

---

### 2. Cooldown System

Enforces minimum time between drug uses.

**How It Works:**
- Tracks last use timestamp per player
- Blocks use if cooldown hasn't expired
- Separate tracking for each player
- Persists until player disconnects

**Configuration:**
```lua
Config.Security = {
    enabled = true,
    cooldownBetweenUses = 1000  -- 1 second cooldown
}
```

**Example Timeline:**
```
Time 0ms:    Player uses joint → Allowed
Time 500ms:  Player uses joint → BLOCKED (cooldown)
Time 1000ms: Player uses joint → Allowed (cooldown expired)
Time 2500ms: Player uses joint → Allowed
```

**Implementation:**
```lua
local playerCooldowns = {}

local currentTime = GetGameTimer()

if playerCooldowns[playerId] and 
   (currentTime - playerCooldowns[playerId].lastUse) < Config.Security.cooldownBetweenUses then
    return false  -- Blocked by cooldown
end

playerCooldowns[playerId] = {
    lastUse = currentTime
}
```

**Customization:**

**Longer Cooldown:**
```lua
Config.Security.cooldownBetweenUses = 5000  -- 5 seconds
```

**Shorter Cooldown:**
```lua
Config.Security.cooldownBetweenUses = 500  -- 0.5 seconds
```

**Roleplay Realistic Cooldown:**
```lua
Config.Security.cooldownBetweenUses = 30000  -- 30 seconds (realistic)
```

---

### 3. Item Ownership Validation

Ensures player actually has the drug item before consumption.

**How It Works:**
- Checks inventory before triggering effects
- Prevents exploits where effects trigger without item
- Double-checks after framework's initial validation
- Server-side only (client cannot bypass)

**Configuration:**
```lua
Config.Security = {
    enabled = true,
    validateItemOwnership = true
}
```

**Implementation:**
```lua
if Config.Security.validateItemOwnership then
    if not Framework.HasItem(source, Config.Joint.itemName, 1) then
        if Config.Security.logSuspiciousActivity then
            print(string.format('[LXR-Drugs] SECURITY: Player %s tried to use joint without having it', source))
        end
        return
    end
end
```

**Why It Matters:**
- Prevents inventory duplication exploits
- Stops menu injectors from triggering effects
- Ensures economy integrity
- Logs potential cheaters

**Logging Example:**
```
[LXR-Drugs] SECURITY: Player 5 tried to use joint without having it
[LXR-Drugs] SECURITY: Player 5 tried to use opium without having it
```

**Disable (NOT RECOMMENDED):**
```lua
Config.Security.validateItemOwnership = false  -- Trust framework only
```

---

### 4. Inventory Close Requirement

Forces inventory to close before drug effects.

**How It Works:**
- Closes player inventory when drug used
- Prevents animation glitches
- Stops inventory manipulation during effects
- Enhances immersion

**Configuration:**
```lua
Config.Security = {
    enabled = true,
    requireInventoryClose = true
}
```

**Implementation:**
```lua
if Config.Security.requireInventoryClose then
    Framework.CloseInventory(source)
end
```

**Benefits:**
- Prevents animation conflicts
- Stops inventory duplication exploits
- Forces player to focus on effects
- More immersive experience

**Disable:**
```lua
Config.Security.requireInventoryClose = false  -- Keep inventory open
```

---

### 5. Suspicious Activity Logging

Logs potential abuse attempts to server console.

**How It Works:**
- Logs rate limit violations
- Logs item ownership failures
- Timestamps all suspicious activity
- Helps identify cheaters

**Configuration:**
```lua
Config.Security = {
    enabled = true,
    logSuspiciousActivity = true
}
```

**Log Examples:**
```
[LXR-Drugs] SECURITY: Player 12 exceeded consumption rate limit
[LXR-Drugs] SECURITY: Player 8 tried to use joint without having it
[LXR-Drugs] SECURITY: Player 8 tried to use opium without having it
[LXR-Drugs] SECURITY: Player 15 exceeded consumption rate limit
```

**Benefits:**
- Identifies cheaters
- Tracks abuse patterns
- Helps with moderation
- Evidence for bans

**Use Cases:**
1. **Moderation:** Check logs daily for patterns
2. **Ban Evidence:** Screenshot logs for proof
3. **Troubleshooting:** Identify legitimate issues vs exploits

**Disable Logging:**
```lua
Config.Security.logSuspiciousActivity = false  -- Silent mode
```

---

### 6. Opium Pipe Requirement

Requires pipe item to smoke opium.

**How It Works:**
- Checks for pipe item in inventory
- Blocks opium use if no pipe found
- Shows error notification
- Prevents unrealistic usage

**Configuration:**
```lua
Config.Opium = {
    itemName = 'opium',
    pipeItem = 'pipe'  -- Required item
}
```

**Implementation:**
```lua
local hasPipe = Framework.GetItemCount(source, Config.Opium.pipeItem) >= 1
if not hasPipe then
    local message = Config.Locale[Config.Lang].opium_need_pipe
    Framework.Notify(source, message, 'error', 3000)
    return
end
```

**Benefits:**
- Adds realism
- Creates item dependency
- Enhances economy (pipe sales)
- Roleplay requirement

**Remove Requirement:**

Option 1 - Empty string:
```lua
Config.Opium.pipeItem = ''  -- No pipe needed
```

Option 2 - Comment out check in `server/server.lua`:
```lua
-- Check for pipe requirement
-- local hasPipe = Framework.GetItemCount(source, Config.Opium.pipeItem) >= 1
-- if not hasPipe then
--     local message = Config.Locale[Config.Lang].opium_need_pipe
--     Framework.Notify(source, message, 'error', 3000)
--     return
-- end
```

---

## 🔐 Server-Side Validation

### Why Server-Side?

**❌ Client-Side Validation (BAD):**
- Can be bypassed by cheaters
- Menu injectors can trigger events
- No protection against exploits

**✅ Server-Side Validation (GOOD):**
- Cannot be bypassed
- Full control over logic
- Protects against all exploits
- Trusted environment

### Validation Flow

```
Player uses drug item
    ↓
[SERVER] Framework usable item callback
    ↓
[SERVER] Is security enabled?
    ↓ NO → Skip checks, proceed
    ↓ YES
[SERVER] Check rate limit
    ↓ EXCEEDED → Block with error
    ↓ OK
[SERVER] Check cooldown
    ↓ ACTIVE → Block with error
    ↓ OK
[SERVER] Validate item ownership
    ↓ NONE → Block with error + log
    ↓ HAS ITEM
[SERVER] Close inventory (if enabled)
    ↓
[SERVER] Remove item from inventory
    ↓
[SERVER] Trigger client event
    ↓
[CLIENT] Play animations and effects
```

---

## 🎯 Best Practices

### For Server Owners

**1. Always Keep Security Enabled:**
```lua
Config.Security.enabled = true  -- ALWAYS in production
```

**2. Monitor Logs Regularly:**
```bash
# Check server console for suspicious activity
grep "SECURITY" your_server_log.txt
```

**3. Adjust Limits for Your Server Type:**

**Hardcore RP:**
```lua
Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 2,
    requireInventoryClose = true,
    validateItemOwnership = true,
    logSuspiciousActivity = true,
    cooldownBetweenUses = 30000  -- 30 seconds
}
```

**Casual Server:**
```lua
Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 10,
    requireInventoryClose = false,
    validateItemOwnership = true,
    logSuspiciousActivity = true,
    cooldownBetweenUses = 1000  -- 1 second
}
```

**4. Document Ban Reasons:**
When banning for drug abuse, include:
- Player ID
- Timestamp
- Log evidence
- Number of violations

**5. Test Security Features:**
```lua
-- Enable debug for testing
Config.Debug = true

-- Try to bypass each security feature
-- Verify blocks work correctly
-- Check logs appear
```

---

### For Developers

**1. Never Trust Client Data:**
```lua
-- ❌ BAD
RegisterNetEvent('lxr-drugs:server:useDrug')
AddEventHandler('lxr-drugs:server:useDrug', function(drugType)
    -- Client could send any drugType, including fake ones
end)

-- ✅ GOOD
Framework.RegisterUsableItem('joint', function(data)
    -- Server controls which items are usable
    -- Client cannot inject fake items
end)
```

**2. Always Validate on Server:**
```lua
-- ✅ GOOD
if not Framework.HasItem(source, 'joint', 1) then
    -- Block and log
    return
end
```

**3. Log Suspicious Activity:**
```lua
if Config.Security.logSuspiciousActivity then
    print(string.format('[LXR-Drugs] SECURITY: Player %s did something suspicious', source))
end
```

**4. Use Cooldowns Wisely:**
- Short cooldowns (1s) for spam prevention
- Long cooldowns (30s+) for realism
- Balance gameplay vs protection

---

## 🚨 Common Exploits & Protections

### Exploit 1: Rapid Item Use Spam

**Attack:**
- Player rapidly clicks use button
- Attempts to trigger effects multiple times
- Bypasses item removal

**Protection:**
- Rate limiting (max per minute)
- Cooldown system (time between uses)
- Item validation before trigger

**Detection:**
```
[LXR-Drugs] SECURITY: Player 5 exceeded consumption rate limit
[LXR-Drugs] SECURITY: Player 5 exceeded consumption rate limit
[LXR-Drugs] SECURITY: Player 5 exceeded consumption rate limit
```

---

### Exploit 2: Menu Injection

**Attack:**
- Cheat menu injects event directly
- Bypasses inventory system
- Triggers effects without item

**Protection:**
- No direct client event handlers
- All triggers from server only
- Item ownership validation

**Example Protected Code:**
```lua
-- ❌ VULNERABLE
RegisterNetEvent('lxr-drugs:client:joint')  -- Client can trigger this!

-- ✅ PROTECTED
-- Only server can trigger client events
TriggerClientEvent('lxr-drugs:client:joint', source)
```

---

### Exploit 3: Item Duplication

**Attack:**
- Use item and disconnect mid-animation
- Use item and die to avoid removal
- Use item from multiple inventories

**Protection:**
- Item removed BEFORE effects trigger
- Inventory validation
- Framework's built-in protections

**Implementation:**
```lua
-- Remove item FIRST
Framework.RemoveItem(source, Config.Joint.itemName, 1)

-- THEN trigger effects
TriggerClientEvent('lxr-drugs:client:joint', source)
```

---

### Exploit 4: Effect Spam

**Attack:**
- Trigger effects repeatedly
- Crash other players with particles
- Spawn unlimited hallucination peds

**Protection:**
- Cooldown system
- Ped cleanup after duration
- Effect cleanup on resource stop

**Cleanup Code:**
```lua
-- Clean up peds
for _, ped in pairs(peds) do
    DeleteEntity(ped)
end

-- Clear effects
AnimpostfxStop('PlayerDrugsPoisonWell')
AnimpostfxStop('playerdrugshalluc01')
```

---

## 🔍 Monitoring & Detection

### Server Console Monitoring

**Look for these patterns:**

**Single Violation:**
```
[LXR-Drugs] SECURITY: Player 8 exceeded consumption rate limit
```
*Could be legitimate rapid clicking. Monitor.*

**Repeated Violations:**
```
[LXR-Drugs] SECURITY: Player 12 exceeded consumption rate limit
[LXR-Drugs] SECURITY: Player 12 exceeded consumption rate limit
[LXR-Drugs] SECURITY: Player 12 exceeded consumption rate limit
[LXR-Drugs] SECURITY: Player 12 tried to use joint without having it
[LXR-Drugs] SECURITY: Player 12 tried to use joint without having it
```
*Clear cheating pattern. Investigate immediately.*

### Using txAdmin

**Filter Logs:**
1. Open txAdmin console
2. Search for "SECURITY"
3. Check timestamps
4. Identify player IDs
5. Investigate player

**Ban Procedure:**
1. Collect log evidence
2. Note player ID and name
3. Screenshot logs
4. Ban with reason: "Drug system exploit"

### Database Logging (Optional)

Add custom logging to database:

```lua
-- In server/server.lua, add after security validation
if Config.Security.logSuspiciousActivity then
    print(string.format('[LXR-Drugs] SECURITY: Player %s exceeded consumption rate limit', source))
    
    -- Optional: Log to database
    MySQL.Async.execute('INSERT INTO security_logs (player_id, event_type, timestamp) VALUES (?, ?, ?)', {
        Framework.GetIdentifier(source),
        'drug_rate_limit',
        os.time()
    })
end
```

---

## 📊 Security Checklist

### Pre-Launch
- [ ] `Config.Security.enabled = true`
- [ ] Rate limit set appropriately
- [ ] Cooldown configured
- [ ] Item validation enabled
- [ ] Logging enabled
- [ ] Test all security features
- [ ] Document ban procedures

### Regular Maintenance
- [ ] Check logs daily
- [ ] Investigate violations
- [ ] Update ban list
- [ ] Adjust limits if needed
- [ ] Monitor player feedback

### Incident Response
- [ ] Collect log evidence
- [ ] Screenshot violations
- [ ] Note player ID
- [ ] Investigate pattern
- [ ] Apply appropriate punishment
- [ ] Document incident

---

## 🛠️ Troubleshooting

### Players Blocked Legitimately

**Problem:** Real players hit rate limit

**Solution:**
- Increase `maxConsumptionPerMinute`
- Reduce `cooldownBetweenUses`
- Check for double-click issues

### No Logs Appearing

**Problem:** Security violations not logged

**Solutions:**
1. Check `Config.Security.logSuspiciousActivity = true`
2. Check `Config.Security.enabled = true`
3. Verify console output not filtered

### Security Too Strict

**Problem:** Players complaining about blocks

**Solution:**
```lua
-- Relax settings
Config.Security = {
    enabled = true,
    maxConsumptionPerMinute = 10,  -- Increase
    cooldownBetweenUses = 500,     -- Decrease
    -- ... other settings
}
```

---

## 🎓 Advanced Security

### Custom Security Hooks

Add additional validation:

```lua
-- In server/server.lua
local function CustomSecurityCheck(source)
    -- Check player is not in safezone
    local coords = GetEntityCoords(GetPlayerPed(source))
    if IsPlayerInSafeZone(coords) then
        return false  -- Block drug use in safezone
    end
    
    -- Check player is not in vehicle
    local ped = GetPlayerPed(source)
    if IsPedInAnyVehicle(ped, false) then
        return false  -- Block in vehicles
    end
    
    return true
end

-- Add to item handler
if not CustomSecurityCheck(source) then
    Framework.Notify(source, 'You cannot use drugs here', 'error', 3000)
    return
end
```

### Webhook Notifications

Send Discord alerts for violations:

```lua
-- Add webhook URL
local webhookURL = 'https://discord.com/api/webhooks/YOUR_WEBHOOK'

-- Send alert
local function SendSecurityAlert(playerId, violation)
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        content = string.format('**SECURITY ALERT**\nPlayer: %s\nViolation: %s\nTime: %s', 
            playerId, violation, os.date('%Y-%m-%d %H:%M:%S'))
    }), {['Content-Type'] = 'application/json'})
end
```

---

## 📞 Support

**Discord:** https://discord.gg/CrKcWdfd3A  
**Developer:** iBoss21 / The Lux Empire

---

**🐺 Secure your server with robust anti-abuse protection!**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
