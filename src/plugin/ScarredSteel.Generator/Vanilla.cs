using Mutagen.Bethesda.Plugins;

namespace ScarredSteel.Generator;

/// <summary>
/// Skyrim.esm records this mod links to. FormIDs were looked up in _ref/fk/all.tsv.
/// Nothing here is overridden; the mod only references these.
/// </summary>
internal static class Vanilla
{
    public static readonly ModKey Skyrim = ModKey.FromFileName("Skyrim.esm");
    private static FormKey K(uint id) => new(Skyrim, id);

    public static readonly FormKey PlayerRef = K(0x000014);
    public static readonly FormKey EquipVoice = K(0x025BEE);

    public static readonly FormKey ArmorCuirass = K(0x06C0EC);
    public static readonly FormKey CraftingSmithingSharpeningWheel = K(0x088108);
    public static readonly FormKey CraftingSmithingArmorTable = K(0x0ADB78);

    public static readonly FormKey IngotIron = K(0x05ACE4);
    public static readonly FormKey LeatherStrips = K(0x0800E4);
    public static readonly FormKey Charcoal = K(0x033760);
    public static readonly FormKey FireSalts = K(0x03AD5E);
}
