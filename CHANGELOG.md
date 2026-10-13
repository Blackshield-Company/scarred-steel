# Changelog

All notable changes to this project are documented here. Versions follow [Semantic Versioning](https://semver.org/).

## [0.1.0] - 2026-10-13

Early beta. First public release. It passes every automated check in the build (Papyrus compile, plugin validation, byte-exact round trip, SEQ check, FOMOD schema) but has not been playtested in game yet. Please report problems on the Nexus page or on GitHub.

### Added
- Player weapon wear and armor wear, as two counters. Combat swings and hits raise them. Tiers apply a detrimental ability. Counters cap at the tier 3 threshold.
- The lesser power "Inspect Gear", granted once at the start by a Start Game Enabled quest, with a one-time intro note.
- Repair at a vanilla grindstone (weapon) or workbench (armor). Smithing at `SCS_FullRepairSkill` clears the counter; below that it drops one tier. Costs iron and leather strips.
- Ember repair when Ember Smithing is installed (soft check, no master): the same materials plus charcoal and fire salts, a full clear, and Hardened (wear builds at half rate until the next repair of that kind).
- Settings as console globals.
- `SEQ/ScarredSteel.seq` for the Start Game Enabled controller quest.
- FOMOD installer with optional Papyrus sources.
