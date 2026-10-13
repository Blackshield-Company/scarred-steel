Scriptname SCS_WearScript extends Quest
{Scarred Steel - player weapon and armor wear. One counter each, not per item.
Menus come from the lesser power and from OnSit. Wear comes from alias events.
No RegisterForUpdate. No timer. No loop waiting on time.}

GlobalVariable Property SCS_IntroShown Auto
GlobalVariable Property SCS_EmberPresent Auto
GlobalVariable Property SCS_WeaponWear Auto
GlobalVariable Property SCS_ArmorWear Auto
GlobalVariable Property SCS_WeaponTierNow Auto
GlobalVariable Property SCS_ArmorTierNow Auto
GlobalVariable Property SCS_WeaponHardened Auto
GlobalVariable Property SCS_ArmorHardened Auto
GlobalVariable Property SCS_WeaponTier1 Auto
GlobalVariable Property SCS_WeaponTier2 Auto
GlobalVariable Property SCS_WeaponTier3 Auto
GlobalVariable Property SCS_ArmorTier1 Auto
GlobalVariable Property SCS_ArmorTier2 Auto
GlobalVariable Property SCS_ArmorTier3 Auto
GlobalVariable Property SCS_FullRepairSkill Auto

Spell Property SCS_PowerInspect Auto
Spell Property SCS_AbWeaponNicked Auto
Spell Property SCS_AbWeaponDulled Auto
Spell Property SCS_AbWeaponBlunted Auto
Spell Property SCS_AbArmorScuffed Auto
Spell Property SCS_AbArmorDented Auto
Spell Property SCS_AbArmorBattered Auto

Message Property SCS_MsgIntro Auto
Message Property SCS_MsgRepairWeapon Auto
Message Property SCS_MsgRepairArmor Auto
Message Property SCS_MsgNoMats Auto
Message Property SCS_MsgNoEmberMats Auto
Message Property SCS_MsgStatus Auto

MiscObject Property IngotIron Auto
MiscObject Property LeatherStrips Auto
MiscObject Property Charcoal Auto
Ingredient Property FireSalts Auto

Bool weaponSkip
Bool armorSkip

Event OnInit()
	GameLoaded()
EndEvent

Function GameLoaded()
	CheckEmber()
	EnsurePower()
	Sync(False)
EndFunction

; Presence only. Ember repair spends vanilla charcoal and fire salts.
Function CheckEmber()
	Form emb = Game.GetFormFromFile(0x803, "EmberSmithing.esp") ; soft: EMB_EmberForgedIronSword
	If emb
		SCS_EmberPresent.SetValueInt(1)
	Else
		SCS_EmberPresent.SetValueInt(0)
	EndIf
EndFunction

Function EnsurePower()
	Actor player = Game.GetPlayer()
	If !player
		Return
	EndIf
	If !player.HasSpell(SCS_PowerInspect)
		player.AddSpell(SCS_PowerInspect, False)
	EndIf
	If SCS_IntroShown.GetValueInt() == 0
		SCS_IntroShown.SetValueInt(1)
		SCS_MsgIntro.Show()
		Debug.Trace("[ScarredSteel] SCS_ intro shown")
	EndIf
EndFunction

; Called by the lesser power.
Function UsePower()
	Sync(False)
	SCS_MsgStatus.Show(SCS_WeaponWear.GetValue(), SCS_WeaponTierNow.GetValue(), SCS_ArmorWear.GetValue(), SCS_ArmorTierNow.GetValue(), SCS_WeaponHardened.GetValue(), SCS_ArmorHardened.GetValue())
EndFunction

Function AddWeaponWear(Int amount)
	If amount < 1
		Return
	EndIf
	If SCS_WeaponHardened.GetValueInt() == 1
		If weaponSkip
			weaponSkip = False
			Return
		EndIf
		weaponSkip = True
	Else
		weaponSkip = False
	EndIf
	Bump(True, amount)
EndFunction

Function AddArmorWear(Int amount)
	If amount < 1
		Return
	EndIf
	If SCS_ArmorHardened.GetValueInt() == 1
		If armorSkip
			armorSkip = False
			Return
		EndIf
		armorSkip = True
	Else
		armorSkip = False
	EndIf
	Bump(False, amount)
EndFunction

