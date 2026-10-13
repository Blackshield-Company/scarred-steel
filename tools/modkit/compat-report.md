# Compatibility report

16 plugins loaded together with Mutagen 0.54.4.0.

## Load order (simulated)

| # | Plugin | ESL | Masters | New records | Overrides | Runtime FormIDs |
|---|---|---|---|---|---|---|
| 1 | BlackshieldCompany.esp | yes | Skyrim.esm | 54 | 0 | FE000800-FE000835 |
| 2 | BountiesOfOblivion.esp | yes | Skyrim.esm | 81 | 0 | FE001800-FE001850 |
| 3 | ContractHunter.esp | yes | Skyrim.esm | 87 | 0 | FE002800-FE002856 |
| 4 | SteelOath.esp | yes | Skyrim.esm | 56 | 0 | FE003800-FE003837 |
| 5 | EmberSmithing.esp | yes | Skyrim.esm | 537 | 0 | FE004800-FE004A18 |
| 6 | GrayManeDebt.esp | yes | Skyrim.esm | 56 | 0 | FE005800-FE005837 |
| 7 | BlackshieldCodex.esp | yes | Skyrim.esm, BlackshieldCompany.esp, BountiesOfOblivion.esp, ContractHunter.esp, SteelOath.esp, EmberSmithing.esp | 45 | 0 | FE006800-FE00682C |
| 8 | WarBanners.esp | yes | Skyrim.esm | 39 | 0 | FE007800-FE007826 |
| 9 | Roadwarden.esp | yes | Skyrim.esm | 53 | 0 | FE008800-FE008834 |
| 10 | SellswordRoster.esp | yes | Skyrim.esm | 60 | 0 | FE009800-FE00983B |
| 11 | TurncoatContract.esp | yes | Skyrim.esm | 69 | 0 | FE00A800-FE00A844 |
| 12 | LedgerOfAsh.esp | yes | Skyrim.esm | 65 | 0 | FE00B800-FE00B840 |
| 13 | OathbreakersPrice.esp | yes | Skyrim.esm | 61 | 0 | FE00C800-FE00C83C |
| 14 | ChampionsReforge.esp | yes | Skyrim.esm | 68 | 0 | FE00D800-FE00D843 |
| 15 | BarrowIronPact.esp | yes | Skyrim.esm | 63 | 0 | FE00E800-FE00E83E |
| 16 | CompanyQuartermaster.esp | yes | Skyrim.esm | 72 | 0 | FE00F800-FE00F847 |

1466 new records; every simulated runtime FormID is unique.

## Overrides of existing records

None. No plugin in the set overrides a vanilla record or another plugin's record.

## EditorIDs and prefixes

| Plugin | Prefix | EditorIDs | Off-prefix |
|---|---|---|---|
| BlackshieldCompany.esp | `BSC_` | 54 | 0 |
| BountiesOfOblivion.esp | `BOO_` | 81 | 0 |
| ContractHunter.esp | `CHT_` | 87 | 0 |
| SteelOath.esp | `SOT_` | 56 | 0 |
| EmberSmithing.esp | `EMB_` | 537 | 0 |
| GrayManeDebt.esp | `GMD_` | 56 | 0 |
| BlackshieldCodex.esp | `BCX_` | 45 | 0 |
| WarBanners.esp | `WBN_` | 39 | 0 |
| Roadwarden.esp | `RWD_` | 53 | 0 |
| SellswordRoster.esp | `SSR_` | 60 | 0 |
| TurncoatContract.esp | `TTC_` | 69 | 0 |
| LedgerOfAsh.esp | `LOA_` | 65 | 0 |
| OathbreakersPrice.esp | `OBP_` | 61 | 0 |
| ChampionsReforge.esp | `CRF_` | 68 | 0 |
| BarrowIronPact.esp | `BIP_` | 63 | 0 |
| CompanyQuartermaster.esp | `CQM_` | 72 | 0 |

1466 EditorIDs across the set; collisions: 0.

## Globals

