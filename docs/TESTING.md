# Testing checklist (v0.1.0, early beta)

Automated (every `./build.sh`):

- [x] Papyrus compiles.
- [x] Plugin validation: ESL range, Skyrim.esm only, no overrides, every form link resolves, script properties match their declarations, SEQ contents, byte-exact round trip.
- [x] FOMOD schema.

In game (not done yet; please help). The power is "Inspect Gear". Plugin FormIDs load as FE xxx 8xx: the quest is `SCS_WearQuest` (800) and the power is `SCS_PowerInspect` (81E).

1. **Start**
   - [ ] On a new game, you learn "Inspect Gear" and see the intro note once. Nothing new is standing in the world.
   - [ ] Save, load: the intro does not show again. The power is still there. `SCS_IntroShown` is 1.
2. **Weapon wear**
   - [ ] Out of combat, swing a weapon. `SCS_WeaponWear` stays 0.
   - [ ] In combat, a right swing, a left swing, and a bow shot each add 1. `getglobalvalue SCS_WeaponWear`.
   - [ ] At 60 / 150 / 260 the notice is "Your blade is nicked." / "dulled." / "blunted." The matching ability is the only weapon ability on you. Active effects show the penalty.
   - [ ] Further swings do not raise wear past 260. No second notice while the tier stays the same.
3. **Armor wear**
   - [ ] With no cuirass, weapon hits do not raise `SCS_ArmorWear`.
   - [ ] With a cuirass, a weapon hit or an arrow adds 1. A power attack adds 2. Two hits inside 0.5 real seconds count as one (`SCS_HitCooldown`).
   - [ ] At 40 / 100 / 180: "Your armor is scuffed." / "dented." / "battered." Armor rating drops by 15 / 40 / 80. Only one of those abilities is on you. Wear stops at 180.
4. **Inspect Gear**
   - [ ] The menu shows weapon wear, weapon tier, armor wear, armor tier, and both hardened flags, plus the tier names. The numbers match the globals.
5. **Repair**
   - [ ] Sit in a chair, or use a forge: no repair menu.
   - [ ] With weapon wear, use a grindstone: Repair / Ember repair / Not now. Not now changes nothing. Without Ember Smithing, Ember repair is absent and `SCS_EmberPresent` is 0.
   - [ ] Repair without 1 iron ingot and 1 leather strips: the notice, and wear unchanged.
   - [ ] Smithing below 30: a tier 2 weapon (wear 150 or more, below 260) goes to 60 and the notice is "Your blade is nicked." Hardened clears.
   - [ ] Smithing 30 or above: the counter goes to 0 and the notice is "Your blade is keen."
   - [ ] Workbench, with armor wear: 1 iron ingot and 2 leather strips. Same skill rule. Tier 1 goes to 0.
6. **Ember repair** (Ember Smithing installed)
   - [ ] `SCS_EmberPresent` is 1. The ember button is on both repair menus.
   - [ ] It spends the normal materials plus 2 charcoal and 1 fire salts. Missing any of them: the ember notice, nothing spent.
   - [ ] Wear goes to 0 even with Smithing below 30. That kind's Hardened global is 1. "Hardened until the next repair."
   - [ ] The next qualifying event counts, the one after does not, and so on, until a normal or ember repair of that kind.
7. **Load**
   - [ ] Save with wear and a tier ability. Load. Wear, tier, abilities, and Hardened match. No intro. No constant script lag (no update loop).
8. **Series** (optional)
   - [ ] With Ember Smithing, heat-tempered weapons and engraved armor are unchanged by repair. This mod adds no items.
   - [ ] With Company Quartermaster, Brynja's refit is still a follower buff. This mod does not change her or any follower.

When reporting a bug, include what you did and the Papyrus log lines containing `SCS_` (enable Papyrus logging in `Skyrim.ini`: `[Papyrus] bEnableLogging=1`, `bEnableTrace=1`).