Function OfferWeaponRepair()
	OfferRepair(True)
EndFunction

Function OfferArmorRepair()
	OfferRepair(False)
EndFunction

Function OfferRepair(Bool weapon)
	Float wear = WearValue(weapon)
	If wear <= 0.0
		Return
	EndIf
	Int tier = TierOf(weapon, wear)
	Int choice = -1
	If weapon
		choice = SCS_MsgRepairWeapon.Show(wear, tier as Float, SCS_FullRepairSkill.GetValue())
	Else
		choice = SCS_MsgRepairArmor.Show(wear, tier as Float, SCS_FullRepairSkill.GetValue())
	EndIf
	If choice == 0
		DoRepair(weapon, False)
	ElseIf choice == 1
		DoRepair(weapon, True)
	EndIf
EndFunction

Function DoRepair(Bool weapon, Bool ember)
	Actor player = Game.GetPlayer()
	If !player
		Return
	EndIf
	Int strips = 1
	If !weapon
		strips = 2
	EndIf
	If ember
		If player.GetItemCount(IngotIron) < 1 || player.GetItemCount(LeatherStrips) < strips || player.GetItemCount(Charcoal) < 2 || player.GetItemCount(FireSalts) < 1
			SCS_MsgNoEmberMats.Show(strips as Float)
			Return
		EndIf
	Else
		If player.GetItemCount(IngotIron) < 1 || player.GetItemCount(LeatherStrips) < strips
			SCS_MsgNoMats.Show(strips as Float)
			Return
		EndIf
	EndIf
	player.RemoveItem(IngotIron, 1, True)
	player.RemoveItem(LeatherStrips, strips, True)
	If ember
		player.RemoveItem(Charcoal, 2, True)
		player.RemoveItem(FireSalts, 1, True)
	EndIf
	Float newWear = 0.0
	If !ember
		If player.GetActorValue("Smithing") < SCS_FullRepairSkill.GetValue()
			newWear = StepDown(weapon, TierOf(weapon, WearValue(weapon)))
		EndIf
	EndIf
	If weapon
		weaponSkip = False
		If ember
			SCS_WeaponHardened.SetValueInt(1)
		Else
			SCS_WeaponHardened.SetValueInt(0)
		EndIf
	Else
		armorSkip = False
		If ember
			SCS_ArmorHardened.SetValueInt(1)
		Else
			SCS_ArmorHardened.SetValueInt(0)
		EndIf
	EndIf
	Int tierBefore = TierOf(weapon, WearValue(weapon))
	Commit(weapon, newWear, True)
	If ember
		Debug.Notification("Hardened until the next repair.")
		Debug.Trace("[ScarredSteel] SCS_ ember repair")
	ElseIf TierOf(weapon, WearValue(weapon)) == tierBefore
		Debug.Notification("Repaired.")
		Debug.Trace("[ScarredSteel] SCS_ repair")
	Else
		Debug.Trace("[ScarredSteel] SCS_ repair")
	EndIf
EndFunction

Function Bump(Bool weapon, Int amount)
	Commit(weapon, WearValue(weapon) + amount, True)
EndFunction

Function Sync(Bool notify)
	Commit(True, SCS_WeaponWear.GetValue(), notify)
	Commit(False, SCS_ArmorWear.GetValue(), notify)
EndFunction

Function Commit(Bool weapon, Float wear, Bool notify)
	Float before = WearValue(weapon)
	Int tierBefore = TierOf(weapon, before)
	Float cap = CapOf(weapon)
	If wear < 0.0
		wear = 0.0
	EndIf
	If wear > cap
		wear = cap
	EndIf
	WearGlobal(weapon).SetValue(wear)
	Int tier = TierOf(weapon, wear)
	TierGlobal(weapon).SetValue(tier as Float)
	If weapon
		ApplyWeaponTier(tier)
	Else
		ApplyArmorTier(tier)
	EndIf
	If notify && tier != tierBefore
		NotifyTier(weapon, tier)
		Debug.Trace("[ScarredSteel] SCS_ tier " + tier)
	EndIf
EndFunction

Float Function WearValue(Bool weapon)
	If weapon
		Return SCS_WeaponWear.GetValue()
	EndIf
	Return SCS_ArmorWear.GetValue()
EndFunction

