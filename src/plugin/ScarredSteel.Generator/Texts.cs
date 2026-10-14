namespace ScarredSteel.Generator;

internal static class Texts
{
    public const string Intro =
        "SCARRED STEEL\n\n" +
        "Combat wears your weapon and your armor. Repair a weapon at a grindstone and armor at a workbench.\n\n" +
        "The lesser power Inspect Gear shows the current wear. Wear is one counter for weapons and one for armor, not a value on each item.";

    public const string RepairWeapon =
        "WEAPON REPAIR\n\n" +
        "Wear %.0f. Tier %.0f (0 Keen, 1 Nicked, 2 Dulled, 3 Blunted).\n\n" +
        "1 iron ingot and 1 leather strips. Smithing %.0f or higher clears it. Otherwise it drops one tier.\n\n" +
        "Ember repair also takes 2 charcoal and 1 fire salts. It clears the wear and hardens the weapon.";

    public const string RepairArmor =
        "ARMOR REPAIR\n\n" +
        "Wear %.0f. Tier %.0f (0 Sound, 1 Scuffed, 2 Dented, 3 Battered).\n\n" +
        "1 iron ingot and 2 leather strips. Smithing %.0f or higher clears it. Otherwise it drops one tier.\n\n" +
        "Ember repair also takes 2 charcoal and 1 fire salts. It clears the wear and hardens the armor.";

    public const string NoMats = "A repair takes 1 iron ingot and %.0f leather strips.";
    public const string NoEmberMats = "An ember repair takes 1 iron ingot, %.0f leather strips, 2 charcoal and 1 fire salts.";

    public const string Status =
        "INSPECT GEAR\n\n" +
        "Weapon wear %.0f, tier %.0f. Armor wear %.0f, tier %.0f.\n" +
        "Hardened: weapon %.0f, armor %.0f.\n\n" +
        "Weapon: 0 Keen, 1 Nicked, 2 Dulled, 3 Blunted.\n" +
        "Armor: 0 Sound, 1 Scuffed, 2 Dented, 3 Battered.\n" +
        "Hardened is 1 after an ember repair, until the next repair of that kind.\n" +
        "Wear hints: %.0f (1 on, 0 off).";
}