| Plugin | Globals |
|---|---|
| BlackshieldCompany.esp | 9 |
| BountiesOfOblivion.esp | 16 |
| ContractHunter.esp | 21 |
| SteelOath.esp | 20 |
| EmberSmithing.esp | 0 |
| GrayManeDebt.esp | 5 |
| BlackshieldCodex.esp | 9 |
| WarBanners.esp | 9 |
| Roadwarden.esp | 27 |
| SellswordRoster.esp | 17 |
| TurncoatContract.esp | 8 |
| LedgerOfAsh.esp | 7 |
| OathbreakersPrice.esp | 6 |
| ChampionsReforge.esp | 8 |
| BarrowIronPact.esp | 6 |
| CompanyQuartermaster.esp | 12 |

180 globals in total, no two with the same EditorID.

## Papyrus scripts

| Plugin | Scripts (attached + shipped .pex) |
|---|---|
| BlackshieldCompany.esp | 6 |
| BountiesOfOblivion.esp | 5 |
| ContractHunter.esp | 6 |
| SteelOath.esp | 3 |
| EmberSmithing.esp | 0 |
| GrayManeDebt.esp | 16 |
| BlackshieldCodex.esp | 2 |
| WarBanners.esp | 4 |
| Roadwarden.esp | 2 |
| SellswordRoster.esp | 4 |
| TurncoatContract.esp | 14 |
| LedgerOfAsh.esp | 13 |
| OathbreakersPrice.esp | 13 |
| ChampionsReforge.esp | 13 |
| BarrowIronPact.esp | 14 |
| CompanyQuartermaster.esp | 3 |

118 distinct script names; duplicates: 0.

## Links between plugins in the set

- BlackshieldCodex.esp -> EmberSmithing.esp: MagicEffect EMB_EmberEngravingEffect
- BlackshieldCodex.esp -> EmberSmithing.esp: MagicEffect EMB_HearthEngravingEffect
- BlackshieldCodex.esp -> EmberSmithing.esp: MagicEffect EMB_BellowsEngravingEffect
- BlackshieldCodex.esp -> BlackshieldCompany.esp: ObjectEffect BSC_EnchBladeEmber
- BlackshieldCodex.esp -> BlackshieldCompany.esp: Weapon BSC_BlackshieldBlade
- BlackshieldCodex.esp -> BlackshieldCompany.esp: Armor BSC_BlackshieldShield
- BlackshieldCodex.esp -> BlackshieldCompany.esp: Armor BSC_BlackshieldPlate
- BlackshieldCodex.esp -> BlackshieldCompany.esp: Quest BSC_CompanyQuest
- BlackshieldCodex.esp -> BlackshieldCompany.esp: GlobalFloat BSC_ContractActive
- BlackshieldCodex.esp -> BlackshieldCompany.esp: GlobalFloat BSC_ContractsDone
- BlackshieldCodex.esp -> SteelOath.esp: GlobalFloat SOT_ActiveSteel
- BlackshieldCodex.esp -> SteelOath.esp: GlobalFloat SOT_ActiveShield
- BlackshieldCodex.esp -> SteelOath.esp: GlobalFloat SOT_ActiveIron
- BlackshieldCodex.esp -> SteelOath.esp: GlobalFloat SOT_ActiveEndurance
- BlackshieldCodex.esp -> SteelOath.esp: GlobalFloat SOT_ActiveClose
- BlackshieldCodex.esp -> ContractHunter.esp: Quest CHT_HunterQuest
- BlackshieldCodex.esp -> ContractHunter.esp: GlobalFloat CHT_BountiesClaimed
- BlackshieldCodex.esp -> ContractHunter.esp: GlobalFloat CHT_PayMult
- BlackshieldCodex.esp -> ContractHunter.esp: GlobalFloat CHT_OpenNotice
- BlackshieldCodex.esp -> ContractHunter.esp: GlobalFloat CHT_OpenWanted
- BlackshieldCodex.esp -> ContractHunter.esp: GlobalFloat CHT_OpenDread
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorDagon
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorBoethiah
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorNamira
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorMolagBal
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorClavicus
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorHircine
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorSanguine
- BlackshieldCodex.esp -> BountiesOfOblivion.esp: GlobalFloat BOO_FavorVaermina

