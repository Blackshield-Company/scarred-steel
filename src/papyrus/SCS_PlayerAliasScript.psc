Scriptname SCS_PlayerAliasScript extends ReferenceAlias
{Scarred Steel - player alias. Swing events, hits, and grindstone or workbench use.
Registrations are renewed on init, load, and location change. No update loop.}

SCS_WearScript Property Wear Auto
Keyword Property ArmorCuirass Auto
Keyword Property CraftingSmithingSharpeningWheel Auto
Keyword Property CraftingSmithingArmorTable Auto
GlobalVariable Property SCS_HitCooldown Auto
GlobalVariable Property SCS_WeaponWear Auto
GlobalVariable Property SCS_ArmorWear Auto

Float lastHit

Event OnInit()
	RegisterSwings()
	Wear.GameLoaded()
EndEvent

Event OnPlayerLoadGame()
	RegisterSwings()
	Wear.GameLoaded()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	RegisterSwings()
EndEvent

Event OnAnimationEvent(ObjectReference akSource, String asEventName)
	If asEventName != "weaponSwing" && asEventName != "weaponLeftSwing" && asEventName != "arrowRelease"
		Return
	EndIf
	Actor player = GetActorReference()
	If !player
		player = Game.GetPlayer()
	EndIf
	If !player || !player.IsInCombat()
		Return
	EndIf
	Wear.AddWeaponWear(1)
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
	Weapon hitWeapon = akSource as Weapon
	If !hitWeapon && !akProjectile
		Return
	EndIf
	Actor player = GetActorReference()
	If !player
		player = Game.GetPlayer()
	EndIf
	If !player || !player.WornHasKeyword(ArmorCuirass)
		Return
	EndIf
	Float now = Utility.GetCurrentRealTime()
	Float wait = SCS_HitCooldown.GetValue()
	If lastHit > 0.0 && (now - lastHit) < wait
		Return
	EndIf
	lastHit = now
	Int n = 1
	If abPowerAttack
		n = 2
	EndIf
	Wear.AddArmorWear(n)
EndEvent

Event OnSit(ObjectReference akFurniture)
	If !akFurniture
		Return
	EndIf
	Form furnBase = akFurniture.GetBaseObject()
	If !furnBase
		Return
	EndIf
	If furnBase.HasKeyword(CraftingSmithingSharpeningWheel) && SCS_WeaponWear.GetValue() > 0.0
		Wear.OfferWeaponRepair()
	ElseIf furnBase.HasKeyword(CraftingSmithingArmorTable) && SCS_ArmorWear.GetValue() > 0.0
		Wear.OfferArmorRepair()
	EndIf
EndEvent

Function RegisterSwings()
	Actor player = GetActorReference()
	If !player
		player = Game.GetPlayer()
	EndIf
	If !player
		Return
	EndIf
	RegisterSwing(player, "weaponSwing")
	RegisterSwing(player, "weaponLeftSwing")
	RegisterSwing(player, "arrowRelease")
EndFunction

Function RegisterSwing(ObjectReference who, String eventName)
	UnregisterForAnimationEvent(who, eventName)
	If !RegisterForAnimationEvent(who, eventName)
		Debug.Trace("[ScarredSteel] SCS_ failed to register " + eventName)
	EndIf
EndFunction
