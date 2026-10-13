using Modkit.Mutagen;
using Mutagen.Bethesda;
using Mutagen.Bethesda.Plugins;
using Mutagen.Bethesda.Plugins.Records;
using Mutagen.Bethesda.Skyrim;
using Noggog;
using static ScarredSteel.Generator.Vanilla;

namespace ScarredSteel.Generator;

internal sealed class Builder
{
    private readonly SkyrimMod _mod;
    private readonly FormIdRegistry _ids;
    private static readonly SkyrimRelease R = SkyrimRelease.SkyrimSE;
    private const byte VanillaQuestFormVersion = 65;
    public const int AliasPlayer = 0;

    public Builder(SkyrimMod mod, FormIdRegistry ids)
    {
        _mod = mod;
        _ids = ids;
    }

    private FormKey Id(string editorId) => _ids.Get(editorId);
    private static FormLink<T> L<T>(FormKey k) where T : class, IMajorRecordGetter => new(k);

    public void Build()
    {
        var qMain = Id("SCS_WearQuest");

        var gIntro = Global("SCS_IntroShown", 0);
        var gEmber = Global("SCS_EmberPresent", 0);
        var gWeaponWear = Global("SCS_WeaponWear", 0);
        var gArmorWear = Global("SCS_ArmorWear", 0);
        var gWeaponTierNow = Global("SCS_WeaponTierNow", 0);
        var gArmorTierNow = Global("SCS_ArmorTierNow", 0);
        var gWeaponHard = Global("SCS_WeaponHardened", 0);
        var gArmorHard = Global("SCS_ArmorHardened", 0);
        var gWeaponT1 = Global("SCS_WeaponTier1", 60);
        var gWeaponT2 = Global("SCS_WeaponTier2", 150);
        var gWeaponT3 = Global("SCS_WeaponTier3", 260);
        var gArmorT1 = Global("SCS_ArmorTier1", 40);
        var gArmorT2 = Global("SCS_ArmorTier2", 100);
        var gArmorT3 = Global("SCS_ArmorTier3", 180);
        var gCooldown = Global("SCS_HitCooldown", 0.5f);
        var gSkill = Global("SCS_FullRepairSkill", 30);

        var effNicked = Penalty("SCS_EffWeaponNicked", "Nicked", ActorValue.AttackDamageMult, "Weapon attacks do 5% less damage.");
        var effDulled = Penalty("SCS_EffWeaponDulled", "Dulled", ActorValue.AttackDamageMult, "Weapon attacks do 12% less damage.");
        var effBlunted = Penalty("SCS_EffWeaponBlunted", "Blunted", ActorValue.AttackDamageMult, "Weapon attacks do 20% less damage.");
        var effScuffed = Penalty("SCS_EffArmorScuffed", "Scuffed", ActorValue.DamageResist, "Armor rating is reduced by 15.");
        var effDented = Penalty("SCS_EffArmorDented", "Dented", ActorValue.DamageResist, "Armor rating is reduced by 40.");
        var effBattered = Penalty("SCS_EffArmorBattered", "Battered", ActorValue.DamageResist, "Armor rating is reduced by 80.");

        var abNicked = Ability("SCS_AbWeaponNicked", "Nicked", "The blade is nicked. Weapon attacks do 5% less damage.", effNicked, 0.05f);
        var abDulled = Ability("SCS_AbWeaponDulled", "Dulled", "The blade is dulled. Weapon attacks do 12% less damage.", effDulled, 0.12f);
        var abBlunted = Ability("SCS_AbWeaponBlunted", "Blunted", "The blade is blunted. Weapon attacks do 20% less damage.", effBlunted, 0.20f);
        var abScuffed = Ability("SCS_AbArmorScuffed", "Scuffed", "The armor is scuffed. Armor rating is reduced by 15.", effScuffed, 15f);
        var abDented = Ability("SCS_AbArmorDented", "Dented", "The armor is dented. Armor rating is reduced by 40.", effDented, 40f);
        var abBattered = Ability("SCS_AbArmorBattered", "Battered", "The armor is battered. Armor rating is reduced by 80.", effBattered, 80f);

        var mgefPower = Add(new MagicEffect(Id("SCS_PowerEffect"), R)
        {
            EditorID = "SCS_PowerEffect",
            Name = "Inspect Gear",
            Flags = MagicEffect.Flag.NoDuration | MagicEffect.Flag.NoMagnitude | MagicEffect.Flag.NoArea
                    | MagicEffect.Flag.Painless | MagicEffect.Flag.NoHitEvent | MagicEffect.Flag.HideInUI,
            MagicSkill = ActorValue.None, ResistValue = ActorValue.None, SecondActorValue = ActorValue.None,
            Archetype = new MagicEffectArchetype { Type = MagicEffectArchetype.TypeEnum.Script, ActorValue = ActorValue.None },
            CastType = CastType.FireAndForget,
            TargetType = TargetType.Self,
            CastingSoundLevel = SoundLevel.Normal,
            Description = "See the wear on your weapon and armor.",
            VirtualMachineAdapter = Vmad.Adapter(Vmad.Script("SCS_PowerEffectScript", Vmad.Obj("Wear", qMain))),
        });
        var power = Add(new Spell(Id("SCS_PowerInspect"), R)
        {
            EditorID = "SCS_PowerInspect",
            Name = "Inspect Gear",
            Description = "See the wear on your weapon and armor.",
            Type = SpellType.LesserPower,
            CastType = CastType.FireAndForget,
            TargetType = TargetType.Self,
            Flags = SpellDataFlag.ManualCostCalc | SpellDataFlag.NoAbsorbOrReflect,
            EquipmentType = L<IEquipTypeGetter>(EquipVoice).AsNullable(),
            Effects = { Fx(mgefPower.FormKey, 0, 0) },
        });

        var msgIntro = Msg("SCS_MsgIntro", Texts.Intro, Btn("Ok"));
        var msgRepairW = Msg("SCS_MsgRepairWeapon", Texts.RepairWeapon, Btn("Repair"), EmberBtn(gEmber), Btn("Not now"));
        var msgRepairA = Msg("SCS_MsgRepairArmor", Texts.RepairArmor, Btn("Repair"), EmberBtn(gEmber), Btn("Not now"));
        var msgNoMats = Notice("SCS_MsgNoMats", Texts.NoMats);
        var msgNoEmber = Notice("SCS_MsgNoEmberMats", Texts.NoEmberMats);
        var msgStatus = Msg("SCS_MsgStatus", Texts.Status, Btn("Ok"));

        var quest = Add(new Quest(qMain, R)
        {
            EditorID = "SCS_WearQuest",
            Name = "Scarred Steel",
            Flags = Quest.Flag.StartGameEnabled | Quest.Flag.RunOnce,
            Priority = 30,
            Type = Quest.TypeEnum.None,
            QuestFormVersion = VanillaQuestFormVersion,
        });
        quest.Aliases.Add(new QuestAlias
        {
            ID = AliasPlayer,
            Type = QuestAlias.TypeEnum.Reference,
            Name = "Player",
            ForcedReference = new FormLinkNullable<IPlacedGetter>(PlayerRef),
        });
        quest.NextAliasID = 1;
        quest.VirtualMachineAdapter = Vmad.QuestAdapter(Vmad.Script("SCS_WearScript",
                Vmad.Obj("SCS_IntroShown", gIntro), Vmad.Obj("SCS_EmberPresent", gEmber),
                Vmad.Obj("SCS_WeaponWear", gWeaponWear), Vmad.Obj("SCS_ArmorWear", gArmorWear),
                Vmad.Obj("SCS_WeaponTierNow", gWeaponTierNow), Vmad.Obj("SCS_ArmorTierNow", gArmorTierNow),
                Vmad.Obj("SCS_WeaponHardened", gWeaponHard), Vmad.Obj("SCS_ArmorHardened", gArmorHard),
                Vmad.Obj("SCS_WeaponTier1", gWeaponT1), Vmad.Obj("SCS_WeaponTier2", gWeaponT2), Vmad.Obj("SCS_WeaponTier3", gWeaponT3),
                Vmad.Obj("SCS_ArmorTier1", gArmorT1), Vmad.Obj("SCS_ArmorTier2", gArmorT2), Vmad.Obj("SCS_ArmorTier3", gArmorT3),
                Vmad.Obj("SCS_FullRepairSkill", gSkill),
                Vmad.Obj("SCS_PowerInspect", power.FormKey),
                Vmad.Obj("SCS_AbWeaponNicked", abNicked), Vmad.Obj("SCS_AbWeaponDulled", abDulled), Vmad.Obj("SCS_AbWeaponBlunted", abBlunted),
                Vmad.Obj("SCS_AbArmorScuffed", abScuffed), Vmad.Obj("SCS_AbArmorDented", abDented), Vmad.Obj("SCS_AbArmorBattered", abBattered),
                Vmad.Obj("SCS_MsgIntro", msgIntro), Vmad.Obj("SCS_MsgRepairWeapon", msgRepairW), Vmad.Obj("SCS_MsgRepairArmor", msgRepairA),
                Vmad.Obj("SCS_MsgNoMats", msgNoMats), Vmad.Obj("SCS_MsgNoEmberMats", msgNoEmber), Vmad.Obj("SCS_MsgStatus", msgStatus),
                Vmad.Obj("IngotIron", IngotIron), Vmad.Obj("LeatherStrips", LeatherStrips),
                Vmad.Obj("Charcoal", Charcoal), Vmad.Obj("FireSalts", FireSalts)))
            .WithAliasScripts(qMain, AliasPlayer, Vmad.Script("SCS_PlayerAliasScript",
                Vmad.Obj("Wear", qMain),
                Vmad.Obj("ArmorCuirass", ArmorCuirass),
                Vmad.Obj("CraftingSmithingSharpeningWheel", CraftingSmithingSharpeningWheel),
                Vmad.Obj("CraftingSmithingArmorTable", CraftingSmithingArmorTable),
                Vmad.Obj("SCS_HitCooldown", gCooldown),
                Vmad.Obj("SCS_WeaponWear", gWeaponWear),
                Vmad.Obj("SCS_ArmorWear", gArmorWear)));
    }

