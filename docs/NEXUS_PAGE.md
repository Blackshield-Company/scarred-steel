# Nexus Mods page: Scarred Steel

Nexus mod id: TBD (not assigned yet).

Early beta: v0.2.0 passes every automated build check but nobody has playtested it in game yet. The page says this at the top. The exact upload-form values are in [NEXUS_FIELDS.md](NEXUS_FIELDS.md).

## Page settings

- **Game:** Skyrim Special Edition
- **Mod name:** Scarred Steel
- **Version:** 0.2.0 (early beta)
- **Category:** Gameplay
- **Suggested tags:** Gameplay, Combat, Lore-Friendly, ESL, No SKSE, Scripted
- **Requirements:** none. Ember Smithing is optional and is not a master.
- **Permissions (suggested):** the source is on GitHub under MIT, so allow modification and conversions with credit, but not re-uploads of the archive itself.
- **File to upload:** `ScarredSteel-0.2.0.zip` (FOMOD) as the main file, named "Scarred Steel".

## Description (paste into the BBCode editor)

```bbcode
[center][size=6][b]SCARRED STEEL[/b][/size]

[size=3][color=#e0a030][b]EARLY BETA (v0.2.0)[/b]: this version passes every automated build check but hasn't been playtested in game yet. Please report bugs in the Bugs tab or on GitHub, ideally with your Papyrus log.[/color][/size][/center]

[line]

[size=4][b]Summary[/b][/size]
Combat wears your weapon and your armor. Repair a weapon at a grindstone and armor at a workbench. The items themselves are not changed.

Base game only. No SKSE. ESL-flagged. Edits no vanilla records. Places nothing in the world.

[size=4][b]What it does[/b][/size]
[list]
[*][b]Weapon wear[/b]. Swings and bow shots in combat add wear. Tiers: Keen, Nicked, Dulled, Blunted. Damage drops 5%, 12%, then 20%.
[*][b]Armor wear[/b]. Weapon and projectile hits, while you wear a cuirass. Tiers: Sound, Scuffed, Dented, Battered. Armor rating drops 15, 40, then 80.
[*][b]Repair[/b]. Use a grindstone or a workbench. Iron and leather strips. Smithing 30 or higher clears it; otherwise it drops one tier.
[*][b]Ember repair[/b]. If Ember Smithing is installed, charcoal and fire salts clear the wear and harden it, so wear builds at half rate until the next repair. Without that mod the option is hidden. This mod does not require it.
[*][b]Inspect Gear[/b]. A lesser power. Shows both counters, both tiers, and whether either is hardened.
[/list]

Wear is two counters, not a value on each item. Vanilla Papyrus cannot tag individual items.

[size=4][b]Requirements[/b][/size]
[list]
[*]Skyrim Special Edition or Anniversary Edition (1.5.97 or 1.6.x).
[*]No SKSE, no SkyUI, no DLC, no Creation Club.
[/list]

[size=4][b]Install[/b][/size]
FOMOD. Enable ScarredSteel.esp. It is ESL-flagged and overrides nothing.

[size=4][b]Settings[/b][/size]
[code]
set SCS_WeaponTier1 to 60
set SCS_WeaponTier2 to 150
set SCS_WeaponTier3 to 260
set SCS_ArmorTier1 to 40
set SCS_ArmorTier2 to 100
set SCS_ArmorTier3 to 180
set SCS_HitCooldown to 0.5
set SCS_FullRepairSkill to 30
[/code]

[size=4][b]The series[/b][/size]
Part of the Blackshield series. It does not edit Ember Smithing's items, and it does not replace Company Quartermaster's follower refit.

[url=https://github.com/Blackshield-Company/scarred-steel]Source and issues[/url].

Donations are optional. Nothing is gated.
[url=https://github.com/sponsors/synthalorian]GitHub Sponsors[/url] · [url=https://ko-fi.com/synthalorian]Ko-fi[/url]
```
