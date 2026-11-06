Config = {}

---------------------------------------------------------------------------
-- How busy the world is
--
-- Every value runs from 0.0 (none) to 1.0 (GTA's normal amount). GTA won't go above 1.0.
--
--   peds                  NPCs walking around
--   scenarioPedsInside    NPCs doing something in one place (sitting, smoking, working) inside buildings
--   scenarioPedsOutside   the same, outside
--   traffic               NPC vehicles driving around
--   randomVehicles        extra random vehicles GTA adds to the traffic
--   parkedVehicles        NPC vehicles parked at the roadside and in car parks

-- The values everywhere, at every time of day.
Config.Default = {
    peds = 1.0,
    scenarioPedsInside = 1.0,
    scenarioPedsOutside = 1.0,
    traffic = 1.0,
    randomVehicles = 1.0,
    parkedVehicles = 1.0,
}

-- Different values by in-game time. `from` and `to` are hours, 0 to 23; a period can run past midnight.
-- Only the values listed change. If periods overlap, the later one in the list wins.
Config.Times = {
    { from = 0, to = 6, peds = 0.4, scenarioPedsOutside = 0.4, traffic = 0.4, randomVehicles = 0.4 },
}

-- Different values by GTA zone. Only the values listed change, and they win over Config.Times.
-- Zone names are GTA's short codes, such as 'AIRP' (the airport), 'DOWNT' (downtown) or 'SANDY' (Sandy
-- Shores). The full list: https://docs.fivem.net/docs/game-references/zones/
Config.Zones = {
    -- AIRP = { peds = 0.3, traffic = 0.5 },
    -- ARMYB = { peds = 0.0, traffic = 0.0, parkedVehicles = 0.0 },
}

---------------------------------------------------------------------------
-- Other traffic
--
-- true keeps them, false turns them off, nil leaves them to GTA and other resources.

-- Garbage trucks driving their rounds.
Config.GarbageTrucks = true

-- NPC boats on the sea and lakes.
Config.RandomBoats = true

-- The far-off traffic GTA draws in the distance, such as the lights on the motorway seen from a hill.
Config.DistantTraffic = true

-- Update checks are controlled in server.cfg for every Pigeon Studios resource at once:
--     set pigeon_update_check "on"      (default)  |  "quiet"  |  "off"
