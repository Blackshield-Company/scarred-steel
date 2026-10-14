# Design notes (v0.2.0, early beta)

## Records (38, FormIDs 0x800-0x825, ESL-flagged, Skyrim.esm only, no overrides)

Nothing is placed in the world. No new cells. No vanilla record is edited.

| EditorID | FormID | Type | Purpose |
|---|---|---|---|
| `SCS_WearQuest` | 800 | QUST (Start Game Enabled, Run Once) | Controller (`SCS_WearScript`). Priority 30, QuestFormVersion 65. Alias 0 = player, forced to `PlayerRef` (000014), script `SCS_PlayerAliasScript`. In `SEQ/ScarredSteel.seq`. |
| `SCS_IntroShown` | 801 | GLOB | 1 after the intro has been shown. |
| `SCS_EmberPresent` | 802 | GLOB | 1 when `EmberSmithing.esp` is loaded. Set on init and on every load. |
| `SCS_WeaponWear` | 803 | GLOB | Read-only mirror of the weapon counter. Script writes it. Cap is `SCS_WeaponTier3`. |
| `SCS_ArmorWear` | 804 | GLOB | Read-only mirror of the armor counter. Cap is `SCS_ArmorTier3`. |
| `SCS_WeaponTierNow` | 805 | GLOB | Read-only mirror. 0 Keen, 1 Nicked, 2 Dulled, 3 Blunted. |
| `SCS_ArmorTierNow` | 806 | GLOB | Read-only mirror. 0 Sound, 1 Scuffed, 2 Dented, 3 Battered. |
| `SCS_WeaponHardened` | 807 | GLOB | 1 after an ember repair, until the next weapon repair. |
| `SCS_ArmorHardened` | 808 | GLOB | 1 after an ember repair, until the next armor repair. |
| `SCS_WeaponTier1` / `2` / `3` | 809 / 80A / 80B | GLOB | Thresholds 60 / 150 / 260. Tier 3 is also the cap. |
| `SCS_ArmorTier1` / `2` / `3` | 80C / 80D / 80E | GLOB | Thresholds 40 / 100 / 180. Tier 3 is also the cap. |
| `SCS_HitCooldown` | 80F | GLOB | 0.5 real seconds. Armor hits closer than this are ignored. |
| `SCS_FullRepairSkill` | 810 | GLOB | 30. Smithing at or above this clears the counter. |
| `SCS_EffWeaponNicked` / `Dulled` / `Blunted` | 811 / 812 / 813 | MGEF | Value Modifier, `AttackDamageMult`, flags Detrimental \| Recover \| NoDuration \| NoArea \| NoHitEvent. Magnitudes 0.05 / 0.12 / 0.20. |
| `SCS_EffArmorScuffed` / `Dented` / `Battered` | 814 / 815 / 816 | MGEF | Value Modifier, `DamageResist`, same flags. Magnitudes 15 / 40 / 80. |
| `SCS_AbWeaponNicked` / `Dulled` / `Blunted` | 817 / 818 / 819 | SPEL (ability) | One weapon penalty at a time. Constant, self. |
| `SCS_AbArmorScuffed` / `Dented` / `Battered` | 81A / 81B / 81C | SPEL (ability) | One armor penalty at a time. |
| `SCS_PowerEffect` | 81D | MGEF (script) | `SCS_PowerEffectScript`. Hidden, no magnitude, no duration. |
| `SCS_PowerInspect` | 81E | SPEL (lesser power) | "Inspect Gear". Voice equip type (`EquipType.Voice` 025BEE), same shape as CQM's power. |
| `SCS_MsgIntro` | 81F | MESG | Shown once. |
| `SCS_MsgRepairWeapon` / `Armor` | 820 / 821 | MESG | Repair, Ember repair, Not now. Ember button condition: `SCS_EmberPresent == 1`. Text args: wear, tier, full-repair skill (`%.0f`). |
| `SCS_MsgNoMats` | 822 | MESG | Notice. Arg: leather strip count. |
| `SCS_MsgNoEmberMats` | 823 | MESG | Notice. Arg: leather strip count. |
| `SCS_MsgStatus` | 824 | MESG | Inspect Gear. Args: weapon wear, weapon tier, armor wear, armor tier, weapon hardened, armor hardened, wear hints. Buttons: Ok; "Turn wear hints off" when `SCS_WearHints == 1`; "Turn wear hints on" when `SCS_WearHints == 0`. Conditioned-out buttons still count in `Show()`. |
| `SCS_WearHints` | 825 | GLOB | 1 (default) shows tier notices. 0 hides them. Toggled from Inspect Gear or the console. |