    private MessageButton EmberBtn(FormKey ember)
    {
        var b = Btn("Ember repair");
        b.Conditions.Add(Cond.Global(ember, CompareOperator.EqualTo, 1));
        return b;
    }

    private T Add<T>(T record) where T : SkyrimMajorRecord
    {
        _mod.GetTopLevelGroup<T>().Add(record);
        return record;
    }

    private FormKey Global(string edid, float value)
    {
        var g = new GlobalFloat(Id(edid), R) { EditorID = edid, Data = value };
        _mod.Globals.Add(g);
        return g.FormKey;
    }

    private FormKey Penalty(string edid, string name, ActorValue av, string description)
    {
        var m = new MagicEffect(Id(edid), R)
        {
            EditorID = edid,
            Name = name,
            Flags = MagicEffect.Flag.Detrimental | MagicEffect.Flag.Recover
                    | MagicEffect.Flag.NoDuration | MagicEffect.Flag.NoArea | MagicEffect.Flag.NoHitEvent,
            MagicSkill = ActorValue.None, ResistValue = ActorValue.None, SecondActorValue = ActorValue.None,
            Archetype = new MagicEffectArchetype { Type = MagicEffectArchetype.TypeEnum.ValueModifier, ActorValue = av },
            CastType = CastType.ConstantEffect,
            TargetType = TargetType.Self,
            CastingSoundLevel = SoundLevel.Normal,
            Description = description,
        };
        _mod.MagicEffects.Add(m);
        return m.FormKey;
    }

