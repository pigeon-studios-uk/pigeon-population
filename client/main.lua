--[[
    Pigeon Population: client.

    Sets how many NPCs and how much traffic GTA spawns around each player. GTA's density natives only
    last one frame, so the chosen values are set every frame. Which values apply is worked out once a
    second from the player's zone and the in-game time:

        Config.Default  <  a matching Config.Times period  <  a matching Config.Zones entry  <  an export

    Each one only changes the values it lists; anything it leaves out comes from the one before.

    Density is decided in each player's own game, for the area around them, so every player runs this.
]]

local RESOURCE = GetCurrentResourceName()
local KEYS = { 'peds', 'scenarioPedsInside', 'scenarioPedsOutside', 'traffic', 'randomVehicles', 'parkedVehicles' }

local current = {}            -- the values set every frame
local override = nil          -- from the SetDensity export, on top of everything

local function clamp(value)
    value = tonumber(value)
    if not value then return nil end
    return math.max(0.0, math.min(1.0, value + 0.0))
end

local function layer(into, values)
    if type(values) ~= 'table' then return end
    for _, key in ipairs(KEYS) do
        local value = clamp(values[key])
        if value then into[key] = value end
    end
end

--- True if the hour is inside the period. A period can run past midnight, such as 22 to 6.
local function inPeriod(hour, period)
    local from, to = tonumber(period.from), tonumber(period.to)
    if not from or not to then return false end
    if from == to then return true end
    if from < to then return hour >= from and hour < to end
    return hour >= from or hour < to
end

--- The values that apply for this zone and hour.
local function resolve(zone, hour)
    local values = { peds = 1.0, scenarioPedsInside = 1.0, scenarioPedsOutside = 1.0, traffic = 1.0, randomVehicles = 1.0, parkedVehicles = 1.0 }
    layer(values, Config.Default)
    for _, period in ipairs(Config.Times or {}) do
        if inPeriod(hour, period) then layer(values, period) end
    end
    if Config.Zones then layer(values, Config.Zones[zone]) end
    layer(values, override)
    return values
end

local function applyToggles(restore)
    if Config.GarbageTrucks ~= nil then SetGarbageTrucks(restore or Config.GarbageTrucks == true) end
    if Config.RandomBoats ~= nil then SetRandomBoats(restore or Config.RandomBoats == true) end
    if Config.DistantTraffic ~= nil then SetDistantCarsEnabled(restore or Config.DistantTraffic == true) end
end

-- Works out the values once a second.
CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        current = resolve(GetNameOfZone(coords.x, coords.y, coords.z), GetClockHours())
        applyToggles(false)
        Wait(1000)
    end
end)

-- Sets them every frame, as GTA needs.
CreateThread(function()
    while true do
        local values = current
        if values.peds then
            SetPedDensityMultiplierThisFrame(values.peds)
            SetScenarioPedDensityMultiplierThisFrame(values.scenarioPedsInside, values.scenarioPedsOutside)
            SetVehicleDensityMultiplierThisFrame(values.traffic)
            SetRandomVehicleDensityMultiplierThisFrame(values.randomVehicles)
            SetParkedVehicleDensityMultiplierThisFrame(values.parkedVehicles)
        end
        Wait(0)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == RESOURCE then applyToggles(true) end
end)

---------------------------------------------------------------------------
-- Exports

--- Sets density values on top of the config for this player, such as { peds = 0.0, traffic = 0.2 } during
--- an event, until it's called again. nil goes back to the config. Takes effect within a second.
exports('SetDensity', function(values)
    override = type(values) == 'table' and values or nil
end)

--- The density values in use right now for this player.
exports('GetDensity', function()
    local copy = {}
    for key, value in pairs(current) do copy[key] = value end
    return copy
end)