GlobalVariable Function WearGlobal(Bool weapon)
	If weapon
		Return SCS_WeaponWear
	EndIf
	Return SCS_ArmorWear
EndFunction

GlobalVariable Function TierGlobal(Bool weapon)
	If weapon
		Return SCS_WeaponTierNow
	EndIf
	Return SCS_ArmorTierNow
EndFunction

Float Function CapOf(Bool weapon)
	Float cap = SCS_ArmorTier3.GetValue()
	If weapon
		cap = SCS_WeaponTier3.GetValue()
	EndIf
	If cap < 0.0
		cap = 0.0
	EndIf
	Return cap
EndFunction

Int Function TierOf(Bool weapon, Float wear)
	Float t1
	Float t2
	Float t3
	If weapon
		t1 = SCS_WeaponTier1.GetValue()
		t2 = SCS_WeaponTier2.GetValue()
		t3 = SCS_WeaponTier3.GetValue()
	Else
		t1 = SCS_ArmorTier1.GetValue()
		t2 = SCS_ArmorTier2.GetValue()
		t3 = SCS_ArmorTier3.GetValue()
	EndIf
	If wear >= t3
		Return 3
	EndIf
	If wear >= t2
		Return 2
	EndIf
	If wear >= t1
		Return 1
	EndIf
	Return 0
EndFunction

Float Function StepDown(Bool weapon, Int tier)
	If tier <= 1
		Return 0.0
	EndIf
	If weapon
		If tier == 2
			Return SCS_WeaponTier1.GetValue()
		EndIf
		Return SCS_WeaponTier2.GetValue()
	EndIf
	If tier == 2
		Return SCS_ArmorTier1.GetValue()
	EndIf
	Return SCS_ArmorTier2.GetValue()
EndFunction

Function ApplyWeaponTier(Int tier)
	Actor player = Game.GetPlayer()
	If !player
		Return
	EndIf
	If tier != 1
		player.RemoveSpell(SCS_AbWeaponNicked)
	EndIf
	If tier != 2
		player.RemoveSpell(SCS_AbWeaponDulled)
	EndIf
	If tier != 3
		player.RemoveSpell(SCS_AbWeaponBlunted)
	EndIf
	If tier == 1 && !player.HasSpell(SCS_AbWeaponNicked)
		player.AddSpell(SCS_AbWeaponNicked, False)
	ElseIf tier == 2 && !player.HasSpell(SCS_AbWeaponDulled)
		player.AddSpell(SCS_AbWeaponDulled, False)
	ElseIf tier == 3 && !player.HasSpell(SCS_AbWeaponBlunted)
		player.AddSpell(SCS_AbWeaponBlunted, False)
	EndIf
EndFunction

Function ApplyArmorTier(Int tier)
	Actor player = Game.GetPlayer()
	If !player
		Return
	EndIf
	If tier != 1
		player.RemoveSpell(SCS_AbArmorScuffed)
	EndIf
	If tier != 2
		player.RemoveSpell(SCS_AbArmorDented)
	EndIf
	If tier != 3
		player.RemoveSpell(SCS_AbArmorBattered)
	EndIf
	If tier == 1 && !player.HasSpell(SCS_AbArmorScuffed)
		player.AddSpell(SCS_AbArmorScuffed, False)
	ElseIf tier == 2 && !player.HasSpell(SCS_AbArmorDented)
		player.AddSpell(SCS_AbArmorDented, False)
	ElseIf tier == 3 && !player.HasSpell(SCS_AbArmorBattered)
		player.AddSpell(SCS_AbArmorBattered, False)
	EndIf
EndFunction

Function NotifyTier(Bool weapon, Int tier)
	If weapon
		If tier == 1
			Debug.Notification("Your blade is nicked.")
		ElseIf tier == 2
			Debug.Notification("Your blade is dulled.")
		ElseIf tier >= 3
			Debug.Notification("Your blade is blunted.")
		Else
			Debug.Notification("Your blade is keen.")
		EndIf
	Else
		If tier == 1
			Debug.Notification("Your armor is scuffed.")
		ElseIf tier == 2
			Debug.Notification("Your armor is dented.")
		ElseIf tier >= 3
			Debug.Notification("Your armor is battered.")
		Else
			Debug.Notification("Your armor is sound.")
		EndIf
	EndIf
EndFunction