    private FormKey Ability(string edid, string name, string description, FormKey effect, float magnitude)
    {
        var spell = Add(new Spell(Id(edid), R)
        {
            EditorID = edid,
            Name = name,
            Description = description,
            Type = SpellType.Ability,
            CastType = CastType.ConstantEffect,
            TargetType = TargetType.Self,
            Flags = SpellDataFlag.ManualCostCalc | SpellDataFlag.NoAbsorbOrReflect,
            Effects = { Fx(effect, magnitude, 0) },
        });
        return spell.FormKey;
    }

    private static Effect Fx(FormKey mgef, float magnitude, int duration) => new()
    {
        BaseEffect = new FormLinkNullable<IMagicEffectGetter>(mgef),
        Data = new EffectData { Magnitude = magnitude, Area = 0, Duration = duration },
    };

    private static MessageButton Btn(string text) => new() { Text = text };

    private FormKey Msg(string edid, string text, params MessageButton[] buttons)
    {
        var m = new Message(Id(edid), R)
        {
            EditorID = edid,
            Description = text,
            Flags = Message.Flag.MessageBox,
            INAM = new byte[4],
        };
        m.MenuButtons.AddRange(buttons);
        _mod.Messages.Add(m);
        return m.FormKey;
    }

    private FormKey Notice(string edid, string text)
    {
        var m = new Message(Id(edid), R) { EditorID = edid, Description = text, Flags = 0, DisplayTime = 2, INAM = new byte[4] };
        _mod.Messages.Add(m);
        return m.FormKey;
    }
}
