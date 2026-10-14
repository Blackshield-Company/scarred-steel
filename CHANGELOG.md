# Changelog

All notable changes to this project are documented here. Versions follow [Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-10-13

### Added
- Wear hints. When a weapon or armor counter crosses a tier, a notice names that tier: "Your blade is nicked (Nicked)", "Your blade is dulling (Dulled)", "Your blade is blunted (Blunted)", "Your blade is keen again (Keen)", and the armor lines "Your armor is scuffed (Scuffed)", "Your armor is dented (Dented)", "Your armor is battered (Battered)", "Your armor is sound again (Sound)". On by default (`SCS_WearHints` is 1). Turn them off or on from Inspect Gear, or with `set SCS_WearHints to 0` in the console. Repair notices are not gated.

### Changed
- Tier notification wording now includes the tier name in parentheses, and a return to tier 0 says "keen again" / "sound again".

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