Vanilla records used (none edited): `PlayerRef` (000014), `EquipType.Voice` (025BEE), `ArmorCuirass` (06C0EC), `CraftingSmithingSharpeningWheel` (088108), `CraftingSmithingArmorTable` (0ADB78), `IngotIron` (05ACE4), `LeatherStrips` (0800E4), `Charcoal` (033760), `FireSalts` (03AD5E). Looked up in `_ref/fk/all.tsv`.

## Why two counters

Vanilla Papyrus cannot tag an individual inventory item and read that tag back later. There is no SKSE. Wear is therefore one weapon counter and one armor counter on the player, not a value on the sword or the cuirass. Swapping gear does not move the counter. The abilities are on the player, so enchantments, tempering, and Ember Smithing variants are never replaced.

## Events

`SCS_PlayerAliasScript` on the forced player alias:

- `RegisterForAnimationEvent` for `weaponSwing`, `weaponLeftSwing`, `arrowRelease`, renewed in `OnInit`, `OnPlayerLoadGame`, and `OnLocationChange`. Each renew unregisters first, then registers, because a graph reload drops the game-side registration.
- `OnAnimationEvent`: +1 weapon wear only if `player.IsInCombat()` and the event is one of those three.
- `OnHit`: count only if `(akSource as Weapon)` or `akProjectile`, and `WornHasKeyword(ArmorCuirass)`. Power attacks add 2. Hits less than `SCS_HitCooldown` real seconds apart are ignored (`Utility.GetCurrentRealTime()` compared to a saved float; no timer).
- `OnSit`: if the furniture base has `CraftingSmithingSharpeningWheel` and weapon wear > 0, the weapon repair menu. If it has `CraftingSmithingArmorTable` and armor wear > 0, the armor menu.

The quest holds the counters, the hardened skip flags (script variables, saved with the quest), the menus, and the abilities. The power's `OnEffectStart` calls `UsePower`.

## Tiers and repair

Tier is the highest threshold the counter has reached. Tier 0 has no ability. On a tier change the script removes the other abilities of that kind, adds the new one, and, if `SCS_WearHints` is not 0, shows one `Debug.Notification` ("Your blade is nicked (Nicked)", "dulling (Dulled)", "blunted (Blunted)", "keen again (Keen)", and the armor lines "scuffed (Scuffed)", "dented (Dented)", "battered (Battered)", "sound again (Sound)"). Repair notices are not gated.

A normal repair spends 1 iron ingot and 1 leather strips (weapon) or 2 leather strips (armor). If `GetActorValue("Smithing") >= SCS_FullRepairSkill` the counter becomes 0. Otherwise it is set to the threshold below the current tier (tier 3 → tier 2 threshold, tier 2 → tier 1 threshold, tier 1 or 0 → 0). Hardened is cleared.

Ember repair spends that plus 2 charcoal and 1 fire salts, always sets the counter to 0, and sets Hardened. While Hardened, the first qualifying event counts and the next is skipped, repeating, until the next repair of that kind. A skipped power attack adds nothing; a counted one still adds 2.

Conditioned-out message buttons keep their index in `Show()`, same as CQM, so Repair is 0, Ember repair is 1, Not now is 2 even when the ember button is hidden.

## Ember Smithing

`Form emb = Game.GetFormFromFile(0x803, "EmberSmithing.esp") ; soft: EMB_EmberForgedIronSword`, guarded with `If emb`. That sets `SCS_EmberPresent`. No master. The materials spent are vanilla.

## No polling

No `RegisterForUpdate`, `RegisterForSingleUpdate`, `OnUpdate`, or loop that waits on time. Swing wear is an animation event. Armor wear is `OnHit`. Repair is `OnSit`. Load and location change only re-register animation events and, on load, refresh the ember flag and the abilities.
