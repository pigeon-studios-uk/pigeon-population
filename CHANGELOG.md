# Changelog

All notable changes to Pigeon Population are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **Major** versions can need changes to your configuration or other resources. Read the **Upgrade notes**.
- **Minor** versions add features without breaking existing setups.
- **Patch** versions fix bugs only.

## [Unreleased]

First release.

### Highlights

- NPCs, traffic and parked cars, each set from none to GTA's normal amount
- Different numbers by time of day
- Different numbers by zone
- Garbage trucks, boats and distant traffic on or off
- An export for events and other resources

### Added

- Six density values (walking NPCs, NPCs in scenarios inside and outside, traffic, random vehicles and parked vehicles) set every frame, from 0.0 to 1.0.
- `Config.Default`, `Config.Times` periods by in-game hour (including past midnight) and `Config.Zones` by GTA zone, each changing only the values it lists.
- Garbage trucks, random boats and distant traffic turned on or off.
- `SetDensity` and `GetDensity` client exports for events and other resources.
- GTA's garbage trucks, boats and distant traffic put back when the resource stops.
- Update checker from the Pigeon Studios version registry.

[Unreleased]: https://github.com/pigeon-studios-uk/pigeon-population/commits/main