## Soft references (Game.GetFormFromFile)

| Plugin | Script | Target | Result |
|---|---|---|---|
| SteelOath.esp | SOT_OathScript.psc:452 | Dawnguard.esm 000800 | plugin not in set: returns None, guarded |
| SteelOath.esp | SOT_OathScript.psc:456 | Dawnguard.esm 007C25 | plugin not in set: returns None, guarded |
| TurncoatContract.esp | TTC_SeriesScript.psc:20 | BlackshieldCompany.esp 000805 (BSC_Rank) | resolves: GlobalFloat BSC_Rank |
| TurncoatContract.esp | TTC_SeriesScript.psc:26 | SteelOath.esp 00080C (SOT_ActiveCount) | resolves: GlobalFloat SOT_ActiveCount |
| TurncoatContract.esp | TTC_SeriesScript.psc:32 | ContractHunter.esp 00081B (CHT_OpenCount) | resolves: GlobalFloat CHT_OpenCount |
| LedgerOfAsh.esp | LOA_SeriesScript.psc:19 | BountiesOfOblivion.esp 00080B (BOO_ContractsDone) | resolves: GlobalFloat BOO_ContractsDone |
| LedgerOfAsh.esp | LOA_SeriesScript.psc:25 | TurncoatContract.esp 000802 (TTC_State) | resolves: GlobalFloat TTC_State |
| OathbreakersPrice.esp | OBP_SeriesScript.psc:19 | SteelOath.esp 00080C (SOT_ActiveCount) | resolves: GlobalFloat SOT_ActiveCount |
| OathbreakersPrice.esp | OBP_SeriesScript.psc:25 | ContractHunter.esp 00081C (CHT_BountiesClaimed) | resolves: GlobalFloat CHT_BountiesClaimed |
| ChampionsReforge.esp | CRF_SeriesScript.psc:18 | EmberSmithing.esp 000800 (EMB_HeatTemperedIronSword) | resolves: Weapon EMB_HeatTemperedIronSword |
| ChampionsReforge.esp | CRF_SeriesScript.psc:24 | GrayManeDebt.esp 000802 (GMD_State) | resolves: GlobalFloat GMD_State |
| ChampionsReforge.esp | CRF_TemperScript.psc:53 | ccffbsse001-imperialdragon.esl 000D69 | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:63 | ccffbsse001-imperialdragon.esl 000D68 | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:67 | ccffbsse001-imperialdragon.esl 00084D | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:71 | ccffbsse001-imperialdragon.esl 000848 | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:75 | ccffbsse001-imperialdragon.esl 00084A | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:80 | ccffbsse001-imperialdragon.esl 00084C | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:84 | ccffbsse001-imperialdragon.esl 000849 | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:88 | ccffbsse001-imperialdragon.esl 000D6A | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:92 | ccffbsse001-imperialdragon.esl 000D6B | plugin not in set: returns None, guarded |
| ChampionsReforge.esp | CRF_TemperScript.psc:96 | ccffbsse001-imperialdragon.esl 000D6C | plugin not in set: returns None, guarded |
| BarrowIronPact.esp | BIP_SeriesScript.psc:18 | GrayManeDebt.esp 000802 (GMD_State) | resolves: GlobalFloat GMD_State |
| BarrowIronPact.esp | BIP_SeriesScript.psc:24 | Roadwarden.esp 00081A (RWD_EncounterCount) | resolves: GlobalFloat RWD_EncounterCount |
| CompanyQuartermaster.esp | CQM_QuartermasterScript.psc:115 | EmberSmithing.esp 000803 (EMB_EmberForgedIronSword) | resolves: Weapon EMB_EmberForgedIronSword |

12 soft reference(s) resolve inside the set; 12 point at plugins not in the set (skipped at runtime).

## Installed files

309 distinct installed paths across 16 archives; collisions: 0.

## Result

**PASS**: no errors.
